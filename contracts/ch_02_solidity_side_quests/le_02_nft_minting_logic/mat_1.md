# Side Quest 2: NFT Minting Logic

![NFT Minting Logic](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+2.0+-+COVER.png)

## Scene

After Neri's legendary victory over Hackana—the malicious AI malware that crippled the Philippine economy—San Juan has become the epicenter of digital innovation. From her coding bunker deep in Pinaglabanan, Neri now leads the national defense force against rogue code remnants of Hackana still lurking in outdated contracts.

One morning, a breach alert flashes on the national blockchain monitor. Hackana's old minions exploited a minting vulnerability in a popular NFT contract, bypassing the supply limit and flooding the system with duplicate NFTs. If this flaw spreads, it could erode the public's trust in Web3 assets.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+2.1.png)

Now, Neri must patch the flawed NFT minting logic—ensuring only authorized entities can mint, and never more than the fixed maximum supply. The future of the San Juan Digital Renaissance depends on it.

**Time Allotment**: 20 minutes

## Why this matters

An NFT (Non-Fungible Token) is only valuable because it's **scarce and provably authentic**. A concert ticket, a land title, a digital artwork — their worth collapses the instant anyone can mint unlimited copies. The breach Neri is chasing is exactly that: a minting function with no supply cap and no access control, so Hackana's minions printed duplicates at will.

Two guarantees keep an NFT collection trustworthy:

1. **Access control** — only an authorized address can mint (otherwise anyone mints freely).
2. **Supply cap** — the contract refuses to exceed a fixed maximum (otherwise "limited edition" means nothing).

This lesson builds both, the modern OpenZeppelin v5 way.

## Fungible vs non-fungible

| | ERC20 (last lesson) | ERC721 (this lesson) |
|---|---|---|
| Unit | interchangeable — every SJT equals every other SJT | unique — each token has its own `tokenId` |
| Tracks | `balanceOf[owner] = amount` | `ownerOf[tokenId] = owner` |
| Analogy | pesos in a wallet | titled property, each with its own deed number |
| Typical use | payments, staking, governance | art, tickets, memberships, certificates |

Because each NFT is unique, minting isn't "increase a number" — it's "create a brand-new token with its own id and assign it an owner."

## 1. Stand on OpenZeppelin's shoulders

You never hand-write the ERC721 standard. OpenZeppelin v5 ships an audited implementation; you inherit it and add only your rules. We use `ERC721URIStorage` (the ERC721 base plus per-token metadata URIs) and `Ownable` (one-line access control).

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureNFT is ERC721URIStorage, Ownable {
    constructor() ERC721("SanJuanNFT", "SJN") Ownable(msg.sender) {}
}
```

Two v5-specific things to notice:

- **`Ownable(msg.sender)`** — in OpenZeppelin **v5**, `Ownable`'s constructor *requires* you to pass the initial owner explicitly. (In the old v4 it defaulted to `msg.sender` silently; v5 made it explicit to prevent ownerless deploys.)
- We call the parent **`ERC721("SanJuanNFT", "SJN")`** constructor to set the collection's name and symbol.

## 2. Access control with `onlyOwner`

`Ownable` gives you a stored `owner` and a ready-made `onlyOwner` modifier. Slap it on `mintNFT` and the function reverts for anyone who isn't the owner — no hand-written `require(msg.sender == owner)` needed, and no chance of a typo in that check.

```solidity
function mintNFT(address recipient, string memory tokenURI) public onlyOwner {
    // ...only the owner reaches this line
}
```

> **Never authorize with `tx.origin`.** Use `msg.sender` (which `Ownable` does internally). `tx.origin` is the original externally-owned account at the start of the whole transaction, so a malicious contract a victim interacts with could relay a call and pass a `tx.origin == owner` check. `msg.sender` is the *immediate* caller and is the only safe basis for authorization.

## 3. The supply cap

Track how many you've minted (`totalSupply`) against a fixed ceiling (`maxSupply`), and reject the mint the moment it would push past the cap.

```solidity
uint256 public totalSupply;
uint256 public maxSupply = 100;

function mintNFT(address recipient, string memory tokenURI) public onlyOwner {
    require(totalSupply < maxSupply, "Max NFT supply reached");

    totalSupply++;                       // becomes the new tokenId: 1, 2, 3, ...
    _safeMint(recipient, totalSupply);
    _setTokenURI(totalSupply, tokenURI);
}
```

How the id works: we increment **first**, then mint, so the very first token gets id `1`, the second `2`, and so on. The id doubles as the running count. There's no need for OpenZeppelin's old `Counters` library — it was **removed in v5**, and a plain `uint256` you increment yourself is the idiomatic replacement.

## 4. `_mint` vs `_safeMint`

OpenZeppelin gives you two internal mint functions, and choosing correctly is a real security decision:

- **`_mint(to, id)`** — assigns ownership with no extra checks.
- **`_safeMint(to, id)`** — does everything `_mint` does, *plus* if `to` is a contract it calls `onERC721Received` to confirm that contract actually knows how to handle NFTs.

Why `_safeMint` matters: if you `_mint` an NFT to a contract that has no idea what ERC721 is, the token is **permanently stuck** there — no function exists to move it out. `_safeMint` reverts instead of trapping the asset. Prefer `_safeMint` for any externally-facing mint.

> **One caveat — reentrancy.** `_safeMint`'s callback hands control to the recipient contract *before* `_safeMint` returns. If you do important state changes (like a paid-mint counter or per-wallet limit) *after* `_safeMint`, a malicious receiver could re-enter and mint again. Defense: follow **Checks-Effects-Interactions** — update all your bookkeeping *before* calling `_safeMint`. In the code above, `totalSupply++` happens before the mint, which is exactly right. (You'll go deep on reentrancy in the very next side quest.)

## Putting it together

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureNFT is ERC721URIStorage, Ownable {
    uint256 public totalSupply;
    uint256 public maxSupply = 100;

    constructor() ERC721("SanJuanNFT", "SJN") Ownable(msg.sender) {}

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner {
        require(totalSupply < maxSupply, "Max NFT supply reached");

        totalSupply++;
        _safeMint(recipient, totalSupply);
        _setTokenURI(totalSupply, tokenURI);
    }
}
```

Trace the minions against it: mint as a non-owner → `onlyOwner` reverts. Mint the 101st token → the supply `require` reverts. Mint to a clueless contract → `_safeMint` reverts instead of bricking the token. Every duplicate-flood path dead-ends at a guard.

## Common mistakes to avoid

1. **No access control on mint.** A public `mintNFT()` with no `onlyOwner` lets *anyone* mint — exactly the bug Hackana exploited.
2. **Checking the cap with `<=` instead of `<`.** `require(totalSupply < maxSupply)` allows ids `1..100` for a cap of 100. Using `<=` would let one extra slip through. Reason about your boundary carefully.
3. **Using `_mint` to a contract address.** Risk of permanently locking the NFT; prefer `_safeMint`.
4. **Reusing or hard-coding token ids.** Minting two tokens with the same id reverts (ERC721 forbids duplicates) — always derive a fresh id.
5. **Reaching for `Counters`.** It's gone in OZ v5. Use a plain `uint256`.
6. **Doing paid-mint accounting *after* `_safeMint`.** Opens a reentrancy hole — apply Checks-Effects-Interactions and update state first.

## What's next

You've seen `_safeMint` hand control to an external contract mid-execution — and hinted that this is dangerous. The next side quest, **Reentrancy Fix**, makes that danger concrete: you'll watch an attacker re-enter a withdraw function to drain a wallet, then shut the door with Checks-Effects-Interactions and `ReentrancyGuard`.

## References

- EIP-721: Non-Fungible Token Standard — https://eips.ethereum.org/EIPS/eip-721
- OpenZeppelin v5 — ERC721 — https://docs.openzeppelin.com/contracts/5.x/api/token/erc721
- OpenZeppelin v5 — Ownable / Access Control — https://docs.openzeppelin.com/contracts/5.x/api/access#Ownable
- OpenZeppelin v5 — ERC721 guide — https://docs.openzeppelin.com/contracts/5.x/erc721

## Closing

Neri redeploys `SecureNFT` and feeds it the attack log. Every illegitimate mint bounces: unauthorized callers blocked, the 101st mint refused, the supply counter holding firm at its ceiling. "Hindi mabibili ang tiwala, kundi pinoprotektahan ng code." (Trust can't be bought — it's protected by code.) The San Juan Digital Renaissance keeps its scarcity, and with it, its value.
