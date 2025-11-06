# Balance Update After Transfer activity:

```js
// TransferWithBalance.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TransferWithBalance({ walletAddress }) {
  const [balance, setBalance] = useState("0");
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");

  const refreshBalance = async () => {
    // TODO: fetch current balance
  };

  useEffect(() => {
    refreshBalance();
  }, [walletAddress]);

  const handleTransfer = async (e) => {
    e.preventDefault();
    // TODO: execute transfer and refresh balance
  };

  return (
    <div>
      <p>Your Balance: {ethers.utils.formatEther(balance)} tokens</p>
      <form onSubmit={handleTransfer}>
        <input
          placeholder="Recipient"
          value={recipient}
          onChange={(e) => setRecipient(e.target.value)}
        />
        <input
          placeholder="Amount"
          value={amount}
          onChange={(e) => setAmount(e.target.value)}
        />
        <button type="submit">Transfer</button>
      </form>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Balance refresh after transactions, state synchronization, UI updates

- Update the `TransferWithBalance` component to:
  - Fetch wallet balance using `balanceOf()` function.
  - Execute token transfer with proper error handling.
  - Refresh balance after successful transfer completion.
  - Maintain accurate balance display throughout the process.
