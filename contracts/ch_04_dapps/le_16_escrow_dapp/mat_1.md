## 🧑‍💻 Background Story

Odessa (“Det”) was on a late-night Zoom with a New York freelance client. “Send escrow first,” the client insisted before the PHP dev could start. In typical PH–NY trust issues, money either sits in a bank or gets tangled in fees. She thought, “What if we build a pure-frontend escrow DApp to simulate P2P service?”

By sunrise, Det had sketched an **Escrow** Solidity contract on her local Hardhat node. The DApp flow was simple:

1. **Buyer** deposits ETH into escrow.
2. UI shows “Pending” with deposit amount.
3. Once the freelancer (Seller) delivers, the Buyer clicks **Release** to send funds.
4. If something goes wrong, the Seller can trigger a **Refund** back to Buyer.

No backend server, no custodian—just wallet-to-wallet logic. Odessa wired React + Ethers.js: a stats panel, a deposit form, and release/refund buttons. She pre-sets Buyer & Seller addresses in `.env`, deploys on Sepolia, and shares the link with her client. Now, both PH and NY sides can see funds locked, pending, and executed—trustless and transparent.

In 30 minutes, Det presented to her WhatsApp group: “Try send 0.01 ETH – I’ll refund if not delivered!” Filipino ingenuity at its best: build fast, iterate, and earn trust one escrow at a time. 🇵🇭🤝🚀

---

## 📚 Theory & Web3 Lecture

1. Escrow Pattern  
   • **Actors**: Buyer (depositor), Seller (recipient).  
   • **Flow**: deposit → (release | refund).  
   • **State**: track `amount`, `deposited`, `released`.

2. Solidity Contract Breakdown

   ```solidity
   function deposit() external payable onlyBuyer { … }
   function release() external onlyBuyer onlyDeposited onlyNotReleased { … }
   function refund() external onlySeller onlyDeposited onlyNotReleased { … }
   ```

   • Modifiers: `onlyBuyer`, `onlySeller`, `onlyDeposited`, `onlyNotReleased`.  
   • Events: `Deposited(uint256)`, `Released(address,uint256)` for frontend reactivity.

3. Ethers.js Integration  
   • **Provider**: JsonRpcProvider or Web3Provider for MetaMask.  
   • **Signer**: for state-changing calls (`deposit`, `release`, `refund`).  
   • **Contract**:

   ```js
   const escrow = new ethers.Contract(
     process.env.REACT_APP_ESCROW_ADDRESS,
     ESCROW_ABI,
     signerOrProvider
   );
   ```

   • **Listening to Events**:

   ```js
   escrow.on("Deposited", (amt) => refreshStats());
   escrow.on("Released", (to, amt) => refreshStats());
   ```

4. React Hooks & UI  
   • `useState` for `buyer`, `seller`, `amount`, `deposited`, `released`, `error`, `loading`.  
   • `useEffect` to load initial state and subscribe to events.  
   • Forms and buttons disable when loading or unauthorized.  
   • `.env` holds `REACT_APP_RPC_URL`, `REACT_APP_ESCROW_ADDRESS`, `REACT_APP_BUYER`, `REACT_APP_SELLER`.

5. Best Practices  
   • Validate addresses with `ethers.utils.isAddress()`.  
   • Wrap async calls in `try/catch` and feedback errors.  
   • Clean up event listeners on unmount.  
   • Show spinners or disabled states during transactions.

🔗 Links  
– Ethers.js: https://docs.ethers.org/v5  
– Solidity: https://docs.soliditylang.org  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## 🧪 Exercises

### Exercise 1: EscrowStats Component

Problem Statement  
Build `EscrowStats` to read on-chain: buyer, seller, deposited amount (ETH), and status (`Pending` | `Released`).

**Solidity Contract (`SimulatedEscrow.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimulatedEscrow {
    address public buyer;
    address public seller;
    uint256 public amount;
    bool public deposited;
    bool public released;

    event Deposited(uint256 amount);
    event Released(address to, uint256 amount);

    constructor(address _buyer, address _seller) {
        buyer = _buyer;
        seller = _seller;
    }

    modifier onlyBuyer() { require(msg.sender == buyer, "only buyer"); _; }
    modifier onlySeller() { require(msg.sender == seller, "only seller"); _; }
    modifier onlyDeposited() { require(deposited, "not deposited"); _; }
    modifier onlyNotReleased() { require(!released, "already released"); _; }

    function deposit() external payable onlyBuyer {
        require(!deposited, "already deposited");
        amount = msg.value;
        deposited = true;
        emit Deposited(msg.value);
    }

    function release() external onlyBuyer onlyDeposited onlyNotReleased {
        released = true;
        payable(seller).transfer(amount);
        emit Released(seller, amount);
    }

    function refund() external onlySeller onlyDeposited onlyNotReleased {
        released = true;
        payable(buyer).transfer(amount);
        emit Released(buyer, amount);
    }
}
```

**Starter Code (`EscrowStats.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
];

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        // TODO: provider = new ethers.providers.JsonRpcProvider(RPC_URL)
        // TODO: contract = new ethers.Contract(ESCROW_ADDR, ABI, provider)
        // TODO: [b, s, a, dep, rel] = await Promise.all([...])
        // TODO: setBuyer(b), setSeller(s), setAmt(a), setDeposited(dep), setReleased(rel)
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (amt === null) return <p>Loading escrow stats…</p>;
  return (
    <div>
      <h3>Escrow Status</h3>
      <p>Buyer: {buyer}</p>
      <p>Seller: {seller}</p>
      <p>Amount: {ethers.utils.formatEther(amt)} ETH</p>
      <p>
        Status:{" "}
        {released
          ? "Released ✅"
          : deposited
          ? "Pending ⏳"
          : "Not Deposited ❌"}
      </p>
    </div>
  );
}
```

To Do List

- [ ] Initialize `provider` with `process.env.REACT_APP_RPC_URL`.
- [ ] Instantiate contract with `process.env.REACT_APP_ESCROW_ADDRESS`.
- [ ] Call `buyer()`, `seller()`, `amount()`, `deposited()`, `released()`.
- [ ] Update state accordingly.

**Full Solution**

```js
// EscrowStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        const escrow = new ethers.Contract(ADDR, ABI, provider);
        const [b, s, a, dep, rel] = await Promise.all([
          escrow.buyer(),
          escrow.seller(),
          escrow.amount(),
          escrow.deposited(),
          escrow.released(),
        ]);
        setBuyer(b);
        setSeller(s);
        setAmt(a);
        setDeposited(dep);
        setReleased(rel);
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (amt === null) return <p>Loading escrow stats…</p>;
  return (
    <div>
      <h3>Escrow Status</h3>
      <p>Buyer: {buyer}</p>
      <p>Seller: {seller}</p>
      <p>Amount: {ethers.utils.formatEther(amt)} ETH</p>
      <p>
        Status:{" "}
        {released
          ? "Released ✅"
          : deposited
          ? "Pending ⏳"
          : "Not Deposited ❌"}
      </p>
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_ESCROW_ADDRESS=0xYourEscrowAddress
```

---

### Exercise 2: DepositFunds Component

Problem Statement  
Create `DepositFunds` that lets the **Buyer** deposit ETH into escrow. After success, call a callback to refresh stats.

**Starter Code (`DepositFunds.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function deposit() payable"];

export default function DepositFunds({ onDeposited }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function deposit() {
    try {
      // TODO: ensure amount > 0
      // TODO: await window.ethereum.request({ method: "eth_requestAccounts" })
      // TODO: provider = new Web3Provider(window.ethereum)
      // TODO: signer = provider.getSigner()
      // TODO: escrow = new Contract(ESCROW_ADDR, ABI, signer)
      // TODO: tx = await escrow.deposit({ value: parseEther(amount) })
      // TODO: await tx.wait(), onDeposited(), clear amount
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Deposit Funds</h4>
      <input
        placeholder="ETH amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button onClick={deposit}>Deposit</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

To Do List

- [ ] Validate `amount` is numeric & > 0.
- [ ] Request accounts and get signer.
- [ ] Call `deposit()` with `{ value: parseEther(amount) }`.
- [ ] Wait for tx, then `onDeposited()`.

**Full Solution**

```js
// DepositFunds.js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function deposit() payable"];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function DepositFunds({ onDeposited }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function deposit() {
    setError("");
    if (!amount || isNaN(amount) || Number(amount) <= 0) {
      setError("Enter a valid amount");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const escrow = new ethers.Contract(ADDR, ABI, signer);
      const tx = await escrow.deposit({
        value: ethers.utils.parseEther(amount),
      });
      await tx.wait();
      setAmount("");
      onDeposited();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Deposit Funds</h4>
      <input
        placeholder="ETH amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button onClick={deposit}>Deposit</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

### Exercise 3: ReleaseControls Component

Problem Statement  
Build `ReleaseControls` showing **Release** (for Buyer) and **Refund** (for Seller) buttons. Each calls the respective contract method and triggers a refresh.

**Starter Code (`ReleaseControls.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
  "function release()",
  "function refund()",
];

export default function ReleaseControls({ onAction }) {
  const [account, setAccount] = useState("");
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);

  useEffect(() => {
    async function load() {
      // TODO: request accounts, get provider, contract
      // TODO: set account, buyer, seller, deposited, released
    }
    load();
  }, []);

  async function doRelease() {
    // TODO: get signer & call release(), await tx.wait(), onAction()
  }

  async function doRefund() {
    // TODO: get signer & call refund(), await tx.wait(), onAction()
  }

  return (
    <div>
      {deposited && !released && (
        <div>
          {account.toLowerCase() === buyer.toLowerCase() && (
            <button onClick={doRelease}>Release Funds</button>
          )}
          {account.toLowerCase() === seller.toLowerCase() && (
            <button onClick={doRefund}>Refund Buyer</button>
          )}
        </div>
      )}
    </div>
  );
}
```

To Do List

- [ ] On mount, fetch current `account`, `buyer`, `seller`, `deposited`, `released`.
- [ ] Implement `doRelease()` and `doRefund()` with signer, contract call, `await tx.wait()`, then `onAction()`.

**Full Solution**

```js
// ReleaseControls.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
  "function release()",
  "function refund()",
];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function ReleaseControls({ onAction }) {
  const [account, setAccount] = useState("");
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);

  useEffect(() => {
    async function load() {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const [acct] = await window.ethereum.request({ method: "eth_accounts" });
      setAccount(acct);
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const escrow = new ethers.Contract(ADDR, ABI, provider);
      const [b, s, dep, rel] = await Promise.all([
        escrow.buyer(),
        escrow.seller(),
        escrow.deposited(),
        escrow.released(),
      ]);
      setBuyer(b);
      setSeller(s);
      setDeposited(dep);
      setReleased(rel);
    }
    load();
  }, []);

  async function doRelease() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const escrow = new ethers.Contract(ADDR, ABI, signer);
    const tx = await escrow.release();
    await tx.wait();
    onAction();
  }

  async function doRefund() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const escrow = new ethers.Contract(ADDR, ABI, signer);
    const tx = await escrow.refund();
    await tx.wait();
    onAction();
  }

  if (!deposited || released) return null;
  return (
    <div>
      {account.toLowerCase() === buyer.toLowerCase() && (
        <button onClick={doRelease}>Release Funds</button>
      )}
      {account.toLowerCase() === seller.toLowerCase() && (
        <button onClick={doRefund}>Refund Buyer</button>
      )}
    </div>
  );
}
```

---

## ✅ Test Cases

Create `__tests__/EscrowApp.test.js`:

```js
// __tests__/EscrowApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import EscrowStats from "../EscrowStats";
import DepositFunds from "../DepositFunds";
import ReleaseControls from "../ReleaseControls";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Escrow DApp Components", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    buyer: jest.fn(),
    seller: jest.fn(),
    amount: jest.fn(),
    deposited: jest.fn(),
    released: jest.fn(),
    deposit: jest.fn(),
    release: jest.fn(),
    refund: jest.fn(),
  };

  beforeEach(() => {
    // Mock window.ethereum
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xBUYER"]),
    };
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({
      getSigner: () => fakeSigner,
    });
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("loads escrow stats", async () => {
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.amount.mockResolvedValue(ethers.utils.parseEther("0.5"));
    fakeContract.deposited.mockResolvedValue(true);
    fakeContract.released.mockResolvedValue(false);

    render(<EscrowStats />);
    expect(await screen.findByText(/Buyer:/)).toHaveTextContent("0xBUYER");
    expect(screen.getByText(/Seller:/)).toHaveTextContent("0xSELLER");
    expect(screen.getByText(/Amount:/)).toHaveTextContent("0.5");
    expect(screen.getByText(/Status:/)).toHaveTextContent("Pending");
  });

  it("deposits funds and calls onDeposited", async () => {
    fakeContract.deposit.mockResolvedValue({ wait: () => Promise.resolve() });
    const onDeposited = jest.fn();
    render(<DepositFunds onDeposited={onDeposited} />);
    fireEvent.change(screen.getByPlaceholderText("ETH amount"), {
      target: { value: "0.3" },
    });
    fireEvent.click(screen.getByText("Deposit"));
    await waitFor(() => expect(fakeContract.deposit).toHaveBeenCalled());
    expect(onDeposited).toHaveBeenCalled();
  });

  it("releases funds when buyer clicks", async () => {
    // Setup ReleaseControls state
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.deposited.mockResolvedValue(true);
    fakeContract.released.mockResolvedValue(false);
    fakeContract.release.mockResolvedValue({ wait: () => Promise.resolve() });

    const onAction = jest.fn();
    render(<ReleaseControls onAction={onAction} />);
    // Wait for buttons to load
    await waitFor(() => screen.getByText("Release Funds"));
    fireEvent.click(screen.getByText("Release Funds"));
    await waitFor(() => expect(fakeContract.release).toHaveBeenCalled());
    expect(onAction).toHaveBeenCalled();
  });

  it("refunds funds when seller clicks", async () => {
    // Simulate current account as seller
    global.window.ethereum.request.mockResolvedValue(["0xSELLER"]);
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.deposited.mockResolvedValue(true);
    fakeContract.released.mockResolvedValue(false);
    fakeContract.refund.mockResolvedValue({ wait: () => Promise.resolve() });

    const onAction = jest.fn();
    render(<ReleaseControls onAction={onAction} />);
    await waitFor(() => screen.getByText("Refund Buyer"));
    fireEvent.click(screen.getByText("Refund Buyer"));
    await waitFor(() => expect(fakeContract.refund).toHaveBeenCalled());
    expect(onAction).toHaveBeenCalled();
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

Odessa shared the link: PH Buyer deposits 0.02 ETH, NY Seller delivers code, clicks **Release**, and funds ring in—no middleman, no delays. Her freelancing group chat lit up: “Smooth, secure, sobrang Pinoy!” Next sprint: add arbiter voting and IPFS proof-of-work. Det’s escrow DApp is just the start of a borderless gig economy. 🇵🇭🤝🌐
