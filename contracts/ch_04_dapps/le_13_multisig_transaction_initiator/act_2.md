# Activity 2: Submit a New Proposal

**Time**: 10 minutes  
**Goal**: Create a `SubmitProposal` component that takes `to`, `value` (in ETH), and `data` (hex) inputs, calls `submitTransaction()`, awaits confirmation, and triggers a callback to reload the list.

## Background

In multisig wallets, any owner can propose transactions that need approval from other owners before execution. This activity focuses on the proposal submission interface.

## Starter Code

Create `SubmitProposal.js`:

```javascript
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function submitTransaction(address,uint256,bytes) returns (uint256)",
];

export default function SubmitProposal({ contractAddress, onSubmitted }) {
  const [to, setTo] = useState("");
  const [value, setValue] = useState("");
  const [data, setData] = useState("0x");
  const [txId, setTxId] = useState(null);
  const [error, setError] = useState("");

  async function submit() {
    try {
      // TODO: validate inputs
      // TODO: request accounts, get signer
      // TODO: parseEther(value), call submitTransaction(to, parsed, data)
      // TODO: await tx.wait(), read event or returned txId
      // TODO: setTxId and call onSubmitted()
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>New Proposal</h4>
      <input
        placeholder="To Address"
        value={to}
        onChange={(e) => setTo(e.target.value)}
      />
      <input
        placeholder="Value (ETH)"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
      <input
        placeholder="Data (hex)"
        value={data}
        onChange={(e) => setData(e.target.value)}
      />
      <button onClick={submit}>Submit</button>
      {txId !== null && <p>Submitted TX ID: {txId}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## To Do List

- [ ] Validate `to` with `ethers.utils.isAddress()`
- [ ] Parse `value` via `ethers.utils.parseEther(value)`
- [ ] Call `window.ethereum.request({ method: "eth_requestAccounts" })`
- [ ] Get `signer = provider.getSigner()` and `wallet` contract
- [ ] `const tx = await wallet.submitTransaction(to, parsed, data)`
- [ ] `const receipt = await tx.wait()` and extract `txId` from `Submit` event
- [ ] `onSubmitted()`, `setTxId(txId)`

## Key Concepts

- **Input Validation**: Ensure addresses are valid and values are numeric
- **Signer Pattern**: Write transactions require MetaMask signer, not just provider
- **Event Parsing**: Extract transaction ID from blockchain events
- **Callback Integration**: Notify parent component to refresh data

## Full Solution

```javascript
// SubmitProposal.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "event Submit(uint indexed txId, address indexed proposer)",
  "function submitTransaction(address,uint256,bytes) returns (uint256)",
];

export default function SubmitProposal({ contractAddress, onSubmitted }) {
  const [to, setTo] = useState("");
  const [value, setValue] = useState("");
  const [data, setData] = useState("0x");
  const [txId, setTxId] = useState(null);
  const [error, setError] = useState("");

  async function submit() {
    setError("");
    setTxId(null);
    if (!ethers.utils.isAddress(to)) return setError("Invalid address");
    if (isNaN(value) || Number(value) < 0) return setError("Invalid value");
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const wallet = new ethers.Contract(contractAddress, ABI, signer);
      const parsed = ethers.utils.parseEther(value);
      const tx = await wallet.submitTransaction(to, parsed, data);
      const receipt = await tx.wait();
      const ev = receipt.events.find((e) => e.event === "Submit");
      const newId = ev.args.txId.toNumber();
      setTxId(newId);
      onSubmitted();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div style={{ margin: "16px 0" }}>
      <h4>New Proposal</h4>
      <input
        style={{ width: "100%", margin: "4px 0" }}
        placeholder="To Address"
        value={to}
        onChange={(e) => setTo(e.target.value)}
      />
      <input
        style={{ width: "100%", margin: "4px 0" }}
        placeholder="Value (ETH)"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
      <input
        style={{ width: "100%", margin: "4px 0" }}
        placeholder="Data (hex)"
        value={data}
        onChange={(e) => setData(e.target.value)}
      />
      <button onClick={submit}>Submit</button>
      {txId !== null && <p>Submitted TX ID: {txId}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```
