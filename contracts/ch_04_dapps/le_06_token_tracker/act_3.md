# Token Transfer Form activity:

```js
// TokenTransfer.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TokenTransfer({ tokenAddress, onTransferComplete }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");

  const handleTransfer = async (e) => {
    e.preventDefault();
    // TODO: execute token transfer
  };

  return (
    <form onSubmit={handleTransfer}>
      <h3>Transfer Tokens</h3>
      <input
        placeholder="Recipient Address"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
        required
      />
      <input
        type="number"
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        required
      />
      <button type="submit" disabled={status === "pending"}>
        {status === "pending" ? "Sending..." : "Send Tokens"}
      </button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-20 transfer function, transaction execution, amount parsing with decimals

- Update the `TokenTransfer` component to:

  - Connect to MetaMask and get signer for transaction signing.
  - Parse the amount input considering token decimals using `parseUnits()`.
  - Execute the `transfer()` function with proper gas estimation.
  - Handle transaction confirmation and update UI status appropriately.
  - Call `onTransferComplete()` callback after successful transfer.

  ```js
  const handleTransfer = async (e) => {
    e.preventDefault();
    try {
      setStatus("pending");

      if (!window.ethereum) {
        throw new Error("Please install MetaMask!");
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const contract = new ethers.Contract(tokenAddress, abi, signer);
      const decimals = await contract.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      await tx.wait();

      setStatus("✅ Transfer successful!");
      setRecipient("");
      setAmount("");

      if (onTransferComplete) {
        onTransferComplete();
      }
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  };
  ```
