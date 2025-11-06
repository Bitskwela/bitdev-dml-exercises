# Activity 1: NFTPreview Component ⏱️ 10 mins

Build a `NFTPreview` component that takes `title`, `description`, and an image `File` and renders a live preview: display the uploaded image, the title, description, and a JSON metadata snippet.

## 📋 Contract Baseline

**Solidity Contract (`PoetNFT.sol`)**

```solidity
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

## 🚀 Starter Code

**`NFTPreview.js`**

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

## ✅ To Do List

- [ ] If `!file`, render "Please upload an image."
- [ ] Use `URL.createObjectURL(file)` for `<img src=...>`
- [ ] Show `title` and `description` below the image
- [ ] Construct `const metadata = { name: title, description, image: imageUrl }`
- [ ] Render `<pre>{JSON.stringify(metadata, null, 2)}</pre>`

## 🎯 Full Solution

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
