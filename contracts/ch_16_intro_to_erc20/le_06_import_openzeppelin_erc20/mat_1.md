## Dan's Story: Don't Cut Your Own Kahoy

Last lesson, Dan finally read the real EIP-20 spec and annotated the entire `IERC20` interface — three view functions (`totalSupply`, `balanceOf`, `allowance`), three state-changers (`transfer`, `approve`, `transferFrom`), two events (`Transfer`, `Approval`) — mapping each one to a move in his smudged workshop notebook. Kuya JM left him with a slogan: *"Learn the interface, not the implementation."* Tonight Dan discovers it was actually a promise — that he will **never have to write the implementation himself.**

Computer lab, Wednesday, the good machine by the window. Dan had `IERC20.sol` open in one tab and a blank `WorkshopCredit.sol` in the other, and he was staring at the blank one the way you stare at a mountain you've agreed to climb.

Six functions. Two events. And behind every one, the *real* work: a mapping of who holds how many credits, another mapping of who may spend whose, overflow-safe math, a guard so nobody sends credits to the zero address, the events firing at exactly the right moment. Two hundred lines, easy. And if he got one line wrong, a student's credits could quietly vanish — the exact "the notebook can't prove anything" nightmare, now written in code thirty kids would trust. He opened a call with Kuya JM out of something close to panic.

> **Dan:** JM, I mapped all six functions like you said. Pero now I have to actually *write* them, di ba? The balances, the allowances, the events, the overflow checks — two hundred lines, and if I mess up one, a student's credits just... disappear.
>
> **Kuya JM:** Stop. Stop typing. Sino nagsabing isusulat mo lahat 'yan?
>
> **Dan:** ...Ako? It's my token.
>
> **Kuya JM:** Dan, dito sa work, *walang* sumusulat ng ERC20 from scratch. Nobody. We import OpenZeppelin — a library na na-audit na, ginamit na ng libo-libong projects, humahawak ng totoong pera sa mainnet ngayon. One line, and you inherit the whole thing.
>
> **Dan:** One line. Parang... nandaya?

Dan actually felt guilty about it, which JM found hilarious.

> **Kuya JM:** Naks, daya daw. Dan — when the barangay builds a house, hindi ka nag-uumpisa sa pagputol ng sariling kahoy. May mga poste na, may bubong na; you carry it together, you raise it together. Bayanihan. The token machinery is already built and *hardened*. Your job isn't to rebuild it — put WCR's name on it and add only what your workshop needs.
>
> **Dan:** So I literally just... `is ERC20`?
>
> **Kuya JM:** `is ERC20`. Then compile it. And Dan — huwag mong aayusin agad kung may ireklamo ang compiler. Basahin mo muna. Naaalala mo si Rust? The compiler is still your strictest Ate, kahit dito. It's about to tell you *exactly* what's missing.

Dan looked at the mountain again. It had gotten a lot smaller. He typed one import line, one contract line, and reached for the Compile button — expecting either a miracle or a scolding. He was about to get the scolding. The good kind.

---

## The Concept: Inheritance, Audited Code, and Bayanihan

### The interface was the *promise*. Someone still writes the *machinery*.

Last lesson's `IERC20` was all signatures and no bodies — a list of what a token must be able to *do*, with none of the code that does it. A promise, not a program. Somebody still has to write the machinery behind that promise: a `mapping` of every address to its balance, a second `mapping` of allowances, arithmetic that can't silently overflow, a guard rejecting transfers to the zero address, and the `Transfer`/`Approval` events firing at the exact right moment. Get any of it subtly wrong and you don't get a compiler error — you get a token that *looks* fine and loses people's credits on a bad day. That's the worst kind of bug: the one that waits for an audience. (Dan has met that bug. Its name was `KeyError: ''`, and it crashed LutoCLI in front of Tita Malou.)

### Inheritance: `is` means "I get everything this contract already has"

Solidity lets one contract build on top of another with the keyword **`is`**:

```solidity
contract WorkshopCredit is ERC20 {
    // WorkshopCredit is now an ERC20 PLUS whatever we add here.
}
```

`WorkshopCredit is ERC20` means WorkshopCredit **inherits** every function and every piece of state `ERC20` defines. It doesn't copy the code into your file — it *stands on it*. The moment you write `is ERC20`, your token already has a working `transfer`, `approve`, `transferFrom`, `balanceOf`, `allowance`, and `totalSupply`, plus the two events — all real, filled-in, tested code you did not type.

```text
        ERC20  (OpenZeppelin's audited implementation)
        ├─ balanceOf()      ← real, working bodies
        ├─ transfer()       ← overflow-safe, guarded
        ├─ approve()        ← fires Approval
        ├─ transferFrom()   ← checks allowance
        ├─ allowance() / totalSupply()
        └─ emits Transfer / Approval
                    ▲
                    │  " is "  (inheritance)
        WorkshopCredit  ← gets ALL of the above for free,
                          then adds only what WCR needs
```

Your job shrinks from *"write a correct token"* to *"name a token and add the workshop-specific parts."* That's the whole trick.

### OpenZeppelin: the barangay already built (and hardened) the house

**OpenZeppelin Contracts** is a free, open-source library of the most-used building blocks in Ethereum — including a reference `ERC20`. It is not random code off the internet: it's been read, reviewed, and audited by thousands of developers and professional security firms; it's used in production by real tokens holding real value right now; and when a bug or better pattern is found, it's fixed *once*, in the open, for everyone. That is **bayanihan** in code form — the whole community carrying one house so no family builds it alone. Rewriting ERC20 by hand isn't brave; it's cutting your own kahoy while a perfectly good, already-raised frame sits right there.

### Inherit, don't copy-paste

You *could* paste OpenZeppelin's code straight into your file. Don't:

| Copy-paste the code | `import` + `is ERC20` |
|---|---|
| You now *own* every line — and every future bug | You *reference* audited code you didn't write |
| Security fixes upstream never reach you | You point at a known, reviewed version |
| Your file balloons to hundreds of lines | Your file stays tiny and readable |
| Easy to accidentally edit the tested code | The base stays untouched and trustworthy |

Inheritance keeps the hardened code hardened. You extend it; you don't disturb it.

### The one line that does the heavy lifting — and why the version is pinned

```solidity
import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
```

```text
@openzeppelin/contracts @ 5.0.2 / token/ERC20/ERC20.sol
└──── the library ────┘  └ver┘  └──── the file inside it ────┘
```

- `@openzeppelin/contracts` — the library's package name.
- `@5.0.2` — the **pinned version**: "give me *exactly* this release, not whatever is newest." The code you tested against is the code you deploy. (v5 matters for us: it uses modern **custom errors** like `ERC20InsufficientBalance` instead of old string messages — you'll meet those later, and only v5 behaves this way.)
- `token/ERC20/ERC20.sol` — the path to the actual file.

The quiet gift: **Remix resolves this import for you.** No `npm install`, no toolchain — you paste the line and Remix fetches the audited source automatically. Same zero-install relief as the Rust Playground.

### The compiler's refusal, read like a letter

Now inherit the base but leave out its constructor, and compile it half-finished. Instead of a green check, you get a red box. Read it like a letter, not an alarm:

```text
TypeError: No arguments passed to the base constructor. Specify the
arguments or mark "WorkshopCredit" as abstract.
  --> WorkshopCredit.sol:18:1:
   |
18 | contract WorkshopCredit is ERC20 {
   | ^ (Relevant source part starts here and spans across multiple lines).
Note: Base constructor parameters:
  --> @openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol:45:16:
   |
45 |     constructor(string memory name_, string memory symbol_) {
   |                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

This is the compiler-as-teacher beat again — the strict Ate from the Rust course in a Solidity hat. **It caught a real problem before anyone got hurt:** the inherited `ERC20` has a `constructor` that *requires* two arguments — a `name_` and a `symbol_` — and you gave it none. **It told you exactly where:** the first arrow points at *your* line, the second (under `Note:`) points into OpenZeppelin's own file at the constructor waiting for arguments. **It offered two honest ways out:** *specify the arguments* (finish the job — pass a name and symbol up to the base; that's a real, deployable token) or *mark it abstract* (declare it intentionally incomplete and undeployable — not what we want). A token must have an identity before it can go live. Errors caught at your desk never reach a student's counter.

---

## Key Takeaways

- **`is` means inheritance.** `contract WorkshopCredit is ERC20` makes your token *an* ERC20 plus whatever you add — you inherit real, working bodies for `transfer`, `approve`, `transferFrom`, `balanceOf`, `allowance`, and `totalSupply` without writing them.
- **OpenZeppelin is audited, community-hardened code.** Reusing it is **bayanihan** — you stand on a house the whole barangay already raised, instead of cutting your own kahoy and owning every bug forever.
- **Inherit, don't copy-paste.** `import` + `is` references the hardened code untouched; pasting it makes you the maintainer of code you didn't write and cuts you off from upstream fixes.
- **Pin the version.** `@openzeppelin/contracts@5.0.2/...` locks the *exact* audited release you tested against — and v5 is what gives WCR modern custom errors later. Remix fetches it with no install.
- **The compiler is a mentor with a red pen — in Solidity too.** "No arguments passed to the base constructor" isn't punishment; it's the strict Ate refusing to ship a nameless, half-built token, pointing at the exact line and naming the missing arguments.
- **This refusal is the setup, not the failure.** A token must have an identity before it can go live — so the compiler stops you at your desk instead of embarrassing you at the counter.

---

## What's Next?

Dan has the whole audited token in his contract now — for the price of one import line — and the compiler is asking for exactly one thing before it goes green: an identity. A `name`. A `symbol`. The two arguments that turn a generic ERC20 into *Workshop Credit, WCR*.

Next lesson he satisfies the base constructor and watches the red turn green. When he deploys and calls `name()` and `symbol()`, the ledger answers back with **"Workshop Credit"** and **"WCR"** — his workshop's credits, finally with a name anyone can read. (One small mystery will be waiting: `totalSupply` will read `0`. Hold that thought.)

**Next Lesson: Add Token Metadata** — giving WCR its name and symbol so the compiler finally says yes.
