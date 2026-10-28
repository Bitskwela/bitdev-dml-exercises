# Lock Tokens on the Bridge Activity

**Goal:** build the "lock" half of a bridge UI. It takes an amount, asks the user to confirm, sends a **payable** transaction with ETH attached, waits for the receipt, and reads the lock id out of the `Locked` event.

At the New York hackathon, Odessa and Neri's bridge demo starts with one form: "Lock 1.5 ETH on PHChain?" You will build `LockForm`, the step every bridge begins with. When the lock confirms, it hands the lock id to the parent through `onLocked`, so the other side of the bridge knows what to release.

## Initial Code

```js
// LockForm.js - Starter Code
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function lockTokens() payable returns (uint256)",
  "event Locked(address indexed user, uint256 amount, uint256 id)",
];

export default function LockForm({ onLocked }) {
  const [amt, setAmt] = useState("");
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Locking
  const [error, setError] = useState("");

  async function doLock() {
    // TODO: Task 1 - Connect the wallet, await the signer, build the contract
    // TODO: Task 2 - Call lockTokens() sending the amount as ETH value
    // TODO: Task 3 - Wait for the receipt, find the Locked event in its logs,
    //                and hand its id to onLocked()
  }

  return (
    <div>
      <h4>Amount to Bridge</h4>
      {/* TODO: Task 4 - Amount input, a Bridge button disabled on invalid input,
          a confirmation step before signing, and the locking / error states */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 40 minutes**

> **Where does the bridge address come from?** The grader supplies `process.env.REACT_APP_BRIDGE_ADDR`, the address of a `BridgeSimulator` contract on its simulated Sepolia chain. In a Vite project you would read `import.meta.env.VITE_BRIDGE_ADDR` instead. **`step`** is a tiny state machine with three values: `"Idle"` (typing), `"Confirm"` (the "are you sure?" box) and `"Locking"` (waiting for the chain).

## Tasks for Learners

Topics Covered: payable calls with `{ value }`, `ethers.parseEther`, `tx.wait()`, reading events from `receipt.logs` (ethers v6), bigint to number, a confirmation step

The numbered tasks match the `TODO` comments in the starter. Tasks 1-3 go inside `doLock()`, which runs when the user confirms. Task 4 builds the form that leads there.

---

### Task 1: Connect the wallet, get the signer, build the contract

Locking sends real value, so the user's wallet must sign. Replace the three `TODO` lines inside `doLock()` with this `try`/`catch`. It switches the UI to `"Locking"` first, and if anything fails (including the user clicking Reject in MetaMask), it shows the error and goes back to `"Idle"`:

```js
async function doLock() {
  try {
    setError("");
    setStep("Locking");

    // Task 1: Connect to MetaMask and create contract instance
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const bridge = new ethers.Contract(
      process.env.REACT_APP_BRIDGE_ADDR,
      ABI,
      signer
    );

    // Task 2 goes here

    // Task 3 goes here
  } catch (err) {
    setError(err.message);
    setStep("Idle");
  }
}
```

The contract is built with the **signer**, not the provider, because only a signer can send transactions.

---

### Task 2: Send the amount as ETH and wait for the receipt

`lockTokens()` takes **no arguments**, yet it is `payable`. The ETH does not go in the argument list. It goes in an **overrides object** as `{ value }`, the last argument of any contract call. `ethers.parseEther("1.5")` converts the typed string into wei (`1500000000000000000n`).

Put this where it says `// Task 2 goes here`:

```js
// Task 2: A payable call carries ETH in the overrides object, not as an
// argument. parseEther turns "1.5" into the wei the chain expects.
const tx = await bridge.lockTokens({
  value: ethers.parseEther(amt),
});
const receipt = await tx.wait();
```

`await bridge.lockTokens(...)` resolves when the transaction is **sent**. `await tx.wait()` resolves when it is **mined**, and returns the **receipt**.

---

### Task 3: Read the lock id from the `Locked` event

A transaction does **not** hand its `returns (uint256)` value back to your code. All you get is a receipt. (You could *simulate* the call with `bridge.lockTokens.staticCall(...)`, but that is only a prediction made before mining.) The reliable way to learn the real lock id is to read the `Locked` event that the contract emitted.

In ethers v6, a receipt has a `logs` array. Every log that this contract's ABI can decode comes back as an `EventLog`, which has a `fragment` (the event definition, including its `name`) and `args`.

Put this where it says `// Task 3 goes here`:

```js
// Task 3: In ethers v6 a receipt exposes `logs`; the ones this contract
// could decode carry a `fragment` naming the event.
const evt = receipt.logs.find((l) => l.fragment && l.fragment.name === "Locked");
const id = Number(evt.args.id);
onLocked(id, amt);
setStep("Idle");
```

`evt.args.id` is a `bigint` (`42n`). `Number(...)` turns it into `42`. The `setStep("Idle")` at the end clears the "Locking on chain…" message.

> **Other ways that also work** (and pass the grader): `receipt.logs.find((l) => l.eventName === "Locked")`, filtering with `l instanceof ethers.EventLog`, or decoding a raw log yourself with `bridge.interface.parseLog(log)`. The lecture compares them. Old tutorials use `receipt.events` <!-- v5-ok -->, which is ethers v5 and is `undefined` in v6.

---

### Task 4: The amount input, the Bridge button, and the confirmation box

Replace the `{/* TODO: Task 4 ... */}` comment **and** the `<p>Placeholder</p>` line (keep the `<div>` and the `<h4>`) with:

```js
<input
  placeholder="ETH"
  value={amt}
  onChange={(e) => setAmt(e.target.value)}
  disabled={step !== "Idle"}
/>
<button
  onClick={() => setStep("Confirm")}
  disabled={!amt || isNaN(amt) || Number(amt) <= 0 || step !== "Idle"}
>
  Bridge
</button>
{step === "Confirm" && (
  <div className="modal">
    <p>Lock {amt} ETH on PHChain?</p>
    <button onClick={doLock}>Yes, lock</button>
    <button onClick={() => setStep("Idle")}>Cancel</button>
  </div>
)}
{step === "Locking" && <p>Locking on chain…</p>}
{error && <p style={{ color: "red" }}>{error}</p>}
```

Pressing **Bridge** does not send anything. It only switches to `"Confirm"`, and only **Yes, lock** calls `doLock()`. That extra step protects people from sending ETH by accident, which matters because a bridge transfer cannot be undone.

---

> **Graded details: labels and wording are checked.** The grader types `1.5` into your form, clicks **Bridge**, then clicks **Yes**, and checks all of these:
>
> - The Bridge control is a `<button>` whose text contains **`Bridge`**, and it is **disabled** while the amount is empty.
> - The amount field is the **first `<input>`** with an `onChange`, because that is where the grader types.
> - Clicking Bridge must **not** call `lockTokens` yet, and the confirmation must show the amount (`1.5`).
> - The confirm button's text must contain **`Yes`**, as in "Yes, lock". A button labelled only "Confirm" or "OK" cannot be found, and most checks then fail. Keep "Yes" out of the Cancel button's label.
> - It calls `eth_requestAccounts` and `provider.getSigner()`.
> - `lockTokens` is called with an overrides object whose `value` is exactly `1500000000000000000` (use `ethers.parseEther`).
> - It calls `tx.wait()`.
> - `onLocked` is called with the id from the `Locked` event, which the grader sets to `42`.
> - After success, the text "Locking on chain" is gone, because `setStep("Idle")` ran.

## Common mistakes

| Mistake | What happens | Fix |
| ------- | ------------ | --- |
| `bridge.lockTokens(ethers.parseEther(amt))` | `no matching fragment`: `lockTokens` takes no arguments, so the ETH must go in `{ value }` | `bridge.lockTokens({ value: ethers.parseEther(amt) })` |
| `ethers.utils.parseEther(amt)` <!-- v5-ok --> | `TypeError` in ethers v6 <!-- v5-ok --> | `ethers.parseEther(amt)` |
| `receipt.events.find(...)` <!-- v5-ok --> | `Cannot read properties of undefined`: v6 has `receipt.logs` <!-- v5-ok --> | `receipt.logs.find((l) => l.fragment && l.fragment.name === "Locked")` |
| `evt.args.id.toNumber()` <!-- v5-ok --> | `toNumber is not a function`: it is a `bigint` <!-- v5-ok --> | `Number(evt.args.id)` |
| Confirm button labelled "Confirm" | The grader cannot find a "Yes" button | Label it `Yes, lock` |
| Bridge button calls `doLock` directly | Fails the "asks for confirmation" check | Bridge only does `setStep("Confirm")` |
| Forgetting `setStep("Idle")` after success | "Locking on chain…" stays forever | Reset the step at the end of Task 3 |

## Breakdown of the Activity

- **`step`** is the UI state machine: `Idle → Confirm → Locking → Idle`. The input and the Bridge button are disabled outside `Idle`.
- **`{ value: ethers.parseEther(amt) }`** is how a payable function receives ETH. The amount is in wei: 1 ETH = 10^18 wei.
- **`tx.wait()`** waits until the transaction is mined, and gives you the receipt.
- **`receipt.logs`** holds every event the transaction emitted. Logs the ABI recognises are `EventLog`s, with `fragment.name`, `eventName` and `args`.
- **`onLocked(id, amt)`** tells the parent which lock to watch, so the release side of the bridge knows what to release.
