## Background Story

Odessa pushes open the heavy oak doors of the Move Guild archives. Dust motes dance in shafts of golden light streaming through tall windows. Before her lies a vast library—shelves upon shelves of scrolls, each containing the wisdom of blockchain developers who came before.

"Welcome, seeker," says Elder Makoto, the guild's keeper. "You've studied Solidity, mastered the EVM. But here, you'll learn something... different."

He unfurls an ancient scroll. "In 2019, brilliant minds at Diem (formerly Libra) faced a crisis. Smart contracts kept getting hacked. Billions lost. Why? Because traditional languages treated digital assets like any other data—copyable, deletable, forgettable."

Makoto's eyes gleam. "Move was born from one radical idea: **digital assets should behave like physical objects**. You can't duplicate your house keys by accident. You can't delete your car and create two new ones. Move brings this sanity to blockchain."

"Today," he says, rolling up the scroll, "you begin your journey into a language where safety isn't optional—it's built into every line of code."

---

## Topics

### What Move Solves

Imagine you're building a bank vault in the digital world. In traditional programming, you might store money as just a number in a database—maybe `balance = 1000`. But here's the terrifying problem: numbers can be copied, overwritten, or deleted by accident. What happens when a bug in your code accidentally sets `balance = balance + balance` twice? Or worse, what if you write `balance = 0` and those funds just... disappear into the void?

This isn't a hypothetical problem. In the world of blockchain smart contracts, these kinds of bugs have cost billions of dollars. Let me walk you through the real dangers that Move was designed to solve.

**The Problem with Traditional Smart Contract Languages:**

When you write a smart contract in Solidity (the language of Ethereum), you're essentially working with a giant spreadsheet. Your tokens, your NFTs, your assets—they're all just numbers and data stored in this spreadsheet. And here's where things get scary:

**Reentrancy Attacks**: Picture this—you write a function to withdraw money from a contract. The function checks your balance, sends you the money, then updates your balance to zero. Seems safe, right? Wrong. What if the receiver is a malicious contract that, when it receives the money, immediately calls your withdraw function again? Since your balance hasn't been updated yet, it checks your old balance and sends money again. And again. And again. This is like someone pressing the ATM withdrawal button repeatedly before the machine can subtract from their account. The infamous DAO hack of 2016 stole $60 million this way.

**Integer Overflow and Underflow**: Computers store numbers with a maximum size. In Solidity, if you have a `uint8` (which can hold 0-255), and you add 1 to 255, it doesn't become 256—it wraps around to 0! Imagine if your bank balance of $255 became $0 when someone deposited $1. Or worse, if someone with a balance of 0 could subtract 1 and suddenly have 255 coins appear from nowhere. These bugs have been exploited to create tokens out of thin air.

**Copy and Delete Bugs**: In traditional languages, you can accidentally duplicate or destroy value. Let's say you have 100 tokens. You write `myTokens = 100; yourTokens = myTokens;` Now both variables hold 100—did you just create 100 tokens from nothing? Or if you reassign a variable holding tokens (`myTokens = 50`), where did the original 100 go? They just vanished. No error, no warning. Just gone.

**Unclear Ownership**: In Solidity, ownership is tracked through mappings—essentially saying "address A owns 100 tokens" in a table. But this is just bookkeeping. There's nothing preventing bad code from adding tokens to someone's balance, subtracting from random accounts, or creating contradictory records. It's like having property deeds written in pencil—anyone with access can erase and rewrite them.

**Move's Revolutionary Approach:**

Now, imagine if digital assets worked like physical objects. You can't photocopy a gold bar. You can't accidentally delete your car keys from existence. If you hand someone a $20 bill, you no longer have it—it's physically moved from your hand to theirs.

This is exactly how Move works. Move treats assets as **resources**—special types with ironclad rules enforced by the language itself:

```move
// In Solidity (dangerous):
uint256 myToken = 100;
myToken = 50; // Where did 50 tokens go? Lost forever!
// No error. No warning. Half your money just disappeared.

// In Move (safe):
let myToken: Coin<USDC> = ...; // You have a coin resource
// myToken = something_else; // ❌ COMPILER ERROR!
// You MUST explicitly:
// - Transfer it: transfer(myToken, recipient)
// - Destroy it: burn(myToken) // Requires special permission
// - Store it: move_to(account, myToken)
// You cannot simply reassign it and make it disappear!
```

Move's compiler acts like a strict guardian. It won't let you compile code that could accidentally lose assets. It's the difference between handling physical cash (Move) versus editing numbers in a spreadsheet (Solidity). With Move, the language itself prevents entire categories of bugs that have plagued blockchain for years.

### Move as a Safe, Verifiable Smart Contract Language

Think of Move as a paranoid security guard who checks everything three times before letting it through. While this might seem excessive when you're just trying to write code, this paranoia is exactly what protects billions of dollars in blockchain assets. Let me explain each safety feature and why it matters to you as a developer.

**Static Typing: Catching Mistakes Before They're Expensive**

In JavaScript or Python, you can write code like this:

```javascript
let amount = "100"; // It's a string
amount = amount + 50; // Now it's "10050"—oops!
```

The code runs, but it's wrong. You only discover the bug when users complain their transactions are broken. In blockchain, deploying a buggy contract can mean lost funds that can never be recovered.

Move uses **static typing**, which means every variable must have a declared type, and the compiler checks that you're using types correctly before you ever deploy. It's like having a spell-checker that catches errors before you send an important email:

```move
let amount: u64 = 100; // This is a 64-bit unsigned integer
let amount_2: u64 = amount + 50; // ✅ Works: 150
// let wrong: u64 = amount + "50"; // ❌ Compiler error: can't add string to number
```

The beauty is that you catch these errors on your laptop during development, not in production where they cost real money.

**No Dynamic Dispatch: Predictability is Safety**

In languages like Solidity, you can make "dynamic calls"—calling functions by name stored in a variable, or calling functions on contracts whose code you don't know at compile time. This flexibility is dangerous:

```solidity
// Solidity: Dynamic call to unknown contract
address unknownContract = ...;
unknownContract.call(data); // What is this calling? Who knows!
```

Move eliminates this uncertainty. Every function call is known at compile time. The compiler knows exactly what code will execute, which means it can verify that code is safe. There are no surprises, no mystery functions that could drain your funds. It's like only allowing deliveries from pre-approved vendors—less flexible, but far more secure.

**Resource Safety: Digital Assets That Can't Disappear**

This is Move's superpower. Remember how we talked about assets as physical objects? Move enforces this at the language level. When you create a resource (like a coin), the compiler tracks it through your entire program:

```move
let coin = Coin { value: 100 }; // Created a coin resource
// What happens to 'coin'?
// - If you don't use it, COMPILER ERROR
// - If you try to copy it, COMPILER ERROR
// - If you try to just delete it, COMPILER ERROR
// You MUST explicitly transfer or destroy it
```

This prevents entire categories of bugs. You can't accidentally:

- Lose assets by reassigning variables
- Duplicate assets by copying
- Leave assets in an invalid state

It's like having a digital asset tracking system built into the language itself—you literally cannot write code that loses track of valuable resources.

**Formal Verification: Mathematical Proof Your Code is Correct**

This might sound academic, but it's incredibly practical. Move allows you to write **specifications**—formal statements about what your code should do. Then, automated tools can mathematically prove your code meets those specs.

For example, you might specify: "After any transaction, the total supply of tokens must remain constant." The verifier can check every possible execution path and prove this is true. This isn't testing (which checks specific cases)—this is a mathematical proof that covers all possible scenarios.

Think of it like an engineer certifying a bridge can hold 10,000 pounds—not by driving 10,000 pounds of trucks over it and hoping, but by calculating the structural integrity mathematically.

**Bytecode Verification: The Blockchain is Your Safety Net**

Here's a clever feature: When you deploy a Move module to the blockchain, the blockchain itself runs a verifier on your bytecode. Even if you somehow bypassed local safety checks, the blockchain rejects unsafe code.

It's like airport security for smart contracts—there's a final checkpoint before your code goes "live" that ensures it meets safety standards. This protects not just you, but everyone who might interact with your code.

**Real-World Impact: What This Means for Your Projects**

Let's bring this back to practical terms. When you build with Move:

**No Reentrancy Vulnerabilities**: Remember that DAO hack we discussed? Move's execution model makes it impossible. When a function is executing, it has exclusive access to the resources it's using. Other functions can't interrupt and call back into it. It's like having a "Do Not Disturb" sign that the language enforces automatically.

**No Integer Overflow**: Move has built-in safe math. If you add two numbers and the result would exceed the maximum value, the program aborts with an error instead of wrapping around. It's like having guardrails on a cliff—you can't accidentally drive off the edge.

**Clear Ownership**: The type system tracks exactly who owns what. There's no ambiguity, no shared state causing confusion. If you own a resource, it's stored at your address with your type signature. This is enforced by the language, not by your careful bookkeeping.

The bottom line: Move lets you focus on your application logic instead of worrying about security vulnerabilities. The language itself is your security team.

### Core Pillars: Safety, Resources, Abilities

Move's architecture rests on three fundamental pillars that work together to create a secure programming environment. Let's explore each one in depth, understanding not just what they are, but why they matter and how they protect you.

**1. Safety Through Types: Your First Line of Defense**

Imagine you're a pharmacist. If someone asks for "medicine," you can't just grab any bottle—you need to know exactly which medicine, what dosage, what form. Move's type system works the same way: every piece of data must have a precise type, and the compiler ensures you never mix things up.

Let's see this in action:

```move
let x: u64 = 100;      // x is a 64-bit unsigned integer
let y: u128 = x;       // ❌ COMPILER ERROR: Type mismatch!
```

Why does this fail? Because `u64` (which can hold 0 to 18,446,744,073,709,551,615) and `u128` (which can hold much larger numbers) are different types. Move doesn't assume you want to convert—you must be explicit:

```move
let x: u64 = 100;
let y: u128 = (x as u128); // ✅ Explicit conversion—you know what you're doing
```

This might seem tedious, but it prevents subtle bugs. Imagine if `x` was representing cents (where 100 = $1.00) and `y` was representing dollars. Accidentally mixing them could cause financial errors. Move forces you to be explicit, which means you're forced to think about what your data represents.

**Different Integer Types in Move:**

Move offers several integer types, and choosing the right one is important:

- `u8`: 0 to 255 (perfect for small counters, flags)
- `u64`: 0 to ~18 quintillion (great for IDs, timestamps, most amounts)
- `u128`: 0 to ~340 undecillion (for very large token amounts)
- `u256`: 0 to astronomical numbers (for cryptographic operations)

Why so many? Because using the smallest type that fits your needs saves computational resources on the blockchain (which means lower transaction fees) and makes your intentions clear to other developers.

**2. Resources: The Heart of Move**

This is where Move gets revolutionary. In most programming languages, when you create data, you can copy it, delete it, or lose track of it without consequences. But what if you're handling something valuable—like money?

Resources in Move are special types that follow strict rules, mimicking how physical assets work. Let me show you what makes something a resource:

```move
struct Coin has key {
    value: u64
}
```

That simple `has key` declaration transforms this ordinary struct into a resource with special superpowers and restrictions:

**What Resources CAN Do:**

✅ **Stored in Global Storage**: Resources can be stored at blockchain addresses, making them persistent and owned by specific accounts. When you create a `Coin` resource and store it at your address, it's yours—recorded on the blockchain. No one can take it without your permission.

```move
public fun create_coin(account: &signer) {
    let coin = Coin { value: 100 };
    move_to(account, coin); // Now stored at the signer's address
}
```

✅ **Transferred Explicitly**: You can move resources between addresses, but you must do so explicitly. There's no accidental transfers:

```move
public fun transfer_coin(from: &signer, to: address, coin: Coin) {
    // The coin has been moved (ownership transferred) to this function
    // Now we explicitly move it to the recipient
    move_to_sender(to, coin);
}
```

✅ **Destroyed with Intent**: If a resource needs to be destroyed (like burning tokens), you must write explicit code with proper permissions:

```move
public fun burn_coin(coin: Coin) {
    let Coin { value: _ } = coin; // Unpack and discard
    // The resource is destroyed, but only because we explicitly unpacked it
}
```

**What Resources CANNOT Do:**

❌ **Cannot Be Copied**: Imagine if you could photocopy dollar bills. That's inflation! Resources can't be copied:

```move
let coin1 = Coin { value: 100 };
let coin2 = coin1;  // ❌ ERROR: Cannot copy resource
// Only ONE coin exists—ownership moved from coin1 to coin2
```

❌ **Cannot Be Dropped (Discarded)**: You can't just forget about a resource:

```move
public fun bad_function(coin: Coin) {
    // Do nothing with coin
} // ❌ ERROR: coin not used—can't just disappear!
```

❌ **Cannot Exist Without Explicit Handling**: Every resource you create must be explicitly handled. It must either be stored, transferred, or destroyed. The compiler tracks every resource and ensures none are lost.

**Why This Matters:**

Resources prevent entire categories of bugs that have cost the blockchain industry billions:

- No lost tokens from forgetting to handle them
- No duplicated assets from copying
- No ambiguity about ownership
- No accidental destruction

It's like the difference between handling physical gold bars (you can see where they are, who has them) versus numbers in a spreadsheet (which can be copied, deleted, or corrupted easily).

**3. Abilities: Fine-Grained Control Over Your Types**

Move gives you four "abilities" that you can grant to your types. Think of abilities as permissions—they control what operations are allowed on your data. Understanding abilities is key to mastering Move.

**The Four Abilities:**

**`copy` - The Ability to Duplicate**

When you give a type the `copy` ability, you're saying "it's safe to duplicate this value." This is appropriate for simple data that doesn't represent scarce assets:

```move
struct Point has copy, drop {
    x: u64,
    y: u64
}

let p1 = Point { x: 10, y: 20 };
let p2 = p1; // ✅ Works because Point has 'copy'
// Now p1 and p2 both exist—the value was copied
```

When should you use `copy`? For data that has no scarcity value: coordinates, configuration settings, mathematical values, etc. Never use `copy` for assets like tokens or NFTs.

**`drop` - The Ability to Be Ignored**

The `drop` ability means "it's okay if this value isn't explicitly used." Without `drop`, Move forces you to handle every instance:

```move
struct Config has drop {
    setting: u64
}

public fun use_config() {
    let config = Config { setting: 100 };
    // Don't use config
} // ✅ OK because Config has 'drop'—it can just disappear
```

Use `drop` for non-critical data that can safely be discarded. Never use it for valuable assets—you don't want someone to accidentally "drop" a million-dollar NFT!

**`store` - The Ability to Be Nested**

The `store` ability allows a type to be stored inside other structs:

```move
struct Inner has store {
    value: u64
}

struct Outer has key {
    inner: Inner  // ✅ OK because Inner has 'store'
}
```

Think of `store` as making a type "portable"—it can be contained within other structures. Most types you create will have `store` because you'll often want to nest them.

**`key` - The Ability to Be a Top-Level Resource**

The `key` ability is special—it makes a type a true resource that can be stored in global storage:

```move
struct Treasure has key {
    gold: u64
}

public fun store_treasure(account: &signer) {
    let treasure = Treasure { gold: 1000 };
    move_to(account, treasure); // ✅ Works because Treasure has 'key'
}
```

Only types with `key` can be stored using `move_to()`. This is your top-level ownership marker—it says "this can exist as a standalone resource owned by an address."

**Combining Abilities: Real-World Examples**

The power comes from combining abilities strategically:

```move
// A simple coordinate—can copy, can drop, can store in other structs
struct Point has copy, drop, store {
    x: u64,
    y: u64
}

// A valuable NFT—can be stored globally, can be nested, but can't copy/drop
struct NFT has key, store {
    id: u64,
    rarity: u8
}

// Account metadata—can be stored globally, but once created, cannot be copied or dropped
struct Account has key {
    balance: u64,
    nonce: u64
}
```

**The Key Insight:**

By default, Move types have NO abilities. This is the opposite of most languages, where everything can be copied and deleted freely. In Move, you must explicitly grant each ability, which forces you to think about how your data should behave. This "secure by default" approach is why Move prevents so many common blockchain vulnerabilities.

Think of abilities as a permission system: you're the gatekeeper deciding what operations are safe for each type you create. Less is more—the fewer abilities you grant, the safer your code, but the more careful you must be in handling those types.

### Move vs EVM Mental Model

If you're coming from Ethereum/Solidity development, Move will feel both familiar and radically different. It's like switching from driving an automatic car to a manual transmission—some concepts translate directly, but you need to learn a new way of thinking about control and safety. Let me walk you through the key mental model differences so you can make this transition smoothly.

**The Fundamental Philosophical Difference**

**EVM (Ethereum) is Contract-Centric:**

In Ethereum, you think in terms of smart contracts. Each contract is like its own little kingdom with its own storage vault. When you build a token system, you create a contract that has a mapping of addresses to balances:

```solidity
// Solidity: Everything lives in the contract
contract MyToken {
    mapping(address => uint256) balances; // The contract owns this data

    function transfer(address to, uint256 amount) public {
        balances[msg.sender] -= amount;  // Update my mapping
        balances[to] += amount;          // Update my mapping
    }
}
```

The contract is the source of truth. All data lives in its storage. When you call functions, you're calling the contract, and it manages everything internally.

**Move is Resource-Centric:**

Move flips this model on its head. Instead of contracts owning data about users, users own their data directly. Resources live at user addresses, not in some central contract:

```move
// Move: Resources live at user addresses
module 0x1::my_token {
    struct Coin has key {
        value: u64
    }

    public fun transfer(from: &signer, to: address, amount: u64)
        acquires Coin {
        // Resources are stored at each user's address
        let from_coin = borrow_global_mut<Coin>(signer::address_of(from));
        let to_coin = borrow_global_mut<Coin>(to);

        from_coin.value = from_coin.value - amount;
        to_coin.value = to_coin.value + amount;
    }
}
```

There's no central storage in the module. Instead, each user has their own `Coin` resource stored at their address. The module provides functions to operate on these user-owned resources.

**Storage Architecture: Where Does My Data Live?**

**EVM Storage:**

In Ethereum, each contract has its own isolated storage space. Think of it as each contract having its own database:

```
Contract A Storage:
├── mapping: balances
├── array: userList
└── uint: totalSupply

Contract B Storage:
├── mapping: stakes
└── address: owner
```

If Contract A wants to know something from Contract B, it must make an external call to B's functions. The data is siloed per contract.

**Move Global Storage:**

Move uses a global storage model. Think of the entire blockchain as one giant database, indexed by `(address, type)` pairs:

```
Global Storage (conceptual):
├── Address 0x123:
│   ├── Coin<USD> { value: 1000 }
│   ├── NFT { id: 42 }
│   └── Account { nonce: 5 }
├── Address 0x456:
│   ├── Coin<USD> { value: 500 }
│   └── Account { nonce: 2 }
```

Any module can access resources from any address (with proper permissions). There's no concept of "this contract's storage" vs "that contract's storage." It's all one unified space, organized by ownership.

**Practical Impact:**

In EVM, if you want to check someone's token balance:

```solidity
uint256 balance = tokenContract.balanceOf(user); // Call the contract
```

In Move, you directly access the resource at their address:

```move
let coin = borrow_global<Coin>(user_address); // Direct access to their resource
let balance = coin.value;
```

**Asset Representation: Numbers vs Objects**

**EVM/Solidity: Assets Are Numerical Ledgers**

In Solidity, tokens are just numbers in a mapping. Your balance is a number stored in someone else's contract:

```solidity
mapping(address => uint256) public balances;

function transfer(address to, uint256 amount) public {
    balances[msg.sender] -= amount; // Just subtract a number
    balances[to] += amount;         // Just add a number
}
```

This is bookkeeping. The contract maintains a ledger saying "Alice has 100 tokens, Bob has 50 tokens." But there's no actual token object—just numbers.

**Danger:** What happens if there's a bug?

```solidity
function buggy_transfer(address to, uint256 amount) public {
    balances[to] += amount;
    // Forgot to subtract from sender—tokens created from nothing!
}
```

**Move: Assets Are First-Class Objects**

In Move, assets are actual objects (resources) that exist and must be explicitly moved:

```move
struct Coin has key {
    value: u64
}

public fun transfer(from: &signer, to: address, amount: u64) {
    // Can't forget to handle the resource—compiler enforces it
    let coin = withdraw(from, amount);  // Must explicitly create/extract
    deposit(to, coin);                  // Must explicitly give it somewhere
}
```

The `Coin` resource is a real object that exists. You can't accidentally create or destroy it—the compiler tracks its lifecycle.

**Ownership Model: Implicit vs Explicit**

**EVM: Implicit Ownership Through Mappings**

In Solidity, ownership is a concept you implement through code, typically with mappings:

```solidity
mapping(address => uint256) public balances;
// "Ownership" is just an entry in this mapping
```

The contract says "I assert that Alice owns 100 tokens" by having a mapping entry. But this is just data—there's no enforcement that this mapping correctly represents ownership. A bug could break this assertion.

**Move: Explicit Ownership Through Type System**

In Move, if a resource exists at your address, you own it. Period. This is enforced by the blockchain itself:

```move
struct Asset has key {
    value: u64
}

// If Asset exists at address 0x123, then 0x123 owns it
// Only 0x123 can provide the signer to authorize operations on it
```

Ownership isn't bookkeeping—it's a structural property of the blockchain. You can't have ambiguous ownership because the type system and storage model don't allow it.

**Function Calls: External vs Direct**

**EVM: External Contract Calls**

In Solidity, when one contract needs to interact with another, it makes an external call:

```solidity
interface OtherContract {
    function doSomething(uint value) external;
}

function callOther(address otherAddr, uint value) public {
    OtherContract(otherAddr).doSomething(value); // External call
}
```

These external calls are expensive (gas-wise) and introduce security risks like reentrancy. Each call crosses a trust boundary.

**Move: Direct Module Function Calls**

In Move, modules call each other's functions directly, like libraries:

```move
module 0x1::module_a {
    public fun do_something(value: u64) {
        // Function implementation
    }
}

module 0x1::module_b {
    use 0x1::module_a;

    public fun call_other(value: u64) {
        module_a::do_something(value); // Direct function call
    }
}
```

This is more like static linking—there's no overhead of crossing contract boundaries because there are no contract boundaries. Everything is just code operating on global storage.

**Visual Comparison:**

```
EVM:                          Move:
┌──────────────┐             ┌──────────────┐
│  Contract A  │             │   Module A   │
│ ┌──────────┐ │             │              │
│ │ Storage  │ │             │  Functions   │
│ │ Mappings │ │             │  that work   │
│ │ Arrays   │ │             │  with global │
│ └──────────┘ │             │  storage     │
│  Functions   │             └──────────────┘
└──────────────┘                    ↓
       ↓                      Global Storage
   External call              ┌──────────────┐
       ↓                      │ Addr: 0x1    │
┌──────────────┐             │ └─ Resource1 │
│  Contract B  │             │ └─ Resource2 │
│ ┌──────────┐ │             ├──────────────┤
│ │ Storage  │ │             │ Addr: 0x2    │
│ │ Different│ │             │ └─ Resource1 │
│ │ Isolated │ │             │ └─ Resource3 │
│ └──────────┘ │             └──────────────┘
│  Functions   │
└──────────────┘
```

**Key Differences Summary:**

| Aspect             | EVM/Solidity                                    | Move                                    |
| ------------------ | ----------------------------------------------- | --------------------------------------- |
| **Philosophy**     | Contract-centric: contracts own and manage data | Resource-centric: users own resources   |
| **Storage**        | Each contract has isolated storage              | Global storage shared by all modules    |
| **Assets**         | Numbers in mappings (bookkeeping)               | First-class resources (actual objects)  |
| **Ownership**      | Implicit via mappings you maintain              | Explicit via type system and storage    |
| **Asset Safety**   | Manual checks needed, easy to make mistakes     | Compiler-enforced, can't duplicate/lose |
| **Function Calls** | External calls between contracts (expensive)    | Direct function calls between modules   |
| **Reentrancy**     | Major risk, need explicit guards                | Prevented by execution model            |
| **Verification**   | External tools (optional)                       | Built-in bytecode verifier (mandatory)  |

**Making the Mental Shift:**

If you're transitioning from Solidity to Move, here are the key mental adjustments:

1. **Stop thinking about "my contract's storage"** → Start thinking about "resources at user addresses"
2. **Stop thinking about numerical balances** → Start thinking about resource objects that exist
3. **Stop thinking about external calls** → Start thinking about direct function calls
4. **Stop thinking about manual safety checks** → Start trusting the compiler to enforce safety

The hardest shift is letting go of the contract-centric model. In Move, you're not building a contract that owns and manages everything—you're building a module that provides operations for resources that users own. It's a subtle but profound difference that makes Move both safer and more efficient.

### Code Anatomy at a Glance

**A Complete Move Module:**

```move
module 0x1::hello_world {
    use std::signer;

    // A simple struct with abilities
    struct Message has key {
        text: vector<u8>
    }

    // Public function to create a message
    public fun create_message(account: &signer, text: vector<u8>) {
        let msg = Message { text };
        move_to(account, msg);
    }

    // Public function to read a message
    public fun read_message(addr: address): vector<u8> acquires Message {
        let msg = borrow_global<Message>(addr);
        *&msg.text
    }
}
```

**Breaking It Down:**

1. **Module Declaration**: `module 0x1::hello_world`

   - `0x1`: The account address where module is published
   - `hello_world`: Module name

2. **Imports**: `use std::signer`

   - Import functionality from other modules

3. **Struct Definition**: `struct Message has key`

   - Define data structures
   - `has key`: Gives it the `key` ability (can be stored globally)

4. **Functions**:

   - `public fun`: Public functions anyone can call
   - Parameters with types: `account: &signer`
   - `acquires Message`: Declares what resources this function accesses

5. **Resource Operations**:
   - `move_to(account, msg)`: Store resource in global storage
   - `borrow_global<Message>(addr)`: Read a resource from storage

**Common Patterns You'll See:**

```move
// 1. Reference parameters (no ownership transfer)
fun read_only(item: &Item) { }

// 2. Mutable reference (can modify)
fun modify(item: &mut Item) { }

// 3. Value parameter (takes ownership)
fun consume(item: Item) { }

// 4. Generic types
fun process<T: copy + drop>(value: T) { }
```

---

## Activity / Exercise

### Exercise 1: Create Your First Move Struct

**Objective**: Understand basic struct definition and abilities.

**Scenario**: You're building a simple blotter system for the barangay. Create a struct to represent a blotter entry.

**Boilerplate Code:**

```move
module 0x1::blotter_logger {
    use std::string::String;

    // TODO: Define a BlotterEntry struct with the following:
    // - id: u64
    // - reporter: address
    // - description: String
    // - timestamp: u64
    // Give it the 'key' and 'store' abilities

    struct BlotterEntry {
        // Your code here
    }
}
```

**Your Task:**
Complete the `BlotterEntry` struct definition with proper fields and abilities.

---

### Exercise 2: Create a Resource Storage Function

**Objective**: Learn how to store resources in global storage.

**Scenario**: Create a function that stores a blotter entry for a user.

**Boilerplate Code:**

```move
module 0x1::blotter_logger {
    use std::string::String;
    use std::signer;

    struct BlotterEntry has key {
        id: u64,
        reporter: address,
        description: String,
        timestamp: u64
    }

    // TODO: Create a public function 'log_entry' that:
    // - Takes a signer reference, id, description, and timestamp
    // - Creates a BlotterEntry
    // - Stores it using move_to

    public fun log_entry(
        // Your parameters here
    ) {
        // Your code here
    }
}
```

**Your Task:**
Complete the `log_entry` function to create and store a blotter entry.

---

### Exercise 3: Read a Resource from Storage

**Objective**: Learn how to read resources from global storage.

**Scenario**: Create a function to retrieve a blotter entry's description.

**Boilerplate Code:**

```move
module 0x1::blotter_logger {
    use std::string::String;
    use std::signer;

    struct BlotterEntry has key {
        id: u64,
        reporter: address,
        description: String,
        timestamp: u64
    }

    // TODO: Create a public function 'get_description' that:
    // - Takes an address
    // - Borrows the BlotterEntry from global storage
    // - Returns a copy of the description
    // - Declares it acquires BlotterEntry

    public fun get_description(
        // Your parameters here
    ) {
        // Your code here
    }
}
```

**Your Task:**
Complete the `get_description` function to read a blotter entry's description.

---

## Answers and Explanation

### Exercise 1 Answer: Create Your First Move Struct

**Complete Solution:**

```move
module 0x1::blotter_logger {
    use std::string::String;

    struct BlotterEntry has key, store {
        id: u64,
        reporter: address,
        description: String,
        timestamp: u64
    }
}
```

**Explanation:**

1. **Field Definitions:**

   - `id: u64`: A 64-bit unsigned integer for the entry ID
   - `reporter: address`: The blockchain address of the person reporting
   - `description: String`: The description of the incident (using Move's String type)
   - `timestamp: u64`: Unix timestamp of when the entry was created

2. **Abilities Explained:**

   - `key`: Allows this struct to be stored in global storage as a top-level resource
   - `store`: Allows this struct to be stored inside other structs

   Without `key`, you couldn't use `move_to()` to store it globally. Without `store`, you couldn't nest it inside other structs.

3. **Why These Types?:**
   - `u64` is Move's standard integer type for IDs and timestamps
   - `address` is Move's built-in type for blockchain addresses
   - `String` from the standard library handles text data safely

---

### Exercise 2 Answer: Create a Resource Storage Function

**Complete Solution:**

```move
module 0x1::blotter_logger {
    use std::string::String;
    use std::signer;

    struct BlotterEntry has key {
        id: u64,
        reporter: address,
        description: String,
        timestamp: u64
    }

    public fun log_entry(
        account: &signer,
        id: u64,
        description: String,
        timestamp: u64
    ) {
        let reporter_addr = signer::address_of(account);

        let entry = BlotterEntry {
            id,
            reporter: reporter_addr,
            description,
            timestamp
        };

        move_to(account, entry);
    }
}
```

**Explanation:**

1. **Function Signature:**
   - `account: &signer`: A reference to the signer (the person calling this function). We don't take ownership, just borrow it.
   - Other parameters: The data needed to create the entry
2. **Getting the Reporter Address:**

   ```move
   let reporter_addr = signer::address_of(account);
   ```

   - `signer::address_of()` extracts the address from a signer reference
   - This ensures the reporter is the actual caller

3. **Creating the Struct:**

   ```move
   let entry = BlotterEntry {
       id,
       reporter: reporter_addr,
       description,
       timestamp
   };
   ```

   - Use shorthand syntax: `id` is the same as `id: id`
   - This creates the struct instance

4. **Storing in Global Storage:**
   ```move
   move_to(account, entry);
   ```
   - `move_to()` stores the resource at the signer's address
   - The resource is "moved" (ownership transferred) into global storage
   - Each address can only have ONE instance of each resource type

**Important Note:** This function can only be called once per account! If called again, it will fail because a `BlotterEntry` already exists at that address. In a real application, you'd use a different pattern (like a collection) for multiple entries.

---

### Exercise 3 Answer: Read a Resource from Storage

**Complete Solution:**

```move
module 0x1::blotter_logger {
    use std::string::String;
    use std::signer;

    struct BlotterEntry has key {
        id: u64,
        reporter: address,
        description: String,
        timestamp: u64
    }

    public fun get_description(addr: address): String acquires BlotterEntry {
        let entry = borrow_global<BlotterEntry>(addr);
        *&entry.description
    }
}
```

**Explanation:**

1. **Function Signature:**

   ```move
   public fun get_description(addr: address): String acquires BlotterEntry
   ```

   - Takes an `address` to look up
   - Returns a `String`
   - `acquires BlotterEntry`: This is REQUIRED! It tells Move this function reads `BlotterEntry` from global storage

2. **Borrowing from Global Storage:**

   ```move
   let entry = borrow_global<BlotterEntry>(addr);
   ```

   - `borrow_global<T>()` gets an immutable reference to a resource
   - The `<BlotterEntry>` is a type parameter telling it what to look for
   - Returns `&BlotterEntry` (a reference, not the actual resource)

3. **Returning the Description:**
   ```move
   *&entry.description
   ```
   - `entry.description` accesses the field (gives us `&String`)
   - `*&` dereferences and re-references to return a copy
   - Since `String` doesn't have `copy` ability by default, this actually creates a proper copy for return

**Alternative (More Explicit):**

```move
public fun get_description(addr: address): String acquires BlotterEntry {
    let entry_ref = borrow_global<BlotterEntry>(addr);
    let desc_ref = &entry_ref.description;
    *desc_ref
}
```

**Why `acquires`?**
Move's borrow checker needs to know at compile time which resources a function will access. This prevents:

- Circular dependencies
- Deadlocks
- Unexpected state changes

If you forget `acquires`, your code won't compile!

---

## Unit Test

To validate these exercises, you would use the Move testing framework. Here's how you'd test each solution:

**Complete Test Module:**

```move
#[test_only]
module 0x1::blotter_logger_tests {
    use std::string;
    use std::signer;
    use 0x1::blotter_logger;

    #[test(account = @0x1)]
    public fun test_create_and_store_entry(account: &signer) {
        let description = string::utf8(b"Test incident at barangay hall");
        let id = 1;
        let timestamp = 1700000000;

        // Test Exercise 2: Log an entry
        blotter_logger::log_entry(
            account,
            id,
            description,
            timestamp
        );

        // Test Exercise 3: Read the entry
        let addr = signer::address_of(account);
        let retrieved_desc = blotter_logger::get_description(addr);

        // Verify the description matches
        assert!(retrieved_desc == string::utf8(b"Test incident at barangay hall"), 0);
    }

    #[test(account = @0x1)]
    #[expected_failure(abort_code = 0x80001)] // RESOURCE_ALREADY_EXISTS
    public fun test_cannot_store_twice(account: &signer) {
        let desc1 = string::utf8(b"First entry");
        let desc2 = string::utf8(b"Second entry");

        // First call should succeed
        blotter_logger::log_entry(account, 1, desc1, 1700000000);

        // Second call should fail - can only store one resource per address
        blotter_logger::log_entry(account, 2, desc2, 1700000001);
    }

    #[test]
    #[expected_failure(abort_code = 0x80002)] // RESOURCE_DOES_NOT_EXIST
    public fun test_reading_nonexistent_entry() {
        // Try to read from an address that has no entry
        let _ = blotter_logger::get_description(@0xBEEF);
    }
}
```

**Test Explanation:**

1. **Test Module Declaration:**

   ```move
   #[test_only]
   ```

   - This module only exists during testing, not in production

2. **Test Function Attributes:**

   ```move
   #[test(account = @0x1)]
   ```

   - `#[test]`: Marks this as a test function
   - `(account = @0x1)`: Creates a test signer at address 0x1

3. **Test 1: Happy Path**

   - Creates a blotter entry
   - Retrieves it
   - Verifies the data matches

4. **Test 2: Error Case - Duplicate Resource**

   ```move
   #[expected_failure(abort_code = 0x80001)]
   ```

   - Tests that storing a second entry fails
   - `0x80001` is Move's error code for "resource already exists"

5. **Test 3: Error Case - Missing Resource**
   ```move
   #[expected_failure(abort_code = 0x80002)]
   ```
   - Tests that reading a non-existent entry fails
   - `0x80002` is Move's error code for "resource does not exist"

**Running the Tests:**

```bash
# In your Move project directory
aptos move test

# Run with verbose output
aptos move test --verbose

# Run specific test
aptos move test --filter test_create_and_store_entry
```

**Expected Output:**

```
Running Move unit tests
[ PASS    ] 0x1::blotter_logger_tests::test_create_and_store_entry
[ PASS    ] 0x1::blotter_logger_tests::test_cannot_store_twice
[ PASS    ] 0x1::blotter_logger_tests::test_reading_nonexistent_entry
Test result: OK. Total tests: 3; passed: 3; failed: 0
```

---

## Closing Story

As the sun sets through the archive windows, Odessa closes her notebook with a satisfied smile. Her first Move module—a simple blotter logger—sits complete before her.

"Not bad for a first day," Elder Makoto says, appearing behind her. "You've learned the foundation: resources, abilities, global storage. But this is just the beginning."

He gestures to the vast library around them. "Resources are Move's superpower, but they're also its greatest challenge. You see, that blotter logger of yours—it can only store ONE entry per address. What happens when Barangay Captain Torres needs to log hundreds of incidents?"

Odessa's eyes widen. "I'd need a collection... like an array or map?"

"Exactly!" Makoto grins. "In your next lesson, we'll explore **Tables**—Move's answer to mappings. You'll learn how to store unlimited entries, how to update them, and how to delete them safely. We'll also dive into **references**—the art of borrowing without owning."

He hands her a new scroll. "Take this home. Study the patterns. Tomorrow, we level up your blotter logger into a real system."

As Odessa walks out into the evening, she feels the weight of the scroll—and the weight of possibility. She's no longer just a Solidity developer. She's becoming a Move practitioner.

The journey has only just begun.

---

**Next Lesson Preview: "Collections and References"**

- Move Tables and vectors
- Mutable vs immutable references
- Building a multi-entry blotter system
- Advanced resource patterns
- Error handling in Move

**Prepare yourself by:**

- Reviewing today's exercises
- Thinking about how you'd store multiple entries
- Experimenting with the test code
- Asking questions in the guild forums

_See you at the next chapter, developer! 🚀_
