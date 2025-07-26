## 🧑‍💻 Background Story

Under the neon glow of Tondo’s mural walls, Odessa (“Det”) met a spoken‐word poet named Lakan. He had powerful lines about hope and Manila’s heartbeat—but no way to “own” them. Odessa grinned: “Kahit spoken word, pwedeng i-mint.” Within an hour, she deployed a minimal `PoetNFT.sol` on her local Hardhat node. Then she scaffolded a React app with three widgets:

1. **Input Form** – Title, Description, and Image Upload (a snapshot of the poet’s expression)
2. **NFT Preview** – Live preview of the metadata JSON and image
3. **Mint Button** – Calls `mintNFT(tokenURI)` on the contract and shows the minted Token ID

When Lakan uploaded his poem’s cover art, typed “Tondo Sunrise” and “Lines of resilience…,” the preview popped up like magic. A click on **Mint** simulated a real on-chain call. Ten seconds later, Token ID #1 appeared, with metadata viewable on the UI. Over gulaman at taho, Lakan raised his phone: “My poem as NFT—para sa future collectors!” Filipino creativity + Web3, one spoken line at a time. 🇵🇭🎤🪙

---

## 📚 Theory & Web3 Lecture

1. ERC-721 Basics  
   • Each NFT has a unique `tokenId` and `tokenURI`.  
   • `tokenURI` returns a JSON metadata link (IPFS or Data URI).  
   • We override `tokenURI()` in Solidity to serve on-chain metadata

2. Smart Contract (`PoetNFT.sol`)  
   • Uses OpenZeppelin’s ERC721  
   • `_tokenIds` counter for unique IDs  
   • `mintNFT(string calldata tokenURI)` mints to `msg.sender`  
   • `event Minted(address indexed, uint256 indexed, string)` fires on mint

3. Frontend Architecture  
   • **Form State**: React useState for `title`, `desc`, `file`  
   • **Preview**: URL.createObjectURL(file) + JSON preview  
   • **Metadata**: Construct a JS object `{ name, description, image }`, Base64-encode to Data URI  
   • **Ethers.js**:

   ```js
   const provider = new ethers.providers.Web3Provider(window.ethereum);
   const signer = provider.getSigner();
   const contract = new ethers.Contract(
     process.env.REACT_APP_POETNFT_ADDRESS,
     ABI,
     signer
   );
   const tx = await contract.mintNFT(tokenURI);
   await tx.wait();
   ```

   • **Event Handling**: listen to `Minted` event to update UI

4. React Hooks & UX  
   • `useEffect` to request accounts on-mount  
   • Disable **Mint** until preview is valid  
   • Show loading spinner during `await tx.wait()`  
   • Catch errors (e.g. user rejects, insufficient gas) and display

5. Security & Best Practices  
   • Validate image file type (`image/*`) and size (< 5 MB)  
   • Never commit private keys—use `.env` for `RPC_URL` and contract address  
   • Clean up event listeners on unmount

🔗 Links  
– Ethers.js: https://docs.ethers.org/v5  
– OpenZeppelin ERC721: https://docs.openzeppelin.com/contracts/4.x/api/token/erc721

---

## 🧪 Exercises

### Exercise 1: NFTPreview Component

Problem Statement  
Build a `NFTPreview` component that takes `title`, `description`, and an image `File` and renders a live preview: display the uploaded image, the title, description, and a JSON metadata snippet.

**Starter Code (`NFTPreview.js`)**

```js
import React from "react";

export default function NFTPreview({ title, description, file }) {
  // TODO: if no file, return "Upload an image"
  // TODO: create image URL with URL.createObjectURL(file)
  // TODO: show <img> preview, <h4>{title}</h4>, <p>{description}</p>
  // TODO: build metadata object and render JSON.stringify(metadata, null, 2)
  return <div>{/* Your preview UI here */}</div>;
}
```

To Do List

- [ ] If `!file`, render “Please upload an image.”
- [ ] Use `URL.createObjectURL(file)` for `<img src=...>`
- [ ] Show `title` and `description` below the image
- [ ] Construct `const metadata = { name: title, description, image: imageUrl }`
- [ ] Render `<pre>{JSON.stringify(metadata, null, 2)}</pre>`

**Full Solution**

```js
// NFTPreview.js
import React from "react";

export default function NFTPreview({ title, description, file }) {
  if (!file) {
    return <p>Please upload an image to preview your NFT.</p>;
  }

  const imageUrl = URL.createObjectURL(file);
  const metadata = {
    name: title || "Untitled",
    description: description || "",
    image: imageUrl,
  };

  return (
    <div style={{ border: "1px solid #ccc", padding: 16 }}>
      <h4>🖼️ Image Preview</h4>
      <img
        src={imageUrl}
        alt="NFT preview"
        style={{ maxWidth: "100%", maxHeight: 200 }}
      />
      <h4>{metadata.name}</h4>
      <p>{metadata.description}</p>
      <h5>Metadata JSON:</h5>
      <pre style={{ background: "#f9f9f9", padding: 8 }}>
        {JSON.stringify(metadata, null, 2)}
      </pre>
    </div>
  );
}
```

---

### Exercise 2: MintNFT Component

Problem Statement  
Implement `MintNFT` that:

1. Takes `title`, `description`, and `file` props.
2. Builds a Base64 Data URI of the metadata JSON
3. Calls `contract.mintNFT(tokenURI)` via Ethers.js
4. Shows the minted `tokenId` and links to view metadata

**Solidity Contract (`PoetNFT.sol`)**

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PoetNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint256 => string) private _tokenURIs;

    event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI);

    constructor() ERC721("PoetNFT","PNT") {}

    function mintNFT(string calldata tokenURI) external returns (uint256) {
        _tokenIds.increment();
        uint256 id = _tokenIds.current();
        _safeMint(msg.sender, id);
        _tokenURIs[id] = tokenURI;
        emit Minted(msg.sender, id, tokenURI);
        return id;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Nonexistent token");
        return _tokenURIs[tokenId];
    }
}
```

**Starter Code (`MintNFT.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
import { Buffer } from "buffer";
const ABI = [
  "function mintNFT(string) returns (uint256)",
  "event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI)",
];

export default function MintNFT({ title, description, file }) {
  const [tokenId, setTokenId] = useState(null);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function mint() {
    try {
      setError("");
      setLoading(true);
      // TODO: await window.ethereum.request({ method: "eth_requestAccounts" })
      // TODO: provider = new ethers.providers.Web3Provider(window.ethereum)
      // TODO: signer = provider.getSigner()
      // TODO: contract = new ethers.Contract(..., ABI, signer)
      // TODO: build metadata = { name, description, image: data:image/...;base64,... }
      // TODO: const json = JSON.stringify(metadata)
      // TODO: const dataUri = "data:application/json;base64," + Buffer.from(json).toString("base64")
      // TODO: const tx = await contract.mintNFT(dataUri)
      // TODO: const receipt = await tx.wait()
      // TODO: find Minted event and setTokenId(event.args.tokenId.toNumber())
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <button onClick={mint} disabled={loading || !file}>
        {loading ? "Minting…" : "Mint NFT"}
      </button>
      {tokenId !== null && <p>✅ Minted Token ID: {tokenId}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

To Do List

- [ ] Request accounts and get signer
- [ ] Assemble `metadata` object and stringify
- [ ] Base64-encode JSON into a Data URI
- [ ] Call `mintNFT(dataUri)` and wait for `tx.wait()`
- [ ] Extract `tokenId` from `Minted` event and update state

**Full Solution**

```js
// MintNFT.js
import React, { useState } from "react";
import { ethers } from "ethers";
import { Buffer } from "buffer";

const ABI = [
  "function mintNFT(string) returns (uint256)",
  "event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI)",
];
const ADDRESS = process.env.REACT_APP_POETNFT_ADDRESS;

export default function MintNFT({ title, description, file }) {
  const [tokenId, setTokenId] = useState(null);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function mint() {
    setError("");
    setLoading(true);
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(ADDRESS, ABI, signer);

      // Build metadata
      const imageData = await file.arrayBuffer();
      const base64Img = Buffer.from(imageData).toString("base64");
      const mimeType = file.type; // e.g., "image/png"
      const imageUri = `data:${mimeType};base64,${base64Img}`;

      const metadata = {
        name: title,
        description,
        image: imageUri,
      };
      const json = JSON.stringify(metadata);
      const dataUri = `data:application/json;base64,${Buffer.from(
        json
      ).toString("base64")}`;

      const tx = await contract.mintNFT(dataUri);
      const receipt = await tx.wait();
      const event = receipt.events.find((e) => e.event === "Minted");
      const newId = event.args.tokenId.toNumber();
      setTokenId(newId);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <button onClick={mint} disabled={loading || !file}>
        {loading ? "Minting…" : "Mint NFT"}
      </button>
      {tokenId !== null && (
        <p>
          ✅ Minted Token ID: {tokenId} &nbsp;
          <a href={`${dataUri}`} target="_blank" rel="noopener noreferrer">
            View Metadata
          </a>
        </p>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_POETNFT_ADDRESS=0xYourContractAddress
```

---

## ✅ Test Cases

Create `__tests__/MintNFT.test.js`:

```js
// __tests__/MintNFT.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import MintNFT from "../MintNFT";
import { ethers } from "ethers";

jest.mock("ethers");
jest.mock("buffer", () => ({
  Buffer: { from: (x) => ({ toString: () => "BASE64" }) },
}));

describe("MintNFT Component", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    mintNFT: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({
      getSigner: () => fakeSigner,
    });
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("calls mintNFT and shows tokenId", async () => {
    // Mock transaction & event
    const fakeReceipt = {
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Minted", args: { tokenId: ethers.BigNumber.from("42") } },
          ],
        }),
    };
    fakeContract.mintNFT.mockResolvedValue(fakeReceipt);

    // Mock file
    const file = new File(["dummy"], "test.png", { type: "image/png" });
    render(<MintNFT title="My Poem" description="Lines..." file={file} />);

    fireEvent.click(screen.getByText("Mint NFT"));

    await waitFor(() => screen.getByText(/Minted Token ID: 42/));
    expect(fakeContract.mintNFT).toHaveBeenCalled();
  });

  it("shows error on user rejection", async () => {
    fakeContract.mintNFT.mockRejectedValue(new Error("User rejected"));
    const file = new File(["dummy"], "test.png", { type: "image/png" });
    render(<MintNFT title="X" description="Y" file={file} />);

    fireEvent.click(screen.getByText("Mint NFT"));
    await waitFor(() => screen.getByText("User rejected"));
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

Lakan clicked **Mint NFT**, watched Token #1 emerge, and shared it on Twitter: “My spoken‐word, now immortalized on-chain!” Odessa smiled—her Tondo poet had a digital legacy. Next, they’ll add IPFS uploads and on-chain royalties. Filipino creativity meets Web3 magic—one poem at a time. Mabuhay Kabataan! 🇵🇭🎤🚀
