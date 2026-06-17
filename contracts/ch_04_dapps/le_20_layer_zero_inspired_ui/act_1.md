# Lock Tokens on Bridge Simulator Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_BRIDGE_ADDR=0xYourBridgeSimulatorAddress

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
    try {
      setError("");
      setStep("Locking");

      // TODO: Task 1 - Connect to MetaMask and create contract instance
      // @note Request account access, create BrowserProvider and await the signer,
      // then instantiate the BridgeSimulator contract

      // TODO: Task 2 - Call lockTokens() with ETH value
      // @note Send a payable transaction with the ETH amount converted to wei

      // TODO: Task 3 - Parse Locked event and invoke callback
      // @note Extract lock ID by parsing receipt.logs and call onLocked callback
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      <h4>Amount to Bridge</h4>
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
      {step === "Locking" && <p>⏳ Locking on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: Payable transactions, `parseEther()`, UI state management, Confirmation modals, Event parsing from receipts, Callback patterns

---

### Task 1: Connect to MetaMask and Create Contract Instance

Request account access from MetaMask, create a `BrowserProvider` and `await` the signer (in ethers v6 `getSigner()` is asynchronous), then instantiate the BridgeSimulator contract using the contract address from environment variables.

```js
await window.ethereum.request({ method: "eth_requestAccounts" });
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const bridge = new ethers.Contract(
  process.env.REACT_APP_BRIDGE_ADDR,
  ABI,
  signer,
);
```

---

### Task 2: Call lockTokens() with ETH Value

Send a payable transaction to `lockTokens()` by including a `value` field in the transaction options. Use `parseEther()` to convert the user's string input to wei — in ethers v6 it's the top-level `ethers.parseEther`, not `ethers.utils.parseEther`. Then wait for the transaction to be mined using `tx.wait()`.

```js
const tx = await bridge.lockTokens({
  value: ethers.parseEther(amt),
});
const receipt = await tx.wait();
```

---

### Task 3: Parse Locked Event and Invoke Callback

In ethers v6 the receipt no longer has a parsed `events` array — instead you decode the raw `receipt.logs` yourself with the contract's `interface.parseLog(log)`. Find the `Locked` event, extract the lock ID from the event arguments (a `bigint` in v6, converted with `Number(...)`), call the `onLocked` callback with the ID and amount, then reset the UI state.

```js
let id;
for (const log of receipt.logs) {
  try {
    const parsed = bridge.interface.parseLog(log);
    if (parsed && parsed.name === "Locked") {
      id = Number(parsed.args.id);
      break;
    }
  } catch {
    // Not one of this contract's events — skip it.
  }
}
onLocked(id, amt);
setStep("Idle");
```

---

## Breakdown of the Activity

**Variables Defined:**

- `amt`: State variable storing the user-entered ETH amount as a string. Must be converted to wei using `parseEther()` before sending to the contract.

- `step`: UI state machine with three states: "Idle" (waiting for input), "Confirm" (showing confirmation modal), and "Locking" (transaction in progress). Controls which UI elements are displayed and disables inputs during processing.

- `error`: State variable storing any error message from failed transactions. Displayed in red below the form.

- `ABI`: The contract's Application Binary Interface containing the `lockTokens` function signature and the `Locked` event definition. The event definition is needed to parse events from the transaction receipt.

- `bridge`: The contract instance created with `ethers.Contract()`. Connected with a signer to enable payable transactions.

- `receipt`: The transaction receipt returned by `tx.wait()`. In ethers v6 it exposes a `logs` array of raw logs (the v5 pre-parsed `events` array was removed); decode each with the contract's `interface.parseLog()`.

- `parsed`: The decoded log produced by `bridge.interface.parseLog(log)`. For the `Locked` event it has `name === "Locked"` and `args` with the event parameters: `user`, `amount`, and `id`.

**Key Functions:**

- `doLock()`:
  The main async function executed when the user confirms the lock. First connects to MetaMask and creates the contract instance. Sends a payable transaction to `lockTokens()` with the ETH value. Waits for confirmation, parses the emitted event, and invokes the parent callback. Handles errors by displaying messages and resetting state.

- `ethers.parseEther(amt)`:
  Converts a human-readable ETH string (e.g., "0.5") to wei as a `bigint`. In ethers v6 it's a top-level helper (`ethers.parseEther`), not under `ethers.utils`. Essential for payable transactions since Solidity works with wei internally. 1 ETH = 10^18 wei.

- `tx.wait()`:
  Returns a Promise that resolves to the transaction receipt once the transaction is mined. The receipt contains events, gas used, block number, and confirmation status.

- `bridge.interface.parseLog(log)`:
  Decodes a single raw log from `receipt.logs` against the contract ABI. Returns an object with `name` and `args` (or throws / returns `null` for a log this ABI doesn't recognize). Loop the logs and match `parsed.name === "Locked"` to find the event — this is the ethers v6 replacement for v5's `receipt.events.find(...)`.

- `onLocked(id, amt)`:
  Callback prop passed from the parent component. Called after successful lock with the unique lock ID and amount. Allows the parent to track locked funds or update UI accordingly.

---

## Complete Solution

```js
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
    try {
      setError("");
      setStep("Locking");

      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer,
      );

      const tx = await bridge.lockTokens({
        value: ethers.parseEther(amt),
      });
      const receipt = await tx.wait();

      let id;
      for (const log of receipt.logs) {
        try {
          const parsed = bridge.interface.parseLog(log);
          if (parsed && parsed.name === "Locked") {
            id = Number(parsed.args.id);
            break;
          }
        } catch {
          // Not one of this contract's events — skip it.
        }
      }
      onLocked(id, amt);
      setStep("Idle");
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      <h4>Amount to Bridge</h4>
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
      {step === "Locking" && <p>⏳ Locking on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```
