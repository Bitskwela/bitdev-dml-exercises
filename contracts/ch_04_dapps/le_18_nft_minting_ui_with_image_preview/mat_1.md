# NFT Minting UI with Image Preview — From File to Token URI

![Filipino spoken-word poet minting NFT](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+18.0+-+COVER.png)

## Scene

Under the neon glow of Tondo's mural walls, Odessa ("Det") met a spoken-word poet named Lakan. He had powerful lines about hope and Manila's heartbeat — but no way to "own" them. Odessa grinned: "Kahit spoken word, pwedeng i-mint." Within an hour she deployed a minimal `PoetNFT.sol` on her local Hardhat node, then scaffolded a React app with three widgets:

![NFT Minting UI with Image Preview](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+18.1.png)

1. **Input Form** — Title, Description, and Image Upload (a snapshot of the poet's expression)
2. **NFT Preview** — Live preview of the metadata JSON and image
3. **Mint Button** — Calls `mintNFT(tokenURI)` on the contract and shows the minted Token ID

When Lakan uploaded his poem's cover art, typed "Tondo Sunrise" and "Lines of resilience…," the preview popped up instantly. A click on **Mint** fired a real on-chain call. Seconds later, Token ID #1 appeared, its metadata viewable right in the UI. Over gulaman at taho, Lakan raised his phone: "My poem as NFT — para sa future collectors!" Filipino creativity + Web3, one spoken line at a time. 🇵🇭🎤🪙

This lesson takes that demo apart and rebuilds it correctly: how a file in the browser becomes a preview and then a `tokenURI`, what the ERC-721 metadata JSON actually has to contain, the trade-off between stuffing data on-chain vs. pinning it to IPFS, and the full mint flow in **ethers v6**. The contract is written against **OpenZeppelin v5**, where the old `Counters` utility no longer exists.

---

## 1. From a File to a preview (the browser half)

When a user picks a file with `<input type="file">`, the browser hands you a `File` object — binary data plus metadata (`name`, `type`, `size`). It is **not** a URL and **not** a string. You turn it into something renderable in one of two ways, and the difference matters.

### `URL.createObjectURL` — for showing the image

`URL.createObjectURL(file)` returns a short, synchronous `blob:` URL that points at the file already sitting in memory. It's the right tool for an `<img src>` preview because it's instant and doesn't copy the bytes.

```javascript
const previewUrl = URL.createObjectURL(file); // "blob:http://localhost/9f8c…"
// <img src={previewUrl} />
```

The catch: every object URL holds the file in memory until you revoke it (or the document unloads). In a form where the user keeps swapping images, that's a slow leak. Revoke the old one when you replace it or when the component unmounts:

```javascript
useEffect(() => {
  if (!file) return;
  const url = URL.createObjectURL(file);
  setPreview(url);
  return () => URL.revokeObjectURL(url); // cleanup
}, [file]);
```

### `FileReader` — for embedding the image in metadata

A `blob:` URL is local and ephemeral; it means nothing to anyone else and vanishes when the tab closes. To put the image *inside* the token's metadata, you need the actual bytes encoded as text. That's `FileReader.readAsDataURL`, which is **asynchronous** and produces a `data:` URI (`data:image/png;base64,iVBOR…`).

```javascript
function fileToDataUri(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result); // "data:image/png;base64,…"
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}
```

**Rule of thumb:** `createObjectURL` for the live preview the user sees; `FileReader`/`readAsDataURL` only when you actually need to serialize the image into JSON or upload it.

---

## 2. The ERC-721 metadata JSON schema

An NFT on its own is just `tokenId → owner`. The picture, name, and traits live in a JSON document that `tokenURI(tokenId)` points to. Marketplaces (OpenSea, etc.) read this schema:

```json
{
  "name": "Tondo Sunrise",
  "description": "Lines of resilience from Manila's heartbeat",
  "image": "ipfs://QmXxx.../sunrise.png",
  "external_url": "https://lakan.example/poem/1",
  "attributes": [
    { "trait_type": "Artist", "value": "Lakan" },
    { "trait_type": "Year",   "value": "2024" },
    { "trait_type": "Medium", "value": "Spoken Word" }
  ]
}
```

- **`name`** and **`description`** are plain strings shown on the listing.
- **`image`** is itself a URI — an `ipfs://`, `https://`, or `data:` link to the actual file. The metadata JSON points at the image; it doesn't usually contain it inline (though it can, as a data URI).
- **`attributes`** is an array of `{ trait_type, value }` objects that render as the trait badges on a marketplace. Numeric traits can add `"display_type"`.

`tokenURI` returns a **link to this JSON**, not the JSON itself — unless you go fully on-chain with a data URI.

---

## 3. Where does the metadata live? Data URI vs IPFS

`tokenURI` can return any URI. The two serious choices:

| Aspect            | Data URI (on-chain)              | IPFS (off-chain, pinned)            |
| ----------------- | -------------------------------- | ----------------------------------- |
| Where it lives    | Inside the transaction / storage | A content-addressed file network    |
| Permanence        | As permanent as the chain        | Only while someone **pins** the CID |
| Gas cost          | High — you pay per byte stored   | Low — you store only a short CID    |
| Size limit        | A few KB before gas is brutal    | Effectively unlimited               |
| Mutability        | Immutable                        | Immutable per CID (content hash)    |
| Best for          | Tiny SVGs, generative art        | Photos, audio, video                |

### Building a data URI token URI (ethers v6)

For small art you can encode the whole metadata JSON as a base64 `data:` URI and store it on-chain — no external dependency at all.

```javascript
async function buildDataUri(title, description, file) {
  const imageUri = await fileToDataUri(file); // data:image/png;base64,…

  const metadata = {
    name: title || "Untitled",
    description: description || "",
    image: imageUri,
  };

  // Unicode-safe base64 of the JSON
  const json = JSON.stringify(metadata);
  const base64 = btoa(unescape(encodeURIComponent(json)));
  return `data:application/json;base64,${base64}`;
}
```

### The IPFS path (sketch)

For real images you upload the file to IPFS (via Pinata, web3.storage, your own node), get back a CID, point `image` at `ipfs://<CID>`, upload the metadata JSON, and use *its* CID as the `tokenURI`. The key word is **pinning**: an unpinned CID can be garbage-collected and your NFT's image disappears. "On IPFS" is not "forever" unless something keeps it pinned.

---

## 4. The smart contract — OpenZeppelin v5 (no Counters)

OpenZeppelin **v5 removed the `Counters` library** entirely. Tutorials that `import "@openzeppelin/contracts/utils/Counters.sol"` and do `using Counters for Counters.Counter` will not compile against v5. The modern, cheaper replacement is a plain `uint256` you increment with `++`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PoetNFT is ERC721URIStorage, Ownable {
    // Replaces the removed OpenZeppelin Counters utility.
    uint256 private _tokenIds;

    event Minted(
        address indexed owner,
        uint256 indexed tokenId,
        string tokenURI
    );

    // OZ v5: Ownable's constructor now takes the initial owner explicitly.
    constructor() ERC721("PoetNFT", "POET") Ownable(msg.sender) {}

    function mintNFT(string calldata _tokenURI) external returns (uint256) {
        unchecked {
            ++_tokenIds; // pre-increment; ids start at 1
        }
        uint256 newTokenId = _tokenIds;

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);

        emit Minted(msg.sender, newTokenId, _tokenURI);
        return newTokenId;
    }

    function totalSupply() external view returns (uint256) {
        return _tokenIds;
    }
}
```

What changed from the old `Counters` pattern:

- `_tokenIds.increment()` → `++_tokenIds`
- `_tokenIds.current()` → `_tokenIds`
- No `using Counters …`, no `Counters.sol` import.
- `++_tokenIds` in an `unchecked` block is safe here: a `uint256` will never realistically overflow from minting, and it saves the overflow-check gas.
- In **OZ v5**, `Ownable(initialOwner)` must receive the owner address in its constructor — the zero-arg form was removed.

---

## 5. The full mint flow in ethers v6

```javascript
import { ethers } from "ethers";

const POETNFT_ABI = [
  "function mintNFT(string tokenURI) returns (uint256)",
  "event Minted(address indexed owner, uint256 indexed tokenId, string tokenURI)",
];

async function mintNFT(title, description, file) {
  // 1) Build the token URI (data URI here; swap in IPFS for big files)
  const tokenURI = await buildDataUri(title, description, file);

  // 2) Connect to the wallet — ethers v6 uses BrowserProvider, and
  //    getSigner() is now async.
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(
    process.env.REACT_APP_POETNFT_ADDRESS,
    POETNFT_ABI,
    signer
  );

  // 3) Send the mint transaction and wait for it to be mined.
  const tx = await contract.mintNFT(tokenURI);
  const receipt = await tx.wait();

  // 4) Recover the tokenId from the Minted event.
  //    ethers v6 has no receipt.events; parse receipt.logs via the interface.
  let tokenId = null;
  for (const log of receipt.logs) {
    try {
      const parsed = contract.interface.parseLog(log);
      if (parsed && parsed.name === "Minted") {
        // uint256 args come back as bigint in v6 — Number() for display.
        tokenId = Number(parsed.args.tokenId);
        break;
      }
    } catch {
      // Not one of our contract's events — skip it.
    }
  }

  return tokenId;
}
```

The three v6 gotchas this flow demonstrates, all of which break a copy-pasted v5 tutorial:

1. **`new ethers.providers.Web3Provider(window.ethereum)` → `new ethers.BrowserProvider(window.ethereum)`.** The `ethers.providers.*` namespace is gone in v6.
2. **`provider.getSigner()` is now asynchronous** — you must `await` it. In v5 it returned synchronously.
3. **`receipt.events` no longer exists.** v6 gives you `receipt.logs`; you decode them yourself with `contract.interface.parseLog(log)`. And `tokenId` arrives as a `bigint`, so use `Number(parsed.args.tokenId)` (or `.toString()`) instead of v5's `.toNumber()`.

---

## 6. Wiring the preview component

```javascript
import { useState, useEffect } from "react";

function NFTMinter({ contractReady, onMint }) {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [file, setFile] = useState(null);
  const [preview, setPreview] = useState(null);
  const [loading, setLoading] = useState(false);
  const [tokenId, setTokenId] = useState(null);
  const [error, setError] = useState(null);

  // Live preview, with cleanup so we don't leak blob URLs.
  useEffect(() => {
    if (!file) return setPreview(null);
    const url = URL.createObjectURL(file);
    setPreview(url);
    return () => URL.revokeObjectURL(url);
  }, [file]);

  const handleFile = (e) => {
    const f = e.target.files[0];
    if (!f) return;
    if (!f.type.startsWith("image/")) return setError("Pick an image file.");
    if (f.size > 5 * 1024 * 1024) return setError("Image must be under 5MB.");
    setError(null);
    setFile(f);
  };

  const handleMint = async () => {
    setLoading(true);
    setError(null);
    try {
      const id = await onMint(title, description, file); // calls mintNFT()
      setTokenId(id);
    } catch (err) {
      // ethers v6: user rejection is ACTION_REJECTED / code 4001
      if (err.code === "ACTION_REJECTED" || err.code === 4001) {
        setError("You cancelled the transaction.");
      } else {
        setError(err.shortMessage || err.message);
      }
    } finally {
      setLoading(false);
    }
  };

  const metadata = { name: title || "Untitled", description, image: preview };

  return (
    <div>
      <input value={title} onChange={(e) => setTitle(e.target.value)} placeholder="Title" />
      <textarea value={description} onChange={(e) => setDescription(e.target.value)} placeholder="Description" />
      <input type="file" accept="image/*" onChange={handleFile} />

      {preview && <img src={preview} alt="preview" style={{ maxWidth: 300 }} />}
      <pre>{JSON.stringify(metadata, null, 2)}</pre>

      <button onClick={handleMint} disabled={!file || loading || !contractReady}>
        {loading ? "Minting…" : "Mint NFT"}
      </button>

      {tokenId !== null && <p>🎉 Minted Token ID: {tokenId}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

## 7. Gas and UX notes

- **Data URIs cost real gas.** Every byte of the `tokenURI` you store on-chain is paid for at mint time. A 30 KB base64 image can make a mint cost many times more than the NFT is worth on a mainnet. Keep on-chain metadata to tiny SVGs/JSON; push photos to IPFS and store only the short CID.
- **Disable the button while minting.** Without `disabled={loading}` the user double-clicks, sends two transactions, and pays twice. Always gate the action on a loading flag.
- **Wait for the receipt before claiming success.** `tx.wait()` resolves only once the transaction is mined; reading the `tokenId` before that gives you nothing. Show a pending state in between.
- **Validate before you read bytes.** Check `file.type` and `file.size` *before* running it through `FileReader`, so a 50 MB video never gets base64-encoded into a doomed transaction.
- **Revoke object URLs.** Especially in a form where users swap images repeatedly — otherwise the tab's memory climbs.

---

## Common mistakes

| Mistake                                          | Problem                              | Fix                                                       |
| ------------------------------------------------ | ------------------------------------ | --------------------------------------------------------- |
| `import ".../utils/Counters.sol"` on OZ v5       | Won't compile — `Counters` removed   | Plain `uint256 private _tokenIds;` + `++_tokenIds`        |
| `new ethers.providers.Web3Provider(...)`         | Throws in ethers v6                  | `new ethers.BrowserProvider(window.ethereum)`             |
| `provider.getSigner()` used synchronously        | Returns a promise, breaks later code | `const signer = await provider.getSigner()`               |
| `receipt.events.find(...)`                        | `events` is undefined in v6          | Loop `receipt.logs`, `contract.interface.parseLog(log)`   |
| `tokenId.toNumber()`                             | No `toNumber` on a v6 `bigint`       | `Number(tokenId)` or `tokenId.toString()`                 |
| Large image as a data URI                        | Transaction too expensive / fails    | Upload to IPFS, store only the CID                        |
| No file validation                               | Wrong type / oversized uploads       | Guard on `file.type` and `file.size` first                |
| Leaking object URLs                              | Memory grows on repeated uploads     | `URL.revokeObjectURL(url)` on replace/unmount             |
| Ownable with no args on OZ v5                    | Constructor mismatch, won't compile  | `Ownable(msg.sender)` in the constructor                  |

---

## Testing checklist

- [ ] File input accepts only images
- [ ] File size validation works (< 5MB)
- [ ] Image preview displays and is revoked on change
- [ ] Metadata JSON preview updates in real time
- [ ] Mint button disabled without a file / while minting
- [ ] Loading state shows during the transaction
- [ ] Token ID displays after a successful mint
- [ ] User rejection (`ACTION_REJECTED` / 4001) handled gracefully
- [ ] `Minted` event parsed from `receipt.logs`
- [ ] Contract compiles against OpenZeppelin v5 (no `Counters`)

---

## Test Cases

Create `__tests__/MintNFT.test.js`:

```js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import MintNFT from "../MintNFT";
import { ethers } from "ethers";

jest.mock("ethers");

describe("MintNFT Component", () => {
  const fakeSigner = {};
  const fakeContract = {
    mintNFT: jest.fn(),
    interface: {
      // ethers v6: we parse logs ourselves; mock parseLog for the Minted event.
      parseLog: jest.fn().mockReturnValue({
        name: "Minted",
        args: { tokenId: 42n }, // v6 returns bigint, not BigNumber
      }),
    },
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    // ethers v6: BrowserProvider replaces Web3Provider; getSigner is async.
    ethers.BrowserProvider = jest.fn().mockReturnValue({
      getSigner: jest.fn().mockResolvedValue(fakeSigner),
    });
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("calls mintNFT and shows tokenId", async () => {
    fakeContract.mintNFT.mockResolvedValue({
      // v6 receipts expose logs, not events.
      wait: () => Promise.resolve({ logs: [{ topics: [], data: "0x" }] }),
    });

    const file = new File(["dummy"], "test.png", { type: "image/png" });
    render(<MintNFT title="My Poem" description="Lines..." file={file} />);

    fireEvent.click(screen.getByText("Mint NFT"));

    await waitFor(() => screen.getByText(/Minted Token ID: 42/));
    expect(fakeContract.mintNFT).toHaveBeenCalled();
  });

  it("shows error on user rejection", async () => {
    fakeContract.mintNFT.mockRejectedValue({ code: "ACTION_REJECTED" });
    const file = new File(["dummy"], "test.png", { type: "image/png" });
    render(<MintNFT title="X" description="Y" file={file} />);

    fireEvent.click(screen.getByText("Mint NFT"));
    await waitFor(() => screen.getByText("You cancelled the transaction."));
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## References

- OpenZeppelin v5 — ERC-721 — https://docs.openzeppelin.com/contracts/5.x/erc721
- OpenZeppelin v5 — Migrating from Counters / 4.x → 5.x — https://docs.openzeppelin.com/contracts/5.x/upgrades
- EIP-721 — Non-Fungible Token Standard (metadata schema) — https://eips.ethereum.org/EIPS/eip-721
- OpenSea — Metadata standards — https://docs.opensea.io/docs/metadata-standards
- ethers v6 — Contracts & event parsing — https://docs.ethers.org/v6/api/contract/
- MDN — FileReader API — https://developer.mozilla.org/en-US/docs/Web/API/FileReader
- MDN — `URL.createObjectURL` — https://developer.mozilla.org/en-US/docs/Web/API/URL/createObjectURL_static

---

## Closing Story

Lakan clicked **Mint NFT**, watched Token #1 emerge from the `Minted` event in the receipt logs, and shared it: "My spoken-word, now immortalized on-chain!" Odessa smiled — her Tondo poet had a digital legacy, minted with a contract that compiles cleanly on today's OpenZeppelin and a UI that speaks today's ethers. Next, they'll wire real IPFS uploads and on-chain royalties. Filipino creativity meets Web3 — one poem at a time. Mabuhay Kabataan! 🇵🇭🎤🚀
