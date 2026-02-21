# Quiz — Answer Key (with Questions)

Source: `quiz.md`

Below are each question (exact text) followed by the correct answer — use the question text to match items when your system randomizes order.

1. Q1 — What is the primary purpose of liquidity locking in a DEX contract?

   - Answer: **C** — Prevents liquidity providers from withdrawing tokens before a specified lock period expires

2. Q2 — In a time-lock mechanism, the block.timestamp global variable is typically used to enforce withdrawal restrictions based on time.

   - Answer: **True**

3. Q3 — What does a 'rug-pull' exploit refer to in DeFi?

   - Answer: **B** — A scenario where someone instantly withdraws all liquidity and crashes the token price

4. Q4 — Which statement can be used to enforce a time-lock withdrawal restriction?

   - Answer: **D** — All of the above can enforce time-lock restrictions

5. Q5 — What is the core mechanism of a staking contract?

   - Answer: **A** — Users deposit tokens and receive a proportional reward after a staking duration

6. Q6 — In a staking contract, yield rewards are typically calculated based on the duration of time a user's tokens remain staked.

   - Answer: **True**

7. Q7 — What is a critical requirement when implementing a staking contract?

   - Answer: **C** — The staking contract must track user stakes using a mapping and enforce withdrawal eligibility based on time

8. Q8 — What is a decentralized lending protocol?

   - Answer: **B** — A peer-to-peer financial agreement recorded on-chain where lenders and borrowers transact directly without intermediaries

9. Q9 — In a lending protocol, borrowers can withdraw funds immediately without collateral verification.

   - Answer: **False**

10. Q10 — Which is the correct way to identify the current function caller to implement proper access control?

    - Answer: **A** — `msg.sender`, which identifies the caller's account address

11. Q11 — The onlyOwner pattern using modifiers is a standard way to restrict function access to the contract owner.

    - Answer: **True**

12. Q12 — What is true regarding tx.origin vs msg.sender?

    - Answer: **D** — All of the above are correct

13. Q13 — What is the ERC20 standard?

    - Answer: **B** — A widely-adopted token standard that defines a set of functions (mint, burn, transfer, etc.) for fungible tokens

14. Q14 — In an ERC20 token contract, the owner should be able to enforce a maximum supply limit to prevent inflation.

    - Answer: **True**

15. Q15 — How should a minting function enforce a maximum supply cap in an ERC20 token contract?
    - Answer: **C** — `require(totalSupply + amount <= maxSupply, 'Exceeds max supply')`
