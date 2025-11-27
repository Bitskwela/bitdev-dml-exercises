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
      // @note Request account access, create Web3Provider and signer,
      // then instantiate the BridgeSimulator contract

      // TODO: Task 2 - Call lockTokens() with ETH value
      // @note Send a payable transaction with the ETH amount converted to wei

      // TODO: Task 3 - Parse Locked event and invoke callback
      // @note Extract lock ID from receipt events and call onLocked callback
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

Request account access from MetaMask, create a `Web3Provider` and signer, then instantiate the BridgeSimulator contract using the contract address from environment variables.

```js
await window.ethereum.request({ method: "eth_requestAccounts" });
const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
const bridge = new ethers.Contract(
  process.env.REACT_APP_BRIDGE_ADDR,
  ABI,
  signer
);
```

---

### Task 2: Call lockTokens() with ETH Value

Send a payable transaction to `lockTokens()` by including a `value` field in the transaction options. Use `parseEther()` to convert the user's string input to wei. Then wait for the transaction to be mined using `tx.wait()`.

```js
const tx = await bridge.lockTokens({
  value: ethers.utils.parseEther(amt),
});
const receipt = await tx.wait();
```

---

### Task 3: Parse Locked Event and Invoke Callback

Find the `Locked` event in the transaction receipt's events array. Extract the lock ID from the event arguments (converting from BigNumber to number). Call the `onLocked` callback with the ID and amount, then reset the UI state.

```js
const evt = receipt.events.find((e) => e.event === "Locked");
const id = evt.args.id.toNumber();
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

- `receipt`: The transaction receipt returned by `tx.wait()`. Contains the `events` array with all events emitted during the transaction.

- `evt`: The specific `Locked` event found in the receipt. Contains `args` with the event parameters: `user`, `amount`, and `id`.

**Key Functions:**

- `doLock()`:
  The main async function executed when the user confirms the lock. First connects to MetaMask and creates the contract instance. Sends a payable transaction to `lockTokens()` with the ETH value. Waits for confirmation, parses the emitted event, and invokes the parent callback. Handles errors by displaying messages and resetting state.

- `ethers.utils.parseEther(amt)`:
  Converts a human-readable ETH string (e.g., "0.5") to wei as a BigNumber. Essential for payable transactions since Solidity works with wei internally. 1 ETH = 10^18 wei.

- `tx.wait()`:
  Returns a Promise that resolves to the transaction receipt once the transaction is mined. The receipt contains events, gas used, block number, and confirmation status.

- `receipt.events.find(e => e.event === "Locked")`:
  Searches the events array for the specific event by name. Returns the event object containing `args` with all indexed and non-indexed parameters.

- `onLocked(id, amt)`:
  Callback prop passed from the parent component. Called after successful lock with the unique lock ID and amount. Allows the parent to track locked funds or update UI accordingly.
