## 🧑‍💻 Background Story

![Filipino spoken-word poet minting NFT](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+18.0+-+COVER.png)

Under the neon glow of Tondo's mural walls, Odessa ("Det") met a spoken-word poet named Lakan. He had powerful lines about hope and Manila's heartbeat, and no way to "own" them. Det grinned: "Kahit spoken word, pwedeng i-mint." She sketched a minimal `PoetNFT` contract and planned a React app with three parts:

![NFT Minting UI with Image Preview](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+18.1.png)

1. **Input form**: title, description, and an image upload (the cover art for the poem).
2. **Preview card**: the image plus the exact metadata JSON that will describe the token.
3. **Mint button**: uploads the art, then calls `mintNFT(tokenURI)` on Sepolia.

Lakan's first question was not about gas or tokens. It was "Can I see it first?" A mint is permanent, so a typo in the title stays forever. Det built the **preview card** first. When Lakan picked his cover art and typed "Tondo Sunrise", the card showed the picture and the JSON instantly, entirely inside the browser, with nothing sent anywhere.

That preview card is what you build in this lesson's activity. The lecture then walks through what happens after the preview: uploading the image, and minting on Sepolia.

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

- What an ERC-721 NFT is, and what its **metadata JSON** looks like.
- How to preview a user's image in the browser with `URL.createObjectURL`, and how to clean it up.
- Why a preview URL (`blob:`) can **never** be the `image` in real metadata, and where the image goes instead.
- How a mint call looks in ethers v6, with an OpenZeppelin 5 contract.

**Activity:** build `NFTPreview`. It prompts for a file when none is chosen, previews the chosen image, and renders the metadata JSON with an `"Untitled"` fallback.

---

### 📐 From preview to mint

```
 ┌────────────── in the browser (this activity) ──────────────┐
 │  title + description + image File                          │
 │        │  URL.createObjectURL(file) → "blob:…"             │
 │        ▼                                                   │
 │  Preview card: <img src="blob:…">  +  { name, description, │
 │                                         image: "blob:…" }  │
 └────────┬───────────────────────────────────────────────────┘
          │  user clicks Mint (beyond the activity)
          ▼
 1. upload image   → ipfs://<imageCID>
 2. upload JSON    → { name, description, image: "ipfs://<imageCID>" } → ipfs://<jsonCID>
 3. mintNFT("ipfs://<jsonCID>") on Sepolia  → Minted(owner, tokenId, tokenURI)
```

The preview and the mint use the **same shape** of JSON. The only difference is where `image` points.

---

### 🔑 Key Concepts

#### 1. ERC-721 in one table

| Piece              | Meaning                                         |
| ------------------ | ----------------------------------------------- |
| `tokenId`          | The unique number of one NFT (1, 2, 3…)         |
| `ownerOf(tokenId)` | Who owns it                                     |
| `balanceOf(owner)` | How many tokens an address owns                 |
| `tokenURI(tokenId)`| A URI pointing to the token's metadata JSON     |

The contract stores only the **pointer** (`tokenURI`). The picture itself lives somewhere else.

#### 2. The metadata JSON

```json
{
  "name": "Tondo Sunrise",
  "description": "Lines of resilience from Manila's heartbeat",
  "image": "ipfs://bafy.../tondo-sunrise.png",
  "attributes": [
    { "trait_type": "Artist", "value": "Lakan" },
    { "trait_type": "Medium", "value": "Spoken word" }
  ]
}
```

`name`, `description` and `image` are the fields every marketplace reads, and they are exactly what the activity's card shows. `attributes` are optional traits.

#### 3. Previewing a file: `URL.createObjectURL`

When a user picks a file, `e.target.files[0]` is a `File`: bytes in memory, not an address. `URL.createObjectURL(file)` gives those bytes a temporary address such as `blob:https://yourapp/1f2e…`, which an `<img>` can display. Two facts to remember:

- The URL works **only in the tab that created it**. Nobody else can open it, and it dies when the page closes.
- Each URL holds its file in memory until you call `URL.revokeObjectURL(url)`.

The activity's version calls `createObjectURL` on every render and never revokes. That is simple, and acceptable for one card in a lesson. A production component makes **one** URL per file and revokes it when the file changes or the card unmounts:

```javascript
import React, { useMemo, useEffect } from "react";

export default function NFTPreview({ title, description, file }) {
  // one URL per file, not one per render
  const imageUrl = useMemo(() => (file ? URL.createObjectURL(file) : null), [file]);
  // free the old URL when the file changes or the card unmounts
  useEffect(() => () => { if (imageUrl) URL.revokeObjectURL(imageUrl); }, [imageUrl]);

  if (!file) return <p>Choose an image to preview your NFT.</p>;
  // ...render the card exactly as in the activity
}
```

The hooks run before the `if (!file)` return on purpose: React requires hooks to be called in the same order on every render.

#### 4. Validating the file before previewing

```javascript
function handleFileChange(e) {
  const file = e.target.files[0];
  if (!file) return;
  if (!file.type.startsWith("image/")) return alert("Please select an image file");
  if (file.size > 5 * 1024 * 1024) return alert("Please pick an image under 5 MB");
  onFileChange(file); // the parent passes it to <NFTPreview file={file} />
}

<input type="file" accept="image/*" onChange={handleFileChange} />
```

#### 5. Where the image really goes

| Option | How `image` / `tokenURI` looks | Pros | Cons |
| ------ | ------------------------------ | ---- | ---- |
| **IPFS** | `ipfs://bafy…` | Content-addressed, so the link cannot silently change | Someone must keep it pinned |
| **Arweave** | `ar://…` | Pay once, stored long-term | Needs AR tokens |
| **HTTPS** | `https://myserver/1.json` | Easy | Breaks if the server goes away |
| **Data URI** | `data:application/json;base64,…` | Lives fully on-chain | Expensive (see below) |
| ~~`blob:`~~ | `blob:https://…` | ❌ never valid | Only exists in your own tab |

**How expensive is on-chain data?** Storing a string costs gas for every 32-byte slot. On a local Hardhat chain, minting `PoetNFT` with a tokenURI of about 240 bytes used ~239,000 gas, and the same mint with a **10 KB** tokenURI used **~7.4 million gas**. That is as much gas as about 350 plain ETH transfers (21,000 gas each). So "fully on-chain" only makes sense for tiny metadata or small SVGs. Photos belong on IPFS or Arweave. (You may have seen a "24 KB limit" mentioned elsewhere. That is EIP-170's cap on a contract's **bytecode** size, not a limit on strings you store, and it has nothing to do with tokenURIs.)

If you do build a data URI in the browser, note that `Buffer` is a Node.js API and **does not exist in the browser**. Use `TextEncoder` and `btoa`, which also handle non-ASCII text such as "ñ" correctly:

```javascript
const toBase64 = (text) => btoa(String.fromCharCode(...new TextEncoder().encode(text)));
const tokenURI = `data:application/json;base64,${toBase64(JSON.stringify(metadata))}`;
```

#### 6. The contract (OpenZeppelin 5)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721, ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract PoetNFT is ERC721URIStorage {
    uint256 private _nextTokenId = 1;

    event Minted(address indexed owner, uint256 indexed tokenId, string tokenURI);

    constructor() ERC721("PoetNFT", "POET") {}

    function mintNFT(string calldata _tokenURI) external returns (uint256) {
        uint256 newTokenId = _nextTokenId++;
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);
        emit Minted(msg.sender, newTokenId, _tokenURI);
        return newTokenId;
    }

    function totalSupply() external view returns (uint256) {
        return _nextTokenId - 1;
    }
}
```

Older tutorials use `Counters.sol` for the id. **`Counters` was removed in OpenZeppelin 5** and no longer compiles, so a plain `uint256` counter replaces it. This contract compiles with OpenZeppelin 5.3 and Solidity 0.8.27.

#### 7. Minting from React (ethers v6, beyond the activity)

```javascript
import { ethers } from "ethers";

async function mint(tokenURI) {              // e.g. "ipfs://<jsonCID>"
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner(); // v6: getSigner() is async
  const nft = new ethers.Contract(POETNFT_ADDRESS, POETNFT_ABI, signer);

  const tx = await nft.mintNFT(tokenURI);
  const receipt = await tx.wait();           // mined

  // v6 receipts carry `logs`; logs this ABI can decode have an eventName
  const minted = receipt.logs.find((log) => log.eventName === "Minted");
  return Number(minted.args.tokenId);        // bigint → number
}
```

The upload step depends on the pinning service you use (most offer a small JavaScript SDK or an HTTP API that returns a CID). Upload the image first, put its `ipfs://` URI into the JSON, upload the JSON, then pass the JSON's `ipfs://` URI to `mintNFT`.

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
| ------- | ------- | -------- |
| Minting with `image: "blob:…"` | The NFT shows a broken image for everyone else | Upload first, then use `ipfs://…` |
| A new object URL every render, never revoked | Memory slowly leaks | `useMemo` + revoke in the effect cleanup |
| `Buffer.from(...)` in the browser | `ReferenceError: Buffer is not defined` | `TextEncoder` + `btoa` |
| Big images as a data URI | Millions of gas, or the transaction fails | IPFS/Arweave for anything over a few KB |
| `import ".../utils/Counters.sol"` | Does not compile on OpenZeppelin 5 | A `uint256` counter |
| No file-type check | Users upload PDFs | `file.type.startsWith("image/")` |

---

### 🧪 How this is graded

Your `NFTPreview` is rendered with a test PNG, then with no file, then with an empty title. The grader checks for an upload/choose/select/pick prompt (and no `createObjectURL` call) when there is no file, a `blob:` `<img>` when there is one, the title and description on screen, the `name`/`description`/`image` keys in the JSON, and the `Untitled` fallback.

---

### 🔗 External Resources

| Resource | Link |
| -------- | ---- |
| OpenZeppelin 5: ERC-721 | https://docs.openzeppelin.com/contracts/5.x/erc721 |
| OpenSea metadata standards | https://docs.opensea.io/docs/metadata-standards |
| MDN: URL.createObjectURL | https://developer.mozilla.org/en-US/docs/Web/API/URL/createObjectURL_static |
| IPFS documentation | https://docs.ipfs.tech/ |
| ethers v6: Contract | https://docs.ethers.org/v6/api/contract/ |

---

## 🌟 Closing Story

Lakan checked the preview three times, fixed a typo in the description, and only then pressed **Mint**. Det's app uploaded the cover art, swapped the `blob:` preview for a real `ipfs://` link, and Token #1 appeared on Sepolia with the exact JSON he had approved. "Walang typo forever," he laughed. Next they'll add royalties for his future collectors. Filipino creativity meets Web3, one poem at a time. 🇵🇭🎤🚀
