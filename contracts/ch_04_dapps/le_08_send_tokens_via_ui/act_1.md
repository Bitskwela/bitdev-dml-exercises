# Send Tokens via UI Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=http://127.0.0.1:8545
// REACT_APP_CONTRACT_ADDRESS=0xYourBaryoTokenAddress

// TokenTransfer.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function transfer(address, uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");

  const handleTransfer = async (e) => {
    e.preventDefault();

    // TODO: Task 1 - Validate inputs before sending
    // @note Check if recipient is valid address and amount is positive number

    // TODO: Task 2 - Connect wallet and create contract with signer
    // @note Request MetaMask access, create Web3Provider, get signer, instantiate contract

    // TODO: Task 3 - Execute transfer and handle confirmation
    // @note Get decimals, parse amount, call transfer(), wait for confirmation
  };

  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      <input
        placeholder="Recipient Address (0x...)"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
      />
      <input
        placeholder="Amount"
        type="number"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button type="submit" disabled={status === "pending"}>
        {status === "pending" ? "Sending..." : "Send"}
      </button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && (
        <p style={{ color: "green" }}>✅ Transfer successful!</p>
      )}
      {status === "error" && <p style={{ color: "red" }}>❌ Transfer failed</p>}
    </form>
  );
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: ERC-20 `transfer`, `Web3Provider`, Signer, `parseUnits`, transaction confirmation, input validation

---

### Task 1: Validate Inputs Before Sending

Before initiating the transfer, validate that the recipient is a valid Ethereum address and the amount is a positive number. Set appropriate error states if validation fails.

```js
if (!ethers.utils.isAddress(recipient)) {
  setStatus("error");
  alert("Invalid recipient address");
  return;
}

if (!amount || isNaN(amount) || Number(amount) <= 0) {
  setStatus("error");
  alert("Enter a valid positive amount");
  return;
}
```

---

### Task 2: Connect Wallet and Create Contract with Signer

Request MetaMask account access, create a `Web3Provider`, get the signer for transaction signing, and instantiate the contract with the signer (not provider) to enable write operations.

```js
await window.ethereum.request({ method: "eth_requestAccounts" });

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
const contract = new ethers.Contract(contractAddress, ABI, signer);
```

---

### Task 3: Execute Transfer and Handle Confirmation

Fetch the token's decimals, parse the amount using `parseUnits()`, call the `transfer()` function, wait for confirmation, and update the UI with the transaction hash and success status.

```js
try {
  setStatus("pending");
  setTxHash("");

  const decimals = await contract.decimals();
  const parsedAmount = ethers.utils.parseUnits(amount, decimals);

  const tx = await contract.transfer(recipient, parsedAmount);
  setTxHash(tx.hash);

  await tx.wait();
  setStatus("success");

  // Clear form
  setRecipient("");
  setAmount("");
} catch (err) {
  console.error("Transfer failed:", err);
  setStatus("error");
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `recipient`: State variable storing the destination wallet address. Must be validated as a proper Ethereum address using `ethers.utils.isAddress()` before sending.

- `amount`: The user-entered amount as a string. This raw input must be converted to the proper token units using `parseUnits()` with the token's decimals.

- `status`: Tracks the transaction state: empty (idle), "pending" (awaiting confirmation), "success" (completed), or "error" (failed). Used to disable the button and show appropriate feedback.

- `txHash`: The transaction hash returned immediately after submitting. Users can use this to verify the transaction on Etherscan before confirmation.

- `parsedAmount`: The BigNumber representation of the user's amount, properly scaled by the token's decimals. For example, "10.5" with 18 decimals becomes `10500000000000000000`.

**Key Functions:**

- `handleTransfer`:
  The main form submission handler. First validates inputs to prevent common errors (invalid address, zero/negative amount). Then connects to MetaMask, gets a signer for transaction signing, and creates a contract instance with write capability. Fetches the token's decimals to properly convert the amount, then calls `transfer(recipient, parsedAmount)`. The function updates status throughout to provide user feedback, and waits for blockchain confirmation using `tx.wait()` before marking success.

- `parseUnits(amount, decimals)`:
  Converts a human-readable token amount to the blockchain's internal representation. Essential because tokens store amounts as integers, not decimals. For example, `parseUnits("25.5", 18)` returns a BigNumber representing 25.5 \* 10^18.

- `tx.wait()`:
  Pauses execution until the transaction is included in a block. This ensures the transfer has actually completed before updating the UI to show success.
