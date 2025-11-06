# Total Minted Counter activity:

```js
// TotalMinted.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function TotalMinted() {
  const [total, setTotal] = useState(null);
  useEffect(() => {
    // TODO
  }, []);
  return <p>Total Minted: {total ?? "Loading..."}</p>;
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA_KEY
REACT_APP_CONTRACT_ADDRESS=0xYourSimpleNFTAddress
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: BigNumber handling, contract state reading, async data fetching, number conversion

- Update the `useEffect` inside the `TotalMinted` component to:

  - Call `contract.totalMinted()` to get the current count of minted tokens.
  - Convert BigNumber result to a regular JavaScript number for display.
  - Handle the async operation properly in useEffect.
  - Display the total count or "Loading..." while fetching.

  ```js
  useEffect(() => {
    async function loadTotal() {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );
      const bn = await contract.totalMinted();
      setTotal(bn.toNumber());
    }
    loadTotal();
  }, []);
  ```
