# Chapter 1 — Quiz Answer Key (with Questions)

Source: `quiz.md`

Each entry lists the exact question text followed by the correct answer (letter/value) and the matching choice text when applicable.

1. Q1 — Which programming language is primarily used to write Ethereum smart contracts?

   - Answer: **A** — `Solidity`

2. Q2 — Which keyword is used to define a smart contract in Solidity?

   - Answer: **B** — `contract`

3. Q3 — Which data type is most commonly used for storing numbers in Solidity?

   - Answer: **C** — `uint256`

4. Q4 — Where are state variables stored in a Solidity contract?

   - Answer: **D** — `storage`

5. Q5 — State variables keep their values even after a function execution ends.

   - Answer: **True**

6. Q6 — Local variables are permanently stored on the blockchain.

   - Answer: **False**

7. Q7 — Which visibility keyword automatically creates a getter function?

   - Answer: **A** — `public`

8. Q8 — The address data type is used to store Ethereum addresses.

   - Answer: **True**

9. Q9 — Which global variable represents the caller of a function?

   - Answer: **C** — `msg.sender`

10. Q10 — The msg.sender variable always refers to the contract owner.

    - Answer: **False**

11. Q11 — Which keyword allows a function to receive Ether?

    - Answer: **B** — `payable`

12. Q12 — Functions marked as view cannot modify state variables.

    - Answer: **True**

13. Q13 — What is the special function that runs during contract deployment?

    - Answer: **A** — `constructor`

14. Q14 — A constructor is executed only once in the lifetime of a contract.

    - Answer: **True**

15. Q15 — Which data structure stores key-value pairs in Solidity?

    - Answer: **D** — `mapping`

16. Q16 — Mappings in Solidity can be iterated directly using a for loop.

    - Answer: **False**

17. Q17 — Which data location is used for state variables?

    - Answer: **B** — `storage`

18. Q18 — The require statement is commonly used for input validation.

    - Answer: **True**

19. Q19 — Which keyword immediately stops execution and reverts state changes?

    - Answer: **C** — `revert`

20. Q20 — If a require condition fails, the remaining gas is refunded.

    - Answer: **True**

21. Q21 — Which Solidity feature is used to log data for off-chain consumption?

    - Answer: **A** — `event`

22. Q22 — Events are cheaper to store than state variables.

    - Answer: **True**

23. Q23 — Which function visibility is optimized for calls from outside the contract?

    - Answer: **D** — `external`

24. Q24 — External functions can be called internally without using this.

    - Answer: **False**

25. Q25 — Which function is triggered when Ether is sent with empty calldata?

    - Answer: **B** — `receive()`

26. Q26 — The receive function must be marked as payable.

    - Answer: **True**

27. Q27 — Which method is currently recommended for sending Ether?

    - Answer: **C** — `call`

28. Q28 — The transfer method forwards all remaining gas by default.

    - Answer: **False**

29. Q29 — A reusable access control logic in Solidity is implemented using a **\_\_**.

    - Answer: **modifier**

30. Q30 — The vulnerability where a function is repeatedly called before state updates is called **\_\_**.
    - Answer: **reentrancy**
