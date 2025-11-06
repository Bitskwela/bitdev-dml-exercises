# Activity 2: MintNFT Component ⏱️ 10 mins

Implement `MintNFT` that: 1) Takes `title`, `description`, and `file` props, 2) Builds a Base64 Data URI of the metadata JSON, 3) Calls `contract.mintNFT(tokenURI)` via Ethers.js, 4) Shows the minted `tokenId` and links to view metadata.

## 📋 Contract Baseline

Using the same `PoetNFT.sol` contract from Activity 1 with:

- `function mintNFT(string calldata tokenURI) external returns (uint256)`
- `event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI)`

## 🚀 Starter Code

**`MintNFT.js`**

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

## ✅ To Do List

- [ ] Request accounts and get signer
- [ ] Assemble `metadata` object and stringify
- [ ] Base64-encode JSON into a Data URI
- [ ] Call `mintNFT(dataUri)` and wait for `tx.wait()`
- [ ] Extract `tokenId` from `Minted` event and update state

## 🎯 Full Solution

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
          <a href={`#`} target="_blank" rel="noopener noreferrer">
            View Metadata
          </a>
        </p>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## 📄 .env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_POETNFT_ADDRESS=0xYourContractAddress
```
