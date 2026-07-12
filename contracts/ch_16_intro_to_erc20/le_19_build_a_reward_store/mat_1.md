## Dan's Story: The Store That Doesn't Exist Yet

Late in the lab, Dan finally closed the allowance loop. A student account called `approve` to authorize a spender for 50 WCR, and then a *second* account — the one Dan kept mentally labeling "the store" — called `transferFrom` and pulled 30 WCR out of the student's balance without the student clicking a thing. The allowance dropped 50 → 20, a `Transfer` event fired, delegated payment *worked*. Except that "store" was a lie: it was just another test account Dan was pretending was a shop. There is no shop. Today he builds the real one — a *second contract*, living on the ledger beside WCR, that knows how to hold a catalog of rewards.

> **Dan:** So the token can *receive* a `transferFrom`. Fine. But there's nobody to receive it. I've been pointing WCR at an empty chair.

The whole point of the credits was the reward counter — the table by the carinderia where a student trades WCR for a turon, a secondhand USB stick, a hand-me-down book, or an hour of Dan's time. In the notebook days, that counter was Tita Malou with a pen, crossing out credits and trusting her own arithmetic. Dan needs that counter to *become code.*

He called Kuya JM, half-expecting to be told this was a whole new project.

> **Kuya JM:** Naku, relax. It's not a new project — it's a second contract. You already shipped one, `WorkshopCredit`. Walang batas na iisang contract lang ang isang project. Your token is one thing on the ledger. The store is another thing, right beside it. They just need to know how to talk.
>
> **Dan:** Talk how? The store isn't the token. It can't just reach into WCR's balances.
>
> **Kuya JM:** Exactly — it can't, and *that's* why you spent three lessons on approve and transferFrom. But before any payment, the store needs two boring things: to *know which token it accepts*, and a *list of items*. Yun lang muna. The storefront and the price tags.

Dan pictured the carinderia's glass display case — the pancit, the lumpia, the little handwritten price cards propped against each tray. A store, stripped down, is exactly that: a list of things, each with a name, a price, and whether it's still available.

> **Dan:** So today I'm building the display case. Empty. With slots for price cards.
>
> **Kuya JM:** That's the one. And here's the part that'll feel weird the first time: the store won't hold a *copy* of WCR. It'll hold WCR's *address* — the token's spot on the ledger — plus the knowledge of how to speak ERC-20 to it. Parang the tindera's number saved in your phone. Di mo siya nilalagay sa phone. You save how to *reach* her.

Dan opened Remix, created a new file next to `WorkshopCredit.sol`, and realized he was no longer building a token. He was building a little economy.

---

## The Concept: A Second Contract, Wired to the First

### One project, many contracts

Everything so far has been a single contract, `WorkshopCredit`. But a real system is usually *several* contracts that each do one job and cooperate. Dan's is two:

```text
        THE LEDGER (one shared blockchain)
  ┌────────────────────────┐   ┌────────────────────────┐
  │  WorkshopCredit (WCR)   │   │      RewardStore        │
  │  ---------------------  │   │  --------------------   │
  │  balances (who holds    │   │  a reference to WCR     │
  │    how much)            │◄──┼── credit = IERC20(addr) │
  │  transfer / approve /   │   │  items[] (the catalog)  │
  │    transferFrom         │   │  addItem() / itemCount()│
  └────────────────────────┘   └────────────────────────┘
     the money                    the shop that will
                                  one day take the money
```

The token holds *balances*. The store holds a *catalog* and a *pointer to the token*. Neither duplicates the other's job — the same instinct that made Dan inherit OpenZeppelin's ERC20 instead of rewriting it.

### Referencing a contract by address + interface

A deployed contract lives at an **address** — a 20-byte identifier like `0xd9145CCE52D386f254917e481eB44e9943F39138`, the spot where its code and state live on the ledger. To let the store use the token, you hand the store that address and tell it *what shape* of contract sits there:

```solidity
IERC20 public immutable credit;
// ...
credit = IERC20(creditToken);   // creditToken is an address
```

Read `IERC20(creditToken)` as: "treat the contract at this address as an ERC-20." `IERC20` is the **interface** from Lesson 5 — the six function signatures with no bodies. It's a promise about *what you can call*, not a copy of *how it works*. The store never holds WCR's balances; it holds WCR's address and the knowledge that it can call `.transferFrom(...)`, `.balanceOf(...)`, and the rest on it.

| | What it is | The barangay version |
|---|---|---|
| **Address** | Where the token lives on the ledger | The tindera's phone number |
| **Interface (`IERC20`)** | Which functions you may call | Knowing you can text her an order |
| **`credit`** | Address + interface, bundled | Her number saved, ready to text |

Dan's *fake* store last lesson was an account with no code. The real store is code that carries WCR's number in its pocket.

### `immutable`: set once, at birth, forever

Notice `credit` is `immutable`. Such a variable is assigned **exactly once, in the constructor**, and never again — after deployment it's frozen. That matters twice over:

- **Trust.** A student (or Tita Malou) can check `credit` once and know the store will *never* silently swap in a different, worthless token. The store is permanently married to WCR — tiwala you can verify, not tiwala you have to grant.
- **Gas.** `immutable` values are baked into the contract's code, so reading them is cheaper than reading storage.

Try to reassign `credit` in `addItem` and the compiler refuses — the same strict-Ate energy from LutoCLI, now guarding a promise.

### Structs: one price card, three fields

A price card holds three facts: a name, a price, and whether it's still for sale. A **struct** bundles them into one custom type:

```solidity
struct Item {
    string name;    // "Turon"
    uint256 price;  // 100 WCR, in base units (100 * 10**18)
    bool active;    // still available?
}
```

`Item` is now a type Dan invented, like `uint256` or `bool`, but shaped for his shop. Prices live in **base units**, exactly like balances: 100 WCR is `100 * 10 ** 18`. The store speaks the same integer language as the token — no floats, ever (the Lesson 9 reason).

### Dynamic arrays: a list that grows

A store isn't one item; it's a *list* that grows as Dan adds rewards — a **dynamic array**:

```solidity
Item[] public items;   // starts empty, grows with .push(...)
```

- `items.push(Item("Turon", 100e18, true))` appends a new item to the end.
- `items.length` is how many exist.
- Because it's `public`, Solidity auto-generates a getter `items(i)` that returns *one* element at index `i` (not the whole array at once).
- The **index is the id**: first pushed = id `0`, next = id `1` — the same zero-based counting as LutoCLI's Rust vectors.

```text
   items  (a dynamic array of Item)
   ┌──────────┬──────────┬──────────┐
   │  id 0    │  id 1    │  id 2    │  ...grows to the right
   │  Turon   │  USB     │  Book    │
   │  100 WCR │  500 WCR │  300 WCR │
   └──────────┴──────────┴──────────┘
```

Who is allowed to stock the shelf? Right now, *anyone* — `addItem` has no guard, exactly like `award` back in Lesson 1. That's deliberate: locking actions to the instructor is what `Ownable` and `onlyOwner` are for, and that's Lesson 21's job. One idea per lesson.

---

## Key Takeaways

- **A project can be many contracts.** WCR (the money) and RewardStore (the shop) are two separate contracts on the same ledger that cooperate — each does one job well.
- **Contracts reference each other by address + interface.** `IERC20(creditToken)` tells the store "treat the contract at this address as an ERC-20" — it holds WCR's *location and how to call it*, never a copy of WCR itself.
- **`immutable` is a verifiable promise.** `credit` is set once in the constructor and frozen forever, so anyone can confirm the store can never swap WCR for a worthless token — and reading it is cheaper too.
- **Structs group related fields.** `Item { name, price, active }` bundles one price card into a single custom type; prices are base units (100 WCR = `100 * 10**18`), the same integer language as balances.
- **Dynamic arrays grow a list.** `Item[] items` uses `.push()` to append, `.length` to count, and the zero-based index as the item id; the `public` getter returns one element at a time.
- **Access control comes later.** Today anyone can `addItem`; restricting the catalog to the instructor is Lesson 21's `onlyOwner`.

---

## What's Next?

The store has a display case and a price card, but it's a museum, not a shop — you can *look* at the turon, you just can't *buy* it. There's no function that takes a student's WCR. That's the missing piece, and it's the one Dan spent Lessons 16 through 18 secretly preparing for.

Next lesson, Dan adds `buyItem(uint256 id)` — the store's first real transaction. Inside it, the store calls `credit.transferFrom(msg.sender, address(this), item.price)`, pulling the buyer's approved WCR straight into the store. The full loop finally connects: a student `approve`s the store on the token, then calls `buyItem` on the store, and the credits actually move — and Dan finds out what happens when a student forgets to approve first.

**Next Lesson: Purchase a Reward** — `buyItem`, `transferFrom` from inside a contract, and the complete approve-then-buy flow.
