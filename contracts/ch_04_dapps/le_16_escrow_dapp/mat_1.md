## 🧑‍💻 Background Story

![Escrow DApp Banner](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+16.0+-+COVER.png)

Odessa ("Det") was on a late-night Zoom with a New York freelance client. "Send escrow first," the client insisted before the PHP dev could start. In typical PH–NY trust issues, money either sits in a bank or gets tangled in fees. She thought, "What if we build a pure-frontend escrow DApp to simulate P2P service?"

![Freelance Escrow Concept](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+16.1.png)

By sunrise, Det had sketched an **Escrow** Solidity contract on her local Hardhat node. The DApp flow was simple:

1. **Buyer** deposits ETH into escrow.
2. UI shows "Pending" with deposit amount.
3. Once the freelancer (Seller) delivers, the Buyer clicks **Release** to send funds.
4. If something goes wrong, the Seller can trigger a **Refund** back to Buyer.

No backend server, no custodian—just wallet-to-wallet logic. Odessa wired React + Ethers.js: a stats panel, a deposit form, and release/refund buttons. She pre-sets Buyer & Seller addresses in `.env`, deploys on Sepolia, and shares the link with her client. Now, both PH and NY sides can see funds locked, pending, and executed—trustless and transparent.

In 30 minutes, Det presented to her WhatsApp group: "Try send 0.01 ETH – I'll refund if not delivered!" Filipino ingenuity at its best: build fast, iterate, and earn trust one escrow at a time. 🇵🇭🤝🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build an **Escrow DApp** that enables trustless P2P transactions. A buyer deposits funds, and only after the seller delivers can the buyer release payment—or the seller can request a refund if something goes wrong.

---

### 📐 Escrow Flow Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      ESCROW FLOW                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌──────────────┐                        ┌──────────────┐      │
│   │    BUYER     │                        │    SELLER    │      │
│   │  (Depositor) │                        │  (Recipient) │      │
│   └──────┬───────┘                        └──────┬───────┘      │
│          │                                       │              │
│          │  deposit() ─────────────┐             │              │
│          │                         │             │              │
│          ▼                         ▼             │              │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                   ESCROW CONTRACT                        │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │  State:                                          │    │   │
│   │  │  ├── buyer: 0xBuyer                              │    │   │
│   │  │  ├── seller: 0xSeller                            │    │   │
│   │  │  ├── amount: 1 ETH                               │    │   │
│   │  │  ├── deposited: true                             │    │   │
│   │  │  └── released: false                             │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   │                         │                                │   │
│   │           ┌─────────────┴─────────────┐                 │   │
│   │           ▼                           ▼                 │   │
│   │   ┌─────────────┐             ┌─────────────┐           │   │
│   │   │  release()  │             │  refund()   │           │   │
│   │   │  (by Buyer) │             │ (by Seller) │           │   │
│   │   └──────┬──────┘             └──────┬──────┘           │   │
│   └──────────┼───────────────────────────┼──────────────────┘   │
│              │                           │                      │
│              ▼                           ▼                      │
│   ┌──────────────────┐       ┌──────────────────┐              │
│   │ Funds → Seller 💰│       │ Funds → Buyer 💰 │              │
│   └──────────────────┘       └──────────────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. Escrow Pattern Benefits

| Traditional (Bank/PayPal)  | Blockchain Escrow    |
| -------------------------- | -------------------- |
| Middleman fees (2-5%)      | Only gas costs       |
| 3-5 day settlement         | Instant on-chain     |
| Requires trust in platform | Trustless code       |
| Limited to certain regions | Global access        |
| Reversible (chargebacks)   | Irreversible (final) |

```
Trust Flow Comparison:
Traditional:  Buyer → [Bank] → Seller  (Bank is trusted middleman)
Blockchain:   Buyer → [Code] → Seller  (Code is the law)
```

#### 2. Smart Contract Implementation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address public seller;
    uint256 public amount;
    bool public deposited;
    bool public released;

    event Deposited(uint256 amount);
    event Released(address indexed to, uint256 amount);
    event Refunded(address indexed to, uint256 amount);

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller");
        _;
    }

    modifier onlyDeposited() {
        require(deposited, "No funds deposited");
        _;
    }

    modifier notReleased() {
        require(!released, "Already released");
        _;
    }

    constructor(address _buyer, address _seller) {
        buyer = _buyer;
        seller = _seller;
    }

    // Buyer deposits funds into escrow
    function deposit() external payable onlyBuyer {
        require(!deposited, "Already deposited");
        require(msg.value > 0, "Must send ETH");
        amount = msg.value;
        deposited = true;
        emit Deposited(msg.value);
    }

    // Buyer releases funds to seller (work completed)
    function release() external onlyBuyer onlyDeposited notReleased {
        released = true;
        payable(seller).transfer(amount);
        emit Released(seller, amount);
    }

    // Seller refunds buyer (work not delivered)
    function refund() external onlySeller onlyDeposited notReleased {
        released = true;
        payable(buyer).transfer(amount);
        emit Refunded(buyer, amount);
    }
}
```

#### 3. State Machine Pattern

```
┌──────────────┐     deposit()     ┌──────────────┐
│   CREATED    │ ─────────────────▶│   FUNDED     │
│              │                   │              │
│ deposited: ❌│                   │ deposited: ✅│
│ released: ❌ │                   │ released: ❌ │
└──────────────┘                   └──────┬───────┘
                                          │
                           ┌──────────────┴──────────────┐
                           │                             │
                     release()                      refund()
                           │                             │
                           ▼                             ▼
                   ┌──────────────┐             ┌──────────────┐
                   │  COMPLETED   │             │  REFUNDED    │
                   │              │             │              │
                   │ Seller paid 💰│             │ Buyer refund💰│
                   │ released: ✅ │             │ released: ✅ │
                   └──────────────┘             └──────────────┘
```

---

### 🏗️ React Component Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    ESCROW APP COMPONENTS                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                      EscrowApp                           │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: buyer, seller, amount, deposited,        │    │   │
│   │  │        released, currentAccount, loading        │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │ Escrow  │      │  Deposit    │     │  Release/   │         │
│   │ Stats   │      │   Form      │     │  Refund     │         │
│   │         │      │             │     │  Controls   │         │
│   │ Buyer:  │      │ [___] ETH   │     │             │         │
│   │ Seller: │      │ [Deposit]   │     │ [Release] 🔓│         │
│   │ Amount: │      │ (Buyer only)│     │ [Refund]  🔒│         │
│   │ Status: │      │             │     │             │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Role-Based Button Visibility

```javascript
function ReleaseControls({
  currentAccount,
  buyer,
  seller,
  deposited,
  released,
}) {
  const isBuyer = currentAccount?.toLowerCase() === buyer?.toLowerCase();
  const isSeller = currentAccount?.toLowerCase() === seller?.toLowerCase();
  const canRelease = isBuyer && deposited && !released;
  const canRefund = isSeller && deposited && !released;

  return (
    <div>
      {canRelease && (
        <button onClick={handleRelease}>Release Funds to Seller</button>
      )}
      {canRefund && <button onClick={handleRefund}>Refund to Buyer</button>}
      {!canRelease && !canRefund && deposited && !released && (
        <p>Waiting for action...</p>
      )}
      {released && <p>✅ Transaction completed</p>}
    </div>
  );
}
```

#### Transaction with Loading State

```javascript
const handleDeposit = async (ethAmount) => {
  setLoading(true);
  setError(null);

  try {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(ESCROW_ADDRESS, ESCROW_ABI, signer);

    const tx = await contract.deposit({
      value: ethers.parseEther(ethAmount),
    });

    // Wait for confirmation
    await tx.wait();

    // Refresh stats
    await refreshStats();
  } catch (err) {
    if (err.code === 4001) {
      setError("Transaction rejected by user");
    } else {
      setError("Transaction failed: " + err.message);
    }
  } finally {
    setLoading(false);
  }
};
```

---

### 📊 Comparison: Escrow Variations

| Feature    | Basic Escrow  | Timed Escrow         | Arbitrated Escrow      |
| ---------- | ------------- | -------------------- | ---------------------- |
| Parties    | Buyer, Seller | Buyer, Seller        | Buyer, Seller, Arbiter |
| Release    | Buyer only    | Auto after deadline  | Majority vote          |
| Refund     | Seller only   | Auto if not released | Arbiter decides        |
| Disputes   | None          | Time-based           | Arbiter resolution     |
| Complexity | Low           | Medium               | High                   |

---

### ⚠️ Common Mistakes

| Mistake                                | Problem                   | Solution                               |
| -------------------------------------- | ------------------------- | -------------------------------------- |
| Missing role checks                    | Anyone can release        | Use `onlyBuyer`/`onlySeller` modifiers |
| Double release                         | Funds sent twice          | Check `!released` before transfer      |
| No deposit check                       | Release on empty contract | Require `deposited == true`            |
| Using `send()` instead of `transfer()` | Silent failure            | Use `transfer()` or check return value |
| Forgetting `tx.wait()`                 | UI updates prematurely    | Always await transaction receipt       |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Only buyer can deposit funds
- [ ] Only buyer can release funds to seller
- [ ] Only seller can trigger refund to buyer
- [ ] Stats update after deposit
- [ ] Release button disabled until funds deposited
- [ ] Cannot release/refund twice
- [ ] Events trigger UI updates
- [ ] Error handling for rejected transactions
- [ ] Loading states prevent double-clicks
- [ ] Addresses come from `.env`, not hardcoded

---

### 🔗 External Resources

| Resource              | Link                                                                     |
| --------------------- | ------------------------------------------------------------------------ |
| OpenZeppelin Escrow   | https://docs.openzeppelin.com/contracts/5.x/api/utils#Escrow             |
| Solidity Security     | https://docs.soliditylang.org/en/latest/security-considerations.html     |
| Ethers Transactions   | https://docs.ethers.org/v6/api/contract/#BaseContractMethod              |
| Pull vs Push Payments | https://fravoll.github.io/solidity-patterns/pull_over_push.html          |

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
    ethers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.BrowserProvider = jest.fn().mockReturnValue({
      getSigner: jest.fn().mockResolvedValue(fakeSigner),
    });
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("loads escrow stats", async () => {
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.amount.mockResolvedValue(ethers.parseEther("0.5"));
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
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

Odessa shared the link: PH Buyer deposits 0.02 ETH, NY Seller delivers code, clicks **Release**, and funds ring in—no middleman, no delays. Her freelancing group chat lit up: "Smooth, secure, sobrang Pinoy!" Next sprint: add arbiter voting and IPFS proof-of-work. Det's escrow DApp is just the start of a borderless gig economy. 🇵🇭🤝🌐
