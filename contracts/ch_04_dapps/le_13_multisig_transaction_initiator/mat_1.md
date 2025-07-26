## 🧑‍💻 Background Story

Odessa sat in a chic SoHo café, sipping kapeng barako over Zoom with her New York mentor. “In the Philippines, corporate boards need at least three of five signatures to greenlight a decision,” she explained. “Kung wala kang quorum, wala kang chain move.” Inspired by this real-world governance rule, she sketched a UI for a Multisig DApp: a proposal form, a live list of pending transactions, and signer buttons that flip green when each of the five owners signs off.

Back in her Makati apartment, Det spun up Hardhat and coded a `MultisigWallet.sol` with five owners and a threshold of three. She deployed it on Sepolia; next, she scaffolded a React app with Create React App. In under 30 minutes, she had:

1. A **Proposal Form** where board members enter destination address, ETH value, and call data.
2. A **Proposal List** showing each tx’s ID, to-address, value, data preview, confirmation count, and “Execute” button (disabled until quorum).
3. **Confirm Buttons** for each owner—simulated via MetaMask’s multiple accounts—so Det could log in as Owner #1, #2, #3, etc.

Every time an owner clicked “Confirm,” the UI listened to the `Confirmation` event, updated the confirmation tally, and marked that owner in the proposal’s row. Once three signatures were in, the “Execute” button lit up, and a follow-up click triggered the on-chain call.

By midnight, Odessa demoed to her mentor: “See? Three signatures, transaction executed, and funds moved.” Her mentor nodded, impressed that Filipino governance customs had been encoded in Solidity and rendered in a sleek React UI. That night, under the glow of neon jeepneys, Det toasted: “To real-world multisig, PH style!” 🇵🇭🔐🚀

---

## 📚 Theory & Web3 Lecture

1. Multisig Wallet Pattern  
   • Owners & threshold: security by committee.  
   • Proposals stored on-chain: struct with `to`, `value`, `data`, `executed`, confirmation count.  
   • Confirmation mapping: each owner can sign once per tx.  
   • Events: `Submit`, `Confirmation`, `Execution` for frontend reactivity.

2. Contract Functions & ABI  
   • `submitTransaction(address to, uint256 value, bytes data) returns (uint256 txId)`  
   • `confirmTransaction(uint256 txId)`  
   • `executeTransaction(uint256 txId)`  
   • Views: `getTransactionCount()`, `transactions(uint256)`, `isConfirmed(uint256, address)`, `getConfirmations(uint256)`.

3. Ethers.js & React Integration  
   • Provider: `new ethers.providers.Web3Provider(window.ethereum)`  
   • Signer: `provider.getSigner()` for state-changing calls  
   • Contract:

   ```js
   const wallet = new ethers.Contract(
     process.env.REACT_APP_MULTISIG_ADDRESS,
     MULTISIG_ABI,
     signerOrProvider
   );
   ```

   • Listening to events:

   ```js
   wallet.on("Confirmation", (owner, txId) => {
     // update UI state
   });
   ```

4. React Hooks & State  
   • useState: `proposals`, `loading`, `error`  
   • useEffect: on-mount load proposals & subscribe to events  
   • Async handlers: `try/catch`, `await tx.wait()`  
   • Quorum logic: disable “Execute” until confirmations ≥ threshold

5. UX & Security  
   • Validate input address with `ethers.utils.isAddress()`  
   • Ensure only owners see confirm buttons  
   • Clean up event listeners in `useEffect` cleanup  
   • Use `.env` for RPC URL & contract address

🔗 Links  
– Ethers.js: https://docs.ethers.org/v5  
– Solidity Multisig example: https://docs.openzeppelin.com/contracts/4.x/api/governance

---

## 🧪 Exercises

### Exercise 1: List All Proposals

Problem Statement  
Build a `ProposalList` component that connects to MetaMask, fetches `getTransactionCount()`, loops through `transactions(i)`, and renders each proposal’s ID, to-address, ETH value, data (hex snippet), executed flag, and current confirmation count.

**Solidity Contract (`MultisigWallet.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultisigWallet {
    event Submit(uint indexed txId, address indexed proposer);
    event Confirmation(address indexed owner, uint indexed txId);
    event Execution(uint indexed txId, bool success);

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public threshold;

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;

    constructor(address[] memory _owners, uint _threshold) {
        require(_owners.length >= _threshold, "owners < threshold");
        threshold = _threshold;
        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "zero owner");
            require(!isOwner[owner], "duplicate owner");
            isOwner[owner] = true;
            owners.push(owner);
        }
    }

    function submitTransaction(address _to, uint _value, bytes calldata _data)
        external onlyOwner returns (uint txId)
    {
        txId = transactions.length;
        transactions.push(
            Transaction({ to: _to, value: _value, data: _data, executed: false, numConfirmations: 0 })
        );
        emit Submit(txId, msg.sender);
    }

    function confirmTransaction(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) notConfirmed(_txId, msg.sender) {
        confirmations[_txId][msg.sender] = true;
        transactions[_txId].numConfirmations += 1;
        emit Confirmation(msg.sender, _txId);
    }

    function executeTransaction(uint _txId)
        external onlyOwner txExists(_txId) notExecuted(_txId)
    {
        Transaction storage txn = transactions[_txId];
        require(txn.numConfirmations >= threshold, "not enough confirmations");
        txn.executed = true;
        (bool success, ) = txn.to.call{ value: txn.value }(txn.data);
        emit Execution(_txId, success);
    }

    modifier onlyOwner() { require(isOwner[msg.sender], "not owner"); _; }
    modifier txExists(uint _txId) { require(_txId < transactions.length, "tx !exists"); _; }
    modifier notExecuted(uint _txId) { require(!transactions[_txId].executed, "tx executed"); _; }
    modifier notConfirmed(uint _txId, address _owner) { require(!confirmations[_txId][_owner], "already confirmed"); _; }

    receive() external payable {}
}
```

**Starter Code (`ProposalList.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
  "function confirmations(uint256, address) view returns (bool)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const wallet = new ethers.Contract(contractAddress, ABI, provider);

        const count = (await wallet.getTransactionCount()).toNumber();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [to, value, data, executed, numConfirmations] =
            await wallet.transactions(i);
          items.push({
            id: i,
            to,
            value: ethers.utils.formatEther(value),
            data: data.slice(0, 10) + "…",
            executed,
            numConfirmations: numConfirmations.toNumber(),
          });
        }
        setProposals(items);
      } catch (err) {
        setError(err.message);
      }
    }
    loadProposals();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Multisig Proposals</h3>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ borderBottom: "1px solid #ccc", padding: "8px 0" }}
        >
          <p>
            <strong>ID #{p.id}</strong>
          </p>
          <p>To: {p.to}</p>
          <p>Value: {p.value} ETH</p>
          <p>Data: {p.data}</p>
          <p>Confirmations: {p.numConfirmations}</p>
          <p>Executed: {p.executed ? "✅" : "❌"}</p>
        </div>
      ))}
    </div>
  );
}
```

To Do List

- [ ] Request accounts via `eth_requestAccounts`
- [ ] Instantiate `provider` & `wallet` contract
- [ ] Call `getTransactionCount()`
- [ ] Loop `i < count`, `wallet.transactions(i)`
- [ ] Format `value` with `ethers.utils.formatEther`
- [ ] `setProposals(items)`

---

### Exercise 2: Submit a New Proposal

Problem Statement  
Create a `SubmitProposal` component that takes `to`, `value` (in ETH), and `data` (hex) inputs, calls `submitTransaction()`, awaits confirmation, and triggers a callback to reload the list.

**Starter Code (`SubmitProposal.js`)**

```js
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

To Do List

- [ ] Validate `to` with `ethers.utils.isAddress()`
- [ ] Parse `value` via `ethers.utils.parseEther(value)`
- [ ] Call `window.ethereum.request({ method: "eth_requestAccounts" })`
- [ ] Get `signer = provider.getSigner()` and `wallet` contract
- [ ] `const tx = await wallet.submitTransaction(to, parsed, data)`
- [ ] `const receipt = await tx.wait()` and extract `txId` from `Submit` event
- [ ] `onSubmitted()`, `setTxId(txId)`

**Full Solution**

```js
// SubmitProposal.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "event Submit(uint indexed txId, address indexed proposer)",
  "function submitTransaction(address,uint256,bytes) returns (uint256)",
];
const RPC = process.env.REACT_APP_RPC_URL;

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

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_MULTISIG_ADDRESS=0xYourMultisigAddress
```

---

### Exercise 3: Confirm a Proposal

Problem Statement  
Build a `ConfirmButton` component that shows “Confirm” or “Confirmed” for a given `txId`. Clicking it calls `confirmTransaction(txId)`, awaits confirmation, and triggers a reload.

**Starter Code (`ConfirmButton.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function isOwner(address) view returns (bool)",
  "function confirmations(uint256,address) view returns (bool)",
  "function confirmTransaction(uint256)",
];

export default function ConfirmButton({ contractAddress, txId, onConfirmed }) {
  const [confirmed, setConfirmed] = useState(false);

  useEffect(() => {
    async function check() {
      // TODO: provider & contract
      // TODO: get signer account
      // TODO: call confirmations(txId, account) and setConfirmed
    }
    check();
  }, [txId]);

  async function confirmTx() {
    try {
      // TODO: request accounts, get signer, call confirmTransaction(txId), await tx.wait()
      // TODO: setConfirmed(true) and onConfirmed()
    } catch (err) {
      console.error(err);
    }
  }

  return (
    <button onClick={confirmTx} disabled={confirmed}>
      {confirmed ? "✅ Confirmed" : "Confirm"}
    </button>
  );
}
```

To Do List

- [ ] Get current account with `eth_requestAccounts`
- [ ] Provider & contract with ABI & signer
- [ ] Call `confirmations(txId, account)` in `useEffect`
- [ ] In `confirmTx()`, call `confirmTransaction(txId)`, `await tx.wait()`, `setConfirmed(true)`, `onConfirmed()`

**Full Solution**

```js
// ConfirmButton.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function confirmations(uint256,address) view returns (bool)",
  "function confirmTransaction(uint256)",
];

export default function ConfirmButton({ contractAddress, txId, onConfirmed }) {
  const [confirmed, setConfirmed] = useState(false);

  useEffect(() => {
    async function check() {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const wallet = new ethers.Contract(contractAddress, ABI, provider);
      const did = await wallet.confirmations(txId, account);
      setConfirmed(did);
    }
    check();
  }, [txId, contractAddress]);

  async function confirmTx() {
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const wallet = new ethers.Contract(contractAddress, ABI, signer);
      const tx = await wallet.confirmTransaction(txId);
      await tx.wait();
      setConfirmed(true);
      onConfirmed();
    } catch (err) {
      console.error(err);
    }
  }

  return (
    <button onClick={confirmTx} disabled={confirmed}>
      {confirmed ? "✅ Confirmed" : "Confirm"}
    </button>
  );
}
```

---

## ✅ Test Cases

Create `__tests__/MultisigUI.test.js`:

```js
// __tests__/MultisigUI.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import ProposalList from "../ProposalList";
import SubmitProposal from "../SubmitProposal";
import ConfirmButton from "../ConfirmButton";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Multisig UI Integration", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    getTransactionCount: jest.fn(),
    transactions: jest.fn(),
    submitTransaction: jest.fn(),
    confirmations: jest.fn(),
    confirmTransaction: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("lists proposals", async () => {
    fakeContract.getTransactionCount.mockResolvedValue({ toNumber: () => 1 });
    fakeContract.transactions.mockResolvedValue([
      "0xTo",
      ethers.BigNumber.from("1000000000000000000"),
      "0x1234",
      false,
      ethers.BigNumber.from("2"),
    ]);
    render(<ProposalList contractAddress="0xWallet" />);
    expect(await screen.findByText(/ID #0/)).toBeInTheDocument();
  });

  it("submits a new proposal", async () => {
    const receipt = {
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Submit", args: { txId: ethers.BigNumber.from("5") } },
          ],
        }),
    };
    fakeContract.submitTransaction.mockResolvedValue(receipt);
    const onSubmitted = jest.fn();
    render(
      <SubmitProposal contractAddress="0xWallet" onSubmitted={onSubmitted} />
    );
    fireEvent.change(screen.getByPlaceholderText("To Address"), {
      target: { value: "0xTo" },
    });
    fireEvent.change(screen.getByPlaceholderText("Value (ETH)"), {
      target: { value: "1" },
    });
    fireEvent.change(screen.getByPlaceholderText("Data (hex)"), {
      target: { value: "0x1234" },
    });
    fireEvent.click(screen.getByText("Submit"));
    await waitFor(() => screen.getByText(/Submitted TX ID: 5/));
    expect(onSubmitted).toHaveBeenCalled();
  });

  it("confirms a proposal", async () => {
    fakeContract.confirmations.mockResolvedValue(false);
    const onConfirmed = jest.fn();
    render(
      <ConfirmButton
        contractAddress="0xWallet"
        txId={0}
        onConfirmed={onConfirmed}
      />
    );
    await waitFor(() => screen.getByText("Confirm"));
    fireEvent.click(screen.getByText("Confirm"));
    await waitFor(() =>
      expect(fakeContract.confirmTransaction).toHaveBeenCalledWith(0)
    );
    expect(onConfirmed).toHaveBeenCalled();
  });
});
```

jest.config.js:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

With her Multisig UI live, Odessa clicked through a full governance cycle: propose, three confirmations, execute. Her NY mentor gave a thumbs-up on Zoom: “Exactly PH-style corporate security.” Next up: transaction execution and on-chain audit logs—Det’s multisig saga is just beginning. Mabuhay decentralized governance! 🇵🇭🔐🚀
