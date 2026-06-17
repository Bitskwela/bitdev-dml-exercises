# Side Quest 1: Token Transfer with the Approval System

![ERC20 Token Transfer](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+1.0+-+COVER.png)

## Scene

The San Juan Digital Payment System is recovering, but Hackana's minions tampered with the ERC20 token approval mechanism, creating issues in transferring funds securely between vendors and customers. Neri, our blockchain defender, must fix the ERC20 approval logic so payments can resume safely and vendors can receive their dues.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+1.1.png)

**Time Allotment**: 20 minutes

## Why this matters

Almost every token you've ever heard of — USDC, DAI, the governance token of your favorite DeFi protocol — is an **ERC20** token. ERC20 is a *standard*: a fixed set of function names and behaviors that every wallet, exchange, and dApp agrees to speak. Because the interface is standardized, a marketplace built today can accept a token minted tomorrow without changing a line of code.

The part Hackana sabotaged is the most security-sensitive corner of that standard: the **approval system** (`approve` + `transferFrom`). It's the mechanism that lets you say "this DEX is allowed to pull up to 100 of my tokens when I trade" *without* handing the DEX your private key. Get it right and payments flow safely. Get it wrong and an attacker drains wallets the moment a victim clicks "approve." This lesson teaches you the standard inside-out so San Juan's payment rails are trustworthy again.

## The mental model: a token is just a ledger

A token contract doesn't move "coins" around. It's a **spreadsheet** living on-chain — a `mapping` from address to balance. "Transferring" tokens means subtracting from one row and adding to another. There are no physical objects; there is only bookkeeping that everyone can verify.

```solidity
mapping(address => uint256) public balanceOf;
```

Two parties matter in ERC20:

- The **owner** — the address that holds the tokens.
- The **spender** — an address the owner has authorized to move some of those tokens on their behalf.

The allowance system is the bridge between them.

## 1. `transfer` — moving your own tokens

`transfer` is the simple case: *you* send *your own* tokens to someone else. The contract checks you have enough, then edits the ledger.

```solidity
function transfer(address _to, uint256 _value) public returns (bool) {
    require(balanceOf[msg.sender] >= _value, "Not enough balance");
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    return true;
}
```

Note the **check before the change** — the `require` runs first, so a transfer that can't be covered reverts before any state is touched. This is the same "validate first" discipline from the validation lesson, and on Solidity 0.8.x the subtraction is also protected: if you somehow tried to subtract more than the balance, the built-in overflow check would revert anyway. The `require` just gives a clear reason instead of a bare `Panic`.

## 2. `approve` — handing out a spending limit

Here's the core idea. The owner doesn't give the spender tokens — they give the spender **permission to pull up to a limit**. That limit is the *allowance*, stored in a nested mapping keyed by `owner → spender → amount`.

```solidity
mapping(address => mapping(address => uint256)) public allowance;

function approve(address _spender, uint256 _value) public returns (bool) {
    allowance[msg.sender][_spender] = _value;
    return true;
}
```

Read the nesting carefully: `allowance[ownerAddress][spenderAddress]` is "how many of the owner's tokens this spender is still allowed to move." When you call `approve` on a DEX's behalf, *you* are `msg.sender` (the owner), and `_spender` is the DEX.

## 3. `transferFrom` — the spender uses the allowance

This is where the magic — and the danger — lives. A spender who was approved can now pull tokens *from* the owner *to* anywhere, as long as they stay within the allowance. It must enforce **two** checks and update **two** ledgers.

```solidity
function transferFrom(
    address _from,
    address _to,
    uint256 _value
) public returns (bool) {
    require(balanceOf[_from] >= _value, "Not enough balance");
    require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;
    allowance[_from][msg.sender] -= _value; // spend down the allowance!

    return true;
}
```

The line teams forget is the last one: **`allowance[_from][msg.sender] -= _value`**. If you don't decrement the allowance, a one-time approval of 100 tokens becomes an *infinite* withdrawal right — the spender could call `transferFrom` over and over until the owner's balance is gone. Spending down the allowance is what makes "approve 100" mean *100, total*, not *100 per call*.

### How the three fit together

| Function | Who calls it | What it changes | Guard rails |
|---|---|---|---|
| `transfer(to, v)` | the token owner | `balanceOf[caller]`, `balanceOf[to]` | caller has enough balance |
| `approve(spender, v)` | the token owner | `allowance[caller][spender]` | (none required — it just sets a limit) |
| `transferFrom(from, to, v)` | an approved spender | both balances **and** `allowance[from][caller]` | `from` has balance AND caller has allowance |

The typical flow: **Alice `approve`s the marketplace for 100 → the marketplace `transferFrom`s 30 when Alice buys → Alice's allowance drops to 70.**

## Security: the approve race condition

Raw `approve` carries a well-known hazard called the **approve front-running / double-spend race**. Suppose Alice approved a spender for 100, then wants to *lower* it to 50. She sends `approve(spender, 50)`. A malicious spender watching the mempool can:

1. Spend the original 100 with `transferFrom` *before* the new approval lands, then
2. Spend another 50 *after* it lands —

draining 150 instead of the 50 Alice intended.

Two defenses, in order of preference:

- **Set to zero first, then to the new value** (`approve(spender, 0)` → `approve(spender, 50)`), so there's no window where both old and new allowances are live.
- **Better: use OpenZeppelin's `increaseAllowance` / `decreaseAllowance`** style helpers, which adjust the allowance by a *delta* rather than overwriting it, closing the race entirely.

> In production you would **never hand-roll an ERC20**. You'd inherit OpenZeppelin's battle-tested `ERC20` base — it implements `transfer`, `approve`, `transferFrom`, events, and the allowance bookkeeping correctly for you:
>
> ```solidity
> import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
>
> contract SanJuanToken is ERC20 {
>     constructor(uint256 initialSupply) ERC20("SanJuanToken", "SJT") {
>         _mint(msg.sender, initialSupply);
>     }
> }
> ```
>
> We hand-build it here so you can *see the wiring*. Once you understand it, always reach for the library.

## Security: calling other tokens with `SafeERC20`

When *your* contract needs to move *someone else's* ERC20 (e.g. a vault pulling a user's USDC), don't call `token.transferFrom(...)` directly. Some real-world tokens (famously USDT) **don't return a bool** on success, and others return `false` instead of reverting on failure. A naive call either reverts on a perfectly good token or silently ignores a failed transfer.

OpenZeppelin's `SafeERC20` normalizes all of this — it checks the return value when there is one and reverts on failure regardless:

```solidity
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

using SafeERC20 for IERC20;

token.safeTransferFrom(user, address(this), amount); // reverts on any failure
```

Rule: **internal accounting can call the base ERC20 directly; any call to an *external, untrusted* token should go through `SafeERC20`.**

## Common mistakes to avoid

1. **Forgetting to decrement the allowance in `transferFrom`.** This is the single most dangerous bug here — it turns a finite approval into an unlimited one.
2. **Checking balance but not allowance (or vice versa).** Both `require`s are mandatory: balance proves the tokens exist, allowance proves the caller is permitted to move them.
3. **Overwriting allowances instead of using zero-first or delta helpers.** Exposes users to the approve race condition.
4. **Trusting an external token's return value blindly.** Use `SafeERC20` for any token you didn't write.
5. **Not emitting `Transfer` / `Approval` events.** (The OZ base does this for you.) Wallets and explorers rely on these events to show balances; a token without them looks "frozen" to the outside world.
6. **Confusing `msg.sender` in `transferFrom`.** In `transferFrom`, `msg.sender` is the *spender*, not the token owner — the allowance is checked against `allowance[_from][msg.sender]`.

## What's next

You now understand the engine behind every token payment, DEX swap, and staking deposit. Next, in **NFT Minting Logic**, you'll move from fungible tokens (every SJT is identical) to *non-fungible* ones (every NFT is unique) and learn to gate minting with a supply cap and access control.

## References

- EIP-20: ERC20 Token Standard — https://eips.ethereum.org/EIPS/eip-20
- OpenZeppelin v5 — ERC20 — https://docs.openzeppelin.com/contracts/5.x/api/token/erc20
- OpenZeppelin v5 — SafeERC20 — https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#SafeERC20
- Solidity by Example — ERC20 — https://solidity-by-example.org/app/erc20/

## Closing

Neri pushes the patched `SanJuanToken` to the network and watches the vendor dashboard come alive. A suki approves the palengke marketplace once; the marketplace pulls exactly what's owed and not a token more; the allowance ticks down precisely as it should. "Tama lang ang pinahintulutan, tama lang ang nakuha." (Only what was permitted, only what was taken.) The payment rails of San Juan are flowing safely again.
