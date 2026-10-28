# Chapter 4 Quiz: Decentralized Applications (DApps)

```json
[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Trust Wallet" },
      { "id": "b", "text": "MetaMask" },
      { "id": "c", "text": "Coinbase Wallet" },
      { "id": "d", "text": "Phantom Wallet" }
    ],
    "question": "Which browser extension wallet do the Chapter 4 DApps connect to through window.ethereum?"
  },
  {
    "id": 2,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "JSON Web Token" },
      { "id": "b", "text": "JavaScript Web Transfer" },
      { "id": "c", "text": "JSON-RPC API Provider" },
      { "id": "d", "text": "Java Web Toolkit" }
    ],
    "question": "What does a Web3 provider like MetaMask inject into the browser window for DApp communication?"
  },
  {
    "id": 3,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "window.ethereum" },
      { "id": "b", "text": "window.web3" },
      { "id": "c", "text": "window.blockchain" },
      { "id": "d", "text": "window.wallet" }
    ],
    "question": "What is the standard object used to access wallet functionality in a browser-based DApp?"
  },
  {
    "id": 4,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Smart contracts on the blockchain are immutable once deployed."
  },
  {
    "id": 5,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Solidity" },
      { "id": "b", "text": "ethers.js (v6)" },
      { "id": "c", "text": "OpenZeppelin" },
      { "id": "d", "text": "MetaMask Snaps" }
    ],
    "question": "Which JavaScript library do the Chapter 4 lessons use to connect a React frontend to smart contracts?"
  },
  {
    "id": 6,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "To store sensitive data" },
      { "id": "b", "text": "To cache blockchain data" },
      { "id": "c", "text": "To bypass smart contract validation" },
      { "id": "d", "text": "To call read-only functions without spending gas" }
    ],
    "question": "What is the purpose of using 'view' or 'pure' functions in a smart contract?"
  },
  {
    "id": 7,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Calling a state-changing function in a smart contract does not require gas fees."
  },
  {
    "id": 8,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Units of computation cost on a blockchain network"
      },
      { "id": "b", "text": "The speed of transactions" },
      { "id": "c", "text": "The amount of storage on the blockchain" },
      { "id": "d", "text": "Network bandwidth" }
    ],
    "question": "What is 'gas' in the context of blockchain transactions?"
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Contract Address Book" },
      { "id": "b", "text": "Contract Application Interface" },
      { "id": "c", "text": "Application Binary Interface" },
      { "id": "d", "text": "Advanced Blockchain Integration" }
    ],
    "question": "What does ABI stand for in the context of smart contract interaction?"
  },
  {
    "id": 10,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The wallet's private key" },
      {
        "id": "b",
        "text": "The unique identifier of a deployed contract on the blockchain"
      },
      { "id": "c", "text": "The timestamp of contract deployment" },
      { "id": "d", "text": "The owner's email address" }
    ],
    "question": "What is a contract address?"
  },
  {
    "id": 11,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Smart contract events can be indexed to create efficient logging and monitoring systems."
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A function that runs on a timer" },
      { "id": "b", "text": "A way to store multiple variables" },
      { "id": "c", "text": "A log entry emitted by a smart contract" },
      { "id": "d", "text": "A function that only the contract owner can call" }
    ],
    "question": "What is an event in Solidity?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "ethers.Contract" },
      { "id": "b", "text": "ethers.Wallet" },
      { "id": "c", "text": "ethers.BrowserProvider" },
      { "id": "d", "text": "ethers.JsonRpcProvider" }
    ],
    "question": "In ethers v6, which class do you create (with an address, an ABI and a provider or signer) to call a deployed smart contract's functions?"
  },
  {
    "id": 14,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Reading data from a smart contract requires the user to have a connected wallet."
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Users approve private key access" },
      { "id": "b", "text": "Users enter their seed phrase" },
      {
        "id": "c",
        "text": "Users sign a message without the DApp gaining access to their wallet"
      },
      { "id": "d", "text": "Users share their MetaMask password" }
    ],
    "question": "How does 'Sign in with Wallet' authentication work?"
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "ERC20" },
      { "id": "b", "text": "ERC721" },
      { "id": "c", "text": "ERC1155" },
      { "id": "d", "text": "ERC777" }
    ],
    "question": "Which token standard is used for non-fungible tokens (NFTs)?"
  },
  {
    "id": 17,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Event listeners in a frontend application can monitor blockchain events in real-time."
  },
  {
    "id": 18,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "A token whose units are identical and interchangeable, like one peso coin and any other peso coin"
      },
      { "id": "b", "text": "A blockchain network" },
      { "id": "c", "text": "A type of smart contract" },
      { "id": "d", "text": "A wallet security feature" }
    ],
    "question": "What is a fungible token?"
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "request.accounts" },
      { "id": "b", "text": "request.wallet" },
      { "id": "c", "text": "request.connect" },
      { "id": "d", "text": "eth_requestAccounts" }
    ],
    "question": "Which method requests a user's wallet address from MetaMask?"
  },
  {
    "id": 20,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Only during deployment" },
      { "id": "b", "text": "Only for reading data" },
      { "id": "c", "text": "When making state-changing transactions" },
      { "id": "d", "text": "Never in modern DApps" }
    ],
    "question": "When does a user's wallet approval become necessary in a DApp?"
  },
  {
    "id": 21,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Multi-signature wallets require multiple private keys to authorize a transaction."
  },
  {
    "id": 22,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "So a captured signature cannot be replayed to sign in again later"
      },
      { "id": "b", "text": "To lower the gas fee of the sign-in" },
      { "id": "c", "text": "To encrypt the user's private key" },
      { "id": "d", "text": "To choose which network the message is signed on" }
    ],
    "question": "In a Sign-In with Wallet flow, why does the message the user signs include a nonce (a value used only once)?"
  },
  {
    "id": 23,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Decentralized Finance Framework" },
      { "id": "b", "text": "Decentralized Finance" },
      { "id": "c", "text": "Digital Finance Exchange" },
      { "id": "d", "text": "Distributed Forensic Engineering" }
    ],
    "question": "What does DeFi stand for?"
  },
  {
    "id": 24,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Cross-chain bridges are unnecessary for DApps that operate on multiple blockchains."
  },
  {
    "id": 25,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A system for storing wallet passwords" },
      { "id": "b", "text": "A blockchain feature" },
      {
        "id": "c",
        "text": "A system where token holders vote on governance decisions"
      },
      { "id": "d", "text": "A type of transaction" }
    ],
    "question": "What is a DAO (Decentralized Autonomous Organization) voting system?"
  },
  {
    "id": 26,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "To bring off-chain data, such as prices or weather readings, on-chain for smart contracts"
      },
      { "id": "b", "text": "To validate transactions on the blockchain" },
      { "id": "c", "text": "To store user wallet keys" },
      { "id": "d", "text": "To compress blockchain data" }
    ],
    "question": "What is the purpose of an oracle in blockchain applications?"
  },
  {
    "id": 27,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Different blockchain networks can have different gas prices and transaction speeds."
  },
  {
    "id": 28,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A smart contract that stores cryptocurrency" },
      {
        "id": "b",
        "text": "A contract that holds funds and only releases them under specific conditions"
      },
      { "id": "c", "text": "A type of wallet" },
      { "id": "d", "text": "A security audit mechanism" }
    ],
    "question": "What is an escrow contract?"
  },
  {
    "id": 29,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "window.chainId" },
      { "id": "b", "text": "window.networkId" },
      { "id": "c", "text": "ethereum.chainID" },
      { "id": "d", "text": "ethereum.request({ method: 'eth_chainId' })" }
    ],
    "question": "How do you programmatically detect which blockchain network a user is connected to?"
  },
  {
    "id": 30,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Private keys should always be stored in frontend code or browser local storage."
  },
  {
    "id": 31,
    "type": "FIB",
    "answer": "gas fee",
    "points": 1,
    "question": "The cost a user pays to have a transaction executed on a blockchain is called a ______."
  },
  {
    "id": 32,
    "type": "FIB",
    "answer": "smart contract",
    "points": 1,
    "question": "A self-executing program stored on the blockchain with terms written in code is called a ______."
  },
  {
    "id": 33,
    "type": "FIB",
    "answer": "token",
    "points": 1,
    "question": "A digital asset representing value or ownership created on a blockchain is called a ______."
  },
  {
    "id": 34,
    "type": "FIB",
    "answer": "transaction hash",
    "points": 1,
    "question": "Every blockchain transaction is uniquely identified by a ______ that can be used to track its status."
  },
  {
    "id": 35,
    "type": "FIB",
    "answer": "wallet",
    "points": 1,
    "question": "A ______ is a software or hardware tool that stores private keys and allows users to manage their cryptocurrency."
  },
  {
    "id": 36,
    "type": "FIB",
    "answer": "dapp",
    "points": 1,
    "question": "An application that runs on a blockchain network and interacts with smart contracts is called a ______."
  },
  {
    "id": 37,
    "type": "FIB",
    "answer": "liquidity pool",
    "points": 1,
    "question": "In DeFi, a ______ is a smart contract holding paired tokens that users can trade against automatically."
  },
  {
    "id": 38,
    "type": "FIB",
    "answer": "gateway",
    "points": 1,
    "question": "A browser cannot load an ipfs:// link directly, so an NFT gallery rewrites it to an HTTP URL such as https://ipfs.io/ipfs/... served by an IPFS ______."
  },
  {
    "id": 39,
    "type": "FIB",
    "answer": "decimals",
    "points": 1,
    "question": "ERC-20 amounts are stored on-chain as whole integers. The token's ______ value (often 18) tells your UI where to put the decimal point when it formats a balance."
  },
  {
    "id": 40,
    "type": "FIB",
    "answer": "allowance",
    "points": 1,
    "question": "When a user approves a smart contract to spend tokens on their behalf, they are setting an ______."
  }
]
```
