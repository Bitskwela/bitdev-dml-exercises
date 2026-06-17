# Side Quest 6: NFT Royalty System — Splitting a Sale & EIP-2981

![NFT Royalty System](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+6.0+-+COVER.png)

## Scene

After Hackana's devastating attacks on Web3 infrastructures, the NFT marketplace of San Juan collapsed — leaving creators unrewarded. Hackana's minions tampered with the royalty payout logic, stripping artists of their deserved income.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+6.1.png)

Now, Neri — **San Juan's top software engineer** — must restore fairness to the creative economy. With her skill, she will secure royalties for every NFT trade, ensuring creators thrive once again.

## Why this matters

A royalty is a promise: *every time this work resells, the original creator gets a cut.* In the old web, that promise lived in contracts, lawyers, and the goodwill of a marketplace. On-chain, the promise can be enforced by code that no one can quietly edit — which is exactly the trust Hackana destroyed and Neri must rebuild.

But "enforce a payout in code" is deceptively dangerous. You are splitting real ETH between a creator and a seller in a single transaction, and the way you *send* that ETH determines whether your contract is safe or a sitting duck for reentrancy and stuck funds. This lesson teaches both halves: the **royalty math** (carving out a percentage correctly), and the **safe payout** (moving ETH without getting drained or bricked). Then it shows you the modern standard — **EIP-2981** — that the whole ecosystem agreed on so royalties travel with the token across every marketplace.

## 1. The royalty math — carve out a percentage

A royalty is just a percentage of the sale price. You already met the golden rule in the previous side quest: **multiply before you divide**, because Solidity has no decimals and division truncates.

```solidity
// salePrice = 1 ETH (in wei), royaltyPercentage = 10  → 10%
uint256 royalty = (salePrice * royaltyPercentage) / 100;
uint256 sellerAmount = salePrice - royalty;
```

Computing `royalty` first and deriving `sellerAmount` by subtraction guarantees the two parts **always sum back to exactly `salePrice`** — no wei is lost to a second rounding. That conservation property matters: if you computed each share independently with its own division, rounding could leave a stray wei trapped in the contract forever.

> For sub-percent royalties (say 2.5%), use **basis points**: `royalty = salePrice * royaltyBps / 10_000`, where `250` means 2.5%. This is what real marketplaces use.

## 2. Sending ETH safely — `.call` beats `.transfer`

Here is the single most important upgrade over older tutorials. There are three ways to send ETH, and **only one is recommended today**:

| Method | Gas forwarded | On failure | Verdict |
|--------|---------------|------------|---------|
| `payable(to).transfer(amount)` | **2300 only** | reverts automatically | **Avoid** — the 2300 stipend breaks for smart-contract recipients |
| `payable(to).send(amount)` | 2300 only | returns `false` (easy to ignore) | Avoid |
| `(bool ok, ) = to.call{value: amount}("")` | **all remaining gas** | returns `false` — you must check | **Recommended** |

Why `.transfer()` is now an anti-pattern: it forwards a hard-coded **2300-gas stipend** to the recipient. That was meant as a reentrancy guard, but it backfires. If the recipient is a smart contract — a multisig wallet, a Gnosis Safe, an account-abstraction wallet — its `receive()` function often needs more than 2300 gas just to accept the payment, so `.transfer()` **reverts and the creator can never be paid.** Gas costs of underlying opcodes have also changed across network upgrades, making the fixed 2300 stipend brittle and future-unsafe.

The modern, robust pattern is a low-level `.call` with an explicit success check:

```solidity
(bool sentRoyalty, ) = payable(creator).call{value: royalty}("");
require(sentRoyalty, "Royalty transfer failed");

(bool sentSeller, ) = payable(currentOwner).call{value: sellerAmount}("");
require(sentSeller, "Seller transfer failed");
```

`call` forwards all available gas (so contract wallets can accept) and returns a boolean — which you **must** `require`, because a failed `call` does *not* revert on its own. Silently ignoring that boolean is how funds get lost.

> The activity's starter code uses `.transfer()` to keep the first pass simple. Now that you understand the failure mode, prefer `.call{value:}("")` + a success check in anything you ship for real.

## 3. Guarding the payout — reentrancy & Checks-Effects-Interactions

Because `.call` forwards all gas, the recipient could be a malicious contract that *calls back into your function* before it finishes — a **reentrancy attack**. Two defenses, used together:

**Checks-Effects-Interactions** — do all your checks, then update all your state, and only *then* send ETH (the external interaction) last:

```solidity
function transferNFT(address buyer, uint256 salePrice) public payable {
    require(msg.value == salePrice, "Incorrect payment amount");   // Checks

    uint256 royalty = (salePrice * royaltyPercentage) / 100;
    uint256 sellerAmount = salePrice - royalty;
    address seller = currentOwner;

    currentOwner = buyer;                                          // Effects (state first!)

    (bool a, ) = payable(creator).call{value: royalty}("");        // Interactions (last)
    require(a, "Royalty transfer failed");
    (bool b, ) = payable(seller).call{value: sellerAmount}("");
    require(b, "Seller transfer failed");
}
```

Notice `currentOwner` is updated **before** any ETH leaves the contract. Even if a recipient tries to reenter, the ownership state is already final.

**OpenZeppelin's `ReentrancyGuard`** — for belt-and-suspenders, add the `nonReentrant` modifier. In OpenZeppelin **v5** the import path is `@openzeppelin/contracts/utils/ReentrancyGuard.sol`:

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract NFTWithRoyalties is ReentrancyGuard {
    function transferNFT(address buyer, uint256 salePrice) public payable nonReentrant {
        // ...
    }
}
```

## 4. The modern standard — EIP-2981

The DIY contract above bakes the royalty into one bespoke `transferNFT`. That works in isolation, but it doesn't *travel*: when the NFT lands on OpenSea, Blur, or any other marketplace, none of them know your custom rule. The ecosystem solved this with **EIP-2981 (NFT Royalty Standard)** — a tiny, standardized interface that lets *any* marketplace ask a token, "for this sale price, who gets a royalty and how much?"

```solidity
function royaltyInfo(uint256 tokenId, uint256 salePrice)
    external view returns (address receiver, uint256 royaltyAmount);
```

OpenZeppelin v5 ships a ready-made `ERC2981` mixin. You set a default royalty in the constructor, and marketplaces read it through the standard interface:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC2981} from "@openzeppelin/contracts/token/common/ERC2981.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SanJuanArt is ERC721, ERC2981, Ownable {
    constructor(address creator)
        ERC721("SanJuanArt", "SJA")
        Ownable(msg.sender)      // OZ v5: owner is passed explicitly
    {
        // 500 basis points = 5% royalty to the creator on every sale
        _setDefaultRoyalty(creator, 500);
    }

    // Required: resolve the diamond inheritance of supportsInterface
    function supportsInterface(bytes4 interfaceId)
        public view override(ERC721, ERC2981) returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```

A few v5 details worth internalizing:

- **`Ownable(msg.sender)`** — in OpenZeppelin v5, `Ownable`'s constructor *requires* an explicit initial owner argument. The old zero-argument `Ownable()` no longer compiles.
- **`_setDefaultRoyalty(receiver, feeNumerator)`** uses **basis points out of 10,000**, so `500` = 5%.
- **`supportsInterface` override** — because the contract inherits from both `ERC721` and `ERC2981`, you must override `supportsInterface` and call `super` so the contract correctly advertises *both* standards.

> **Important caveat:** EIP-2981 *signals* the royalty; it does not *enforce* payment. A marketplace queries `royaltyInfo` and chooses to honor it. On-chain enforcement (like the DIY split above) guarantees payment but only for sales that go through *your* contract. Real systems combine both: implement EIP-2981 for ecosystem compatibility, and enforce on-chain where the trade path is under your control.

## DIY split vs. EIP-2981 — when to use which

| | DIY on-chain split (the activity) | EIP-2981 (`ERC2981`) |
|---|---|---|
| **Enforcement** | Payment guaranteed for sales through your contract | Only a *signal*; marketplace chooses to honor |
| **Marketplace support** | None — they don't know your rule | Recognized by OpenSea, Blur, etc. |
| **Royalty travels with token** | No | Yes |
| **Best for** | Learning the mechanics; closed marketplaces you control | Production NFTs meant to trade anywhere |

## Common mistakes to avoid

1. **Using `.transfer()` for payouts.** The 2300-gas stipend silently breaks for smart-contract recipients (multisigs, AA wallets), locking creators out of their royalties. Use `.call{value:}("")` and check the returned boolean.
2. **Ignoring the success boolean from `.call`.** A failed `.call` does **not** revert by itself. Always `require(success, "...")`, or funds vanish into a failed transfer with no error.
3. **Sending ETH before updating state.** Update ownership (and any balances) *before* the external call — Checks-Effects-Interactions — to slam the door on reentrancy.
4. **Computing each share with its own division.** Compute `royalty` then `sellerAmount = salePrice - royalty` so the parts always sum exactly to `salePrice`; independent divisions can strand a wei.
5. **Reinventing royalties when EIP-2981 exists.** For anything that should trade on real marketplaces, implement `ERC2981` so the royalty is portable — don't lock it inside a one-off function.
6. **Using deprecated OpenZeppelin patterns.** No `Counters`, no `SafeMath` (0.8+ has built-in overflow checks), no zero-arg `Ownable()`. Use `Ownable(msg.sender)` and OZ v5 import paths.

## Gas & security notes

- `.call` forwarding all gas is *correct* for payouts, but it's also why reentrancy protection is non-negotiable — pair it with Checks-Effects-Interactions and/or `nonReentrant`.
- For paying *many* recipients, prefer a **pull-payment** pattern (recipients withdraw their own balance) over pushing ETH in a loop — one failing recipient can't block everyone else, and you minimize external calls.
- EIP-2981 is `view`-only and costs nothing to query off-chain; it adds negligible on-chain overhead.

## What's next

You've split value safely between parties and met the standard that makes royalties portable. Next, in the **Decentralized Traffic Management** side quest, you'll switch from *moving value* to *managing state* — and learn why the discrete "valid states" you've been comparing as strings really belong in an `enum`, with `onlyOwner` access control guarding every change.

## References

- EIP-2981 — NFT Royalty Standard — https://eips.ethereum.org/EIPS/eip-2981
- OpenZeppelin v5 — `ERC2981` — https://docs.openzeppelin.com/contracts/5.x/api/token/common#ERC2981
- OpenZeppelin v5 — `ReentrancyGuard` — https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard
- Solidity docs — Sending and receiving Ether (`call` vs `transfer`) — https://docs.soliditylang.org/en/latest/security-considerations.html#sending-and-receiving-ether
- Solidity by Example — Sending Ether & Reentrancy — https://solidity-by-example.org/sending-ether/

## Closing

Neri redeploys the marketplace, and the first resale rolls through: a digital mural of the Pinaglabanan monument changes hands for 2 ETH. In the same block, 0.1 ETH lands in the original artist's wallet — automatic, unstoppable, exactly as promised. "Para sa mga lumikha," she says — for the creators. Hackana stole their income by tampering with logic no one could see; Neri gave it back with logic everyone can verify.
