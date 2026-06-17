# ERC1155 Token Standard — One Contract, Many Assets

![28.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_28_erc1155_token_standard/28.0%20-%20COVER.png)

## Scene

The final stage of Neri's quest against Hackana has begun. Hackana deploys its most sophisticated malware, targeting multi-purpose digital assets like gaming collectibles and resource tokens.

To counter this, Neri introduces her team to the **ERC1155 token standard**, known for its versatility in handling multiple types of assets within a single smart contract. One contract can hold a stack of **1000 fungible Gold Coins** *and* a single **one-of-a-kind Artifact** at the same time — and move dozens of them in one cheap, batched transaction.

This innovation empowers Neri's team to build highly efficient contracts that defend against Hackana while enabling seamless operations for digital assets across games, marketplaces, and barangay reward programs.

![28.1 - ERC1155 Token Standard](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_28_erc1155_token_standard/28.1.png)

## Why this matters

Before ERC1155, a game that wanted fungible gold (ERC20) *and* unique swords (ERC721) had to deploy and manage **two separate contracts** — two sets of approvals, two gas bills, two integration paths. Worse, sending a player ten different items meant ten separate transfer transactions.

**ERC1155 collapses all of that into one contract addressed by token `id`.** Each `id` is its own "bucket" of supply. Mint 1000 of id `1` and it behaves like a currency; mint exactly 1 of id `2` and it behaves like an NFT. Batch operations move many ids at once. This is *the* standard for games, in-game economies, and any system juggling multiple asset types — and it's what Neri needs to rebuild San Juan's digital economy efficiently.

## The mental model: a balance sheet keyed by (account, id)

ERC20 tracks `balanceOf(account)` — one number per holder. ERC1155 tracks **`balanceOf(account, id)`** — a separate balance for *every token type a holder owns*. Picture a spreadsheet:

| account | id 1 (GOLD) | id 2 (ARTIFACT) |
|---|---|---|
| Neri | 1000 | 1 |
| Player A | 50 | 0 |

- **Fungible** tokens (GOLD): many units of the same id, interchangeable — a currency.
- **Non-fungible** tokens (ARTIFACT): supply of exactly **1** for that id — unique.
- **Semi-fungible**: e.g. 100 "concert tickets" of one id that later become collectibles. Same machinery.

The standard doesn't enforce fungibility — *you* decide by how much you mint of each id.

## The MultiAsset contract — Neri's resource vault

Here is the complete contract this lesson builds, current for OpenZeppelin v5:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MultiAsset is ERC1155, Ownable {
    uint256 public constant GOLD = 1;     // Fungible token
    uint256 public constant ARTIFACT = 2; // Non-fungible token

    constructor()
        ERC1155("https://api.example.com/metadata/{id}.json")
        Ownable(msg.sender)
    {
        _mint(msg.sender, GOLD, 1000, "");  // Mint 1000 Gold Coins
        _mint(msg.sender, ARTIFACT, 1, ""); // Mint 1 Special Artifact
    }

    function mint(address to, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(to, id, amount, data);
    }
}
```

Let's break down every concept it touches.

## 1. The constructor: base URI + ownership

`ERC1155` takes **one** constructor argument — a base metadata URI — and `Ownable` takes the initial owner (the v5 requirement you met in Lesson 24).

```solidity
constructor()
    ERC1155("https://api.example.com/metadata/{id}.json")
    Ownable(msg.sender)
{ ... }
```

**Key gotcha — `Ownable(msg.sender)` is mandatory in v5.** Omit it and the contract won't compile. The deployer becomes the owner and gains the `onlyOwner` minting power.

## 2. `_mint` — create supply of one id

```solidity
_mint(to, id, amount, data);
//    │   │   │       └─ extra bytes passed to receiver hooks (usually "")
//    │   │   └─ how many units to create
//    │   └─ which token type (the bucket)
//    └─ who receives them
```

`_mint(msg.sender, GOLD, 1000, "")` credits Neri with 1000 of id `1`. `_mint(msg.sender, ARTIFACT, 1, "")` gives her the single unique id `2`.

**Key gotcha — `_mint` is `internal`.** Like ERC20's `_mint`, you never expose it directly. The public `mint(...)` wrapper above is guarded with `onlyOwner`, so only Neri can issue new assets — Hackana can't print Gold.

## 3. `_mintBatch` — create several ids at once

When you need to mint *many* types in one shot, `_mintBatch` takes parallel arrays of ids and amounts:

```solidity
function mintStarterPack(address to) external onlyOwner {
    uint256[] memory ids = new uint256[](2);
    uint256[] memory amounts = new uint256[](2);
    ids[0] = GOLD;     amounts[0] = 100; // 100 gold
    ids[1] = ARTIFACT; amounts[1] = 1;   // 1 artifact
    _mintBatch(to, ids, amounts, "");
}
```

**Key gotcha — the arrays must be the same length**, paired index-by-index (`ids[i]` gets `amounts[i]`). A length mismatch reverts. Batching is the whole point of ERC1155: one transaction, one base gas cost, many assets.

## 4. Reading balances: single and batch

```solidity
// One holder, one id:
uint256 gold = token.balanceOf(neri, GOLD); // -> 1000

// Many (account, id) pairs in one call:
address[] memory accounts = new address[](2);
uint256[] memory ids      = new uint256[](2);
accounts[0] = neri;     ids[0] = GOLD;
accounts[1] = playerA;  ids[1] = ARTIFACT;
uint256[] memory balances = token.balanceOfBatch(accounts, ids);
```

Note ERC1155's `balanceOf` takes **two** arguments `(account, id)` — unlike ERC20's single-argument `balanceOf(account)`. Forgetting the `id` is a common slip when coming from ERC20. `balanceOfBatch` returns an array of balances for many `(account, id)` pairs at once.

## 5. Transfers: `safeTransferFrom` and `safeBatchTransferFrom`

ERC1155 transfers are always **"safe"** — the recipient, if it's a contract, must signal it can handle ERC1155 tokens (via the `onERC1155Received` hook) or the transfer reverts. This prevents tokens getting stranded in contracts that can't move them.

```solidity
// Move 50 GOLD from `neri` to `playerA`:
token.safeTransferFrom(neri, playerA, GOLD, 50, "");

// Move several ids in one transaction:
uint256[] memory ids     = new uint256[](2);
uint256[] memory amounts = new uint256[](2);
ids[0] = GOLD;     amounts[0] = 50;
ids[1] = ARTIFACT; amounts[1] = 1;
token.safeBatchTransferFrom(neri, playerA, ids, amounts, "");
```

**Key gotcha — operator approval is all-or-nothing.** ERC1155 has no per-token allowance like ERC20. A holder calls `setApprovalForAll(operator, true)` to let an operator (e.g. a marketplace) move **all** of their ids, or keeps it `false`. There's no "approve 50 GOLD only." Approve operators you trust.

## 6. The `{id}` URI substitution — one template for every token

The base URI you pass to the constructor contains a literal `{id}` placeholder:

```
https://api.example.com/metadata/{id}.json
```

This is an ERC1155 convention: clients substitute the requested token id — **as a lowercase, zero-padded 64-character hex string** — into `{id}` to fetch that token's metadata. So GOLD (id 1) resolves to:

```
https://api.example.com/metadata/0000000000000000000000000000000000000000000000000000000000000001.json
```

**Key gotcha — the substitution is done by the client, not Solidity.** The default `uri(uint256)` function returns the *same* template string for every id (it does **not** interpolate on-chain — that would waste gas). Wallets and explorers do the replacement. If you need genuinely per-id URIs on-chain, override `uri(uint256)` yourself.

## ERC20 vs ERC721 vs ERC1155

| Feature | ERC20 | ERC721 | ERC1155 |
|---|---|---|---|
| Asset kind | Fungible (currency) | Non-fungible (unique) | **Both + semi-fungible** |
| Token types per contract | 1 | 1 collection | **Many (by `id`)** |
| `balanceOf` | `(account)` | `(account)` count | **`(account, id)`** |
| Batch transfers | No | No | **Yes (`safeBatchTransferFrom`)** |
| Best for | Money/points | Art/deeds | **Games, mixed economies** |

## Security & gas notes

- **Batching is the gas win.** Sending 10 item types via 10 ERC20/721 transfers pays the ~21,000-gas transaction base cost 10 times. One `safeBatchTransferFrom` pays it once. For games minting loot, this is dramatic savings.
- **Guard your `mint`.** An unguarded public `mint` lets anyone inflate any id to infinity. `onlyOwner` (or an `AccessControl` MINTER role) is non-negotiable.
- **`safeTransferFrom` protects recipients, not senders.** It checks the *receiver* can handle the token; it does **not** validate your business rules. Add your own `require`s for game logic.
- **Overflow is handled.** Since Solidity 0.8, `amount` arithmetic reverts on overflow automatically — no SafeMath needed, and OZ v5 removed it anyway.

## Common mistakes to avoid

1. **Calling `balanceOf(account)` with one argument.** ERC1155 needs `balanceOf(account, id)`. The single-arg ERC20 habit won't compile.
2. **Omitting `Ownable(msg.sender)`.** The v5 constructor requirement — your contract won't compile without it.
3. **Mismatched array lengths in batch calls.** `ids` and `amounts` must be equal length; otherwise it reverts.
4. **Expecting on-chain `{id}` interpolation.** The default `uri()` returns the raw template; clients substitute. Override `uri()` only if you truly need per-id strings on-chain.
5. **Exposing `_mint` / `_mintBatch` publicly.** Wrap them in guarded functions.
6. **Assuming ERC20-style allowances.** ERC1155 uses operator approval (`setApprovalForAll`), which is all-or-nothing.

## What's next

You can now manage entire economies in one contract. In **Lesson 29** you'll make contracts you can *upgrade* after deployment using the proxy pattern and `@openzeppelin/contracts-upgradeable`, so a live token economy can gain new features without migrating balances. **Lesson 30** then hardens everything with the Checks-Effects-Interactions pattern and `ReentrancyGuard`. Looking back, **Lesson 24** introduced the inheritance and `Ownable(msg.sender)` foundation this lesson builds on.

## References

- OpenZeppelin Contracts v5 — ERC1155 guide — https://docs.openzeppelin.com/contracts/5.x/erc1155
- OpenZeppelin Contracts v5 — ERC1155 API reference — https://docs.openzeppelin.com/contracts/5.x/api/token/erc1155
- EIP-1155 (the standard) — https://eips.ethereum.org/EIPS/eip-1155
- ERC1155 metadata `{id}` substitution rules — https://eips.ethereum.org/EIPS/eip-1155#metadata
- OpenZeppelin Contracts Wizard — https://wizard.openzeppelin.com/

## Closing

As Neri and her team deploy the ERC1155-based contract, Hackana's attempts to destabilize multi-purpose digital assets fail spectacularly. Gold flows through the palengke, rare Artifacts reward the defenders, and a single batched transaction equips an entire barangay's worth of players at once. The versatility and efficiency of ERC1155 prove to be a decisive advantage.

In the aftermath, the blockchain infrastructure is stronger than ever, inspiring a new generation of developers to build creative applications on Ethereum — many of them, like Neri, standing on the shoulders of one well-chosen standard.
