# Chapter 1 Quiz: Basic Solidity

```js
[
  {
    id: 1,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "Solidity" },
      { id: "b", text: "Java" },
      { id: "c", text: "Python" },
      { id: "d", text: "Rust" },
    ],
    question:
      "Which programming language is primarily used to write Ethereum smart contracts?",
  },
  {
    id: 2,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "class" },
      { id: "b", text: "contract" },
      { id: "c", text: "module" },
      { id: "d", text: "package" },
    ],
    question: "Which keyword is used to define a smart contract in Solidity?",
  },
  {
    id: 3,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "string" },
      { id: "b", text: "bool" },
      { id: "c", text: "uint256" },
      { id: "d", text: "address[]" },
    ],
    question:
      "Which data type is most commonly used for storing numbers in Solidity?",
  },
  {
    id: 4,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "memory" },
      { id: "b", text: "calldata" },
      { id: "c", text: "stack" },
      { id: "d", text: "storage" },
    ],
    question: "Where are state variables stored in a Solidity contract?",
  },
  {
    id: 5,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "State variables keep their values even after a function execution ends.",
  },
  {
    id: 6,
    type: "TF",
    answer: false,
    points: 1,
    question: "Local variables are permanently stored on the blockchain.",
  },
  {
    id: 7,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "public" },
      { id: "b", text: "private" },
      { id: "c", text: "internal" },
      { id: "d", text: "external" },
    ],
    question:
      "Which visibility keyword automatically creates a getter function?",
  },
  {
    id: 8,
    type: "TF",
    answer: true,
    points: 1,
    question: "The address data type is used to store Ethereum addresses.",
  },
  {
    id: 9,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "msg.value" },
      { id: "b", text: "tx.origin" },
      { id: "c", text: "msg.sender" },
      { id: "d", text: "block.timestamp" },
    ],
    question: "Which global variable represents the caller of a function?",
  },
  {
    id: 10,
    type: "TF",
    answer: false,
    points: 1,
    question: "The msg.sender variable always refers to the contract owner.",
  },
  {
    id: 11,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "payable()" },
      { id: "b", text: "payable" },
      { id: "c", text: "transferable" },
      { id: "d", text: "ether" },
    ],
    question: "Which keyword allows a function to receive Ether?",
  },
  {
    id: 12,
    type: "TF",
    answer: true,
    points: 1,
    question: "Functions marked as view cannot modify state variables.",
  },
  {
    id: 13,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "constructor" },
      { id: "b", text: "initialize" },
      { id: "c", text: "deploy" },
      { id: "d", text: "setup" },
    ],
    question:
      "What is the special function that runs during contract deployment?",
  },
  {
    id: 14,
    type: "TF",
    answer: true,
    points: 1,
    question:
      "A constructor is executed only once in the lifetime of a contract.",
  },
  {
    id: 15,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "array" },
      { id: "b", text: "struct" },
      { id: "c", text: "enum" },
      { id: "d", text: "mapping" },
    ],
    question: "Which data structure stores key-value pairs in Solidity?",
  },
  {
    id: 16,
    type: "TF",
    answer: false,
    points: 1,
    question: "Mappings in Solidity can be iterated directly using a for loop.",
  },
  {
    id: 17,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "memory" },
      { id: "b", text: "storage" },
      { id: "c", text: "calldata" },
      { id: "d", text: "stack" },
    ],
    question: "Which data location is used for state variables?",
  },
  {
    id: 18,
    type: "TF",
    answer: true,
    points: 1,
    question: "The require statement is commonly used for input validation.",
  },
  {
    id: 19,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "require" },
      { id: "b", text: "assert" },
      { id: "c", text: "revert" },
      { id: "d", text: "throw" },
    ],
    question:
      "Which keyword immediately stops execution and reverts state changes?",
  },
  {
    id: 20,
    type: "TF",
    answer: true,
    points: 1,
    question: "If a require condition fails, the remaining gas is refunded.",
  },
  {
    id: 21,
    type: "MCQ",
    answer: "a",
    points: 1,
    choices: [
      { id: "a", text: "event" },
      { id: "b", text: "modifier" },
      { id: "c", text: "struct" },
      { id: "d", text: "enum" },
    ],
    question:
      "Which Solidity feature is used to log data for off-chain consumption?",
  },
  {
    id: 22,
    type: "TF",
    answer: true,
    points: 1,
    question: "Events are cheaper to store than state variables.",
  },
  {
    id: 23,
    type: "MCQ",
    answer: "d",
    points: 1,
    choices: [
      { id: "a", text: "internal" },
      { id: "b", text: "private" },
      { id: "c", text: "public" },
      { id: "d", text: "external" },
    ],
    question:
      "Which function visibility is optimized for calls from outside the contract?",
  },
  {
    id: 24,
    type: "TF",
    answer: false,
    points: 1,
    question: "External functions can be called internally without using this.",
  },
  {
    id: 25,
    type: "MCQ",
    answer: "b",
    points: 1,
    choices: [
      { id: "a", text: "fallback()" },
      { id: "b", text: "receive()" },
      { id: "c", text: "payable()" },
      { id: "d", text: "ether()" },
    ],
    question:
      "Which function is triggered when Ether is sent with empty calldata?",
  },
  {
    id: 26,
    type: "TF",
    answer: true,
    points: 1,
    question: "The receive function must be marked as payable.",
  },
  {
    id: 27,
    type: "MCQ",
    answer: "c",
    points: 1,
    choices: [
      { id: "a", text: "delegatecall" },
      { id: "b", text: "send" },
      { id: "c", text: "call" },
      { id: "d", text: "transfer" },
    ],
    question: "Which method is currently recommended for sending Ether?",
  },
  {
    id: 28,
    type: "TF",
    answer: false,
    points: 1,
    question: "The transfer method forwards all remaining gas by default.",
  },
  {
    id: 29,
    type: "FIB",
    answer: "modifier",
    points: 1,
    question:
      "A reusable access control logic in Solidity is implemented using a ______.",
  },
  {
    id: 30,
    type: "FIB",
    answer: "reentrancy",
    points: 1,
    question:
      "The vulnerability where a function is repeatedly called before state updates is called ______.",
  },
];
```
