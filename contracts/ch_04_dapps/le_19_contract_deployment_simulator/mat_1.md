## 🧑‍💻 Background Story

At a Barangay Tech Hub in Quezon City, Neri had prepared a live-coding workshop: "Today, you'll deploy your first smart contract—from the browser!" Odessa ("Det") set up a local Hardhat node and invited learners to connect MetaMask to `http://127.0.0.1:8545`. She clicked "Deploy Simulator," pasted a simple ABI/Bytecode artifact, hit **Deploy**, and in seconds a new contract address flashed on screen.

The room buzzed. "Ang dali pala!" said Carlo, a senior high coding club member from Pasig. Odessa smiled: "No backend, no Truffle CLI—just your React app and Ethers.js." Next, she opened **Deploy History**, a panel that logged each address and timestamp. Learners saw their contracts accumulate like trophies.

By lunchtime, the class had deployed over 30 instances of `HelloWorld.sol`, each storing a custom greeting. Neri and Odessa high-fived: from pure beginners to "real" blockchain devs in under 30 minutes. "Simulated," yes—but the thrill was genuine. Filipino ingenuity turned a sandbox into a production-like pipeline, one click at a time. 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

1. Why Simulate Deployment in Frontend?

   - Gives beginners a DevOps-lite experience without installing CLI tools.
   - Exposes `ContractFactory`, transaction lifecycle, gas estimation, and receipts.

2. Ethers.js ContractFactory

   - `new ethers.ContractFactory(abi, bytecode, signer)` builds a deployer.
   - `factory.deploy(...constructorArgs)` → returns a `Contract` instance with a `.deployTransaction`.
   - `await contract.deployed()` waits for on-chain confirmation.

3. MetaMask as Signer

   - `const provider = new ethers.providers.Web3Provider(window.ethereum)`
   - `await provider.send("eth_requestAccounts", [])` to connect.
   - `const signer = provider.getSigner()` signs the deployment tx.

4. Frontend Architecture

   - **Inputs**: ABI JSON, Bytecode string, constructor arguments
   - **Deploy Button**: triggers `factory.deploy(...)`
   - **Status Handling**: show spinner, catch errors (user reject, gas issues)
   - **Deploy History**: maintain an array of `{ address, timestamp }` in React state (or `localStorage`) and render a list.

5. Gas & Best Practices
   - Estimate gas: `await factory.signer.estimateGas(factory.getDeployTransaction(...))`.
   - Disable the button while deploying.
   - Clean up UI on unmount.
   - Never include private keys in client code—use MetaMask or a secure signer.

🔗 Further Reading

- Ethers.js Deployment: https://docs.ethers.org/v5/api/contract/contract-factory/
- Ethereum JSON-RPC: https://ethereum.org/en/developers/docs/apis/json-rpc/

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