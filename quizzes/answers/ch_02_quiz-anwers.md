# Chapter 2 — Quiz Answer Key (with Questions)

Source: `quiz.md`

Each entry includes the exact question text followed by the correct answer (letter or value) and the matching choice text where applicable.

1. Q1 — In the ERC20 standard, which function is used to transfer tokens from one address to another?

   - Answer: **B** — `transfer()`

2. Q2 — Which ERC20 function allows a token holder to authorize another address to spend tokens on their behalf?

   - Answer: **C** — `approve()`

3. Q3 — What is the relationship between the approve() and transferFrom() functions?

   - Answer: **D** — `transferFrom()` uses the allowance set by `approve()`

4. Q4 — ERC721 tokens (NFTs) are non-fungible, meaning each token has a unique identity.

   - Answer: **True**

5. Q5 — What is a critical security concern when implementing NFT minting logic?

   - Answer: **A** — Maximum supply limit

6. Q6 — A reentrancy attack occurs when a malicious contract calls back into a vulnerable function before state changes are finalized.

   - Answer: **True**

7. Q7 — What is the best practice to prevent reentrancy vulnerabilities?

   - Answer: **B** — Following the checks-effects-interactions pattern

8. Q8 — Which of the following can be used to protect against reentrancy attacks?

   - Answer: **C** — Both A and B (ReentrancyGuard modifier from OpenZeppelin and checks-effects-interactions)

9. Q9 — In a multi-signature wallet, any single owner can execute transactions without approval from others.

   - Answer: **False**

10. Q10 — What does an 'approval threshold' mean in a multi-signature wallet?

    - Answer: **A** — The minimum number of signatures required to approve a transaction

11. Q11 — What is dynamic pricing in the context of ride-hailing applications?

    - Answer: **B** — Price that adjusts based on demand, time, or other factors

12. Q12 — Dynamic pricing helps balance supply and demand by adjusting prices during peak hours.

    - Answer: **True**

13. Q13 — In an NFT royalty system, who receives a percentage of the sale price on secondary market transactions?

    - Answer: **C** — Royalty recipients

14. Q14 — NFT royalties ensure creators continue to earn income from their work even after the initial sale.

    - Answer: **True**

15. Q15 — In a decentralized traffic management system, what are valid traffic light states?

    - Answer: **D** — red, yellow, or green

16. Q16 — String comparison in Solidity requires using keccak256(abi.encodePacked()) for accurate results.

    - Answer: **True**

17. Q17 — Which statement is used to validate that a traffic light state is one of the allowed values?

    - Answer: **A** — `require`

18. Q18 — An ERC721 contract can mint unlimited tokens without any supply constraints.

    - Answer: **False**

19. Q19 — What data structure is commonly used to track approvals in multi-signature wallets?

    - Answer: **B** — `mapping`

20. Q20 — A security vulnerability where a function is called repeatedly before state is updated is called a **\_\_** attack.

    - Answer: **reentrancy**

21. Q21 — What is the primary purpose of the allowance mechanism in ERC20 tokens?

    - Answer: **B** — It allows a spender to use a specified amount of tokens on behalf of the owner

22. Q22 — In ERC721, the tokenURI() function is used to retrieve metadata associated with a specific NFT.

    - Answer: **True**

23. Q23 — What does the 'effects' part of the checks-effects-interactions pattern refer to?

    - Answer: **D** — Updating state variables before making external calls

24. Q24 — A multi-signature wallet requires all owners to approve every single transaction without exception.

    - Answer: **False**

25. Q25 — How does dynamic pricing typically function in a decentralized application?

    - Answer: **C** — An algorithm automatically adjusts prices based on real-time market conditions

26. Q26 — NFT royalties are typically enforced through on-chain mechanisms in modern marketplaces.

    - Answer: **True**

27. Q27 — What is a primary advantage of using smart contracts in a multi-signature wallet?

    - Answer: **A** — Access control and permission management

28. Q28 — In ERC20, a **\_\_** is a unit of value that can be transferred between addresses with the approval of the owner.

    - Answer: **token**

29. Q29 — What makes a token ID in ERC721 significant?

    - Answer: **B** — A unique identifier that distinguishes it from all other tokens in the contract

30. Q30 — In a multi-signature wallet, each owner's signature serves as an **\_\_** for a pending transaction.
    - Answer: **approval**
