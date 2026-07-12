[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A coin you buy low and sell high to make a profit" },
      { "id": "b", "text": "A ledger of who-holds-how-much — a list of addresses and balances — living in a program on a blockchain" },
      { "id": "c", "text": "A unique, one-of-a-kind digital collectible" },
      { "id": "d", "text": "A file format for storing images on-chain" }
    ],
    "question": "Stripped of hype, what is an ERC-20 token at its core?"
  },
  {
    "id": 2,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Workshop Credit (WCR) is a transparent points system you earn and spend, not a coin to buy, sell, or invest in."
  },
  {
    "id": 3,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Every unit is unique and non-interchangeable" },
      { "id": "b", "text": "The token can never be divided into smaller amounts" },
      { "id": "c", "text": "Every unit is identical and interchangeable — any 40 WCR equals any other 40 WCR" },
      { "id": "d", "text": "The token's price is fixed by the government" }
    ],
    "question": "What does it mean that ERC-20 tokens are 'fungible'?"
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "3 view functions, 3 write functions, and 2 events" },
      { "id": "b", "text": "10 functions and no events" },
      { "id": "c", "text": "1 function that does everything" },
      { "id": "d", "text": "Only the transfer function" }
    ],
    "question": "What does the core ERC-20 interface consist of?"
  },
  {
    "id": 5,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Copy-paste OpenZeppelin's code into your own file and edit it" },
      { "id": "b", "text": "Inherit it with `contract WorkshopCredit is ERC20` so you reuse audited, battle-tested code" },
      { "id": "c", "text": "Rewrite the whole ERC-20 standard by hand for safety" },
      { "id": "d", "text": "Download it and run npm install in Remix" }
    ],
    "question": "How does Dan reuse OpenZeppelin's ERC20 implementation (the bayanihan move)?"
  },
  {
    "id": 6,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In OpenZeppelin v5, a contract inheriting ERC20 must pass a name and symbol to the base constructor, or it won't compile."
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "1000" },
      { "id": "b", "text": "1000 / 10" },
      { "id": "c", "text": "1000 * 10 ** decimals()" },
      { "id": "d", "text": "1000 + decimals()" }
    ],
    "question": "With the default 18 decimals, how do you mint 1,000 whole WCR as base units?"
  },
  {
    "id": 8,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It permanently deletes the contract" },
      { "id": "b", "text": "It runs exactly once, at deployment, to set the contract's starting state (like name and initial supply)" },
      { "id": "c", "text": "It runs every time someone calls a function" },
      { "id": "d", "text": "It is only used to read data from the contract" }
    ],
    "question": "What does a Solidity constructor do?"
  },
  {
    "id": 9,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Read-only calls like name(), symbol(), balanceOf(), and totalSupply() cost gas and change the blockchain's state."
  },
  {
    "id": 10,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The contract silently crashes and loses everyone's balances" },
      { "id": "b", "text": "The transaction reverts with the custom error ERC20InsufficientBalance — an atomic refusal, nothing changes" },
      { "id": "c", "text": "It sends whatever balance is available and ignores the rest" },
      { "id": "d", "text": "It creates new tokens to cover the difference" }
    ],
    "question": "In OpenZeppelin v5, what happens when you try to transfer more tokens than you hold?"
  },
  {
    "id": 11,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Transfer, because it moves tokens immediately" },
      { "id": "b", "text": "Mint, because it creates new tokens" },
      { "id": "c", "text": "The allowance model — approve sets a spending limit, and transferFrom lets a spender pull up to that limit" },
      { "id": "d", "text": "Burn, because it destroys tokens" }
    ],
    "question": "How does a store contract collect tokens from a buyer on the buyer's behalf?"
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "allowance(owner, spender)" },
      { "id": "b", "text": "balanceOf(spender)" },
      { "id": "c", "text": "totalSupply()" },
      { "id": "d", "text": "decimals()" }
    ],
    "question": "Which function tells you how much a spender is still approved to move on an owner's behalf?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Nothing — anyone is always allowed to create tokens" },
      { "id": "b", "text": "It reverts with OwnableUnauthorizedAccount, because minting is restricted with onlyOwner" },
      { "id": "c", "text": "It succeeds but the tokens are worthless" },
      { "id": "d", "text": "It transfers ownership to the caller" }
    ],
    "question": "With onlyOwner minting, what happens when a non-owner calls the mint/rewardStudent function?"
  },
  {
    "id": 14,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Burning tokens permanently reduces totalSupply, so a claimed reward can remove its credits from circulation."
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It makes the token increase in price" },
      { "id": "b", "text": "It records who was rewarded, how much, and a human-readable reason permanently in the transaction log" },
      { "id": "c", "text": "It hides the reward from everyone except the owner" },
      { "id": "d", "text": "It deletes the student's previous balance" }
    ],
    "question": "What does emitting a StudentRewarded event accomplish?"
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Goerli" },
      { "id": "b", "text": "The Ethereum mainnet with real ETH" },
      { "id": "c", "text": "The Sepolia testnet, using free faucet ETH" },
      { "id": "d", "text": "A private notebook file" }
    ],
    "question": "Where does Dan deploy WCR and the RewardStore for the public graduation demo?"
  }
]
