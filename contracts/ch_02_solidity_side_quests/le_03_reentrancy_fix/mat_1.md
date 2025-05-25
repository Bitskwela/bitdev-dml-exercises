# Side Quest 3: Reentrancy Fix

## Scenario:

In the heart of the Eastwood-Kalayaan Markets — a bustling digital palengke built on blockchain — vendors proudly accept crypto payments via the “Palengke Wallet,” a decentralized wallet system that revolutionized how suki (loyal customers) pay for bangus, kakanin, and sinangag na sinigang kits. Life was finally simpler. The sari-sari stores were thriving. Micro-entrepreneurs no longer waited in line at remittance centers. Everything flowed smoothly…

Until one day — it didn't.

A strange pattern emerged. Wallets were bleeding funds. Vendors reported missing balances after withdrawals. Stall owners in Quezon City's crypto bazaar began calling it the "Ghost Withdrawals" — money vanishing without warning. Panic ensued. And rumors spread fast in Facebook group chats: “Na-hack tayo!”

As Neri investigates, she traces the problem back to a forgotten piece of legacy code — left behind by a minion of Hackana during their attempt to sabotage the country's financial systems. The exploit? A reentrancy vulnerability.

A malicious actor found a loophole in the `withdraw()` function of the Palengke Wallet smart contract. Instead of withdrawing once, they call back into the contract — again and again — draining funds in a single transaction before balances are updated.

## Mission Brief

**Your task is clear. Help Neri to:**

- Patch the Palengke Wallet to prevent reentrancy.

- Use `checks-effects-interactions` and `ReentrancyGuard` to secure the contract.

- Educate other builders on best practices so this never happens again.

You have 20 minutes before the next exploit wave hits.

Your code could be the firewall that protects the future of decentralized finance in the Philippines.

### Mission Details

**Time Allotment**: 20 minutes

**Solidity Topics Covered**: Reentrancy, Best Practices.
