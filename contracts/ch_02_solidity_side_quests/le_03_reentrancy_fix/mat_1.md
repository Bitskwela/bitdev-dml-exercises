# Side Quest 3: Reentrancy Fix

![Reentrancy Fix](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+3.0+-+COVER.png)

## Scene

In the heart of the Eastwood-Kalayaan Markets — a bustling digital palengke built on blockchain — vendors proudly accept crypto payments via the "Palengke Wallet," a decentralized wallet system that revolutionized how suki (loyal customers) pay for bangus, kakanin, and sinangag na sinigang kits. Life was finally simpler. The sari-sari stores were thriving. Micro-entrepreneurs no longer waited in line at remittance centers. Everything flowed smoothly…

Until one day — it didn't.

A strange pattern emerged. Wallets were bleeding funds. Vendors reported missing balances after withdrawals. Stall owners in Quezon City's crypto bazaar began calling it the "Ghost Withdrawals" — money vanishing without warning. Panic ensued. And rumors spread fast in Facebook group chats: "Na-hack tayo!"

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+3.1.png)

As Neri investigates, she traces the problem back to a forgotten piece of legacy code — left behind by a minion of Hackana during their attempt to sabotage the country's financial systems. The exploit? A reentrancy vulnerability.

A malicious actor found a loophole in the `withdraw()` function of the Palengke Wallet smart contract. Instead of withdrawing once, they call back into the contract — again and again — draining funds in a single transaction before balances are updated.

**Time Allotment**: 20 minutes
**Solidity Topics Covered**: Reentrancy, Checks-Effects-Interactions, ReentrancyGuard.

## Why this matters

Reentrancy is the most infamous bug in smart-contract history. It's how **The DAO** was drained of ~3.6 million ETH in 2016 — an exploit so large it forced the hard fork that split Ethereum and Ethereum Classic. A decade later it still appears in audits, because the trap is subtle: the vulnerable code *looks* perfectly reasonable. The Palengke Wallet's "Ghost Withdrawals" are this exact bug. Once you can see it, you can never un-see it — and you'll spot it in code reviews for the rest of your career.

## The vulnerable contract

Here's the legacy `withdraw` Neri found. Read it slowly and ask yourself: what order do things happen in?

```solidity
function withdraw(uint256 amount) public {
    require(balances[msg.sender] >= amount, "Insufficient balance"); // Check
    (bool success, ) = msg.sender.call{value: amount}("");           // Interaction
    require(success, "Transfer failed");

    balances[msg.sender] -= amount;                                  // Effect (TOO LATE!)
}
```

The fatal detail: it **sends the ETH first** and **updates the balance last**. Between those two lines, the contract has handed control to `msg.sender` while *still believing they have their full balance*.

## How the attack actually works

To understand why that ordering is lethal, you need one fact about Solidity: **`msg.sender.call{value: amount}("")` doesn't just move ETH — it executes code.** If `msg.sender` is a contract, sending it ETH triggers that contract's `receive()` (or `fallback()`) function. The attacker controls that function. So they can run *any code they want* in the middle of your `withdraw`.

The attacker deploys a contract like this:

```solidity
contract Attacker {
    PalengkeWallet public wallet;

    constructor(address _wallet) { wallet = PalengkeWallet(payable(_wallet)); }

    // Step 1: deposit a little, then kick off the drain
    function attack() external payable {
        wallet.deposit{value: 1 ether}(); // or send via receive()
        wallet.withdraw(1 ether);
    }

    // Step 2: this runs every time the wallet sends us ETH
    receive() external payable {
        if (address(wallet).balance >= 1 ether) {
            wallet.withdraw(1 ether); // re-enter BEFORE our balance was zeroed!
        }
    }
}
```

Now trace the **single transaction**:

1. Attacker calls `withdraw(1 ether)`. The check passes — they really have 1 ether.
2. The wallet does `call{value: 1 ether}` to the attacker. **Control jumps to the attacker's `receive()`.**
3. Inside `receive()`, the attacker immediately calls `withdraw(1 ether)` **again**.
4. The check runs again — and *passes*, because the wallet **hasn't deducted the balance yet** (that line is still waiting below the `call`). The wallet thinks the attacker still has a full balance.
5. The wallet sends *another* 1 ether → `receive()` fires again → `withdraw` again → …

This loops, each level draining another ether, until the wallet is empty or gas runs out. Only when the recursion finally unwinds does `balances[msg.sender] -= amount` run — repeatedly subtracting from a balance that's now meaningless. **One transaction, the whole pool gone.** That's the Ghost Withdrawal.

The root cause in one sentence: **the contract made a decision based on state it was about to change, but changed it too late.**

## Fix #1: Checks-Effects-Interactions (the real fix)

The pattern that *structurally* prevents reentrancy is an ordering rule for every function that touches state and talks to the outside world:

1. **Checks** — validate everything (`require`s) first.
2. **Effects** — update all your own state (balances, flags) next.
3. **Interactions** — only *then* make external calls (sending ETH, calling other contracts).

Apply it to `withdraw` and the bug evaporates:

```solidity
function withdraw(uint256 amount) public {
    require(balances[msg.sender] >= amount, "Insufficient balance"); // Checks

    balances[msg.sender] -= amount;                                  // Effects (FIRST!)

    (bool success, ) = msg.sender.call{value: amount}("");           // Interactions (LAST)
    require(success, "Transfer failed");
}
```

Now replay the attack: the attacker's `receive()` still re-enters and calls `withdraw` again — but this time the balance was **already zeroed in step 2 before the call**, so the re-entrant `require(balances[msg.sender] >= amount)` **fails and reverts**. The recursion dies on its first attempt. The hacker withdraws exactly what they're owed and not a wei more.

Notice we use **`.call{value:}("")` and check the returned `success`**, not the old `.transfer()` or `.send()`. Since EIP-1884 raised certain gas costs, `.transfer()`'s hard-coded 2300-gas stipend can break legitimate recipients (like smart-contract wallets). The modern best practice is `call` *combined with* Checks-Effects-Interactions — `call` forwards enough gas, and CEI is what keeps it safe.

## Fix #2: `nonReentrant` (defense in depth)

OpenZeppelin's `ReentrancyGuard` adds a **lock**. The `nonReentrant` modifier flips a flag to "entered" on the way in and back on the way out; any *re-entrant* call hits the raised flag and reverts immediately.

```solidity
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PalengkeWallet is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function withdraw(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}
```

How the guard works under the hood, conceptually:

```solidity
modifier nonReentrant() {
    require(_status != _ENTERED, "ReentrancyGuard: reentrant call"); // locked?
    _status = _ENTERED;   // raise the lock
    _;                    // run the function body
    _status = _NOT_ENTERED; // lower the lock on exit
}
```

> **Note the v5 import path:** `@openzeppelin/contracts/utils/ReentrancyGuard.sol`. In OpenZeppelin v5 it lives under **`utils/`** — the old v4 `security/ReentrancyGuard.sol` path no longer exists. Importing the old path will fail to compile.

### Which fix do I use?

| | Checks-Effects-Interactions | `nonReentrant` |
|---|---|---|
| What it is | a *design discipline* — order your code correctly | a runtime *lock* applied via modifier |
| Cost | free | small extra gas (a storage read/write per call) |
| Protects against | reentrancy into the same function via correct ordering | reentrancy into *any* guarded function, even cross-function |
| Best practice | **always** | add as **defense-in-depth**, especially with multiple state-changing externals |

**Use both.** CEI is your primary, free, structural defense. `nonReentrant` is the seatbelt that catches the case you missed — for example *cross-function* reentrancy, where the attacker re-enters a *different* function that shares the same state.

## Common mistakes to avoid

1. **Updating state after the external call.** The original bug. State changes must come *before* any `.call`.
2. **Thinking `.transfer()` is "safe from reentrancy."** Its 2300-gas stipend used to block re-entry, but it's brittle and can break valid recipients. Don't rely on it — use `call` + CEI.
3. **Guarding only the obvious function.** Cross-function reentrancy drains via a *sibling* function that shares state. Apply `nonReentrant` to every state-changing externally-callable function, and keep CEI everywhere.
4. **Ignoring the `call` return value.** `call` returns `(bool success, bytes)` — always `require(success, ...)`. It does **not** auto-revert on failure the way a direct call would.
5. **Read-only reentrancy.** Even view functions can be re-entered while state is mid-update, feeding stale values to other protocols. Be wary when other contracts read your state during your external calls.
6. **Assuming "I don't send ETH, so I'm safe."** Any external call — including ERC721's `_safeMint` callback or an ERC777 hook — can hand control to an attacker. Reentrancy isn't only about ETH transfers.

## What's next

You've learned to defend a single contract from re-entry. The final side quest, the **Multi-Signature Wallet**, scales trust outward: instead of guarding *how* funds leave, you'll require *multiple approvers* to agree before any transfer executes at all.

## References

- Solidity docs — Reentrancy & security considerations — https://docs.soliditylang.org/en/latest/security-considerations.html#reentrancy
- OpenZeppelin v5 — ReentrancyGuard — https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard
- Solidity by Example — Reentrancy — https://solidity-by-example.org/hacks/re-entrancy/
- Consensys — Reentrancy attacks — https://consensys.io/diligence/blog/2019/09/stop-using-soliditys-transfer-now/

## Closing

Neri redeploys the Palengke Wallet with balances zeroed *before* the payout and a `nonReentrant` lock on top. She runs the attacker's own contract against it on a fork — and watches it revert on the very first re-entry, the drain dead before it starts. The Ghost Withdrawals stop. "Ang ayos ng pagkakasunod-sunod, siyang sumalba sa palengke." (The right order of operations is what saved the market.) Eastwood-Kalayaan trades on, and the suki sleep soundly.
