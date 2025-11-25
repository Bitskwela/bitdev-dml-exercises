## 🧑‍💻 Background Story

At a Barangay Tech Hub in Quezon City, Neri had prepared a live-coding workshop: "Today, you'll deploy your first smart contract—from the browser!" Odessa ("Det") set up a local Hardhat node and invited learners to connect MetaMask to `http://127.0.0.1:8545`. She clicked "Deploy Simulator," pasted a simple ABI/Bytecode artifact, hit **Deploy**, and in seconds a new contract address flashed on screen.

The room buzzed. "Ang dali pala!" said Carlo, a senior high coding club member from Pasig. Odessa smiled: "No backend, no Truffle CLI—just your React app and Ethers.js." Next, she opened **Deploy History**, a panel that logged each address and timestamp. Learners saw their contracts accumulate like trophies.

By lunchtime, the class had deployed over 30 instances of `HelloWorld.sol`, each storing a custom greeting. Neri and Odessa high-fived: from pure beginners to "real" blockchain devs in under 30 minutes. "Simulated," yes—but the thrill was genuine. Filipino ingenuity turned a sandbox into a production-like pipeline, one click at a time. 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **contract deployment simulator** that allows users to deploy smart contracts directly from the browser. This demystifies the deployment process and teaches the fundamentals of `ContractFactory`, gas estimation, and transaction lifecycles.

---

### 📐 Deployment Simulator Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                  DEPLOYMENT SIMULATOR FLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    USER INPUT                            │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ ABI: [{ "inputs": [...], "name": "greet", ... }] │    │   │
│   │  │ Bytecode: 0x608060405234801561001057600080...    │    │   │
│   │  │ Constructor Args: ["Hello World!"]               │    │   │
│   │  │                                                  │    │   │
│   │  │ [Deploy Contract]                                │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                                ▼                                │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                 ContractFactory                          │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ const factory = new ContractFactory(             │    │   │
│   │  │     abi,                                         │    │   │
│   │  │     bytecode,                                    │    │   │
│   │  │     signer                                       │    │   │
│   │  │ );                                               │    │   │
│   │  │                                                  │    │   │
│   │  │ const contract = await factory.deploy(...args);  │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                                ▼                                │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    MetaMask                              │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ [Confirm Transaction]                            │    │   │
│   │  │ Deploy Contract                                  │    │   │
│   │  │ Gas: ~150,000                                    │    │   │
│   │  │ [Confirm] [Reject]                               │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                                ▼                                │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                 BLOCKCHAIN                               │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ ✅ Contract Deployed!                            │    │   │
│   │  │ Address: 0x1234...ABCD                           │    │   │
│   │  │ Block: #12345678                                 │    │   │
│   │  │ Gas Used: 145,230                                │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. What is ContractFactory?

| Component | Purpose |
|-----------|---------|
| **ABI** | Interface definition (function signatures) |
| **Bytecode** | Compiled contract code to deploy |
| **Signer** | Account that pays gas and becomes deployer |
| **deploy()** | Creates transaction to deploy contract |

```javascript
import { ethers } from "ethers";

// Create factory from ABI and bytecode
const factory = new ethers.ContractFactory(
    contractABI,    // Array of function/event definitions
    contractBytecode, // "0x608060..." compiled code
    signer          // Connected wallet
);

// Deploy with constructor arguments
const contract = await factory.deploy("Hello!", 42);

// Wait for mining
await contract.deployed();

// Now you have the address
console.log("Deployed to:", contract.address);
```

#### 2. Deployment Transaction Anatomy

```
┌─────────────────────────────────────────────────────────────────┐
│                  DEPLOYMENT TRANSACTION                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   {                                                             │
│     from: "0xYourWallet...",     // Deployer address            │
│     to: null,                     // null = contract creation   │
│     data: "0x608060...",         // Bytecode + constructor args │
│     value: "0x0",                // ETH to send (usually 0)     │
│     gasLimit: 150000,            // Max gas willing to pay      │
│     gasPrice: "20000000000"      // 20 gwei                     │
│   }                                                             │
│                                                                 │
│   Result:                                                       │
│   ├── Transaction Hash: 0xabc123...                             │
│   ├── Contract Address: 0xNewContract...                        │
│   ├── Block Number: 12345678                                    │
│   └── Gas Used: 145,230                                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### 3. Gas Estimation

```javascript
// Estimate gas before deploying
const deployTx = factory.getDeployTransaction("Hello!", 42);
const estimatedGas = await signer.estimateGas(deployTx);

console.log("Estimated gas:", estimatedGas.toString());

// Add 20% buffer for safety
const gasLimit = estimatedGas.mul(120).div(100);
```

#### 4. Example: HelloWorld Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    string public greeting;
    
    event GreetingUpdated(string oldGreeting, string newGreeting);
    
    constructor(string memory _greeting) {
        greeting = _greeting;
    }
    
    function setGreeting(string memory _greeting) external {
        string memory old = greeting;
        greeting = _greeting;
        emit GreetingUpdated(old, _greeting);
    }
}
```

Compile with Hardhat to get ABI + Bytecode:
```bash
npx hardhat compile
# Artifacts in artifacts/contracts/HelloWorld.sol/HelloWorld.json
```

---

### 🏗️ React Component Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEPLOY SIMULATOR COMPONENTS                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    DeployApp                             │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: constructorArgs, deploying, deployedAddr, │    │   │
│   │  │        history, error                            │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │  Deploy │      │  Deployed   │     │   Deploy    │         │
│   │  Form   │      │   Result    │     │   History   │         │
│   │         │      │             │     │             │         │
│   │ Greeting│      │ ✅ Success! │     │ #1: 0xABC  │         │
│   │ [_____] │      │ 0x1234...   │     │ #2: 0xDEF  │         │
│   │         │      │             │     │ #3: 0x789  │         │
│   │[Deploy] │      │[Copy Addr]  │     │             │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Complete Deployment Implementation

```javascript
import { useState } from "react";
import { ethers } from "ethers";

// Pre-loaded HelloWorld ABI and bytecode
import HelloWorldArtifact from "./artifacts/HelloWorld.json";

function DeploySimulator() {
    const [greeting, setGreeting] = useState("");
    const [deploying, setDeploying] = useState(false);
    const [deployedAddress, setDeployedAddress] = useState(null);
    const [history, setHistory] = useState([]);
    const [error, setError] = useState(null);

    const deployContract = async () => {
        if (!greeting.trim()) {
            setError("Please enter a greeting message");
            return;
        }

        setDeploying(true);
        setError(null);
        setDeployedAddress(null);

        try {
            // Check for MetaMask
            if (!window.ethereum) {
                throw new Error("MetaMask not detected");
            }

            // Request account access
            await window.ethereum.request({ 
                method: "eth_requestAccounts" 
            });

            // Setup provider and signer
            const provider = new ethers.providers.Web3Provider(
                window.ethereum
            );
            const signer = provider.getSigner();

            // Create factory
            const factory = new ethers.ContractFactory(
                HelloWorldArtifact.abi,
                HelloWorldArtifact.bytecode,
                signer
            );

            // Deploy with constructor argument
            console.log("Deploying with greeting:", greeting);
            const contract = await factory.deploy(greeting);

            console.log("Waiting for confirmation...");
            console.log("Tx hash:", contract.deployTransaction.hash);

            // Wait for deployment
            await contract.deployed();

            console.log("Deployed to:", contract.address);
            setDeployedAddress(contract.address);

            // Add to history
            setHistory(prev => [
                ...prev,
                {
                    address: contract.address,
                    greeting: greeting,
                    timestamp: new Date().toISOString()
                }
            ]);

        } catch (err) {
            console.error("Deployment error:", err);
            if (err.code === 4001) {
                setError("Transaction rejected by user");
            } else {
                setError(err.message);
            }
        } finally {
            setDeploying(false);
        }
    };

    return (
        <div>
            <h2>Deploy HelloWorld Contract</h2>
            
            <div>
                <input
                    type="text"
                    placeholder="Greeting message"
                    value={greeting}
                    onChange={(e) => setGreeting(e.target.value)}
                    disabled={deploying}
                />
                <button 
                    onClick={deployContract}
                    disabled={deploying || !greeting.trim()}
                >
                    {deploying ? "Deploying..." : "Deploy"}
                </button>
            </div>

            {error && <p style={{ color: "red" }}>{error}</p>}

            {deployedAddress && (
                <div>
                    <h3>✅ Deployed Successfully!</h3>
                    <p>Address: {deployedAddress}</p>
                    <button onClick={() => 
                        navigator.clipboard.writeText(deployedAddress)
                    }>
                        Copy Address
                    </button>
                </div>
            )}

            {history.length > 0 && (
                <div>
                    <h3>Deployment History</h3>
                    <ul>
                        {history.map((item, i) => (
                            <li key={i}>
                                #{i + 1}: {item.address.slice(0, 10)}...
                                ({item.greeting})
                            </li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    );
}
```

---

### 📊 Deployment vs Contract Call Comparison

| Aspect | Deployment | Contract Call |
|--------|------------|---------------|
| **to** field | `null` | Contract address |
| **data** field | Bytecode + args | Encoded function call |
| **Creates** | New contract | State change or read |
| **Gas** | Higher (code storage) | Lower (execution only) |
| **Result** | New address | Return value or tx |

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Missing bytecode | Factory fails | Check artifact file |
| Wrong constructor args | Deployment reverts | Match Solidity constructor |
| Not awaiting `deployed()` | Address undefined | Always `await contract.deployed()` |
| Insufficient gas | Transaction fails | Use gas estimation |
| Wrong network | Contract on wrong chain | Verify chain ID first |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Deploy button disabled without input
- [ ] Loading state shows during deployment
- [ ] Transaction hash visible while pending
- [ ] Contract address displays after success
- [ ] Copy address button works
- [ ] Deployment history persists in state
- [ ] Error handling for user rejection
- [ ] Error handling for insufficient funds
- [ ] Deployed contract callable

---

### 🔗 External Resources

| Resource | Link |
|----------|------|
| Ethers ContractFactory | https://docs.ethers.org/v5/api/contract/contract-factory/ |
| Hardhat Compilation | https://hardhat.org/hardhat-runner/docs/guides/compile-contracts |
| Gas Estimation | https://docs.ethers.org/v5/api/providers/provider/#Provider-estimateGas |
| Contract Creation | https://ethereum.org/en/developers/docs/smart-contracts/deploying/ |



---

## ✅ Test Cases

Create `__tests__/DeploySimulator.test.js`:

```js
// __tests__/DeploySimulator.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import DeploySimulator from "../DeploySimulator";
import { ethers } from "ethers";

jest.mock("ethers");

describe("DeploySimulator Component", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeFactory = { deploy: jest.fn() };
  const fakeContract = { deployed: jest.fn() };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = jest.fn().mockReturnValue(fakeSigner);
    ethers.ContractFactory = jest.fn().mockImplementation(() => fakeFactory);
  });

  it("deploys contract and calls onDeployed", async () => {
    const onDeployed = jest.fn();
    // Mock deploy flow
    fakeContract.address = "0xDEAD";
    fakeFactory.deploy.mockResolvedValue(fakeContract);
    fakeContract.deployed.mockResolvedValue();

    render(<DeploySimulator onDeployed={onDeployed} />);
    fireEvent.change(screen.getByPlaceholderText("Greeting message"), {
      target: { value: "Hello Test" },
    });
    fireEvent.click(screen.getByText("Deploy"));

    await waitFor(() =>
      expect(fakeFactory.deploy).toHaveBeenCalledWith("Hello Test")
    );
    await waitFor(() => expect(onDeployed).toHaveBeenCalledWith("0xDEAD"));
  });

  it("shows error when user rejects", async () => {
    fakeFactory.deploy.mockRejectedValue(new Error("User denied"));
    render(<DeploySimulator onDeployed={() => {}} />);
    fireEvent.change(screen.getByPlaceholderText("Greeting message"), {
      target: { value: "Oops" },
    });
    fireEvent.click(screen.getByText("Deploy"));
    expect(await screen.findByText("User denied")).toBeInTheDocument();
  });
});
```

Add to `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: {
    "\\.(css|scss)$": "identity-obj-proxy",
  },
};
```

---

## 🌟 Closing Story

By the end of the workshop, each learner had their own "HelloWorld" contract address listed in **Deploy History**—proof that they'd just deployed code to a blockchain, all from a pure-frontend sandbox. Neri and Odessa handed out stickers: "I Deployed with React.js & Ethers.js." For many, it was the spark that ignited a Web3 journey. Next up: front-end upgrades to support constructor overloading and live ABI imports. Filipino dev power—deploying the future, one click at a time. 🇵🇭🔥