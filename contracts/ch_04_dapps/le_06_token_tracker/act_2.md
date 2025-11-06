# Wallet Token Balance activity:

```js
// TokenBalance.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenBalance({ tokenAddress, walletAddress }) {
  const [balance, setBalance] = useState("0");
  const [decimals, setDecimals] = useState(18);

  useEffect(() => {
    // TODO: fetch wallet's token balance
  }, [tokenAddress, walletAddress]);

  const formatBalance = (raw, decimals) => {
    return ethers.utils.formatUnits(raw, decimals);
  };

  return (
    <div>
      <h3>Your Balance</h3>
      <p>{formatBalance(balance, decimals)} tokens</p>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-20 balanceOf function, token decimals handling, BigNumber formatting

- Update the `TokenBalance` component to:

  - Fetch the connected wallet's token balance using `balanceOf()`.
  - Get token decimals to properly format the balance display.
  - Handle BigNumber conversion to human-readable format.
  - Use `ethers.utils.formatUnits()` for proper decimal formatting.

  ```js
  useEffect(() => {
    const fetchBalance = async () => {
      if (!tokenAddress || !walletAddress) return;

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, abi, provider);

      const [balanceRaw, decimalsValue] = await Promise.all([
        contract.balanceOf(walletAddress),
        contract.decimals(),
      ]);

      setBalance(balanceRaw.toString());
      setDecimals(decimalsValue);
    };

    fetchBalance();
  }, [tokenAddress, walletAddress]);
  ```
