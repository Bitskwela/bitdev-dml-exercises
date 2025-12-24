# Advance Solidity Quiz

```json
[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Allows users to withdraw tokens anytime without restrictions"
      },
      { "id": "b", "text": "Charges a fee every time liquidity is accessed" },
      {
        "id": "c",
        "text": "Prevents liquidity providers from withdrawing tokens before a specified lock period expires"
      },
      {
        "id": "d",
        "text": "Only allows withdrawals on specific days of the week"
      }
    ],
    "question": "What is the primary purpose of liquidity locking in a DEX contract?"
  },
  {
    "id": 2,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In a time-lock mechanism, the block.timestamp global variable is typically used to enforce withdrawal restrictions based on time."
  },
  {
    "id": 3,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A tax imposed on liquidity providers" },
      {
        "id": "b",
        "text": "A scenario where someone instantly withdraws all liquidity and crashes the token price"
      },
      { "id": "c", "text": "A scheduled maintenance window" },
      { "id": "d", "text": "A feature that rewards early investors" }
    ],
    "question": "What does a 'rug-pull' exploit refer to in DeFi?"
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "require(block.timestamp > lockTime, 'Locked')" },
      { "id": "b", "text": "assert(block.timestamp > lockTime)" },
      { "id": "c", "text": "if (block.timestamp < lockTime) revert()" },
      {
        "id": "d",
        "text": "All of the above can enforce time-lock restrictions"
      }
    ],
    "question": "Which statement can be used to enforce a time-lock withdrawal restriction?"
  },
  {
    "id": 5,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Users deposit tokens and receive a proportional reward after a staking duration"
      },
      {
        "id": "b",
        "text": "Users can instantly sell their tokens at a premium price"
      },
      { "id": "c", "text": "Users can borrow tokens without collateral" },
      { "id": "d", "text": "Users can lock their voting rights" }
    ],
    "question": "What is the core mechanism of a staking contract?"
  },
  {
    "id": 6,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In a staking contract, yield rewards are typically calculated based on the duration of time a user's tokens remain staked."
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Only the contract owner can stake tokens" },
      { "id": "b", "text": "Rewards are fixed regardless of staking duration" },
      {
        "id": "c",
        "text": "The staking contract must track user stakes using a mapping and enforce withdrawal eligibility based on time"
      },
      {
        "id": "d",
        "text": "Users can unstake before the lock period without restrictions"
      }
    ],
    "question": "What is a critical requirement when implementing a staking contract?"
  },
  {
    "id": 8,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A loan issued only by banks" },
      {
        "id": "b",
        "text": "A peer-to-peer financial agreement recorded on-chain where lenders and borrowers transact directly without intermediaries"
      },
      {
        "id": "c",
        "text": "A traditional microfinance scheme with fixed interest rates"
      },
      { "id": "d", "text": "A government-backed loan program" }
    ],
    "question": "What is a decentralized lending protocol?"
  },
  {
    "id": 9,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "In a lending protocol, borrowers can withdraw funds immediately without collateral verification."
  },
  {
    "id": 10,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "msg.sender, which identifies the caller's account address"
      },
      {
        "id": "b",
        "text": "tx.origin, which always represents the contract deployer"
      },
      { "id": "c", "text": "block.timestamp, which represents the caller" },
      { "id": "d", "text": "contract.owner, a built-in Solidity variable" }
    ],
    "question": "Which is the correct way to identify the current function caller to implement proper access control?"
  },
  {
    "id": 11,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The onlyOwner pattern using modifiers is a standard way to restrict function access to the contract owner."
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "tx.origin attacks can be prevented by using msg.sender instead"
      },
      {
        "id": "b",
        "text": "tx.origin represents the original transaction sender and can be spoofed"
      },
      {
        "id": "c",
        "text": "msg.sender is safer for access control than tx.origin"
      },
      { "id": "d", "text": "All of the above are correct" }
    ],
    "question": "What is true regarding tx.origin vs msg.sender?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "A standard for creating unique digital certificates"
      },
      {
        "id": "b",
        "text": "A widely-adopted token standard that defines a set of functions (mint, burn, transfer, etc.) for fungible tokens"
      },
      { "id": "c", "text": "A protocol for encrypted communication" },
      { "id": "d", "text": "A mechanism for decentralized governance voting" }
    ],
    "question": "What is the ERC20 standard?"
  },
  {
    "id": 14,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In an ERC20 token contract, the owner should be able to enforce a maximum supply limit to prevent inflation."
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "require(totalSupply + amount <= maxSupply)" },
      { "id": "b", "text": "assert(supply < maxSupply)" },
      {
        "id": "c",
        "text": "require(totalSupply + amount <= maxSupply, 'Exceeds max supply')"
      },
      { "id": "d", "text": "if (totalSupply >= maxSupply) return false" }
    ],
    "question": "How should a minting function enforce a maximum supply cap in an ERC20 token contract?"
  }
]
```
