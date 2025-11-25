# Token Tracker Activity

## Initial Code

```solidity
// BaryoToken.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BaryoToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("BaryoToken", "BARYO") {
        _mint(msg.sender, initialSupply);
    }
}
```

```js
// TokenTracker.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  const [account, setAccount] = useState("");

  useEffect(() => {
    // TODO: Fetch token info
  }, [tokenAddress]);

  const fetchBalance = async () => {
    // TODO: Fetch user's token balance
  };

  return (
    <div>
      <h2>Token Information</h2>
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
      <hr />
      <button onClick={fetchBalance}>Fetch My Balance</button>
      {balance && <p>Your Balance: {balance}</p>}
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: ERC-20 standard functions, `Promise.all`, BigNumber formatting, `formatUnits`, token balance display

---

### Task 1: Validate Address and Create Contract Instance

Inside the `useEffect`, validate the token address using `ethers.utils.isAddress()`, create a `JsonRpcProvider`, and instantiate the ERC-20 contract.

```js
if (!ethers.utils.isAddress(tokenAddress)) {
  console.error("Invalid token address");
  return;
}

const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);

const contract = new ethers.Contract(tokenAddress, ABI, provider);
```

---

### Task 2: Fetch Token Metadata Using Promise.all

Call `name()`, `symbol()`, and `decimals()` in parallel using `Promise.all` for efficient data fetching. Update the `info` state with the fetched values.

```js
useEffect(() => {
  const fetchTokenInfo = async () => {
    if (!ethers.utils.isAddress(tokenAddress)) return;

    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(tokenAddress, ABI, provider);

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

---

### Task 3: Implement the fetchBalance Function

Connect to MetaMask, get the user's address, fetch their token balance using `balanceOf()`, and format it using `formatUnits()` with the token's decimals.

```js
const fetchBalance = async () => {
  try {
    const [user] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    setAccount(user);

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(tokenAddress, ABI, provider);

    const rawBalance = await contract.balanceOf(user);
    const formatted = ethers.utils.formatUnits(rawBalance, info.decimals);
    setBalance(`${formatted} ${info.symbol}`);
  } catch (err) {
    console.error("Error fetching balance:", err);
  }
};
```

---

## Complete Solution

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  const [account, setAccount] = useState("");

  useEffect(() => {
    const fetchTokenInfo = async () => {
      if (!ethers.utils.isAddress(tokenAddress)) return;

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

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

  const fetchBalance = async () => {
    try {
      const [user] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(user);

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      const rawBalance = await contract.balanceOf(user);
      const formatted = ethers.utils.formatUnits(rawBalance, info.decimals);
      setBalance(`${formatted} ${info.symbol}`);
    } catch (err) {
      console.error("Error fetching balance:", err);
    }
  };

  return (
    <div>
      <h2>Token Information</h2>
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
      <hr />
      <button onClick={fetchBalance}>Fetch My Balance</button>
      {balance && <p>Your Balance: {balance}</p>}
    </div>
  );
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `info`: A state object containing the token's metadata: `name` (human-readable name like "BaryoToken"), `symbol` (ticker like "BARYO"), and `decimals` (precision, typically 18). This data is fetched once when the component mounts or when `tokenAddress` changes.

- `balance`: A formatted string displaying the user's token balance with the symbol (e.g., "125.50 BARYO"). Uses `formatUnits` to convert the raw BigNumber to a human-readable decimal.

- `account`: The connected wallet address. Obtained from MetaMask when the user clicks "Fetch My Balance".

- `ABI`: The Application Binary Interface defining the ERC-20 functions we're calling. Uses Ethers.js human-readable format for simplicity.

**Key Functions:**

- `fetchTokenInfo` (inside useEffect):
  An async function that validates the token address, creates a read-only provider and contract instance, then fetches `name()`, `symbol()`, and `decimals()` in parallel using `Promise.all`. Parallel fetching is more efficient than sequential calls because all three RPC requests happen simultaneously. The results are stored in the `info` state.

- `fetchBalance`:
  An async function triggered by user action. It connects to MetaMask via `eth_requestAccounts`, gets the user's wallet address, then calls `balanceOf(address)` to get their raw token balance. The raw balance is a BigNumber (e.g., 125500000000000000000), which is converted to a readable format using `formatUnits(rawBalance, decimals)`. This produces a string like "125.5" which is combined with the symbol for display.
