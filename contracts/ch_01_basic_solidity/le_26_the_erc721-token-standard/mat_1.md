# The ERC-721 Token Standard — Minting Unique NFTs

![26.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_26_the_erc721-token-standard/26.0%20-%20COVER.png)

## Scene

Neri's mission against Hackana leads her to an art fair in Metro Manila showcasing digital artworks. Many artists are distraught — their creations have been screenshotted, copied, and resold without consent. There is no way to prove who made what, or who truly owns the original.

Neri realizes she can fix this with the same blockchain tools she has been mastering. She turns to **ERC-721**, the standard for **Non-Fungible Tokens (NFTs)** — unique, indivisible tokens that represent one-of-a-kind items like art, music, collectibles, and land titles. With ERC-721, each artwork gets an immutable, on-chain certificate of authenticity and ownership. She builds `DigitalArtToken`, a contract that lets her mint a unique token for every piece an artist registers.

## Why this matters

A peso is **fungible** — any peso is interchangeable with any other; you only care *how many* you hold. A painting is **non-fungible** — there is exactly one original, and "which one" matters more than "how many." ERC-20 (Lesson 25) handles the peso case. ERC-721 handles the painting case.

For the art fair this is everything: an NFT gives each artwork a globally unique `tokenId`, a provable owner recorded on-chain, and a `tokenURI` pointing to its metadata (title, description, image). Copy the image all you like — you cannot copy the *token*, and the token is what the blockchain treats as the original. That is how Neri gives artists something a screenshot can never take: cryptographic proof of authorship and ownership.

## Don't reinvent it — stand on OpenZeppelin

ERC-721 is a *specification* (EIP-721): a required set of functions (`ownerOf`, `balanceOf`, `transferFrom`, `approve`, `safeTransferFrom`…) plus events that every NFT must implement so that wallets, marketplaces, and other contracts can talk to it. Writing all of that correctly by hand is hard and dangerous — one ownership-tracking bug and tokens get stuck or stolen.

So you **inherit** the audited implementation from OpenZeppelin and add only your minting logic on top. The repo uses **OpenZeppelin v5.3.0** and **solc 0.8.26**, so every import path and pattern below is the modern v5 form.

```solidity
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
```

- **`ERC721`** — the core standard: ownership tracking, transfers, approvals.
- **`ERC721URIStorage`** — an extension that stores a per-token metadata URI (so each artwork can carry its own title/image link). It inherits from `ERC721`, so inheriting the extension gives you the whole standard.
- **`Ownable`** — access control, so only the contract owner can mint.

## The standard's core functions (you inherit these for free)

| Function | What it answers / does |
|---|---|
| `balanceOf(address owner)` | How many tokens does this address own? |
| `ownerOf(uint256 tokenId)` | Who owns this specific token? |
| `transferFrom(from, to, tokenId)` | Move a token (caller must be owner/approved). |
| `safeTransferFrom(from, to, tokenId)` | Same, but reverts if `to` is a contract that can't receive NFTs — prevents tokens getting permanently stuck. |
| `approve(to, tokenId)` | Let one address transfer one specific token on your behalf. |
| `setApprovalForAll(operator, bool)` | Let an operator (e.g., a marketplace) manage *all* your tokens. |
| `tokenURI(uint256 tokenId)` | The metadata link for a token (provided by `ERC721URIStorage`). |

You implement none of these. Your job is the part the standard leaves open: **minting**.

## Minting safely — the modern v5 pattern

This is where most outdated tutorials go wrong. Here is the correct, current `DigitalArtToken` contract — the one this lesson's activity builds:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DigitalArtToken is ERC721URIStorage, Ownable {
    // Plain uint256 auto-incrementing counter (see the warning below)
    uint256 private _tokenIds;

    constructor()
        ERC721("DigitalArtToken", "DAT") // token name + symbol
        Ownable(msg.sender)              // v5: owner MUST be set explicitly
    {}

    function mintArt(
        address recipient,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        _tokenIds++;                       // first token gets id 1
        uint256 newItemId = _tokenIds;

        _safeMint(recipient, newItemId);   // safe: checks recipient can hold NFTs
        _setTokenURI(newItemId, tokenURI); // attach the artwork's metadata

        return newItemId;
    }
}
```

Walk through the load-bearing decisions:

### `Ownable(msg.sender)` is mandatory in v5

In OpenZeppelin **v5**, `Ownable` has **no default constructor** — you *must* pass the initial owner explicitly. `Ownable(msg.sender)` makes whoever deploys the contract the owner. Omitting it (the old v4 style, `Ownable()` with no argument) will not compile against v5.

### `onlyOwner` guards the mint

Without access control, *anyone* could mint tokens and forge "authentic" artworks — destroying the very trust the NFT is supposed to provide. `onlyOwner` (from `Ownable`) restricts `mintArt` to the contract owner, so only the authorized minter can issue tokens. For a multi-minter setup you would graduate to `AccessControl` roles, but `onlyOwner` is the right starting point.

### A plain `uint256` counter — NOT `Counters`

```solidity
uint256 private _tokenIds;   //  modern: a simple counter, incremented before each mint
```

> **Critical currency note:** older guides use OpenZeppelin's `Counters` library (`using Counters for Counters.Counter; Counters.Counter private _tokenIds; _tokenIds.increment();`). **`Counters` was removed in OpenZeppelin v5** — that code will not compile. The library only ever wrapped a `uint256`, and since Solidity 0.8 has built-in overflow protection, it added nothing. Use a plain `uint256` and `++` it directly, exactly as above. (Pre-incrementing means the first token is id `1`, which avoids confusion with the "no token" zero value.)

### `_safeMint` over `_mint`

`_mint(to, id)` creates the token but does **no check** on the recipient. If `to` is a contract that wasn't built to handle NFTs, the token is minted into a black hole — permanently frozen. `_safeMint(to, id)` calls `onERC721Received` on contract recipients and **reverts** if they can't acknowledge it, preventing stuck tokens. Prefer `_safeMint` for minting to arbitrary recipients.

> **Reentrancy footnote:** because `_safeMint` makes an external call to the recipient, follow Checks-Effects-Interactions — update your own state (like `_tokenIds`) *before* the `_safeMint` call, as the contract above does. For mints guarded by `onlyOwner` the risk is low, but the habit matters once recipients are untrusted.

### `_setTokenURI` attaches the metadata

`ERC721URIStorage` gives you `_setTokenURI(tokenId, uri)`, which links the token to its metadata (typically a JSON file on IPFS describing the artwork and pointing to its image). Now `tokenURI(newItemId)` returns that link, and any marketplace can display the art correctly.

### A note on the v5 transfer hook

If you ever need to run logic on *every* mint, transfer, or burn (e.g., enforcing a max supply, or pausing transfers), OpenZeppelin **v5 uses a single `_update` hook** — you override `_update(address to, uint256 tokenId, address auth)`. The old `_beforeTokenTransfer` / `_afterTokenTransfer` hooks were **removed in v5**. You don't need this for `DigitalArtToken`, but reach for `_update` (not the removed hooks) when you do.

## Security & best-practice notes

- **Always gate minting.** An unguarded `mint` is the most common NFT exploit. `onlyOwner` (or an `AccessControl` role) is not optional.
- **Prefer `_safeMint`** when minting to addresses you don't control, to avoid tokens locked in non-receiver contracts.
- **No `Counters`, no `SafeMath`.** Both are obsolete in this stack. A plain `uint256` with `++` is correct and cheaper; 0.8's checked arithmetic handles overflow.
- **Validate inputs where it matters.** Decide whether minting to `address(0)` should revert (OpenZeppelin's `_mint`/`_safeMint` already revert on the zero address — lean on that rather than re-checking).
- **Pin your metadata.** A `tokenURI` pointing at a centralized, mutable URL undermines the immutability story. Use content-addressed storage (IPFS/Arweave) so the metadata can't be swapped out from under the owner.

## Common mistakes to avoid

1. **`Ownable()` with no argument.** v5 requires `Ownable(msg.sender)` (or another initial-owner address) in the constructor. The no-arg form is a v4 relic.
2. **Reaching for `Counters`.** Removed in v5 — won't compile. Use a plain `uint256`.
3. **Overriding `_beforeTokenTransfer`.** Removed in v5 — override `_update` instead.
4. **Forgetting `onlyOwner` on `mintArt`.** Leaves minting open to the public and forges away your authenticity guarantee.
5. **Using `_mint` for arbitrary recipients.** Risks minting into a contract that can't hold NFTs. Use `_safeMint`.
6. **Confusing ERC-721 with ERC-20.** Don't add `decimals` or a fungible `transfer(amount)` — NFTs move by unique `tokenId`, not by quantity.

## What's next

You now have unique, owned, metadata-rich tokens. Adjacent lessons round out the picture: **ERC-20 (Lesson 25)** for fungible tokens, **events** so marketplaces can index your mints, and **`AccessControl`** when one owner isn't enough and you need granular minting roles. Looking further, the **ERC-1155** multi-token standard combines fungible and non-fungible in one contract — a natural next step once ERC-721 feels comfortable.

## References

- EIP-721 (the standard itself): https://eips.ethereum.org/EIPS/eip-721
- OpenZeppelin docs — ERC-721: https://docs.openzeppelin.com/contracts/5.x/erc721
- OpenZeppelin docs — ERC721URIStorage: https://docs.openzeppelin.com/contracts/5.x/api/token/erc721#ERC721URIStorage
- OpenZeppelin docs — Ownable (v5): https://docs.openzeppelin.com/contracts/5.x/api/access#Ownable
- OpenZeppelin Contracts Wizard (generate a starter NFT): https://wizard.openzeppelin.com/

## Closing

With `DigitalArtToken` deployed, Neri runs a workshop at the art fair. One by one, artists mint their pieces — each `mintArt` call stamping a unique `tokenId` and a metadata link onto the chain, signed by the owner's key. An artist refreshes her wallet and sees her first NFT appear, with her name on it forever. "Hindi na nila maaagaw ang gawa ko," she whispers. (They can't steal my work anymore.)

Artists begin minting, selling globally, and earning on resales. The buzz spreads — and Hackana realizes that disrupting a decentralized system, where every original is provably owned, will not be easy. Neri prepares for the next phase: empowering citizens to adopt blockchain in daily life while fortifying defenses against Hackana's schemes.
