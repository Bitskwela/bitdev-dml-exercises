# Upgradable Smart Contracts

## Scene: The Adaptive Shield

As Neri and her team near the climax of their battle against Hackana, they realize one critical flaw: static systems can't counter evolving threats. Hackana's malware adapts rapidly, learning to bypass traditional defenses.

To outsmart it, Neri's team devises a strategy—deploying upgradable contracts that can evolve without losing existing data. This marks a revolutionary step in their quest, creating a system that can be updated in real time to counter any challenge.

### Solidity Topic: Upgradable Smart Contracts

**What are they?**

Upgradable smart contracts use proxy patterns to separate logic from storage. This allows developers to upgrade a contract's functionality without redeploying it or losing its state.

**Why Upgradability Matters:**

- Fix bugs or vulnerabilities after deployment.
- Add new features or optimize existing ones.
- Preserve user data and interactions.

**More Info About Upgradable Contracts**

- Proxy Pattern: The proxy contract delegates calls to an implementation contract while retaining storage.
- OpenZeppelin Upgrades: A library simplifying the creation of upgradable contracts.
- Key Steps:
  - Deploy a proxy contract.
  - Link the proxy to an implementation contract.
  - Upgrade by pointing the proxy to a new implementation.
