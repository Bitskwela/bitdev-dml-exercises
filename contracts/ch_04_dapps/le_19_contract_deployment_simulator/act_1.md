# Deploy a Contract from the Browser Activity

**Goal:** deploy a compiled contract from React. Connect the wallet, build an `ethers.ContractFactory` from the artifact, deploy with a constructor argument, wait until it is mined, and report the new address.

Carlo from the Pasig coding club asked Neri at the Barangay Tech Hub: "Can I deploy without the terminal?" You will build `DeploySimulator`, a form where you type a greeting, press **Deploy**, approve in MetaMask, and get back the address of your very own `HelloWorld` contract.

## Initial Code

```js
// DeploySimulator.js - Starter Code
import React, { useState } from "react";
import { ethers } from "ethers";
import HelloWorldArtifact from "../artifacts/HelloWorld.json";

export default function DeploySimulator({ onDeployed }) {
  const [greet, setGreet] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function deploy() {
    // TODO: Task 1 - Connect the wallet and await its signer
    // TODO: Task 2 - Build a ContractFactory from the artifact's abi + bytecode
    // TODO: Task 3 - Deploy with the greeting, wait for the deployment to be
    //                mined, then hand the address to onDeployed()
  }

  return (
    <div>
      <h4>Deploy HelloWorld Contract</h4>
      {/* TODO: Task 4 - Greeting input, a Deploy button that is disabled while
          deploying or empty, and the error state */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 30 minutes**

> **What is `HelloWorldArtifact`?** When Hardhat compiles a contract, it writes a JSON **artifact** with two halves: the `abi` (the list of functions, used to encode calls and the constructor) and the `bytecode` (the compiled program that actually gets stored on-chain). The grader provides `../artifacts/HelloWorld.json` for a contract with `constructor(string)` and `function greet() view returns (string)`. **`onDeployed`** is a prop: a function from the parent that wants to know the new address.

## Tasks for Learners

Topics Covered: `ethers.BrowserProvider`, `await provider.getSigner()`, `ethers.ContractFactory`, `factory.deploy`, `waitForDeployment`, `getAddress`, button state

The numbered tasks match the `TODO` comments in the starter. Tasks 1-3 go inside `deploy()`. Task 4 is the form.

---

### Task 1: Connect the wallet and get a signer

Deploying is a **transaction**. Someone has to sign it and pay the gas, and that someone is the user's wallet. Ask for the account, wrap MetaMask in a `BrowserProvider`, and **await** its signer (in ethers v6, `getSigner()` returns a Promise).

Replace the three `TODO` lines inside `deploy()` with this `try`/`catch`/`finally`. It clears any old error, shows the loading state, and always turns loading off at the end, whether the deploy succeeds or fails:

```js
async function deploy() {
  try {
    setError("");
    setLoading(true);

    // Task 1: Connect to MetaMask and get signer
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();

    // Task 2 goes here

    // Task 3 goes here
  } catch (err) {
    setError(err.message);
  } finally {
    setLoading(false);
  }
}
```

---

### Task 2: Build a ContractFactory from the artifact

A **factory** knows how to create new copies of a contract. It needs both halves of the artifact (the ABI to encode the constructor argument, and the bytecode to deploy) plus the signer that will send the transaction.

Put this where it says `// Task 2 goes here`:

```js
// Task 2: A factory needs both halves of the artifact — the ABI to encode
// the constructor call, and the bytecode that actually gets deployed.
const factory = new ethers.ContractFactory(
  HelloWorldArtifact.abi,
  HelloWorldArtifact.bytecode,
  signer
);
```

---

### Task 3: Deploy, wait until mined, report the address

`factory.deploy(greet)` sends the deployment transaction, passing `greet` to the constructor. It returns as soon as the transaction is **sent**, not when it is **mined**. `await contract.waitForDeployment()` waits for the block. Only then is the contract really live, and `await contract.getAddress()` gives its address.

Put this where it says `// Task 3 goes here`:

```js
// Task 3: Deploy contract and wait for confirmation
const contract = await factory.deploy(greet);
// Sending the deployment is not the same as it being mined; the address
// is not usable until this resolves.
await contract.waitForDeployment();
onDeployed(await contract.getAddress());
```

---

### Task 4: The greeting input, the Deploy button, and the error

Replace the `{/* TODO: Task 4 ... */}` comment **and** the `<p>Placeholder</p>` line (keep the `<div>` and the `<h4>`) with:

```js
<input
  placeholder="Greeting message"
  value={greet}
  onChange={(e) => setGreet(e.target.value)}
/>
<button onClick={deploy} disabled={loading || !greet}>
  {loading ? "Deploying…" : "Deploy"}
</button>
{error && <p style={{ color: "red" }}>{error}</p>}
```

`disabled={loading || !greet}` blocks two mistakes: deploying with an empty greeting (a wasted transaction) and double-clicking while a deploy is already running.

---

> **Graded details: labels and wording are checked.** The grader types `Kumusta, mundo!` (and later `Mabuhay!`) into your form, clicks the control labelled **Deploy**, and checks all of these:
>
> - The Deploy control is a `<button>` whose text **contains `Deploy`**. "Deploy" and "Deploying…" both contain it. Avoid a label like "Launch", or an icon with no text.
> - Before anything is typed, that button is **disabled**.
> - The greeting field is the **first `<input>`** with an `onChange`, because that is where the grader types.
> - It calls `window.ethereum.request({ method: "eth_requestAccounts" })` and `provider.getSigner()`.
> - It creates `new ethers.ContractFactory(abi, bytecode, signer)` with **all three** arguments.
> - It calls `factory.deploy(...)` with exactly the typed greeting as its first argument.
> - It awaits `contract.waitForDeployment()`.
> - It calls `onDeployed` with the deployed address (the grader's fake chain deploys to `0xde910eD910Ed910ED910eD910Ed910ed910Ed910`).
>
> A plain `onClick` on the button (as above) passes. So does a `<form onSubmit>` wrapping the input, with a `<button type="submit">Deploy</button>`. In a real browser, that submit handler must call `e.preventDefault()`, or the page reloads mid-deploy.

## Common mistakes

| Mistake | What happens | Fix |
| ------- | ------------ | --- |
| `new ethers.providers.Web3Provider(...)` <!-- v5-ok --> | `TypeError` in ethers v6 <!-- v5-ok --> | `new ethers.BrowserProvider(window.ethereum)` |
| `const signer = provider.getSigner();` with no `await` | `signer` is a Promise, and the factory fails | `await provider.getSigner()` |
| `await contract.deployed()` <!-- v5-ok --> | `deployed is not a function`: that is v5 <!-- v5-ok --> | `await contract.waitForDeployment()` |
| `onDeployed(contract.address)` <!-- v5-ok --> | `undefined`: v6 contracts have no `.address` <!-- v5-ok --> | `await contract.getAddress()` (or `contract.target`) |
| `new ethers.ContractFactory(abi, signer)` | Nothing to deploy, because the bytecode is missing | Pass `abi, bytecode, signer` |
| Button not disabled when empty | Fails the first check | `disabled={loading \|\| !greet}` |

## Breakdown of the Activity

- **`BrowserProvider` + `await getSigner()`**: the wallet that signs and pays for the deployment.
- **`ContractFactory(abi, bytecode, signer)`**: a deployer for one contract type.
- **`factory.deploy(...args)`**: sends a transaction with `to: null` and `data = bytecode + encoded constructor args`. Its arguments go to the constructor.
- **`waitForDeployment()`**: resolves once that transaction is mined and the code exists at the new address.
- **`getAddress()`**: the new contract's address, which `onDeployed` hands to the parent.
- **`try / catch / finally`**: a rejected signature or a failed deploy shows up as `error`, and `loading` always resets.
