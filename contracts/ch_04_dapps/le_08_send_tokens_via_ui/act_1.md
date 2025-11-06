# Basic Token Transfer Form activity:

```js
// TokenTransferForm.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenTransferForm() {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    // TODO: execute token transfer transaction
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Send Tokens</h3>
      <input
        placeholder="Recipient Address"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
      />
      <input
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button type="submit">Send</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-20 transfer, Web3Provider, transaction signing, error handling

- Update the `TokenTransferForm` component to:
  - Connect to MetaMask and get signer for transaction execution.
  - Parse amount with proper decimals using `parseUnits()`.
  - Execute `transfer()` function with recipient and parsed amount.
  - Handle transaction confirmation and display status updates.
