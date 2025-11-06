# Single NFT Renderer activity:

```js
// NFTViewer.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/NFT.json";

export default function NFTViewer({ tokenId }) {
  const [nft, setNft] = useState({ name: "", image: "", description: "" });
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // TODO: fetch NFT metadata
  }, [tokenId]);

  return (
    <div>
      <h3>NFT #{tokenId}</h3>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <div>
          <h4>{nft.name}</h4>
          <img src={nft.image} alt={nft.name} style={{ maxWidth: "200px" }} />
          <p>{nft.description}</p>
        </div>
      )}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-721 tokenURI, IPFS metadata fetching, JSON parsing

- Update the `NFTViewer` component to:
  - Fetch tokenURI using `tokenURI(tokenId)` from the NFT contract.
  - Make HTTP request to fetch JSON metadata from IPFS/HTTP URI.
  - Parse the metadata JSON to extract name, image, and description.
  - Handle loading states and display the NFT information properly.
