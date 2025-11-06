# Wallet NFT Collection activity:

```js
// WalletNFTs.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/NFT.json";

export default function WalletNFTs({ walletAddress }) {
  const [ownedTokens, setOwnedTokens] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // TODO: fetch NFTs owned by wallet
  }, [walletAddress]);

  return (
    <div>
      <h3>Your NFTs</h3>
      {loading ? (
        <p>Loading collection...</p>
      ) : (
        <div>
          {ownedTokens.map((tokenId) => (
            <div key={tokenId}>Token #{tokenId}</div>
          ))}
        </div>
      )}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-721 balanceOf, ownerOf iteration, filtering owned tokens

- Update the `WalletNFTs` component to:
  - Get wallet's NFT balance using `balanceOf(address)`.
  - Iterate through token IDs to check ownership with `ownerOf(tokenId)`.
  - Filter and collect token IDs owned by the specified wallet.
  - Display the list of owned token IDs efficiently.
