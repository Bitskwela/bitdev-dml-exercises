# Sign-In with Wallet Experience Activity

## Initial Code

```solidity
// Authenticator.sol - Contract Baseline
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

```js
// WalletAuth.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/Authenticator.json";

export default function WalletAuth() {
  const [account, setAccount] = useState(null);
  const [signature, setSignature] = useState("");
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [error, setError] = useState("");

  const connectWallet = async () => {
    // TODO: Connect wallet and get account
  };

  const signMessage = async () => {
    // TODO: Sign a nonce message
  };

  const verifySignature = async () => {
    // TODO: Verify signature on-chain
  };

  return (
    <div>
      {!account ? (
        <button onClick={connectWallet}>Connect Wallet</button>
      ) : !signature ? (
        <div>
          <p>Connected: {account}</p>
          <button onClick={signMessage}>Sign In</button>
        </div>
      ) : !isAuthenticated ? (
        <div>
          <p>Signature: {signature.slice(0, 20)}...</p>
          <button onClick={verifySignature}>Verify & Unlock</button>
        </div>
      ) : (
        <div>
          <h2>🚀 Welcome to the Dashboard!</h2>
          <p>Authenticated as: {account}</p>
        </div>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=http://localhost:8545
REACT_APP_CONTRACT_ADDRESS=0xYourAuthenticatorAddress
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: Wallet connection, message signing, signature verification, `ecrecover`, SIWE pattern, nonce generation

---

### Task 1: Implement the `connectWallet` Function

Check if MetaMask is installed, request account access using `eth_requestAccounts`, create a Web3Provider, and store the connected account address in state.

```js
const connectWallet = async () => {
  try {
    setError("");
    if (!window.ethereum) {
      setError("Please install MetaMask!");
      return;
    }

    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const address = await signer.getAddress();
    setAccount(address);
  } catch (err) {
    console.error("Connection failed:", err);
    setError("Failed to connect wallet");
  }
};
```

---

### Task 2: Implement the `signMessage` Function

Generate a unique nonce message using the current timestamp, then use the signer's `signMessage` method to request a signature from MetaMask. Store both the message and signature for later verification.

```js
const [message, setMessage] = useState("");

const signMessage = async () => {
  try {
    setError("");
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();

    const nonce = Date.now().toString();
    const msg = `Sign in to Dashboard\n\nNonce: ${nonce}`;

    const sig = await signer.signMessage(msg);
    setMessage(msg);
    setSignature(sig);
  } catch (err) {
    console.error("Signing failed:", err);
    setError("Failed to sign message");
  }
};
```

---

### Task 3: Implement the `verifySignature` Function

Hash the message, split the signature into its components (v, r, s), and call the smart contract's `verify` function to authenticate the user on-chain. Unlock the dashboard on successful verification.

```js
const verifySignature = async () => {
  try {
    setError("");
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

    const isValid = await contract.verify(account, msgHash, v, r, s);

    if (isValid) {
      setIsAuthenticated(true);
    } else {
      setError("Signature verification failed");
    }
  } catch (err) {
    console.error("Verification failed:", err);
    setError("Failed to verify signature");
  }
};
```

---

## Complete Solution

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/Authenticator.json";

export default function WalletAuth() {
  const [account, setAccount] = useState(null);
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [error, setError] = useState("");

  const connectWallet = async () => {
    try {
      setError("");
      if (!window.ethereum) {
        setError("Please install MetaMask!");
        return;
      }

      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const address = await signer.getAddress();
      setAccount(address);
    } catch (err) {
      console.error("Connection failed:", err);
      setError("Failed to connect wallet");
    }
  };

  const signMessage = async () => {
    try {
      setError("");
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const nonce = Date.now().toString();
      const msg = `Sign in to Dashboard\n\nNonce: ${nonce}`;

      const sig = await signer.signMessage(msg);
      setMessage(msg);
      setSignature(sig);
    } catch (err) {
      console.error("Signing failed:", err);
      setError("Failed to sign message");
    }
  };

  const verifySignature = async () => {
    try {
      setError("");
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

      const isValid = await contract.verify(account, msgHash, v, r, s);

      if (isValid) {
        setIsAuthenticated(true);
      } else {
        setError("Signature verification failed");
      }
    } catch (err) {
      console.error("Verification failed:", err);
      setError("Failed to verify signature");
    }
  };

  return (
    <div>
      {!account ? (
        <button onClick={connectWallet}>Connect Wallet</button>
      ) : !signature ? (
        <div>
          <p>Connected: {account}</p>
          <button onClick={signMessage}>Sign In</button>
        </div>
      ) : !isAuthenticated ? (
        <div>
          <p>Signature: {signature.slice(0, 20)}...</p>
          <button onClick={verifySignature}>Verify & Unlock</button>
        </div>
      ) : (
        <div>
          <h2>🚀 Welcome to the Dashboard!</h2>
          <p>Authenticated as: {account}</p>
        </div>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `account`: Stores the connected wallet address (e.g., `0xABC...123`). Used to identify the user throughout the authentication flow and passed to the smart contract for verification.

- `message`: The human-readable message that the user signs. Contains a nonce (timestamp) to prevent replay attacks. The same message must be hashed during verification to recover the signer's address.

- `signature`: The cryptographic signature produced by MetaMask when the user signs the message. This 65-byte hex string contains the `v`, `r`, and `s` components needed for `ecrecover`.

- `isAuthenticated`: A boolean state that tracks whether the user has successfully verified their signature on-chain. When `true`, the dashboard is unlocked and displayed.

- `msgHash`: The keccak256 hash of the message, created using `ethers.utils.id()`. This hash is what gets signed and verified, not the raw message text.

- `v, r, s`: The three components of an Ethereum signature. `r` and `s` are 32-byte values that form the core signature, while `v` (27 or 28) is the recovery ID that helps determine which public key was used.

**Key Functions:**

- `connectWallet`:
  Initiates the wallet connection flow. First checks if MetaMask is installed by looking for `window.ethereum`. Calls `eth_requestAccounts` to prompt the user to connect (triggers MetaMask popup). Creates a Web3Provider and signer to access the connected account's address. Error handling catches both MetaMask absence and user rejection.

- `signMessage`:
  Generates a unique message with a timestamp-based nonce, then requests the user's signature via `signer.signMessage()`. MetaMask displays the message content so the user can review what they're signing. The nonce ensures each sign-in attempt creates a unique signature, preventing attackers from reusing old signatures.

- `verifySignature`:
  Performs on-chain verification of the signature. Hashes the message with `ethers.utils.id()` (equivalent to `keccak256`), then splits the signature into its `v`, `r`, `s` components. Calls the smart contract's `verify()` function which uses Solidity's built-in `ecrecover` to recover the signer's address and compare it to the claimed account. This is a read-only call (no gas cost) since `verify` is a `pure` function.
