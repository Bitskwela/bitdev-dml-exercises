# Mini Project #5: SariSari Token — Tokenizing the Barangay Store Economy

![Sari-sari store](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+5.0+-+COVER+.png)

## Scene

Sari-sari stores are pillars of Filipino barangay life. Aling Nena runs one in North Cotabato, but she struggles to get fair financing.

Inspired by web3, she asks for help to tokenize her store's goods. Each **SST (SariSariToken)** represents ₱1 worth of inventory.

![Aling Nena's Sari-sari Store](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+5.1.png)

Investors can buy _SST_, and she can issue more when she restocks — but supply must stay limited to prevent inflation.

You must help build the token logic that supports this local micro-economy securely.

## Why this matters

This is the capstone: you'll mint a **real ERC-20 token** — the same standard behind USDC, DAI, and thousands of others — backed by something concrete (Aling Nena's inventory). The defining challenge of an asset-backed token is **trust through scarcity**. If Aling Nena (or whoever holds the keys) could mint unlimited SST, every existing token would be diluted to worthlessness — exactly the inflation that wrecks real currencies. The whole point of putting this on-chain is that the **supply cap is enforced by code that no one — not even the owner — can override.** Get the cap and the access control right, and you've built an economic instrument people can actually trust. Get them wrong, and you've built a rug-pull.

## 1. Inheriting from OpenZeppelin `ERC20`

You never write an ERC-20 from scratch — you inherit OpenZeppelin's audited implementation. It gives you `transfer`, `approve`, `transferFrom`, `balanceOf`, `totalSupply`, and the internal `_mint`/`_burn` for free.

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SariSariToken is ERC20 {
    constructor() ERC20("SariSari Token", "SST") {
        _mint(msg.sender, 10_000 * 1e18); // ₱10,000 of initial inventory
    }
}
```

**Key gotcha — the 18-decimals convention.** ERC-20 tokens are divisible; OpenZeppelin's default is **18 decimals**, so "10,000 tokens" is written `10_000 * 1e18` (or `10_000 * 10 ** decimals()`). Mint a bare `10000` and you've actually created 0.00000000000001 SST. Always scale by the decimals.

## 2. Enforcing the supply cap

The cap is what makes SST non-inflationary. There are two correct ways to enforce it.

**Option A — `ERC20Capped` (preferred).** OpenZeppelin ships an extension that enforces the cap *inside* `_mint` itself. You literally cannot mint past the cap, anywhere in the contract, because the override lives in the token's own minting path. Less code to get wrong:

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SariSariToken is ERC20Capped, Ownable {
    constructor()
        ERC20("SariSari Token", "SST")
        ERC20Capped(50_000 * 1e18)   // hard cap baked in
        Ownable(msg.sender)
    {
        _mint(msg.sender, 10_000 * 1e18); // counts against the cap
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount); // reverts automatically if it would exceed the cap
    }
}
```

**Option B — manual `MAX_SUPPLY` check.** Equally valid and good to understand, since you'll see it everywhere. You guard `_mint` yourself:

```solidity
uint256 public constant MAX_SUPPLY = 50_000 * 1e18;

function mint(address to, uint256 amount) external onlyOwner {
    require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds cap");
    _mint(to, amount);
}
```

The catch with Option B: the check only protects *this* `mint` function. If the contract grows another minting path and you forget to add the same guard, the cap is bypassable. `ERC20Capped` enforces it centrally — that's why it's preferred. Note `1e18` and `10 ** decimals()` are interchangeable here because the default `decimals()` is 18.

| Approach | Where the cap lives | Risk |
|---|---|---|
| `ERC20Capped` | inside `_mint` (central) | minimal — every mint path is covered |
| Manual `require` in `mint` | only in the function you wrote | you must remember it on every new mint path |

## 3. Gating `mint` with `Ownable`

A supply cap is meaningless if anyone can mint up to it. Minting must be owner-only — and we use the `Ownable` you learned in the previous project, with the v5 constructor signature.

```solidity
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// ...
constructor() ERC20("SariSari Token", "SST") Ownable(msg.sender) { ... }

function mint(address to, uint256 amount) external onlyOwner {  // <- gated
    _mint(to, amount);
}
```

**Key gotcha — v5 `Ownable(msg.sender)`.** Just like the Aid Vault, OpenZeppelin v5 requires the initial owner as a constructor argument. Use `msg.sender`, never `tx.origin` (which would be phishable). When you have multiple base constructors — `ERC20(...)`, `ERC20Capped(...)`, `Ownable(...)` — list them all in the derived constructor's header.

## 4. Burning (optional, for honest accounting)

If Aling Nena sells inventory and wants to retire the matching tokens, she can `burn`. OpenZeppelin's `ERC20Burnable` extension adds `burn`/`burnFrom`. Burning *reduces* `totalSupply`, which under `ERC20Capped` frees headroom under the cap again — useful for a token that tracks real, changing inventory.

```solidity
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// contract SariSariToken is ERC20Capped, ERC20Burnable, Ownable { ... }
```

## Full reference contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SariSariToken is ERC20Capped, Ownable {
    constructor()
        ERC20("SariSari Token", "SST")
        ERC20Capped(50_000 * 1e18) // hard cap: 50,000 SST
        Ownable(msg.sender)
    {
        _mint(msg.sender, 10_000 * 1e18); // initial ₱10,000 of inventory
    }

    /// @notice Owner mints new SST when inventory is restocked.
    /// Reverts automatically (via ERC20Capped) if it would exceed the cap.
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
```

If your course environment pins an older OpenZeppelin, the manual-cap version (Option B above) compiles the same `mint` behavior without `ERC20Capped` — either is acceptable for the activity.

## Security & gas notes

- **Hard cap is the trust anchor.** A cappable supply is the difference between a credible asset-backed token and a rug-pull. Prefer `ERC20Capped` so the cap can't be bypassed by a future mint path.
- **`onlyOwner` on `mint`.** An ungated `mint` lets anyone inflate the supply to the cap and dump it.
- **`msg.sender` ownership, not `tx.origin`.** Same phishing reasoning as Project #4.
- **Respect decimals.** Always scale amounts by `1e18` (18 decimals) so on-chain numbers mean what you think.
- **Use audited code.** Inheriting OpenZeppelin's `ERC20`/`ERC20Capped` avoids re-implementing (and mis-implementing) allowance and balance accounting — the source of countless token bugs.
- **`_mint` is `internal` by design.** Exposing it only through an `onlyOwner` wrapper keeps minting controlled; never make a public mint without access control.

## Common mistakes to avoid

1. **Ungated `mint`.** Without `onlyOwner`, anyone can mint to the cap. Always restrict it.
2. **No supply cap at all.** Unlimited minting dilutes every holder — the inflation the project exists to prevent.
3. **Forgetting decimals.** `_mint(owner, 10000)` mints a dust amount; use `10_000 * 1e18`.
4. **`Ownable()` with no argument on v5.** Must be `Ownable(msg.sender)`, listed alongside the `ERC20`/`ERC20Capped` base constructors.
5. **A manual cap check on one path but not another.** If you add a second minting path, the manual `require` won't protect it. `ERC20Capped` enforces centrally.

## What's next

You've completed Chapter 3's mini-projects — time-locked vaults, ERC-20 staking, peer-to-peer lending, a security-hardened vault, and now a capped asset-backed token. Next up is **Chapter 4: dApps**, where you'll connect these contracts to a real frontend so users can interact with them through a wallet — turning the contracts you've mastered into products people can actually use.

## References

- OpenZeppelin v5 — ERC20: https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20
- OpenZeppelin v5 — ERC20Capped: https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Capped
- OpenZeppelin v5 — ERC20Burnable: https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20Burnable
- OpenZeppelin Contracts Wizard (generate a token interactively): https://wizard.openzeppelin.com/
- EIP-20 — the ERC-20 standard: https://eips.ethereum.org/EIPS/eip-20

## Closing

Neri deploys SariSariToken with Aling Nena watching over her shoulder. Ten thousand SST land in her wallet — ₱10,000 of inventory, now on-chain. An investor buys in; the supply is provably capped at 50,000, so their stake can't be diluted by a midnight mint. When Aling Nena restocks, she mints more — but the contract refuses the moment she'd cross the cap. "Tokenized ang tindahan, pero hindi nababawasan ang tiwala." (The store is tokenized, but the trust isn't diluted.) From a sari-sari store in North Cotabato to a top-1% Solidity skillset — you've built an economy.
