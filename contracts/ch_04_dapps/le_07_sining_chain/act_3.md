# All Minted NFTs Display activity:

```js
// AllNFTs.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/NFT.json";

export default function AllNFTs() {
  const [totalSupply, setTotalSupply] = useState(0);
  const [allTokens, setAllTokens] = useState([]);

  useEffect(() => {
    // TODO: fetch total supply and display all tokens
  }, []);

  return (
    <div>
      <h3>All Minted NFTs (Total: {totalSupply})</h3>
      <div>
        {allTokens.map((tokenId) => (
          <div key={tokenId}>
            Token #{tokenId}
            {/* Could integrate with NFTViewer component */}
          </div>
        ))}
      </div>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-721 totalSupply, sequential token enumeration, batch processing

- Update the `AllNFTs` component to:
  - Fetch `totalSupply()` to get the count of minted NFTs.
  - Generate array of token IDs from 0 to totalSupply - 1.
  - Create efficient display of all minted tokens.
  - Consider pagination for large collections (bonus).
