# Chapter 2 Quiz: Solidity Side Quests

```ts
[
  {
    id: 1,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "approve()" },
      { id: "b", text: "transfer()" },
      { id: "c", text: "mint()" },
      { id: "d", text: "burn()" },
    ],
    question:
      "In the ERC20 standard, which function is used to transfer tokens from one address to another?",
  },
  {
    id: 2,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "balanceOf()" },
      { id: "b", text: "transfer()" },
      { id: "c", text: "approve()" },
      { id: "d", text: "transferFrom()" },
    ],
    question:
      "Which ERC20 function allows a token holder to authorize another address to spend tokens on their behalf?",
  },
  {
    id: 3,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "transferFrom() only requires the owner's signature" },
      { id: "b", text: "approve() transfers tokens immediately" },
      { id: "c", text: "allowance() requires multiple confirmations" },
      { id: "d", text: "transferFrom() uses the allowance set by approve()" },
    ],
    question:
      "What is the relationship between the approve() and transferFrom() functions?",
  },
  {
    id: 4,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "ERC721 tokens (NFTs) are non-fungible, meaning each token has a unique identity.",
  },
  {
    id: 5,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "Maximum supply limit" },
      { id: "b", text: "Owner's name" },
      { id: "c", text: "Expiration date" },
      { id: "d", text: "Network type" },
    ],
    question:
      "What is a critical security concern when implementing NFT minting logic?",
  },
  {
    id: 6,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "A reentrancy attack occurs when a malicious contract calls back into a vulnerable function before state changes are finalized.",
  },
  {
    id: 7,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "Using multiple require statements" },
      { id: "b", text: "Following the checks-effects-interactions pattern" },
      { id: "c", text: "Increasing gas limits" },
      { id: "d", text: "Using longer variable names" },
    ],
    question:
      "What is the best practice to prevent reentrancy vulnerabilities?",
  },
  {
    id: 8,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "ReentrancyGuard modifier from OpenZeppelin" },
      { id: "b", text: "Checks-effects-interactions pattern" },
      { id: "c", text: "Both A and B" },
      { id: "d", text: "Using only view functions" },
    ],
    question:
      "Which of the following can be used to protect against reentrancy attacks?",
  },
  {
    id: 9,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "In a multi-signature wallet, any single owner can execute transactions without approval from others.",
  },
  {
    id: 10,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      {
        id: "a",
        text: "The minimum number of signatures required to approve a transaction",
      },
      { id: "b", text: "The maximum number of owners allowed" },
      { id: "c", text: "The time limit for transaction execution" },
      { id: "d", text: "The total funds in the wallet" },
    ],
    question:
      "What does an 'approval threshold' mean in a multi-signature wallet?",
  },
  {
    id: 11,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "Fixed price regardless of demand" },
      {
        id: "b",
        text: "Price that adjusts based on demand, time, or other factors",
      },
      { id: "c", text: "Price set by the government" },
      { id: "d", text: "Price that decreases over time" },
    ],
    question:
      "What is dynamic pricing in the context of ride-hailing applications?",
  },
  {
    id: 12,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "Dynamic pricing helps balance supply and demand by adjusting prices during peak hours.",
  },
  {
    id: 13,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "Validators" },
      { id: "b", text: "Miners" },
      { id: "c", text: "Royalty recipients" },
      { id: "d", text: "Smart contract auditors" },
    ],
    question:
      "In an NFT royalty system, who receives a percentage of the sale price on secondary market transactions?",
  },
  {
    id: 14,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "NFT royalties ensure creators continue to earn income from their work even after the initial sale.",
  },
  {
    id: 15,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "blue" },
      { id: "b", text: "orange" },
      { id: "c", text: "purple" },
      { id: "d", text: "red, yellow, or green" },
    ],
    question:
      "In a decentralized traffic management system, what are valid traffic light states?",
  },
  {
    id: 16,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "String comparison in Solidity requires using keccak256(abi.encodePacked()) for accurate results.",
  },
  {
    id: 17,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "require" },
      { id: "b", text: "assert" },
      { id: "c", text: "revert" },
      { id: "d", text: "validate" },
    ],
    question:
      "Which statement is used to validate that a traffic light state is one of the allowed values?",
  },
  {
    id: 18,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "An ERC721 contract can mint unlimited tokens without any supply constraints.",
  },
  {
    id: 19,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "address" },
      { id: "b", text: "mapping" },
      { id: "c", text: "array" },
      { id: "d", text: "struct" },
    ],
    question:
      "What data structure is commonly used to track approvals in multi-signature wallets?",
  },
  {
    id: 20,
    type: "FIB",
    answer: "reentrancy",
    points: 1,
    question:
      "A security vulnerability where a function is called repeatedly before state is updated is called a ______ attack.",
  },
  {
    id: 21,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "It permanently removes tokens from circulation" },
      { id: "b", text: "It allows a spender to use a specified amount of tokens on behalf of the owner" },
      { id: "c", text: "It checks the balance of an account" },
      { id: "d", text: "It creates new tokens" },
    ],
    question:
      "What is the primary purpose of the allowance mechanism in ERC20 tokens?",
  },
  {
    id: 22,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "In ERC721, the tokenURI() function is used to retrieve metadata associated with a specific NFT.",
  },
  {
    id: 23,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "Disabling external calls" },
      { id: "b", text: "Using only internal functions" },
      { id: "c", text: "Requiring multiple confirmations for every transaction" },
      { id: "d", text: "Updating state variables before making external calls" },
    ],
    question:
      "What does the 'effects' part of the checks-effects-interactions pattern refer to?",
  },
  {
    id: 24,
    type: "TF",
    answer: false,
    points: 1,
    question:
      "A multi-signature wallet requires all owners to approve every single transaction without exception.",
  },
  {
    id: 25,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "The owner must manually adjust prices each hour" },
      { id: "b", text: "Prices are set based on historical data only" },
      { id: "c", text: "An algorithm automatically adjusts prices based on real-time market conditions" },
      { id: "d", text: "Prices remain constant indefinitely" },
    ],
    question:
      "How does dynamic pricing typically function in a decentralized application?",
  },
  {
    id: 26,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "NFT royalties are typically enforced through on-chain mechanisms in modern marketplaces.",
  },
  {
    id: 27,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "Access control and permission management" },
      { id: "b", text: "Automatically preventing all transactions" },
      { id: "c", text: "Storing unlimited amounts of data" },
      { id: "d", text: "Creating new cryptocurrency" },
    ],
    question:
      "What is a primary advantage of using smart contracts in a multi-signature wallet?",
  },
  {
    id: 28,
    type: "FIB",
    answer: "token",
    points: 1,
    question:
      "In ERC20, a ______ is a unit of value that can be transferred between addresses with the approval of the owner.",
  },
  {
    id: 29,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "The contract address" },
      { id: "b", text: "A unique identifier that distinguishes it from all other tokens in the contract" },
      { id: "c", text: "The creation date of the NFT" },
      { id: "d", text: "The Ethereum gas price" },
    ],
    question:
      "What makes a token ID in ERC721 significant?",
  },
  {
    id: 30,
    type: "FIB",
    answer: "approval",
    points: 1,
    question:
      "In a multi-signature wallet, each owner's signature serves as an ______ for a pending transaction.",
  },
];
```
