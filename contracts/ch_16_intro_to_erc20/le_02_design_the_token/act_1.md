# Encode the Napkin as Constants

The design is finished on paper — now pin it in code so it can't quietly drift. Open `act_1.sol` and work the TODOs in order. This contract has no balances and moves no credits yet; it simply *states the six design decisions* in a form the compiler and the barangay can both read. Think of it as the napkin, typed up and made permanent.

## Task 1: Identity — Name and Symbol

Declare two **`public constant` strings**: `NAME` set to `"Workshop Credit"` (readable — it says what the token is) and `SYMBOL` set to `"WCR"` (short, UPPERCASE, ticker-shaped). `constant` means the value is fixed at compile time and can never change — exactly what a design decision should be. `public` gives each one a free getter, so anyone can read the labels.

## Task 2: Precision — Decimals

Declare a **`public constant uint8`** named `DECIMALS` set to `18`. This is the ERC-20 default, and it's only a *display* setting — it tells wallets where to put the decimal point, and changes nothing about the real on-chain count. (Why 18, and how base units really work, is Lesson 9. For now: default, don't fight it.)

## Task 3: Supply — the Initial Float

Declare a **`public constant uint256`** named `INITIAL_SUPPLY` set to `1000` — the whole credits that exist the moment the token is born, minted to the instructor as a pool to hand out from. This is the "ilan sa simula" answer from JM's six questions, written as a number the whole course will build on.

## Task 4: Roles — the Admin, Set at Deploy

Declare a **`public immutable address`** named `admin`, then in the `constructor` set `admin = msg.sender`. `immutable` is like `constant`'s cousin: also unchangeable, but its value isn't known until the contract is *deployed* — `msg.sender` is whoever deploys it, and they become the one accountable person, the only one who may ever mint. An `immutable` must be assigned exactly once, in the constructor.

## Sample Output

Deploy in Remix, then click the blue getter buttons in the deployed panel (the deployer's address will vary):

```text
NAME()            ->  "Workshop Credit"
SYMBOL()          ->  "WCR"
DECIMALS()        ->  18
INITIAL_SUPPLY()  ->  1000
admin()           ->  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
```

Five reads, five design decisions — and every one is public, fixed, and impossible to quietly change after deploy. That permanence is the entire point of writing the napkin down in code.

## Reflection Questions

1. `NAME`, `SYMBOL`, `DECIMALS`, and `INITIAL_SUPPLY` are `constant`, but `admin` is `immutable`. Why can't `admin` also be `constant` — what's different about the moment its value becomes known?
2. This contract records the design but cannot actually stop anyone from doing anything — it holds no balances and has no mint function. Which single decision from the napkin is the one that will later need *real* enforcement, and why is "who can mint" the choice that decides whether a credit is worth anything?
3. Run the design through Tita Malou's test: if `INITIAL_SUPPLY` were `1000` but *anyone* could create more later, would the `1000` mean anything? What does that tell you about which design decision actually protects a credit's value?

## Challenge: Design It Like You Mean It

**Challenge A — Break one decision on purpose.** Copy the five-field design onto paper or into a notes file from scratch, without peeking at `act_1.sol`. Then change exactly *one* decision to a bad choice — set "who can mint" to "anyone" — and write one sentence describing what that does to the value of a single credit, in Kevin's terms. Keep your broken version; the point is to *feel* why the real rule is the real rule.

**Challenge B — Design the earning numbers, and defend them.** JM's spec sheet says credits are earned for "attendance" and for "finishing an exercise," but not how many. Decide Dan's two numbers: how many WCR for showing up versus for completing an exercise. Write them down, then write 2–3 sentences on *why the numbers have to be fixed and public* rather than decided by Dan's mood each week — connect it back to what makes a credit a promise instead of a favor.

## What You've Learned

- **A design document can be code:** `constant` and `immutable` fields let a contract *state* its decisions permanently, before it does anything at all.
- **`constant` vs `immutable`:** `constant` is fixed at compile time (`NAME`, `DECIMALS`); `immutable` is fixed once at deploy (`admin = msg.sender`) — both can never change afterward.
- **"Who can mint" is the value-defining decision** — the one Tita Malou's test targets, and the one a later lesson (`Ownable`, `onlyOwner`) will actually enforce.
- **The napkin is a map of the whole course:** name and symbol become the constructor (L7), initial supply becomes `_mint` (L8), "who can mint" becomes `onlyOwner` (L21), spend becomes the RewardStore, and redeem becomes burning.
