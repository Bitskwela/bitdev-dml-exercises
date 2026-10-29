# Chapter 4 — Quiz Answer Key (with Questions)

Source: `quiz.md`

1. Q1 — Which browser extension wallet do the Chapter 4 DApps connect to through window.ethereum?

   - Answer: **B** — MetaMask

2. Q2 — What does a Web3 provider like MetaMask inject into the browser window for DApp communication?

   - Answer: **C** — JSON-RPC API Provider

3. Q3 — What is the standard object used to access wallet functionality in a browser-based DApp?

   - Answer: **A** — window.ethereum

4. Q4 — Smart contracts on the blockchain are immutable once deployed.

   - Answer: **True**

5. Q5 — Which JavaScript library do the Chapter 4 lessons use to connect a React frontend to smart contracts?

   - Answer: **B** — ethers.js (v6)

6. Q6 — What is the purpose of using 'view' or 'pure' functions in a smart contract?

   - Answer: **D** — To call read-only functions without spending gas

7. Q7 — Calling a state-changing function in a smart contract does not require gas fees.

   - Answer: **False**

8. Q8 — What is 'gas' in the context of blockchain transactions?

   - Answer: **A** — Units of computation cost on a blockchain network

9. Q9 — What does ABI stand for in the context of smart contract interaction?

   - Answer: **C** — Application Binary Interface

10. Q10 — What is a contract address?

    - Answer: **B** — The unique identifier of a deployed contract on the blockchain

11. Q11 — Smart contract events can be indexed to create efficient logging and monitoring systems.

    - Answer: **True**

12. Q12 — What is an event in Solidity?

    - Answer: **C** — A log entry emitted by a smart contract

13. Q13 — In ethers v6, which class do you create (with an address, an ABI and a provider or signer) to call a deployed smart contract's functions?

    - Answer: **A** — ethers.Contract

14. Q14 — Reading data from a smart contract requires the user to have a connected wallet.

    - Answer: **False**

15. Q15 — How does 'Sign in with Wallet' authentication work?

    - Answer: **C** — Users sign a message without the DApp gaining access to their wallet

16. Q16 — Which token standard is used for non-fungible tokens (NFTs)?

    - Answer: **B** — ERC721

17. Q17 — Event listeners in a frontend application can monitor blockchain events in real-time.

    - Answer: **True**

18. Q18 — What is a fungible token?

    - Answer: **A** — A token whose units are identical and interchangeable, like one peso coin and any other peso coin

19. Q19 — Which method requests a user's wallet address from MetaMask?

    - Answer: **D** — eth_requestAccounts

20. Q20 — When does a user's wallet approval become necessary in a DApp?

    - Answer: **C** — When making state-changing transactions

21. Q21 — Multi-signature wallets require multiple private keys to authorize a transaction.

    - Answer: **True**

22. Q22 — In a Sign-In with Wallet flow, why does the message the user signs include a nonce (a value used only once)?

    - Answer: **A** — So a captured signature cannot be replayed to sign in again later

23. Q23 — What does DeFi stand for?

    - Answer: **B** — Decentralized Finance

24. Q24 — Cross-chain bridges are unnecessary for DApps that operate on multiple blockchains.

    - Answer: **False**

25. Q25 — What is a DAO (Decentralized Autonomous Organization) voting system?

    - Answer: **C** — A system where token holders vote on governance decisions

26. Q26 — What is the purpose of an oracle in blockchain applications?

    - Answer: **A** — To bring off-chain data, such as prices or weather readings, on-chain for smart contracts

27. Q27 — Different blockchain networks can have different gas prices and transaction speeds.

    - Answer: **True**

28. Q28 — What is an escrow contract?

    - Answer: **B** — A contract that holds funds and only releases them under specific conditions

29. Q29 — How do you programmatically detect which blockchain network a user is connected to?

    - Answer: **D** — ethereum.request({ method: 'eth_chainId' })

30. Q30 — Private keys should always be stored in frontend code or browser local storage.

    - Answer: **False**

31. Q31 — The cost a user pays to have a transaction executed on a blockchain is called a **__**.

    - Answer: **gas fee**

32. Q32 — A self-executing program stored on the blockchain with terms written in code is called a **__**.

    - Answer: **smart contract**

33. Q33 — A digital asset representing value or ownership created on a blockchain is called a **__**.

    - Answer: **token**

34. Q34 — Every blockchain transaction is uniquely identified by a **__** that can be used to track its status.

    - Answer: **transaction hash**

35. Q35 — A **__** is a software or hardware tool that stores private keys and allows users to manage their cryptocurrency.

    - Answer: **wallet**

36. Q36 — An application that runs on a blockchain network and interacts with smart contracts is called a **__**.

    - Answer: **dapp**

37. Q37 — In DeFi, a **__** is a smart contract holding paired tokens that users can trade against automatically.

    - Answer: **liquidity pool**

38. Q38 — A browser cannot load an ipfs:// link directly, so an NFT gallery rewrites it to an HTTP URL such as https://ipfs.io/ipfs/... served by an IPFS **__**.

    - Answer: **gateway**

39. Q39 — ERC-20 amounts are stored on-chain as whole integers. The token's **__** value (often 18) tells your UI where to put the decimal point when it formats a balance.

    - Answer: **decimals**

40. Q40 — When a user approves a smart contract to spend tokens on their behalf, they are setting an **__**.

    - Answer: **allowance**
