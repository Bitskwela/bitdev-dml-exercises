## 🧑‍💻 Background Story

![Contract Deployment Simulator](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+19.0+-+COVER.png)

At a Barangay Tech Hub in Quezon City, Neri had prepared a live-coding workshop: "Today, you'll deploy your first smart contract, from the browser!" Odessa ("Det") had everyone switch MetaMask to **Sepolia** and grab free test ETH from a faucet. She opened a page called "Deploy Simulator", typed a greeting, hit **Deploy**, approved in MetaMask, and a few seconds later a brand-new contract address flashed on screen.

![MetaMask Confirm Deployment](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+19.1.png)

The room buzzed. "Ang dali pala!" said Carlo, a senior-high coding club member from Pasig. Det smiled: "No backend, no terminal. Just React, ethers and your wallet." Each learner's contract stored their own greeting. Anyone could call `greet()` on it and read the message back, and anyone could look the address up on a Sepolia block explorer.

By lunchtime the class had deployed over 30 copies of `HelloWorld`. "Simulator" was only the page's name. The deployments were real Sepolia transactions, paid with test ETH, and the thrill was genuine. 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

- What a compiled **artifact** is (ABI + bytecode), and why deployment needs both halves.
- How `ethers.ContractFactory` deploys a contract with constructor arguments in ethers v6.
- The difference between a deployment being **sent** and being **mined** (`waitForDeployment`).
- How to read the new address, the deployment transaction hash, and estimate gas with `bigint` math.

**Activity:** build `DeploySimulator`. It takes a greeting input and a **Deploy** button that stays disabled until there is a greeting, deploys `HelloWorld` with it, waits until it is mined, and hands the address to `onDeployed`.

---

### 📐 Deployment flow

```
 Greeting: "Kumusta, mundo!"  [Deploy]
        │
        ▼
 new ethers.ContractFactory(abi, bytecode, signer)
        │  factory.deploy("Kumusta, mundo!")
        ▼
 MetaMask: "Contract deployment" — approve ✅        ← transaction SENT
        │  contract.deploymentTransaction().hash
        ▼
 await contract.waitForDeployment()                  ← transaction MINED
        │
        ▼
 await contract.getAddress()  →  0xNewContract…  →  onDeployed(address)
```

---

### 🔑 Key Concepts

#### 1. The contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloWorld {
    string private greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greet() external view returns (string memory) {
        return greeting;
    }
}
```

The constructor runs **once**, during deployment, and stores the greeting. Its ABI is exactly what the activity's artifact describes: `constructor(string)` and `function greet() view returns (string)`.

#### 2. The artifact: two halves

Compiling with Hardhat (`npx hardhat compile`) writes `artifacts/contracts/HelloWorld.sol/HelloWorld.json`. The two fields you need are:

| Field | What it is | Used for |
| ----- | ---------- | -------- |
| `abi` | The interface: functions, events, constructor inputs | Encoding the constructor argument, and calling `greet()` later |
| `bytecode` | The compiled program, `0x6080…` | The code the deployment actually puts on-chain |

The ABI alone deploys nothing, and the bytecode alone can't encode `"Kumusta, mundo!"` into the constructor call. A factory needs both, **plus a signer** to send and pay for the transaction.

#### 3. Deploying with ethers v6

```javascript
import { ethers } from "ethers";

const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();              // v6: async

const factory = new ethers.ContractFactory(abi, bytecode, signer);

const contract = await factory.deploy("Kumusta, mundo!"); // SENT, not yet mined
console.log("tx hash:", contract.deploymentTransaction().hash);

await contract.waitForDeployment();                       // MINED
const address = await contract.getAddress();              // also: contract.target
console.log("Deployed to:", address);
console.log(await contract.greet());                      // "Kumusta, mundo!"
```

These calls were run against a local Hardhat chain with ethers 6.13.4: the deployment printed a hash immediately, `waitForDeployment()` resolved once it was mined, and `greet()` returned the constructor's greeting. The v5 names `contract.deployed()`, `contract.address` and `contract.deployTransaction` <!-- v5-ok --> are all `undefined` in v6.

#### 4. What a deployment transaction looks like

```
{
  from: "0xYourWallet…",        // the signer, who pays the gas
  to:   null,                   // no recipient: null means "create a contract"
  data: "0x6080…" + encoded("Kumusta, mundo!"),   // bytecode + constructor args
  value: 0n,
  gasLimit, maxFeePerGas, maxPriorityFeePerGas    // filled in by ethers/MetaMask
}

receipt.contractAddress  →  the new contract's address
```

The new address is not random. It is computed from the deployer's address and their **nonce** (their transaction count), so the same wallet never gets the same address twice.

#### 5. Estimating gas (bigint math)

```javascript
const deployTx = await factory.getDeployTransaction("Kumusta, mundo!"); // v6: async
const estimated = await signer.estimateGas(deployTx);                   // a bigint
const gasLimit = (estimated * 120n) / 100n;                             // +20% buffer

const contract = await factory.deploy("Kumusta, mundo!", { gasLimit });  // overrides go last
```

In ethers v6, gas amounts are native `bigint`s, so you use `*` and `/` with `n`-suffixed literals instead of method calls. On a local Hardhat chain this `HelloWorld` deployment estimated about **215,000 gas**. Deployment costs much more than a normal call, because every byte of code is stored forever.

---

### 🏗️ Growing the simulator (beyond the activity)

Once the basic deploy works, Det's workshop page added a result panel, the tx hash while pending, and a history list:

```javascript
const [history, setHistory] = useState([]);
const [pendingHash, setPendingHash] = useState("");

async function deployAndRecord(greeting) {
  const contract = await factory.deploy(greeting);
  setPendingHash(contract.deploymentTransaction().hash);   // show while mining
  await contract.waitForDeployment();
  const address = await contract.getAddress();
  setHistory((prev) => [...prev, { address, greeting, at: new Date().toISOString() }]);
  setPendingHash("");
}
```

To tell a "Reject" click apart from a real failure, use `ethers.isError(err, "ACTION_REJECTED")` in the `catch`.

---

### 📊 Deployment vs contract call

| Aspect | Deployment | Contract call (write) |
| ------ | ---------- | --------------------- |
| `to` | `null` | The contract's address |
| `data` | Bytecode + constructor args | Function selector + args |
| Creates | A new contract | A state change |
| Gas | High (code is stored) | Lower |
| Result | `receipt.contractAddress` | Return value / events |

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
| ------- | ------- | -------- |
| Using the address right after `deploy()` | The contract isn't mined yet | `await contract.waitForDeployment()` |
| Forgetting `await` on `getSigner()` | The factory gets a Promise, not a signer | `const signer = await provider.getSigner()` |
| Missing bytecode in the factory | Nothing to deploy | `new ContractFactory(abi, bytecode, signer)` |
| Wrong constructor args | Encoding error or revert | Match the Solidity constructor exactly |
| `estimated.mul(120)` <!-- v5-ok --> | Not a function on `bigint` | `(estimated * 120n) / 100n` |
| Deploying on the wrong network | The contract lands on a chain you didn't mean | Check the chain id first (lesson 17) |
| Empty greeting allowed | Wasted gas on a useless contract | Disable the button until there is input |

---

### 🧪 How this is graded

The grader mounts `DeploySimulator` with a fake Sepolia wallet and a stub `HelloWorld` artifact. It types a greeting and clicks the button labelled **Deploy**, then checks that the button was disabled while empty, that you requested accounts and awaited a signer, built the factory with abi + bytecode + signer, passed the greeting to `deploy`, awaited `waitForDeployment()`, and called `onDeployed` with the deployed address.

---

### 🔗 External Resources

| Resource | Link |
| -------- | ---- |
| ethers v6: ContractFactory | https://docs.ethers.org/v6/api/contract/#ContractFactory |
| ethers v6: BaseContract (waitForDeployment, getAddress) | https://docs.ethers.org/v6/api/contract/#BaseContract |
| Hardhat 2: compiling contracts | https://v2.hardhat.org/hardhat-runner/docs/guides/compile-contracts |
| ethereum.org: deploying contracts | https://ethereum.org/en/developers/docs/smart-contracts/deploying/ |

---

## 🌟 Closing Story

By the end of the workshop, every learner had their own `HelloWorld` address in the **Deploy History** panel, and Carlo had already called `greet()` on his classmates' contracts to read their messages. Neri and Odessa handed out stickers: "I Deployed with React & ethers." For many, it was the spark that started a Web3 journey. Next up: pasting in any artifact and building the constructor form automatically from its ABI. Filipino dev power, deploying the future one click at a time. 🇵🇭🔥
