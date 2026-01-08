# Chapter 12 Quiz: Move Language

```json
[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Solidity" },
      { "id": "b", "text": "Move" },
      { "id": "c", "text": "Rust" },
      { "id": "d", "text": "Vyper" }
    ],
    "question": "Which programming language is designed specifically for resource-oriented smart contract development on blockchains like Sui and Aptos?"
  },
  {
    "id": 2,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "contract" },
      { "id": "b", "text": "module" },
      { "id": "c", "text": "class" },
      { "id": "d", "text": "package" }
    ],
    "question": "Which keyword is used to define a smart contract unit in Move?"
  },
  {
    "id": 3,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "create, read, update, delete" },
      { "id": "b", "text": "copy, drop, store, key" },
      { "id": "c", "text": "public, private, friend, entry" },
      { "id": "d", "text": "move, borrow, clone, transfer" }
    ],
    "question": "What are the four abilities in Move?"
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "u32" },
      { "id": "b", "text": "u128" },
      { "id": "c", "text": "u64" },
      { "id": "d", "text": "u16" }
    ],
    "question": "Which unsigned integer type is most commonly used in Move for balances and amounts?"
  },
  {
    "id": 5,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In Move, a struct without any abilities cannot be copied, dropped, or stored."
  },
  {
    "id": 6,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Move allows multiple resources of the same type to be stored under a single address."
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "key" },
      { "id": "b", "text": "store" },
      { "id": "c", "text": "copy" },
      { "id": "d", "text": "drop" }
    ],
    "question": "Which ability allows a struct to be stored as a top-level resource in global storage?"
  },
  {
    "id": 8,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The 'store' ability allows a struct to be stored inside other structs."
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "borrow_from" },
      { "id": "b", "text": "get_global" },
      { "id": "c", "text": "move_to" },
      { "id": "d", "text": "store_at" }
    ],
    "question": "Which function is used to store a resource under an address in global storage?"
  },
  {
    "id": 10,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Constants in Move can be modified after the module is deployed."
  },
  {
    "id": 11,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "clone" },
      { "id": "b", "text": "move" },
      { "id": "c", "text": "reference" },
      { "id": "d", "text": "borrow" }
    ],
    "question": "When you assign a value to a new variable in Move, what happens to the original variable by default?"
  },
  {
    "id": 12,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Primitive types like u64 and bool have the 'copy' ability by default."
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "&T" },
      { "id": "b", "text": "*T" },
      { "id": "c", "text": "ref T" },
      { "id": "d", "text": "T&" }
    ],
    "question": "What is the syntax for an immutable reference in Move?"
  },
  {
    "id": 14,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "A mutable reference (&mut T) allows you to modify the referenced value."
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "requires" },
      { "id": "b", "text": "uses" },
      { "id": "c", "text": "borrows" },
      { "id": "d", "text": "acquires" }
    ],
    "question": "Which annotation must be added to a function that accesses global storage resources?"
  },
  {
    "id": 16,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "In Move, you can have multiple mutable references to the same value at the same time."
  },
  {
    "id": 17,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "switch/case" },
      { "id": "b", "text": "if/else" },
      { "id": "c", "text": "match" },
      { "id": "d", "text": "when/then" }
    ],
    "question": "Which control flow construct is used for conditionals in Move?"
  },
  {
    "id": 18,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The 'while' and 'loop' keywords are used for iteration in Move."
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "throw" },
      { "id": "b", "text": "revert" },
      { "id": "c", "text": "abort" },
      { "id": "d", "text": "panic" }
    ],
    "question": "Which keyword immediately stops execution and reverts all state changes in Move?"
  },
  {
    "id": 20,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The assert! macro aborts execution if its condition evaluates to false."
  },
  {
    "id": 21,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Option<T>" },
      { "id": "b", "text": "Maybe<T>" },
      { "id": "c", "text": "Nullable<T>" },
      { "id": "d", "text": "Optional<T>" }
    ],
    "question": "Which type is used to represent a value that may or may not exist in Move?"
  },
  {
    "id": 22,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Vectors in Move can grow dynamically using vector::push_back."
  },
  {
    "id": 23,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "vector::add" },
      { "id": "b", "text": "vector::push_back" },
      { "id": "c", "text": "vector::insert" },
      { "id": "d", "text": "vector::append" }
    ],
    "question": "Which function adds an element to the end of a vector?"
  },
  {
    "id": 24,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Tables in Move can be iterated directly using a for loop."
  },
  {
    "id": 25,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "public" },
      { "id": "b", "text": "external" },
      { "id": "c", "text": "public(friend)" },
      { "id": "d", "text": "protected" }
    ],
    "question": "Which visibility modifier allows only declared friend modules to call a function?"
  },
  {
    "id": 26,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Entry functions can be called directly by blockchain transactions."
  },
  {
    "id": 27,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "template<T>" },
      { "id": "b", "text": "generic T" },
      { "id": "c", "text": "[T]" },
      { "id": "d", "text": "<T>" }
    ],
    "question": "What is the syntax for declaring a generic type parameter in Move?"
  },
  {
    "id": 28,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Generic type parameters can be constrained with abilities like 'T: copy + drop'."
  },
  {
    "id": 29,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "phantom" },
      { "id": "b", "text": "virtual" },
      { "id": "c", "text": "abstract" },
      { "id": "d", "text": "ghost" }
    ],
    "question": "Which keyword marks a type parameter that is only used at the type level, not in fields?"
  },
  {
    "id": 30,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The witness pattern uses a struct that can only be created once to prove authorization."
  },
  {
    "id": 31,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "@test" },
      { "id": "b", "text": "#[test]" },
      { "id": "c", "text": "test::" },
      { "id": "d", "text": "unittest" }
    ],
    "question": "Which attribute marks a function as a unit test in Move?"
  },
  {
    "id": 32,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "#[expected_failure] is used to test that a function aborts with a specific error."
  },
  {
    "id": 33,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "log" },
      { "id": "b", "text": "emit" },
      { "id": "c", "text": "event::emit" },
      { "id": "d", "text": "broadcast" }
    ],
    "question": "Which function is typically used to emit events in Move?"
  },
  {
    "id": 34,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Events in Move are stored on-chain and can be queried from within smart contracts."
  },
  {
    "id": 35,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Capability pattern" },
      { "id": "b", "text": "Singleton pattern" },
      { "id": "c", "text": "Observer pattern" },
      { "id": "d", "text": "Factory pattern" }
    ],
    "question": "Which design pattern uses structs as permission tokens to grant access to restricted operations?"
  },
  {
    "id": 36,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Minimizing global storage reads and writes is a key gas optimization technique."
  },
  {
    "id": 37,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Faster execution" },
      { "id": "b", "text": "Easier debugging" },
      { "id": "c", "text": "Smaller binary size" },
      { "id": "d", "text": "Prevention of resource duplication and loss" }
    ],
    "question": "What is the primary security benefit of Move's linear type system?"
  },
  {
    "id": 38,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Move's borrow checker prevents data races by enforcing strict aliasing rules."
  },
  {
    "id": 39,
    "type": "FIB",
    "answer": "resource",
    "points": 1,
    "question": "A struct without any abilities is called a ______ and cannot be copied or dropped."
  },
  {
    "id": 40,
    "type": "FIB",
    "answer": "borrow_global",
    "points": 1,
    "question": "The function ______ is used to get an immutable reference to a resource in global storage."
  }
]
```
