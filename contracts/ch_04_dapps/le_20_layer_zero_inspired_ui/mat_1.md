## 🧑‍💻 Background Story

At a bustling LayerZero hackathon in New York City, Odessa (“Det”) teamed up with Neri to demo a **cross-chain bridge**—but they only had one local Hardhat node. No problem. Over coffee, they spun up a **BridgeSimulator** contract and built a React UI that **felt** like real cross-chain magic.

Front and center: a **Network** dropdown (“PHChain” ↔ “NYChain”), an **Amount** input, and a big **Bridge Tokens** button. Click. A confirmation modal pops: “Lock 0.05 ETH on PHChain?” Confirm → MetaMask pops → tx is sent → a loading spinner → “Locked! Lock ID #3.” Then the UI flips to **NYChain**, asks “Release 0.05 ETH on NYChain?” Confirm → MetaMask → spinner → “Success! Tokens bridged.”

Under the hood, it’s the same contract on one network, but the UX simulates two chains, network switching, relayer wait, confirmations, error handling, and loading states. By demo’s end, judges thought it was real. Filipino ingenuity had turned a sandbox into a production-grade cross-chain flow—in under 30 minutes. Mabuhay BridgeSimulator! 🇵🇭🔗🌐

---

## 📚 Theory & Web3 Lecture

1. Cross-Chain Bridge Patterns

   - **Lock & Release**: tokens locked on source chain, minted/released on destination.
   - **Relayer**: off-chain service observes lock event and calls release.
   - **UX Steps**: choose origin/destination, confirm lock, wait, confirm release.

2. BridgeSimulator Solidity Contract

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.7;

   contract BridgeSimulator {
     struct Lock { address user; uint256 amount; bool released; }
     mapping(uint256 => Lock) public locks;
     uint256 public nextId;
     event Locked(address indexed user, uint256 amount, uint256 id);
     event Released(address indexed user, uint256 amount, uint256 id);

     function lockTokens() external payable returns (uint256 id) {
       require(msg.value > 0, "Zero amount");
       id = ++nextId;
       locks[id] = Lock(msg.sender, msg.value, false);
       emit Locked(msg.sender, msg.value, id);
     }

     function releaseTokens(uint256 id) external {
       Lock storage l = locks[id];
       require(l.user == msg.sender, "Not owner");
       require(!l.released, "Already released");
       l.released = true;
       payable(l.user).transfer(l.amount);
       emit Released(msg.sender, l.amount, id);
     }

     function getLock(uint256 id)
       external view returns (address user, uint256 amount, bool released)
     {
       Lock memory l = locks[id];
       return (l.user, l.amount, l.released);
     }
   }
   ```

   - `lockTokens()`: locks ETH, emits `Locked`.
   - `releaseTokens(id)`: refunds ETH, emits `Released`.

3. Ethers.js + React Architecture

   - **Providers/Signers**:
     ```js
     const web3 = new ethers.providers.Web3Provider(window.ethereum);
     const signer = web3.getSigner();
     ```
   - **Contract Instance**:
     ```js
     const bridge = new ethers.Contract(
       process.env.REACT_APP_BRIDGE_ADDR,
       BRIDGE_ABI,
       signer
     );
     ```
   - **Calls & tx lifecycle**:
     ```js
     const tx = await bridge.lockTokens({ value: amtWei });
     await tx.wait();
     ```
   - **Network Switching**: use `wallet_switchEthereumChain` to simulate PHChain↔NYChain flows.

4. React State Machine

   - States: `Idle` → `ConfirmLock` → `Locking` → `Locked` → `ConfirmRelease` → `Releasing` → `Done`
   - Hooks: `useState` for `step`, `amount`, `lockId`, `error`, `loading`
   - `useEffect` to detect `chainChanged` and reset if user switches networks manually.
   - **Modals & UX**: confirmation modals, spinners, success notices.

5. Best Practices
   - Validate `amount > 0`.
   - Wrap all `await` calls in `try/catch`.
   - Clean up event listeners.
   - Store RPC & contract address in `.env` (e.g. `REACT_APP_RPC_URL`, `REACT_APP_BRIDGE_ADDR`).

🔗 Further Reading

- Ethers.js Contracts: https://docs.ethers.org/v5/api/contract/contract/
- MetaMask RPC Methods: https://docs.metamask.io/guide/rpc-api.html

---

## 🧪 Exercises

### Exercise 1: LockForm Component

Problem Statement  
Build `LockForm` that:

1. Lets user enter an ETH amount.
2. On **Bridge** click, shows a confirm modal.
3. Calls `lockTokens()` on `BridgeSimulator` when confirmed.
4. Emits `onLocked(id, amount)` callback.

**Starter Code (`LockForm.js`)**

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
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );
      const tx = await bridge.lockTokens({
        value: ethers.utils.parseEther(amt),
      });
      const receipt = await tx.wait();
      const evt = receipt.events.find((e) => e.event === "Locked");
      const id = evt.args.id.toNumber();
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

To Do List

- [ ] Validate input (`>0`, numeric).
- [ ] Modal for confirm step (`step==="Confirm"`).
- [ ] Call `lockTokens` with `{ value: parseEther(amt) }`.
- [ ] Extract `id` from `Locked` event and call `onLocked(id, amt)`.
- [ ] Handle loading and errors.

**Full Solution**  
_See code above in Starter with TODOs filled in._

---

### Exercise 2: ReleaseFlow Component

Problem Statement  
Create `ReleaseFlow` that accepts `lockId` & `amount`, shows a confirm modal for release on **NYChain**, and calls `releaseTokens(lockId)`.

**Starter Code (`ReleaseFlow.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function releaseTokens(uint256)",
  "event Released(address indexed user, uint256 amount, uint256 id)",
];

export default function ReleaseFlow({ lockId, amount, onDone }) {
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Releasing
  const [error, setError] = useState("");

  async function doRelease() {
    try {
      setError("");
      setStep("Releasing");
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );
      const tx = await bridge.releaseTokens(lockId);
      await tx.wait();
      onDone();
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      {step === "Idle" && (
        <button onClick={() => setStep("Confirm")}>
          Release {amount} ETH on NYChain
        </button>
      )}
      {step === "Confirm" && (
        <div className="modal">
          <p>Release {amount} ETH on NYChain?</p>
          <button onClick={doRelease}>Yes, release</button>
          <button onClick={() => setStep("Idle")}>Cancel</button>
        </div>
      )}
      {step === "Releasing" && <p>⏳ Releasing on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

To Do List

- [ ] Show **Release** button when `step==="Idle"`.
- [ ] Confirm modal and `doRelease()` on confirm.
- [ ] Call `releaseTokens(lockId)` and await receipt.
- [ ] Invoke `onDone()` on success.
- [ ] Handle loading and errors.

**Full Solution**  
_See code above in Starter with TODOs filled in._

---

### Exercise 3: BridgeApp Integration

Problem Statement  
Build `BridgeApp` that:

1. Renders `LockForm`.
2. After lock, auto-asks user to switch to NYChain (simulate via chain ID check).
3. Renders `ReleaseFlow`.
4. Shows final success message.

**Starter Code (`BridgeApp.js`)**

```js
import React, { useState, useEffect } from "react";
import LockForm from "./LockForm";
import ReleaseFlow from "./ReleaseFlow";

export default function BridgeApp() {
  const [lockId, setLockId] = useState(null);
  const [amount, setAmount] = useState("");
  const [step, setStep] = useState("Lock"); // Lock|Switch|Release|Done
  const [currentChain, setCid] = useState(null);

  // detect chain
  useEffect(() => {
    async function detect() {
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setCid(parseInt(hex, 16));
    }
    detect();
    window.ethereum.on("chainChanged", detect);
    return () => window.ethereum.removeListener("chainChanged", detect);
  }, []);

  function handleLocked(id, amt) {
    setLockId(id);
    setAmount(amt);
    setStep("Switch");
  }

  function handleReleased() {
    setStep("Done");
  }

  async function doSwitch() {
    // TODO: call wallet_switchEthereumChain to targetChainId (e.g. 0x4 for Rinkeby)
  }

  return (
    <div>
      {step === "Lock" && <LockForm onLocked={handleLocked} />}
      {step === "Switch" && (
        <div>
          <p>
            Please switch from chain {currentChain} to chain{" "}
            {process.env.REACT_APP_TARGET_CHAIN_ID}
          </p>
          <button onClick={doSwitch}>Switch Chain</button>
        </div>
      )}
      {step === "Release" && (
        <ReleaseFlow lockId={lockId} amount={amount} onDone={handleReleased} />
      )}
      {step === "Done" && (
        <p>
          ✅ Bridged {amount} ETH! Your lock ID: {lockId}
        </p>
      )}
    </div>
  );
}
```

To Do List

- [ ] On lock, move `step` to “Switch”.
- [ ] In **Switch** UI, call `wallet_switchEthereumChain` with `REACT_APP_TARGET_CHAIN_ID`.
- [ ] On success, set `step="Release"`.
- [ ] Wire `ReleaseFlow` and final success.

**Full Solution**

```js
// BridgeApp.js
import React, { useState, useEffect } from "react";
import LockForm from "./LockForm";
import ReleaseFlow from "./ReleaseFlow";
import { ethers } from "ethers";

export default function BridgeApp() {
  const [lockId, setLockId] = useState(null);
  const [amount, setAmount] = useState("");
  const [step, setStep] = useState("Lock"); // Lock|Switch|Release|Done
  const [currentChain, setCid] = useState(null);

  const targetHex = ethers.utils.hexValue(
    Number(process.env.REACT_APP_TARGET_CHAIN_ID)
  );

  useEffect(() => {
    async function detect() {
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setCid(parseInt(hex, 16));
    }
    detect();
    window.ethereum.on("chainChanged", detect);
    return () => window.ethereum.removeListener("chainChanged", detect);
  }, []);

  function handleLocked(id, amt) {
    setLockId(id);
    setAmount(amt);
    setStep("Switch");
  }

  async function doSwitch() {
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: targetHex }],
      });
      setStep("Release");
    } catch (err) {
      console.error(err);
      // handle 4902, 4001 if needed
    }
  }

  function handleReleased() {
    setStep("Done");
  }

  return (
    <div style={{ padding: 24, fontFamily: "sans-serif" }}>
      <h2>🌉 Bridge Simulator</h2>
      {step === "Lock" && <LockForm onLocked={handleLocked} />}
      {step === "Switch" && (
        <div>
          <p>
            🔄 Current Chain: {currentChain}. Please switch to{" "}
            {process.env.REACT_APP_TARGET_CHAIN_ID}.
          </p>
          <button onClick={doSwitch}>Switch Chain</button>
        </div>
      )}
      {step === "Release" && (
        <ReleaseFlow lockId={lockId} amount={amount} onDone={handleReleased} />
      )}
      {step === "Done" && (
        <p>
          ✅ Bridged {amount} ETH! Your lock ID: {lockId}
        </p>
      )}
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_BRIDGE_ADDR=0xYourBridgeSimulatorAddress
REACT_APP_TARGET_CHAIN_ID=1337
```

---

## ✅ Test Cases

Create `__tests__/BridgeApp.test.js`:

```js
// __tests__/BridgeApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import BridgeApp from "../BridgeApp";
import { ethers } from "ethers";

jest.mock("ethers");

describe("BridgeApp Flow", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeBridge = {
    lockTokens: jest.fn(),
    releaseTokens: jest.fn(),
  };
  beforeAll(() => {
    global.window.ethereum = {
      request: jest
        .fn()
        // detect chainId
        .mockResolvedValueOnce("0x1")
        // eth_requestAccounts
        .mockResolvedValueOnce(["0xABC"])
        // wallet_switchEthereumChain
        .mockResolvedValueOnce(null),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeBridge);
    // mock lock tx
    fakeBridge.lockTokens.mockResolvedValue({
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Locked", args: { id: ethers.BigNumber.from("7") } },
          ],
        }),
    });
    // mock release tx
    fakeBridge.releaseTokens.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
  });

  it("completes bridge flow", async () => {
    render(<BridgeApp />);
    // Lock step
    fireEvent.change(screen.getByPlaceholderText("ETH"), {
      target: { value: "0.1" },
    });
    fireEvent.click(screen.getByText("Bridge"));
    // Confirm modal
    fireEvent.click(screen.getByText("Yes, lock"));
    await waitFor(() => expect(fakeBridge.lockTokens).toHaveBeenCalled());
    // Switch step
    fireEvent.click(screen.getByText("Switch Chain"));
    await waitFor(() => screen.getByText(/Release 0.1 ETH/));
    // Release step
    fireEvent.click(screen.getByText("Release 0.1 ETH on NYChain"));
    fireEvent.click(screen.getByText("Yes, release"));
    await waitFor(() =>
      expect(fakeBridge.releaseTokens).toHaveBeenCalledWith(7)
    );
    // Done
    expect(await screen.findByText(/✅ Bridged/)).toBeInTheDocument();
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At hackathon’s demo stage, the crowd watched Odessa’s UI lock—and then “release”—0.2 ETH across **simulated** PHChain & NYChain. Judges applauded the slick UX: “Feels like the real LayerZero!” Back in Cebu, Neri and Odessa sketched the next leap—integrating a mock relayer backend and real cross-chain testnets. Filipino dev power: bridging chains, building futures! 🇵🇭🌐🔥
