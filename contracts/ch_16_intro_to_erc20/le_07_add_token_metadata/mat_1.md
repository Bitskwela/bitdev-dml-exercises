## Dan's Story: Registering the Name

Last lesson Dan did the bayanihan move — one `import` line and `contract WorkshopCredit is ERC20 { }` inherited a whole battle-tested token instead of 200 hand-rolled lines. Then he hit Compile and the green check *didn't* come: `No arguments passed to the base constructor.` He inherited ERC20's machinery, but ERC20 refuses to be born without a name and a symbol — and Dan had given it neither. He left that red error on the screen on purpose. Today he answers it.

The lab was almost empty — merienda hour, most of the kids had wandered off to Tita Malou's carinderia for turon. Dan stayed. Yesterday's red error was still sitting in Remix, and it had been quietly bugging him through his last class. He read it out loud, slowly, the way JM taught him to read the Rust compiler in the LutoCLI days.

```text
TypeError: No arguments passed to the base constructor. Specify the
arguments or mark "WorkshopCredit" as abstract.
```

> **Dan:** "Specify the arguments." Okay — you want arguments. But arguments for *what*, and to *who*?

He pulled up JM on Messenger and typed the whole thing out. The voice note came back while he was still explaining.

> **Kuya JM:** Ay, that one's actually easy, Dan — you're just missing the paperwork. Think of it like registering your workshop with the barangay. Yung ERC20 na minana mo? Before it can exist, it needs a name and a symbol on file. Once. Not every day — once, sa araw na isinilang.
>
> **Dan:** So the token has, like... a birth certificate.
>
> **Kuya JM:** Exactly yan. And the thing that fills out the birth certificate is the **constructor**. It runs one time, at the very moment you deploy — nagbi-birth ang contract — and never again. Your job today is to write that constructor and hand the name and symbol up to ERC20.

Dan thought about his smudged notebook. On the first page, in his own handwriting, it said *"Workshop Credits — Kuya Dan's Coding Class."* That was the closest thing WCR had ever had to a name. Now he was about to make it official, on-chain, where nobody could scribble over it.

> **Kuya JM:** Name it two things. A full name people can read, and a short ticker — like how "Bitcoin" the name is different from "BTC" the symbol. Gawin mong maayos, Dan. Whatever you type today, that's what thirty kids will see when they check their balance.
>
> **Dan:** Workshop Credit. Symbol: WCR.
>
> **Kuya JM:** Naks. Then go give it to the constructor, cousin.

Dan cracked his knuckles. This was the moment the thing in his notebook got a real name in a place he couldn't erase.

> **Dan:** Sige. Let's get you born, WCR.

---

## The Concept: The Constructor and the Token's Name

### What a constructor is

A **constructor** is a special function that runs **exactly once** — at the instant the contract is deployed — and then never again. It's the setup crew: its whole job is to put the contract into a valid starting state before anyone can use it.

```text
  DEPLOYMENT (happens exactly ONCE)        AFTER DEPLOYMENT (happens forever)
  --------------------------------         ----------------------------------
  constructor() runs                       name()        -> "Workshop Credit"
    |  fills in the token's identity       symbol()      -> "WCR"
    |  sets name + symbol on file          totalSupply() -> ...
    v                                       balanceOf(x) -> ...
  contract is now "born" and live          transfer(...) -> ...
        the constructor NEVER runs again after this line
```

Once the contract is deployed, the constructor is gone — you cannot call it. That's *why* it's the right place for a permanent decision like a name: you set it at birth, and it's locked into the contract's identity.

### Passing arguments to a base constructor

Here's the piece that tripped Dan up in Lesson 6. When you write `contract WorkshopCredit is ERC20`, you inherit ERC20 — but ERC20 has its **own** constructor, and in OZ v5 it *demands* two arguments:

```solidity
// Inside OpenZeppelin's ERC20.sol (you inherit this — don't copy it)
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

ERC20 won't build without a `name_` and a `symbol_`. In Lesson 6, `WorkshopCredit` had no constructor at all, so it never handed ERC20 those two strings — and the compiler refused, exactly the way Rust's compiler refused to ship a bug. Same lesson, new language: **the tool stops you at your desk instead of embarrassing you in front of your students.** The fix is to give `WorkshopCredit` its own constructor whose only job is to pass the two strings *up* to the parent:

```solidity
contract WorkshopCredit is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {}
    //           ^^ your constructor takes       ^^ your (empty) body:
    //              no arguments itself              nothing else to set up yet
    //
    //           ERC20("Workshop Credit", "WCR")  <- the "base constructor call":
    //           forwards the name and symbol up to the ERC20 you inherited
}
```

Read the header left to right:

| Piece | What it means |
|-------|---------------|
| `constructor()` | *WorkshopCredit's* own constructor. It takes no arguments — whoever deploys it types nothing. |
| `ERC20("Workshop Credit", "WCR")` | A **base constructor call**. It runs the parent ERC20's constructor and hands it the two strings it demanded. |
| `{}` | The body of *your* constructor. Empty for now — nothing else to set up. (Lesson 8 puts minting here.) |

That `ERC20(...)` sitting between the `)` and the `{` is the whole answer to yesterday's error. You're not marking the contract abstract; you're *specifying the arguments*, exactly as the compiler asked. One detail worth filing away: the **parent runs first**. On deploy, Solidity runs the base ERC20 constructor (setting `_name` and `_symbol`) *before* your body — so by the time your `{}` runs, the token is already named. Right now your body is empty; in Lesson 8, whatever you put there will run knowing the identity is already in place.

### Why pass the name through a constructor at all?

Because a constructor argument is a **choice made per deployment**. The same `WorkshopCredit.sol` file could be deployed once as `"Workshop Credit" / "WCR"` for Dan's Marikina class and again as `"Cebu Workshop Credit" / "CWC"` somewhere else — one source file, different identities, decided at birth. Inheriting OpenZeppelin's ERC20 gives you that flexibility for free; you just fill in the blanks it left.

### name() and symbol(): the metadata getters

The two strings don't vanish. ERC20 stores them and exposes them through two free, read-only functions anyone on Earth can call:

| Function | Returns | For WCR |
|----------|---------|---------|
| `name()` | the token's full human name | `"Workshop Credit"` |
| `symbol()` | the short ticker | `"WCR"` |

These, plus `decimals()` (Lesson 9), are the token's **metadata** — the optional, human-friendly labels from the EIP-20 spec you annotated in Lesson 5. Wallets, block explorers, and Tita Malou's future receipt all read them to show a friendly name instead of a raw contract address.

```text
   what's stored in the contract          what a human sees
   -----------------------------          -----------------
   name()   -> "Workshop Credit"   --->   "Kevin, you hold 100 Workshop Credit"
   symbol() -> "WCR"               --->   "100 WCR"
   (address 0x5B38...eddC4)        --->   (the ledger nobody can rename)
```

Naming a token is not decoration. It's the first line of the public ledger's story: whatever Dan types today is the identity every student, parent, and skeptical Tita will see forever. Nobody — not even Dan — can rename it by hand later. That permanence is the point.

---

## Key Takeaways

- A **constructor** runs **exactly once**, at deployment, and never again — it's where you lock in a contract's permanent starting state, like a token's name.
- When you inherit with `is ERC20`, you must satisfy **its** constructor. OZ v5's ERC20 requires a `name_` and a `symbol_`, so your constructor must pass them up.
- The syntax `constructor() ERC20("Workshop Credit", "WCR") {}` is a **base constructor call**: `ERC20(...)` forwards arguments to the parent; the `{}` is your own (still empty) setup body — and the parent runs first.
- **`name()`** and **`symbol()`** are free, read-only metadata getters returning exactly the strings you passed in — the friendly labels wallets and explorers display.
- Passing the arguments is the direct fix for Lesson 6's `No arguments passed to the base constructor` error — you *specify the arguments* instead of marking the contract abstract.
- Metadata is **permanent and public**: nobody, not even the deployer, can rename a live token by hand. That immutability is the whole point of the ledger.
- Naming a token is **not** the same as funding it: right now `totalSupply()` reads `0`. WCR has an identity but no credits yet.

---

## What's Next?

WCR finally has a name — but it's an empty ledger. `totalSupply()` reads a stubborn `0`, which means if Dan checked his own balance right now, he'd hold exactly zero of his own credits. A token nobody owns any of is just a fancy label on nothing. Before he can settle Kevin's dispute or hand a student a single credit, Dan has to actually *create* some.

Next lesson, Dan opens the constructor's empty `{}` body and drops in one line — `_mint` — to bring the first 1,000 Workshop Credits into existence and put them in his own account. He'll deploy, check `balanceOf`, and finally *see* the credits exist... and then notice the number looks deeply, hilariously wrong (spoiler: `0.000000000000001000`). But that weirdness is a Lesson 9 problem. First, the supply.

**Next Lesson: Create the Initial Supply** — using `_mint` in the constructor to bring WCR to life.
