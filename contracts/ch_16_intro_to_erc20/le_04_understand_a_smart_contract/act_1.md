# Deploy Your First Contract and Talk to It

Build `HelloToken`, deploy it to Remix's built-in test blockchain, and click its buttons to read live on-chain state and call a function. This is the first real thing Dan makes that "lives" somewhere. Open `act_1.sol`: the `greet()` function is already carried over from Lesson 3 — your job is to give the contract *state* to remember, then see it on-chain. Work the TODOs in order.

## Task 1: Add the `name` State Variable

Declare a **public** `string` state variable `name` set to `"Hello Token"`. State variables live in the blockchain's storage at this contract's address and **persist** between calls. Marking it `public` does something extra: Solidity auto-generates a free `name()` getter — a clickable button — so you never write a read function yourself.

## Task 2: Add the `totalSupply` State Variable

Declare a **public** `uint256` state variable `totalSupply` set to `100`. `uint256` is the workhorse integer — a non-negative whole number, no decimals. Like `name`, `public` gives you a free `totalSupply()` getter. Both variables get their values the moment you deploy, and they stay there.

## Task 3: Compile and Deploy on the Remix VM

Open **https://remix.ethereum.org**, create `HelloToken.sol`, and paste your contract. On the **Solidity Compiler** tab, confirm the version satisfies `^0.8.20` and compile. Then open **Deploy & Run Transactions**, leave the environment on **Remix VM (Cancun)** (a free, instant, in-browser fake blockchain), make sure the selector says **HelloToken**, and click the orange **Deploy**. Deploying *does* cost gas — you created something — so it's a real transaction.

## Task 4: Read State and Call the Function

Under **Deployed Contracts**, expand the panel. You'll see three **blue** buttons — all free reads. Click **name** and **totalSupply** to read the actual values stored on-chain (you never wrote those getters — `public` did). Then click **greet**: notice the terminal logs it as a `call`, not a transaction — no gas, because `greet()` is `pure` and touches no state.

## Sample Output

Deploy in Remix, then click the blue buttons in the deployed panel:

```text
name()          ->  0: string: Hello Token
totalSupply()   ->  0: uint256: 100
greet()         ->  0: string: Kumusta, blockchain!
```

Every value above is readable by anyone who has the contract's address, and no one — not even Dan — can quietly rewrite it. The `greet()` click logs a `call`, never a `status 0x1` transaction: you asked a question and got an answer for free.

## Reflection Questions

1. You never wrote a `name()` or `totalSupply()` function, yet both appear as buttons in Remix. What did the word `public` do, and why does every ERC-20 lean on this same trick?
2. Clicking `greet()` cost zero gas and logged a `call`, not a transaction. Using the word `pure`, explain why the network charged you nothing.
3. If you reload the Remix tab, the deployed `HelloToken` disappears and `totalSupply` is gone with it. Does that contradict the claim that state "persists forever"? What is actually resetting, and what would be different on a real network?

## Challenge: Give HelloToken a Little More to Say

**Challenge A — Add a symbol and redeploy.** Every real token has a *symbol* (like `WCR` will). Add a third public state variable, `string public symbol = "HELLO";`, right under the `name` line. Recompile and **Deploy again** — you'll get a *new* address, because each deploy is a fresh instance. Expand the new deployed contract and click the new blue **symbol** button. Note what happens to the *old* deployed copy: editing the source does nothing to a contract already on-chain; only a fresh Deploy carries your change.

**Challenge B — Predict the colors before you click.** Without deploying anything new, answer on paper first, then verify in Remix: (1) Of the buttons `name`, `totalSupply`, `symbol`, and `greet` — which are **blue** and which, if any, are **orange**? Why? (2) Imagine you added `function setSupply(uint256 newSupply) public { totalSupply = newSupply; }`. Would its button be blue or orange, and would clicking it cost gas? Explain using the idea that changing shared state costs gas.

## What You've Learned

- A smart contract is **state + code living at an address** — `name` and `totalSupply` are the remembered state; `greet()` is the code.
- **`public` on a state variable auto-generates a free getter** with the same name — the exact shortcut behind every ERC-20 read function.
- **`view`/`pure`/getter reads are free** (blue in Remix); **changing state costs gas** (orange, a real transaction).
- **Deploying creates one live instance at a new address.** Each Deploy is a fresh copy; editing the source never touches a contract already on-chain.
