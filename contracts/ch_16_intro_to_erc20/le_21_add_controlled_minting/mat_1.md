## Dan's Story: Who Holds the Pen?

Last lesson the RewardStore made its first real sale: Kevin `approve`d the store, called `buyItem(0)`, and `transferFrom` pulled the credits out of his balance and into the store's — every step logged in public. The approve → transferFrom machinery finally bought a turon. But the demo skated past a quieter question. *Every* WCR that exists came from a single `_mint` of 1,000 at deploy. Thirty kids earn credits every Saturday. When those 1,000 run out — and they will — where do new credits come from, and **who is allowed to make them?**

Wednesday, late merienda. The carinderia was between rushes, and Dan had his laptop open next to a plate of turon he had absolutely not paid for. Across from him sat **Ate Rina** — his old ML mentor from two courses ago, the one who taught him to *prove* Luto v2 worked instead of just hoping. She's a data analyst now, which means she spends her days thinking about exactly one thing: who is allowed to touch which numbers.

> **Dan:** Watch. Kevin approves the store, buys a turon, and boom — the ledger logs it. Naks, it actually works, Ate.

Ate Rina watched the transaction confirm. She did not look impressed. She looked like she was reading a contract, which she was.

> **Ate Rina:** Cute. So where do the credits come from?
>
> **Dan:** I minted 1,000 to myself at deploy. Pang-simula. But I've given away like 850 na, so I'm adding a `mint` function — para makagawa ako ng bago when new kids join.

He typed it out, fast and proud:

```solidity
function mint(address to, uint256 amount) external {
    _mint(to, amount);
}
```

> **Dan:** One line. Now I can top up anytime.

Ate Rina put down her fork. Never a good sign.

> **Ate Rina:** Who can call that, bata?
>
> **Dan:** Me. I'll call it when I need to.
>
> **Ate Rina:** No. Read your own code. Who *can* call it?

Dan looked at the line. `external`. No check. No guard. Nothing between the whole internet and `_mint`.

> **Dan:** ...Anyone. Anyone can call it.
>
> **Ate Rina:** So Kevin can mint himself a million WCR. His tita can. A stranger na napadaan sa Etherscan can. If *anyone* can print credits — wala nang halaga ang credits. Zero. Your turon economy dies the first time one smart kid reads the contract.

From behind the counter, Tita Malou delivered her verdict without turning around.

> **Tita Malou:** Printing your own pera? Anak, yan yung sinasabi ko. Scam yan.

Dan opened his mouth to argue and couldn't. An open `mint` was *exactly* the thing that made "token" sound like a scam: someone, somewhere, quietly printing more whenever they felt like it.

> **Dan:** Okay. So the fix isn't *no* minting — the workshop grows, I need to make more. The fix is that only *I* can mint. And everyone can *see* that only I can, and see every single time I do it.
>
> **Ate Rina:** Now you're thinking like me. Lock the door — then put the door behind glass so the whole barangay can watch who holds the key. That's not a scam. That's the opposite of one.

Dan deleted his naive line and reached for the tool to build the door properly: OpenZeppelin's `Ownable`.

---

## The Concept: The Power to Create, and the Lock on the Door

### Where credits come from: `_mint`

You met `_mint` back in Lesson 8. It **creates tokens out of nothing**: it raises an account's balance, raises `totalSupply`, and emits a `Transfer` event *from the zero address* (`0x000...000`) — the ledger's way of saying "these did not exist before this line."

```text
   _mint(to, amount)  does three things, atomically:
   ┌──────────────────────────────────────────────┐
   │  1. balanceOf[to]        += amount            │
   │  2. totalSupply          += amount            │
   │  3. emit Transfer(address(0), to, amount)     │
   └──────────────────────────────────────────────┘
```

`_mint` is `internal` — the outside world can't call it directly. To create credits *after* deployment you must **expose** it through a function you write. And the instant you do, you've drilled a hole straight to the money printer. The only question that matters is who you let walk through it.

### The danger: an open mint

Dan's one-liner had no guard, so `_mint` was reachable by anyone with a wallet:

| | Open `mint` (anyone) | Controlled `mint` (`onlyOwner`) |
|---|---|---|
| Kevin mints himself 1,000,000 WCR | succeeds | reverts |
| A stranger on Etherscan mints | succeeds | reverts |
| Supply stays predictable | no | yes |
| Credits mean anything | no | yes |

This is the sari-sari listahan again. The whole point of the utang notebook is that the tindera holds the pen. If any customer could stroll behind the counter and write their own "bayad na," the notebook would record nothing but lies. A credit is worth something only because **its creation is controlled and everyone knows the rule.** Take away the control and you haven't made everyone rich — you've made the number meaningless.

### Access control: `Ownable` and `onlyOwner`

Rather than hand-roll a permission check, Dan inherits OpenZeppelin's **`Ownable`** — the same bayanihan move as inheriting `ERC20`. `Ownable` gives the contract exactly one privileged address, the **owner**, plus the tools to guard functions with it. Two pieces do the work:

1. **`Ownable(msg.sender)` in the constructor.** OZ v5 *requires* you to name the initial owner at deploy — it won't guess. `msg.sender` in the constructor is whoever sent the deployment transaction, so this means **"the account that deploys becomes the owner."** For WCR, that's Dan.

2. **The `onlyOwner` modifier.** Tack it on a function and OZ inserts a gatekeeper that runs *before* the body:

```text
   caller ──▶ [ onlyOwner gate ]──▶ function body ──▶ _mint(...)
                    │
                    │  msg.sender != owner() ?
                    ▼
              REVERT before the body ever runs
              (nothing changes, state untouched)
```

If `msg.sender` isn't the owner, the call reverts *before a single line of the function runs*. No tokens minted, no state touched.

There's a transparency bonus too. `Ownable` gives a free public getter, **`owner()`**, that anyone can call. The lock isn't a secret — the whole barangay can read *who* holds the key. Minting is restricted, and restricted *visibly*. That is the honest answer to "scam yan": one person can print, and everyone can see who, and every credit they've ever printed.

### The revert: `OwnableUnauthorizedAccount`

When a non-owner hits the gate, OZ v5 reverts with a **custom error** — the same style as `ERC20InsufficientBalance` from Lesson 15, not an old-fashioned string:

```solidity
error OwnableUnauthorizedAccount(address account);
```

The `account` field is the caller who tried and was refused. It's typed, cheap on gas, and machine-readable — a block explorer can decode it and say "this address is not the owner" without parsing English. You'll see it verbatim in the activity.

### Why add minting at all?

Why not keep the fixed 1,000 forever and dodge the whole risk? Because the workshop *grows*. New kids join in month three who weren't there at deploy. Rewards get handed out and spent. A permanently fixed supply means that once those first 1,000 credits are in circulation, Dan can never reward a newcomer again. **Controlled minting keeps the system flexible without making it untrustworthy** — the lock is precisely what makes the flexibility safe.

---

## Key Takeaways

- **`_mint` is the money printer.** It creates tokens from nothing, raises `totalSupply`, and emits a `Transfer` *from the zero address*. Because it's `internal`, you expose it through a function you write — a hole straight to the printer.
- **An open mint destroys the token.** If anyone can create credits, credits mean nothing. Value comes from creation being *controlled and predictable*, not from scarcity being impossible.
- **`Ownable` gives one owner, set at deploy.** OZ v5 requires `Ownable(msg.sender)` in the constructor — the deployer becomes the owner. No default, no guessing.
- **`onlyOwner` is a gate that runs first.** A non-owner call reverts *before the body executes*, so `_mint` never runs and no state changes.
- **The revert is a typed custom error:** `OwnableUnauthorizedAccount(address account)`, where `account` is the refused caller — same OZ v5 style as `ERC20InsufficientBalance`.
- **The lock is public.** `owner()` lets anyone read who holds the key, and every mint is a `Transfer` in the log — the honest answer to "printing money sounds like a scam."
- **Controlled minting keeps WCR flexible AND trustworthy.** The workshop grows; the lock is what makes creating credits for newcomers safe instead of dangerous.

---

## What's Next?

The lock works — only Dan can mint, and everyone can see it. But watch that `Transfer` event again: it records *from zero, to Kevin, 200 WCR*. It records that credits were created. It does **not** record *why*. Attendance? Finishing exercise 3? Helping a classmate debug? The ledger is silent on the one thing the workshop actually cares about — the reason.

Next, Dan makes minting *mean* something: a `rewardStudent(address, amount, reason)` function and a custom `StudentRewarded` event, so every credit issued carries a human-readable reason written permanently and publicly into the log. Minting becomes rewarding, and the ledger finally answers not just *how much*, but *what for*.

**Next Lesson: Add Student Rewards** — `rewardStudent` and the `StudentRewarded` event: minting with a reason the whole barangay can read.
