## 🧑‍💻 Background Story

![Escrow DApp Banner](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+16.0+-+COVER.png)

Odessa ("Det") was on a late-night Zoom with a New York freelance client. "Send escrow first," the client insisted before the PH dev team could start. Between Manila and New York, trust usually means a bank in the middle, a week of waiting, and fees on both ends. Det thought: "What if the money sat in a smart contract that neither of us controls?"

![Freelance Escrow Concept](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+16.1.png)

By sunrise she had an **Escrow** contract tested on her laptop with Hardhat and deployed to the **Sepolia** testnet. The deal was simple:

1. The **buyer** (the client) deposits ETH into the contract.
2. Everyone can see the money is locked: the status reads **Pending**.
3. When the seller (the dev team) delivers, the buyer calls **release** and the seller gets paid.
4. If the deal falls through, the seller calls **refund** and the buyer gets the money back.

The first thing both sides asked for was not a button. It was proof. "Before I start coding, I want to *see* the 0.75 ETH is really there," said Kuya Miguel, the team lead. So Det's first screen was a read-only **escrow status panel**: buyer, seller, amount, and status, straight from Sepolia, with no wallet needed. That panel is what you build in this lesson's activity. The deposit, release and refund flow is explained below so you understand what the panel is reporting on.

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

- What an escrow contract is and the three states it moves through.
- How to read a contract's public state with a **read-only provider** (`ethers.JsonRpcProvider`), with no wallet involved.
- How to fetch several values at once with `Promise.all`, and display wei as ether with `ethers.formatEther`.
- How a safe escrow pays out: **checks-effects-interactions**, `call` instead of `transfer`, and the pull-payment pattern.

**Activity:** build `EscrowStats`, a status viewer that reads `buyer`, `seller`, `amount`, `deposited` and `released` from a Sepolia escrow and shows **Pending** while the money is locked.

---

### 📐 Escrow Flow

```
   BUYER                    ESCROW CONTRACT                    SELLER
     │                ┌───────────────────────┐                  │
     │  deposit() ──▶ │ buyer:     0xBuyer    │                  │
     │  (+0.75 ETH)   │ seller:    0xSeller   │                  │
     │                │ amount:    0.75 ETH   │                  │
     │                │ deposited: true       │                  │
     │                │ released:  false      │                  │
     │                └───────────┬───────────┘                  │
     │                            │                              │
     │   release() (buyer) ───────┼───────▶ 0.75 ETH ──────────▶ │
     │ ◀────────── 0.75 ETH ──────┼─────── refund() (seller)     │
```

Every one of those five fields is `public`, which means Solidity generates a free getter for it (`buyer()`, `seller()`, ...). Reading them costs no gas and needs no signature. That is why the status panel can use a plain RPC connection.

---

### 🔑 Key Concepts

#### 1. Why escrow on-chain?

| Traditional (bank / platform) | Smart-contract escrow                 |
| ----------------------------- | ------------------------------------- |
| Platform fees, often a few %  | Only gas fees                         |
| Days to settle across borders | Settles in the next block             |
| You trust the platform        | You trust code anyone can read        |
| Chargebacks possible          | Final once released                   |

The trade-off is real: "final" also means there is no customer service to undo a mistake. That is why the contract's rules have to be right.

#### 2. The state machine

```
 ┌───────────────┐   deposit()   ┌───────────────┐
 │ NOT DEPOSITED │ ────────────▶ │    PENDING    │
 │ deposited: ❌ │               │ deposited: ✅ │
 │ released:  ❌ │               │ released:  ❌ │
 └───────────────┘               └───────┬───────┘
                           release() ┌───┴───┐ refund()
                                     ▼       ▼
                              ┌──────────────────┐
                              │     SETTLED      │
                              │  released: ✅    │
                              └──────────────────┘
```

Two booleans give you three states. When you display them, check `released` **first**. A settled escrow still has `deposited == true`, so checking `deposited` first would leave a finished deal stuck on "Pending".

#### 3. The contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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

    constructor(address _buyer, address _seller) {
        buyer = _buyer;
        seller = _seller;
    }

    function deposit() external payable onlyBuyer {
        require(!deposited, "Already deposited");
        require(msg.value > 0, "Must send ETH");
        amount = msg.value;
        deposited = true;
        emit Deposited(msg.value);
    }

    function release() external onlyBuyer {
        require(deposited, "No funds deposited");    // 1. checks
        require(!released, "Already settled");
        released = true;                              // 2. effects
        (bool ok, ) = payable(seller).call{value: amount}(""); // 3. interaction
        require(ok, "Transfer failed");
        emit Released(seller, amount);
    }

    function refund() external onlySeller {
        require(deposited, "No funds deposited");
        require(!released, "Already settled");
        released = true;
        (bool ok, ) = payable(buyer).call{value: amount}("");
        require(ok, "Transfer failed");
        emit Refunded(buyer, amount);
    }
}
```

This contract compiles with Solidity 0.8.27. On a local Hardhat chain, `release()` paid the seller exactly 0.75 ETH, and a later `refund()` reverted with `"Already settled"`.

#### 4. Paying out safely: checks, effects, then interactions

Sending ETH hands control to the receiver. If the receiver is a contract, its code runs in the middle of your function. A malicious receiver can call `release()` again before your function finishes. That attack is called **reentrancy**. The defence is the order of the lines:

1. **Checks.** Run every `require` first.
2. **Effects.** Update your own state (`released = true`) *before* sending anything.
3. **Interactions.** Only then send the money.

If the receiver re-enters, `released` is already `true`, so the second call fails its check.

**Why `call` and not `transfer`?** Older tutorials use `payable(x).transfer(amount)`. It forwards a fixed 2300 gas, which was meant as a reentrancy guard. Gas costs have changed since then, and 2300 gas is no longer enough for many smart-contract wallets (for example multisigs) to receive ETH, so a `transfer` to such a wallet reverts every time, and the escrow can never pay it. The current recommendation is `call{value: ...}("")`, with its success flag checked, protected by checks-effects-interactions. For extra safety you can add OpenZeppelin's `nonReentrant` modifier (`import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";`).

#### 5. Pull over push

The contract above **pushes** money out. A sturdier design lets each party **pull** their own money. `release()` and `refund()` only record who is owed, and a separate `withdraw()` sends it:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PullEscrow is ReentrancyGuard {
    mapping(address => uint256) public owed;

    // release() and refund() only record who is owed...
    function _credit(address to, uint256 value) internal {
        owed[to] += value;
    }

    // ...and each party pulls their own money out.
    function withdraw() external nonReentrant {
        uint256 value = owed[msg.sender];
        require(value > 0, "Nothing to withdraw");
        owed[msg.sender] = 0; // effect before interaction
        (bool ok, ) = payable(msg.sender).call{value: value}("");
        require(ok, "Transfer failed");
    }
}
```

With pull payments, a receiver that rejects ETH can only block its own withdrawal, never the whole deal. OpenZeppelin 4.x shipped ready-made `Escrow` and `PullPayment` contracts. **Both were removed in OpenZeppelin 5**, so today you write the few lines above yourself, as most production contracts do.

---

### 🔌 Reading the escrow from React (what the activity does)

A **provider** is your app's connection to the blockchain. In ethers v6 you will use two kinds:

| Provider | Created with | Can read? | Can sign? | Needs a wallet? |
| -------- | ------------ | --------- | --------- | --------------- |
| `ethers.JsonRpcProvider` | an RPC URL | ✅ | ❌ | No |
| `ethers.BrowserProvider` | `window.ethereum` (MetaMask) | ✅ | ✅ via `await provider.getSigner()` | Yes |

The status panel only reads, so a `JsonRpcProvider` is the right tool. The client in New York does not need MetaMask just to check the deal.

```javascript
const provider = new ethers.JsonRpcProvider(RPC); // e.g. a Sepolia RPC URL
const escrow = new ethers.Contract(ADDR, ABI, provider);

// Five independent reads: send them together instead of one after another.
const [b, s, a, dep, rel] = await Promise.all([
  escrow.buyer(),
  escrow.seller(),
  escrow.amount(),
  escrow.deposited(),
  escrow.released(),
]);

typeof a;               // "bigint" — in ethers v6 every uint256 is a native bigint
ethers.formatEther(a);  // "0.75"   — wei (10^18 per ETH) to a readable string
```

`Promise.all` returns the results in the order you listed the calls, which is why the destructuring `[b, s, a, dep, rel]` lines up.

### ✍️ Writing to the escrow (beyond the activity)

Deposit, release and refund change state, so they need the user's wallet to **sign** a transaction. That is a `BrowserProvider` plus a signer:

```javascript
const handleDeposit = async (ethAmount) => {
  setLoading(true);
  setError("");
  try {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner(); // v6: getSigner() is async
    const escrow = new ethers.Contract(ESCROW_ADDRESS, ESCROW_ABI, signer);

    const tx = await escrow.deposit({ value: ethers.parseEther(ethAmount) });
    await tx.wait(); // wait until it is mined before refreshing the panel
    await refreshStats();
  } catch (err) {
    // ethers v6 reports a "Reject" click in MetaMask as ACTION_REJECTED
    if (ethers.isError(err, "ACTION_REJECTED")) setError("Transaction rejected");
    else setError("Transaction failed: " + err.message);
  } finally {
    setLoading(false);
  }
};
```

Two details: `{ value: ... }` is how a `payable` function receives ETH, and `ethers.parseEther("0.75")` turns the typed string into `750000000000000000n` wei. If you call `window.ethereum.request(...)` directly instead of going through ethers, a rejection arrives as error `code === 4001`.

To show the right buttons, compare the connected account with the parties. Lower-case both sides, because addresses can come back in mixed-case checksum form:

```javascript
const isBuyer = account?.toLowerCase() === buyer?.toLowerCase();
const isSeller = account?.toLowerCase() === seller?.toLowerCase();
const canRelease = isBuyer && deposited && !released;
const canRefund = isSeller && deposited && !released;
```

Hiding a button is only a convenience. The real protection is the `onlyBuyer` / `onlySeller` modifiers in the contract.

---

### 📊 Escrow variations

| Feature    | Basic escrow  | Timed escrow           | Arbitrated escrow      |
| ---------- | ------------- | ---------------------- | ---------------------- |
| Parties    | Buyer, seller | Buyer, seller          | Buyer, seller, arbiter |
| Release    | Buyer         | Buyer, or auto after a deadline | Buyer or arbiter |
| Refund     | Seller        | Auto if not released in time    | Arbiter decides  |
| Complexity | Low           | Medium                 | High                   |

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
| ------- | ------- | -------- |
| Missing role checks | Anyone can release the money | `onlyBuyer` / `onlySeller` modifiers |
| Sending before updating state | Reentrancy can pay out twice | Checks, effects, then interactions |
| Paying with `transfer()` | Smart-contract wallets may be unable to receive | `call{value: ...}("")` and check `ok` |
| Showing `amount` raw | `750000000000000000` on screen | `ethers.formatEther(amount)` |
| Checking `deposited` before `released` | A settled deal still shows "Pending" | Check `released` first |
| Using a wallet provider just to read | Users without MetaMask see nothing | `ethers.JsonRpcProvider` for reads |
| Forgetting `await tx.wait()` | UI refreshes before the change is mined | Always wait for the receipt |

---

### 🧪 How this is graded

Your `EscrowStats` is mounted against a simulated Sepolia escrow (deposited, not released, 0.75 ETH). The grader checks that you used `ethers.JsonRpcProvider` and read all five fields, and that the screen shows both full addresses, `0.75` (never the raw wei), and the word **Pending**. The activity page lists every checked detail.

---

### 🔗 External Resources

| Resource | Link |
| -------- | ---- |
| ethers v6: JsonRpcProvider | https://docs.ethers.org/v6/api/providers/jsonrpc/ |
| ethers v6: Contract | https://docs.ethers.org/v6/api/contract/ |
| OpenZeppelin 5: ReentrancyGuard | https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard |
| Solidity security considerations | https://docs.soliditylang.org/en/latest/security-considerations.html |
| Pull over push payments | https://fravoll.github.io/solidity-patterns/pull_over_push.html |

---

## 🌟 Closing Story

The New York client opened Det's link, saw "Amount: 0.75 ETH, Status: Pending ⏳", and replied, "Okay, start na kayo." Two weeks later the team delivered, the client clicked release, and the status flipped to "Released ✅". No bank, no week-long wait. Kuya Miguel's next request: an arbiter for disputes. Det's escrow panel was only the start of a borderless gig economy. 🇵🇭🤝🌐
