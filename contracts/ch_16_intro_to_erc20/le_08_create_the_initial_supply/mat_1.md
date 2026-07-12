## Dan's Story: The First Line in the Ledger

Last week's win still felt unreal: Dan finally had a token that knew its own name. `constructor() ERC20("Workshop Credit", "WCR") {}` — he deployed it, clicked `name()` and read back **"Workshop Credit"**, clicked `symbol()` and read back **"WCR"**. Then he clicked `totalSupply` and Remix answered `0`. A named, compiling, fully-legitimate token — holding exactly zero credits. Every balance in the whole contract was zero, his own included. The notebook existed; nothing was written in it yet. And it bugged him all day.

Wednesday evening, carinderia already wiped down, the last suki long gone. Tita Malou was refilling the toyo bottles by the register while Dan hunched over his laptop at the wobbly corner table, the short leg propped on a folded receipt like always.

> **Dan:** Ma, it's like I printed a brand-new utang notebook — nice cover, "Workshop Credit" nakasulat sa harap — pero walang laman. Wala pang kahit isang linya.

Tita Malou didn't look up from the toyo.

> **Tita Malou:** Eh di sulatan mo. Anong silbi ng notebook na blanko?

Which was, annoyingly, the whole problem in one sentence. Somebody has to write the first line. In his smudged paper notebook that was easy — grab a pen, write *"Kevin — 100."* But this notebook lived inside a contract. There was no pen, no page he could reach in and scribble on.

He'd been reading the OpenZeppelin source in Remix that afternoon and kept tripping over one function: `_mint`. Underscore in front — which JM once said meant "internal: the contract uses it on itself, outsiders can't call it." He fired off a voice note.

> **Dan:** JM, para gumawa ng credits, `_mint` ba? Pero paano ko sya tatawagin? Wala syang button sa Remix.
>
> **Kuya JM:** Tama, `_mint`. And wala nga syang button — internal sya, so walang taga-labas na makakagawa ng credits kahit gustuhin nila. Feature yun, hindi bug. The only place you can call it is from *inside* your own contract. So saan mo ilalagay? Sa constructor — yung tumatakbo isang beses lang, sa deploy. Yun ang first line mo. Mint yourself a starting pile the moment the token is born.

Dan sat with that. The constructor runs once, at birth. Whoever deploys is `msg.sender` at that moment — the instructor, him. He could hand himself the whole starting supply in the same breath the token comes alive.

> **Kuya JM:** Like the paluwagan — somebody puts the first money in the pot before anyone can pull from it. Mint 1,000 to yourself, tapos later you hand them out. Sige, subukan mo.

Tita Malou wandered over with two cups of leftover sago't gulaman, set one by his elbow, and squinted at the screen the way she squints at any number she didn't write herself.

> **Tita Malou:** Gagawa ka ng pera sa computer. Anak, scam yan — nakita ko sa Facebook.
>
> **Dan:** Hindi pera, Ma. Points. Parang stamp card ni Aling Nena — bumili ng sampu, libre ang isa. I'm giving myself the whole stamp booklet first, tapos ako mag-iistampa sa mga bata pag natapos nila. And unlike your notebook — *makikita nila.* Hindi lang sa akin nakasulat.

She made a noise that wasn't agreement but wasn't quite the usual *scam yan* either. Progress. Dan turned back to the constructor and typed the one line that would write the ledger's very first entry.

---

## The Concept: Minting — Writing Credits Into Existence

### What `_mint` actually does

`_mint(account, amount)` is an **internal helper** you inherit from OpenZeppelin's `ERC20`. It does two things atomically — and they are the *only* honest way credits ever come into existence:

1. **Adds `amount` to `balanceOf(account)`** — that account now holds more credits.
2. **Adds `amount` to `totalSupply`** — the grand total of all credits goes up by the same amount.

That second part is the important one. There is no minting credits *to someone* without the *total* rising by the same number. The books always balance. You cannot secretly inflate one balance without the total showing exactly that many new credits appeared.

```text
        BEFORE _mint(you, 1000)              AFTER _mint(you, 1000)
        -----------------------              ----------------------
        totalSupply .......... 0             totalSupply ......... 1000
        balanceOf(you) ....... 0             balanceOf(you) ...... 1000
        balanceOf(kevin) ..... 0             balanceOf(kevin) .... 0
                                             ^ your balance AND the
                                               total moved together
```

### Why it's `_mint`, not `mint`

The leading underscore is an OpenZeppelin convention meaning **internal**: callable only from *inside* your contract. No button in Remix, no random wallet on the internet can invoke it. That is deliberate — if anyone could mint, credits would be worthless (Ate Rina's whole point, still lessons away). For now the guardrail is simple: the *only* place we call `_mint` is the constructor, so credits are created exactly once, at deployment, and never again (yet).

### `msg.sender` in a constructor = the deployer

`msg.sender` always means "the address that called this code." Inside a **constructor**, that call *is the deployment transaction* — so `msg.sender` is the account that **deployed** the contract. In Remix that's whichever account is selected in "Deploy & Run" when you hit Deploy. That's you, the instructor.

| Where you write `msg.sender` | What it means |
|---|---|
| In the constructor | The account that **deployed** the contract |
| In a normal function later (e.g. `transfer`) | The account that **called that function** |

So `_mint(msg.sender, 1000)` reads: *"the moment I'm born, hand my deployer 1,000 base units."*

### `totalSupply` is just the sum of every balance

Worth saying out loud, because it's the invariant the whole token rests on: **`totalSupply` always equals the sum of every account's `balanceOf`.** Not "usually." Always. `_mint` keeps it true by moving both numbers up together; `transfer` just shuffles credits between two balances, so the total never changes. Only minting and burning move the total.

```text
   totalSupply  ==  balanceOf(you) + balanceOf(kevin) + balanceOf(everyone else)
      1000       ==      1000       +        0         +          0
```

Minting also shows on the public ledger as a transfer **from the zero address** (`0x0000...0000`) — nobody, an address with no owner and no private key — **to you**. "From nobody, to Dan, 1,000." Even credit *creation* is a visible line anyone can read; nothing sneaks in through a side door. (We open that log in Lesson 14.)

### The catch nobody warned Dan about

Look at the type `_mint` wants: `amount` is a `uint256` — a plain whole number, nothing after a dot. Solidity has **no decimals, no floats, no fractions**. You literally cannot type `_mint(msg.sender, 1000.5)` — it won't compile. Every amount a token moves is an integer count of its smallest unit, and "where the decimal point goes for a human" is a *separate* display question. Dan just met the counting half. Watch what the display half does to his `1000`.

He minted `1000`, and `balanceOf` cheerfully returned `1000`. But WCR is an 18-decimal token (OpenZeppelin's default — next lesson). Any real wallet slides the point 18 places left before showing it:

```text
   raw on-chain balance:  1000
   decimals declared:     18
   displayed as WCR:      1000 / 10^18  =  0.000000000000001000 WCR
```

So Kevin, opening a wallet to check his instructor's stash, wouldn't read "1,000 WCR." He'd read **`0.000000000000001000 WCR`** — a microscopic sliver of a single credit. The raw integer is correct; the place value is off by an enormous, invisible factor Dan never typed and never saw.

> **Kuya JM:** Hindi nasira — nag-mint ka ng 1000, pero 1000 *ng ano*? Not 1,000 credits. It's 1,000 of the smallest sliver the token can count. Parang nag-deposito ka ng 1,000 *centavos* tapos nagtaka ka bakit ang liit. Tama lahat ng numero mo. Mali lang yung *unit*. Bukas, decimals — yun ang fix.

The compiler didn't stop him. The deploy succeeded. Every number is internally consistent. And the token is still *wrong* in the one way that matters — it holds a sliver where Dan meant a thousand. Don't fix it yet. Sit in the weirdness. Lesson 9 is the whole answer.

---

## Key Takeaways

- **`_mint(account, amount)` is how credits come into existence** — it raises that account's balance *and* `totalSupply` by the same amount, atomically. The books always balance.
- **It's `_mint`, not `mint`** — the underscore means internal. No button, no outside caller. Right now the only place it runs is the constructor, so credits are created exactly once, at deployment.
- **The constructor runs once, at deployment** — putting `_mint` there hands the deployer a starting pile the moment the token is born, like the first contribution into a paluwagan pot.
- **`msg.sender` in a constructor is the deployer** — the account selected in Remix when you hit Deploy. In a normal function later, it's whoever *called* that function.
- **Minting is a public transfer from the zero address** — "from nobody, to you" — so even creation is a visible line. Nothing sneaks in.
- **Solidity has no decimals or floats** — every `amount` is a whole-number `uint256`, a count of the smallest unit. Getting the unit wrong is exactly what bit Dan.
- **The number is right, the unit is not.** `1000` raw base units on an 18-decimal token displays as `0.000000000000001000 WCR` — a sliver, not a thousand. That gap is the cliffhanger into Lesson 9.

---

## What's Next?

Dan has a token holding exactly `1000` — and every wallet on Earth renders that as `0.000000000000001000 WCR`, a crumb of a single credit. Nothing broke. Nothing errored. By every technical measure the contract works perfectly. And it is still wrong, because Dan meant *a thousand credits* and the ledger holds a sliver.

The culprit is a single number he never chose and never even saw: **decimals**, quietly defaulting to `18`. Next lesson JM finishes the centavo analogy — pesos versus centavos, except with eighteen zeros — and Dan learns the one idea that makes every ERC-20 balance on the planet make sense: on-chain there are no decimal points at all, only whole-number **base units**, and `decimals()` is nothing but a display instruction. The fix is a five-character edit to that `_mint` line, and the moment it lands, `balanceOf` finally reads a clean `1000` WCR.

**Next Lesson: Understand Token Decimals** — base units, `10 ** decimals()`, and why your 1,000 looked like almost nothing.
