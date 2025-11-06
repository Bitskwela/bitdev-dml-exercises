## 🧑‍💻 Background Story

At a bustling LayerZero hackathon in New York City, Odessa ("Det") teamed up with Neri to demo a **cross-chain bridge**—but they only had one local Hardhat node. No problem. Over coffee, they spun up a **BridgeSimulator** contract and built a React UI that **felt** like real cross-chain magic.

Front and center: a **Network** dropdown ("PHChain" ↔ "NYChain"), an **Amount** input, and a big **Bridge Tokens** button. Click. A confirmation modal pops: "Lock 0.05 ETH on PHChain?" Confirm → MetaMask pops → tx is sent → a loading spinner → "Locked! Lock ID #3." Then the UI flips to **NYChain**, asks "Release 0.05 ETH on NYChain?" Confirm → MetaMask → spinner → "Success! Tokens bridged."

Under the hood, it's the same contract on one network, but the UX simulates two chains, network switching, relayer wait, confirmations, error handling, and loading states. By demo's end, judges thought it was real. Filipino ingenuity had turned a sandbox into a production-grade cross-chain flow—in under 30 minutes. Mabuhay BridgeSimulator! 🇵🇭🔗🌐

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
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At hackathon's demo stage, the crowd watched Odessa's UI lock—and then "release"—0.2 ETH across **simulated** PHChain & NYChain. Judges applauded the slick UX: "Feels like the real LayerZero!" Back in Cebu, Neri and Odessa sketched the next leap—integrating a mock relayer backend and real cross-chain testnets. Filipino dev power: bridging chains, building futures! 🇵🇭🌐🔥