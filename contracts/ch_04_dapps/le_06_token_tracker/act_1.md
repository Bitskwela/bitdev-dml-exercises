# Token Info Display activity:

```js
// TokenInfo.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenInfo({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });

  useEffect(() => {
    // TODO: fetch token info
  }, [tokenAddress]);

  return (
    <div>
      <h2>Token Information</h2>
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-20 standard functions, contract metadata reading, parallel async calls

- Update the `TokenInfo` component to:

  - Create provider and contract instance for the ERC-20 token.
  - Call `name()`, `symbol()`, and `decimals()` functions simultaneously.
  - Use Promise.all for efficient parallel data fetching.
  - Update component state with the fetched token metadata.

  ```js
  useEffect(() => {
    const fetchTokenInfo = async () => {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, abi, provider);

      const [name, symbol, decimals] = await Promise.all([
        contract.name(),
        contract.symbol(),
        contract.decimals(),
      ]);

      setInfo({ name, symbol, decimals });
    };

    if (tokenAddress) {
      fetchTokenInfo();
    }
  }, [tokenAddress]);
  ```
