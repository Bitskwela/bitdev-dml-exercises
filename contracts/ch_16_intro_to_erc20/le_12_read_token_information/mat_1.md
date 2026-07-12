## Dan's Story: The Worksheet That Trusts No One

Last session Dan finally deployed. He'd opened Remix's **Deploy & Run** tab, picked "Remix VM (Cancun)", clicked **Deploy**, and watched a live `WORKSHOPCREDIT` appear under **Deployed Contracts** with a real address — `0xd91...39138`. Workshop Credit stopped being a file and became a *thing that existed somewhere*. Kuya JM's reply was one line: *"Ayan. Ngayon, basahin mo."* Read it. That's today.

Monday night, empty computer lab, one humming machine. Dan expanded the WCR instance and a stack of buttons unfolded — some blue, some orange. He didn't know the difference yet, but the blue ones looked *safe* somehow, like they wouldn't break anything.

He was still thinking about Kevin. Lesson 1's whole fight — the smudged notebook, *"Kuya Dan, tapos ko na, bakit wala akong credits?"* — had one root problem: only Dan could read the notebook. If a student wanted to check their own balance, they had to *ask Dan and believe him.*

He clicked the blue button that said `name`. No wallet popup, no gas, no "confirm." Just a value, instantly, in the terminal below.

> **Dan:** *(reading)* "Workshop Credit." Okay. It knows its own name.

He clicked `symbol` — `WCR`. He clicked `totalSupply` — a wall of digits. He clicked `balanceOf`, pasted his instructor address, and there was the same long number again. Every click, an answer. No permission asked, nothing changed. He clicked `totalSupply` ten times in a row like a kid with a doorbell, and it was 1,000 WCR every time — no transaction, no cost, no trace. He messaged JM.

> **Dan:** Kuya, bakit yung ibang buttons blue tapos yung iba orange? Yung blue, parang libre — pindot lang, may sagot agad, walang gas.
>
> **Kuya JM:** Yun mismo, Dan. Blue = *read*. `view` functions — tumitingin lang sila, hindi humahawak ng kahit ano. Kaya libre, kaya walang confirm. Orange = *write*: yun ang gagalaw ng balances, yun ang may gas. Ngayong linggo, blue muna. Learn to read the ledger before you touch it.

Dan pulled out a fresh page — but this time he wasn't writing balances *into* the notebook. He was copying them *out of* the ledger: name, symbol, decimals, total supply, his balance, a blank student's balance. A token-info worksheet. Halfway through he stopped and stared at it. *Anyone* could do this. Any student, on any laptop, with just the contract address, could click these exact blue buttons and get these exact answers — without asking him.

He could already hear his mom at the carinderia counter, arms crossed. *"Anak, paano ko malalaman kung totoo yang numero? Ikaw pa rin ang magsasabi."* For the first time, he had an answer that didn't start with "trust me."

---

## The Concept: Reading the Ledger Costs Nothing

### Two kinds of function: look vs. touch

Every function on a smart contract falls into one of two camps, and this whole lesson lives in the gap between them.

- **Read (view) functions** only *look* at the contract's state. They compute an answer and hand it back without changing a single stored value. Because nothing changes, no one has to agree and no block has to be mined — so they cost **no gas** and produce **no transaction.**
- **Write functions** *change* stored state — they move balances, set allowances, mint, burn. Changing shared state means the whole network must record it, so a write is a **transaction**: it costs gas, needs a signature, and leaves a permanent mark.

In Solidity a read-only function is marked `view` (may read state, never write) or `pure` (touches no state at all). You saw `greet()` marked `pure` back in HelloToken. Today's ERC-20 reads are all `view`.

### Remix paints them for you: blue vs. orange

Under **Deployed Contracts**, expand your WCR instance and every function becomes a color-coded button:

```text
   v WORKSHOPCREDIT AT 0xD91...39138
      [ name ]         BLUE   : view, read-only, free
      [ symbol ]       BLUE
      [ decimals ]     BLUE
      [ totalSupply ]  BLUE
      [ balanceOf ]    BLUE   (takes an address arg)
      ---------------------------------------------
      [ transfer ]     ORANGE : write, costs gas
      [ approve ]      ORANGE
      [ transferFrom ] ORANGE
```

A **blue** button is a `view`/`pure` call: the answer appears instantly, no MetaMask popup, no gas. In the Remix terminal it shows up as a **`call`**, not a **`transact`**. An **orange** button is a state-changing transaction — that's next lesson's territory. A `call` is a *question* answered locally; a `transact` is a *change* the whole network records. Every button's color tells you which one you're about to do, before you click.

### The five reads on your token

These come free from OpenZeppelin's ERC20 — you wrote none of them, but they're all here and all public:

| Function | Returns | What it answers | Type |
|---|---|---|---|
| `name()` | `string` | The token's full name | metadata |
| `symbol()` | `string` | The short ticker | metadata |
| `decimals()` | `uint8` | Base-unit scale (how many decimal places) | metadata |
| `totalSupply()` | `uint256` | Total credits in existence, in **base units** | core view |
| `balanceOf(account)` | `uint256` | One account's credits, in **base units** | core view |

Remember Lesson 9: `totalSupply` and `balanceOf` return **base units**, not the human number. With `decimals() = 18`, the display value 1,000 WCR is stored as `1000 * 10^18 = 1000000000000000000000`. The big number is the truth; divide by `10^18` for the human number.

### Why "free to read" is the entire point

This is the beat the whole course has been building toward, so slow down here.

A read call never touches a block because it never *needs* to — it isn't asking the network to agree on a change, only asking one question about a state everyone already shares. Anyone can call `balanceOf` on any address and get the same answer, forever, without permission and without paying. The ledger doesn't check *who's asking* — it just answers.

```text
   THE SMUDGED NOTEBOOK              THE PUBLIC LEDGER (WCR)
   -------------------              -----------------------
   Who can read it?  Only Dan       Who can read it?  Anyone, with the address
   Check a balance?  Ask Dan,       Check a balance?  Click balanceOf,
                     trust him                        read it yourself
   Quietly edited?   Yes, an        Quietly edited?   No — reading changes
                     eraser                           nothing; writing is a tx
   Trust required    Trust DAN      Trust required    Trust NOBODY — verify
```

Kevin doesn't have to *believe* Dan that he holds 100 WCR; Tita Malou doesn't have to *believe* there are exactly 1,000 credits. They click a blue button. **Transparency isn't a feature Dan added — it's what a read function *is*.**

### One call, four answers

The five reads are separate buttons, but nothing stops you from writing your *own* `view` function that bundles them. A tuple-returning read like `creditSummary()` calls `name()`, `symbol()`, `decimals()`, and `totalSupply()` internally and returns all four at once — still a blue button, still free, still a plain `call`. That's your activity: one click, the whole token's identity card. Because it only *reads*, it stays gasless and callable by anyone.

---

## Key Takeaways

- **Read (`view`) functions only look, never touch.** They compute an answer without changing state — so they cost no gas, sign no transaction, and can be called by anyone.
- **Remix colors them:** blue = read (instant, free, logged as a `call`); orange = write (a transaction that costs gas). Today you only press blue.
- **The five WCR reads** — `name`, `symbol`, `decimals`, `totalSupply`, `balanceOf` — all come free from OpenZeppelin's ERC20. You wrote none of them, but every one is public.
- **`totalSupply` and `balanceOf` return base units** (Lesson 9): 1,000 WCR reads as `1000000000000000000000`. The big number is the truth; divide by `10^18` for the human number.
- **You can bundle reads into your own `view`** — a `creditSummary()` returning a tuple is still gasless and public, because reading never touches a block.
- **Free-to-read *is* the transparency.** The notebook required trusting Dan; the ledger requires trusting no one — anyone with the address clicks the same blue button and gets the same honest answer.

---

## What's Next?

Dan can now *read* the ledger from every angle — but every number he's read has been frozen since the moment he deployed. The instructor holds 1,000, the students hold nothing, and nothing has actually *moved*. Reading is trust; the workshop needs credits to change hands.

Next lesson, Dan finally presses an **orange** button. He sends 100 WCR from his instructor account to a student — his very first `transfer` — and the notebook dispute from Lesson 1 gets the answer it never had: Kevin's balance stops being a promise and becomes a number on a ledger nobody can quietly erase.

**Next Lesson: Transfer Tokens** — Dan moves credits for the first time, from his account to a student's, and watches both balances update on-chain.
