## 🧑‍💻 Background Story

In the heart of a Manila-based Web3 startup, the HR team struggled to secure their internal “Hire Filipino Talent” dashboard. Paper resumes and password resets? Nakakabored! Neri stepped in with an idea: “Let’s do Sign-In with Ethereum (SIWE).”

That evening in Brooklyn, Odessa joined via Zoom from her co-working nook, eyes gleaming. “No backend? No problem,” Neri said. She deployed a tiny `Authenticator` contract on Hardhat: it simply recovers your signed message on-chain. Odessa’s mission was to build the React interface:

1. **Connect** the user’s MetaMask wallet
2. **Generate & display** a nonce message
3. **Request** the user’s signature
4. **Call** the contract’s `verify()` (read-only) to ensure the signer matches the wallet
5. **Unlock** the “Hire Filipino Talent” dashboard on success

As the local Hardhat node hummed, Odessa wired up Ethers.js to MetaMask, signed a nonce, called `verify()`, and watched the dashboard appear—no refresh, no passwords, pure crypto. The HR team gasped: “Ayos ‘to!”

From Manila’s startup hustle to Brooklyn’s café vibe, Odessa had just mastered SIWE without a real server. Next stop: securing APIs, role-based access, and cross-chain identity. But tonight, she celebrates that “Welcome, 0x…!” screen on her “Hire Filipino Talent” dashboard. 🇵🇭🔐✨

---

## 📚 Theory & Web3 Lecture

### 1. What Is SIWE?

Sign-In with Ethereum (EIP-4361) lets users authenticate by signing a structured message. No centralized passwords—proof of wallet ownership unlocks resources.

### 2. Authenticator Contract

```solidity
// contracts/Authenticator.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authenticator {
    /// @notice Verify that `signature` is from `user` over `msgHash`
    function verify(
        address user,
        bytes32 msgHash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external pure returns (bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixed = keccak256(abi.encodePacked(prefix, msgHash));
        return ecrecover(prefixed, v, r, s) == user;
    }
}
```

- It’s a **read-only** `pure` function: calling it via JSON-RPC costs **no gas**.
- Frontend passes `(userAddress, messageHash, v, r, s)` to validate signature on-chain.

### 3. React + Ethers.js Flow

1. **Connect Wallet**

   - `await provider.send("eth_requestAccounts", [])`
   - `const signer = provider.getSigner()`

2. **Generate Nonce & Message**
   ```js
   const nonce = Date.now().toString();
   const message = `Sign-in to HR Dashboard\n\nNonce: ${nonce}`;
   ```
3. **Sign Message**
   ```js
   const signature = await signer.signMessage(message);
   ```
4. **Split & Hash**
   ```js
   const msgHash = ethers.utils.id(message); // keccak256
   const { v, r, s } = ethers.utils.splitSignature(signature);
   ```
5. **Call Contract.verify()**
   ```js
   const contract = new ethers.Contract(addr, abi, provider);
   const isValid = await contract.verify(user, msgHash, v, r, s);
   if (isValid) unlockDashboard();
   ```
6. **State Management**
   - `useState` for `connected`, `signed`, `isValid`
   - `useEffect` to react to changes

### 4. Security & Best Practices

- **Fresh Nonce** every session to prevent replay.
- **Timeout**: invalidate old nonces if >5 min.
- **Prefix** must match Ethers.js internal prefix.
- Use **.env** for RPC URL & contract address; never commit secrets.

External References

- Ethers.js Signing: https://docs.ethers.org/v5/api/signer/#Signer-signMessage
- EIP-4361 Spec: https://eips.ethereum.org/EIPS/eip-4361

---

## 🧪 Exercises

### Solidity Baseline (`contracts/Authenticator.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authenticator {
    function verify(
        address user,
        bytes32 msgHash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external pure returns (bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixed = keccak256(abi.encodePacked(prefix, msgHash));
        return ecrecover(prefixed, v, r, s) == user;
    }
}
```

.env Sample

```
REACT_APP_RPC_URL=http://localhost:8545
REACT_APP_CONTRACT_ADDRESS=0xYourAuthenticatorAddress
```

---

### Exercise 1: Connect Wallet & Display Address

**Problem Statement**  
Build `ConnectWallet.js`. When the user clicks “Connect Wallet,” prompt MetaMask, then display `0x…` address.

**Starter (`ConnectWallet.js`)**

```js
import { useState } from "react";
import { ethers } from "ethers";

export default function ConnectWallet() {
  const [account, setAccount] = useState(null);

  const connect = async () => {
    // TODO
  };

  return (
    <div>
      <button onClick={connect}>Connect Wallet</button>
      {account && <p>Connected: {account}</p>}
    </div>
  );
}
```

**To Do List**

- Check `window.ethereum`; alert if missing.
- `await window.ethereum.request({ method: 'eth_requestAccounts' })`.
- Create `provider = new ethers.providers.Web3Provider(window.ethereum)`.
- `const signer = provider.getSigner()`.
- `setAccount(await signer.getAddress())`.

**Full Solution**

```js
const connect = async () => {
  if (!window.ethereum) {
    alert("Install MetaMask");
    return;
  }
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const addr = await signer.getAddress();
  setAccount(addr);
};
```

---

### Exercise 2: Sign a Nonce Message

**Problem Statement**  
After connecting, generate a timestamp nonce, prompt `signMessage`, and display the signature.

**Starter (`SignIn.js`)**

```js
import { useState } from "react";
import { ethers } from "ethers";

export default function SignIn({ account }) {
  const [signature, setSignature] = useState("");

  const sign = async () => {
    // TODO
  };

  return (
    <div>
      <button onClick={sign} disabled={!account}>
        Sign In
      </button>
      {signature && (
        <>
          <p>Signature:</p>
          <code>{signature}</code>
        </>
      )}
    </div>
  );
}
```

**To Do List**

- Use existing `Web3Provider` & `signer`.
- Create `message = \`Nonce: ${Date.now()}\``.
- `const sig = await signer.signMessage(message)`.
- `setSignature(sig)`.

**Full Solution**

```js
const sign = async () => {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const nonce = Date.now().toString();
  const msg = `Sign in to HR Dashboard\n\nNonce: ${nonce}`;
  const sig = await signer.signMessage(msg);
  setSignature(sig);
};
```

---

### Exercise 3: Verify Signature On-Chain

**Problem Statement**  
Use the `Authenticator` contract’s `verify()` to check the signature. On success, show the “Hire Filipino Talent” dashboard.

**Starter (`AuthDashboard.js`)**

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/Authenticator.json";

export default function AuthDashboard({ account, signature, message }) {
  const [isValid, setIsValid] = useState(false);

  const verifyOnChain = async () => {
    // TODO
  };

  return (
    <div>
      <button onClick={verifyOnChain} disabled={!signature}>
        Verify & Unlock Dashboard
      </button>
      {isValid && (
        <div>
          <h2>🚀 Hire Filipino Talent Dashboard</h2>
          <p>Welcome, {account}!</p>
        </div>
      )}
    </div>
  );
}
```

**To Do List**

1. Hash the message: `const msgHash = ethers.utils.id(message)`.
2. `splitSignature(signature)` → `{ v, r, s }`.
3. Instantiate `provider = new ethers.providers.JsonRpcProvider(RPC_URL)`.
4. `const contract = new ethers.Contract(addr, abi, provider)`.
5. `const ok = await contract.verify(account, msgHash, v, r, s)`.
6. `if ok, setIsValid(true)`; else alert failure.

**Full Solution**

```js
const verifyOnChain = async () => {
  const msgHash = ethers.utils.id(message);
  const { v, r, s } = ethers.utils.splitSignature(signature);
  const provider = new ethers.providers.JsonRpcProvider(
    process.env.REACT_APP_RPC_URL
  );
  const contract = new ethers.Contract(
    process.env.REACT_APP_CONTRACT_ADDRESS,
    abi,
    provider
  );
  const ok = await contract.verify(account, msgHash, v, r, s);
  if (ok) setIsValid(true);
  else alert("Signature invalid");
};
```

**Solidity Signature**

```solidity
function verify(
  address user,
  bytes32 msgHash,
  uint8 v,
  bytes32 r,
  bytes32 s
) external pure returns (bool);
```

---

## ✅ Test Cases

```js
// __tests__/ConnectWallet.test.js
import React from "react";
import { render, fireEvent, screen } from "@testing-library/react";
import ConnectWallet from "../components/ConnectWallet";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  return {
    ...original,
    providers: {
      Web3Provider: jest.fn(() => ({
        getSigner: () => ({
          getAddress: () => Promise.resolve("0xABC"),
        }),
      })),
    },
  };
});

test("connects wallet and displays address", async () => {
  window.ethereum = { request: jest.fn().mockResolvedValue(["0xABC"]) };
  render(<ConnectWallet />);
  fireEvent.click(screen.getByText("Connect Wallet"));
  expect(await screen.findByText(/Connected: 0xABC/)).toBeInTheDocument();
});
```

```js
// __tests__/SignInAndVerify.test.js
import React from "react";
import { render, fireEvent, screen, waitFor } from "@testing-library/react";
import SignIn from "../components/SignIn";
import AuthDashboard from "../components/AuthDashboard";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  const fakeSig = "0xsig";
  return {
    ...original,
    providers: {
      Web3Provider: jest.fn(() => ({
        getSigner: () => ({
          signMessage: () => Promise.resolve(fakeSig),
        }),
      })),
      JsonRpcProvider: jest.fn(),
    },
    utils: {
      ...original.utils,
      id: jest.fn(() => "0xhash"),
      splitSignature: jest.fn(() => ({ v: 27, r: "0x1", s: "0x2" })),
    },
    Contract: jest.fn(() => ({
      verify: jest.fn(() => Promise.resolve(true)),
    })),
  };
});

test("signs message and verifies on-chain", async () => {
  render(<SignIn account="0xABC" />);
  fireEvent.click(screen.getByText("Sign In"));
  expect(await screen.findByText(/Signature:/)).toBeInTheDocument();

  const sig = screen.getByText(/0xsig/).textContent;
  render(
    <AuthDashboard
      account="0xABC"
      signature={sig}
      message={`Sign in to HR Dashboard\n\nNonce: ${Date.now()}`}
    />
  );
  fireEvent.click(screen.getByText(/Verify & Unlock/));
  await waitFor(() =>
    expect(
      screen.getByText(/Hire Filipino Talent Dashboard/)
    ).toBeInTheDocument()
  );
});
```

---

## 🌟 Closing Story

With a few clicks and a signed message, Odessa unlocked the “Hire Filipino Talent” dashboard—no passwords, no servers, pure on-chain auth. Neri beamed from Laguna as their HR tool leveled up in security and style.

Next on their roadmap: role-based access (RBAC), metatransactions for gasless login, and SIWE with backend integrations. But for now: welcome to the future of Web3 authentication, Pinoy style! 🇵🇭🔑🚀
