# Sign-In with Wallet Experience Activity

The HR team wants a dashboard you unlock with your wallet instead of a password. In this activity you build `WalletAuth`, a four-step flow. The user clicks **Connect**, then **Sign In** (signing a message that carries a nonce), then **Verify**, which checks the signature with the `Authenticator` contract. When the check passes, the dashboard appears.

**What you will learn:** how to sign a message with a wallet using ethers v6, why the signed bytes must match what the contract expects, and how to verify a signature on-chain. You will also see what this frontend-only check does **not** protect (see the note after Task 4).

## The Contract You Are Calling

You do not write or deploy this contract. Read its prefix line closely: `\n32` means it expects the wallet to have signed exactly **32 bytes**.

```solidity
// Authenticator.sol - already deployed on Sepolia
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

## Initial Code

This is the starter that opens in your editor. The comment on line 1 says `.js`, but the file you are editing is `WalletAuth.jsx`.

```js
// WalletAuth.js - Starter Code
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
    // TODO: Task 1 - Guard for MetaMask, request accounts, then read the
    //                signer's address into `account`
  };

  const signMessage = async () => {
    // TODO: Task 2 - Build a message containing a nonce and have the signer
    //                sign it; store both the message and the signature
  };

  const verifySignature = async () => {
    // TODO: Task 3 - Verify the signature on-chain and unlock on success
  };

  return (
    <div>
      {/* TODO: Task 4 - Walk the user through connect, sign in, verify, done */}
      <p>Placeholder</p>
    </div>
  );
}
```

The editor provides `process.env.REACT_APP_RPC_URL` (a Sepolia RPC URL), `process.env.REACT_APP_CONTRACT_ADDRESS` and the ABI file `../abi/Authenticator.json`.

**Time Allotment: 35 minutes**

## Tasks for Learners

Topics Covered: `ethers.BrowserProvider`, `signer.getAddress()`, `signer.signMessage()`, `ethers.id`, `ethers.getBytes`, `ethers.Signature.from`, on-chain signature verification, nonces

This lesson uses **ethers v6**. `ethers.providers.Web3Provider`, `ethers.utils.id` and `ethers.utils.splitSignature` are version 5 and fail here. <!-- v5-ok -->

This is the hardest activity so far, and Task 2 is where most people get stuck. Take it slowly.

---

### Task 1: Implement `connectWallet`

Replace the body of `connectWallet`:

```js
const connectWallet = async () => {
  try {
    setError("");
    if (!window.ethereum) {
      setError("Please install MetaMask!");
      return;
    }

    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const address = await signer.getAddress();
    setAccount(address);
  } catch (err) {
    console.error("Connection failed:", err);
    setError("Failed to connect wallet");
  }
};
```

- With no wallet, put a message containing **MetaMask** in `error`. Task 4 renders it, so the user sees a warning instead of a dead button.
- Read the address with **`await signer.getAddress()`**. It gives you the address of the account that will sign. The grader checks that you call it. Taking `accounts[0]` from the request instead does not pass this activity.
- `getSigner()` is async in v6, so it needs `await` too.

---

### Task 2: Implement `signMessage`

Replace the body of `signMessage`:

```js
const signMessage = async () => {
  try {
    setError("");
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();

    // A nonce makes every message different. (Real replay protection needs
    // a server that issues the nonce and accepts it only once.)
    const nonce = Date.now().toString();
    const msg = `Sign in to Dashboard\n\nNonce: ${nonce}`;

    // Authenticator.verify re-prefixes a 32-byte hash, so sign the 32 hash
    // BYTES. Signing the text would prefix the text's length instead, and
    // the on-chain check could never match.
    const sig = await signer.signMessage(ethers.getBytes(ethers.id(msg)));
    setMessage(msg);
    setSignature(sig);
  } catch (err) {
    console.error("Signing failed:", err);
    setError("Failed to sign message");
  }
};
```

Read the `signMessage` line from the inside out:

1. `ethers.id(msg)` hashes the text with keccak256, giving a 32-byte hash written as a hex string such as `"0x5f2c..."`.
2. `ethers.getBytes(...)` turns that hex string into the actual **32 bytes** (a `Uint8Array`).
3. `signer.signMessage(bytes)` asks MetaMask to sign them. The wallet adds the prefix `"\x19Ethereum Signed Message:\n32"` (32 = the number of bytes signed), exactly the prefix the contract rebuilds.

Why not `signer.signMessage(msg)`? The wallet would then prefix the **text's length**, `\n42`, and the contract, which always uses `\n32`, could never match. The same goes for `signer.signMessage(ethers.id(msg))` without `getBytes`: v6 treats any string as text, so it would sign 66 characters with the prefix `\n66`.

About the nonce: it only makes a signature single-use when a **server** issues it, remembers it and refuses it the second time. Here the nonce is made in the browser and nothing remembers it. It shows you *where* a nonce goes, but on its own it does not stop a replay. The lecture explains this in "What This Flow Does and Does Not Protect".

---

### Task 3: Implement `verifySignature`

Replace the body of `verifySignature`:

```js
const verifySignature = async () => {
  try {
    setError("");
    const msgHash = ethers.id(message);
    const { v, r, s } = ethers.Signature.from(signature);

    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
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

- `ethers.id(message)` rebuilds the same 32-byte hash you signed. `message` must be exactly the string from Task 2, which is why Task 2 stored it.
- `ethers.Signature.from(signature)` splits the 65-byte signature into `v` (27 or 28), `r` and `s`.
- `verify` is a `pure` function, so a read-only `JsonRpcProvider` is enough and the call costs no gas.

---

### Task 4: Render the Four Steps

Replace the whole `return (...)` block (including `<p>Placeholder</p>`) with:

```js
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
        <h2>Welcome to the Dashboard!</h2>
        <p>Authenticated as: {account}</p>
      </div>
    )}
    {error && <p style={{ color: "red" }}>{error}</p>}
  </div>
);
```

Each step shows only the button for what comes next: no account means **Connect**, no signature means **Sign In**, not yet verified means **Verify**, and after that the dashboard. The error line sits outside the steps, so it can appear at any stage.

> **Graded details: labels and wording are checked.** The grader clicks buttons by the words they contain, in this order: **Connect**, then **Sign In**, then **Verify**.
>
> - The first screen must show a button whose label contains **Connect** (for example `Connect Wallet`).
> - With no wallet installed, clicking Connect must show text containing **MetaMask** (for example `Please install MetaMask!`).
> - On connect, you must call **`signer.getAddress()`** and show the returned address (`0x1234...7890` in the test wallet).
> - After connecting, a button whose label contains **Sign In** must appear. Clicking it must call `signer.signMessage(...)`.
> - The message text you pass to `ethers.id()` must contain the word **Nonce** (any case).
> - What you pass to `signMessage` must be **32 bytes, not a string**: `ethers.getBytes(ethers.id(msg))`. Passing `msg` or `ethers.id(msg)` fails.
> - After signing, a button whose label contains **Verify** must appear. Clicking it must call `contract.verify(...)`.
> - After a successful verify, the page must show text containing **Dashboard** (any case).

---

## What This Lesson Does and Does Not Secure

Be clear-eyed about the result. A valid signature proves the user controls that wallet. But here, the dashboard appears because a state variable in the user's own browser became `true`, and anyone can flip that in the developer tools. Also, because nothing remembers the nonce, an old message and signature would still pass `verify()`.

For a real app, a server must check the signature, issue and consume the nonce, and hand out a session. It must send protected data only to requests that carry that session. You are practising the signing and verifying mechanics here, which is the part that runs in the browser either way.

---

## Common Mistakes

- **`signer.signMessage(msg)`** (signing the text). It looks natural, but it can never verify against this contract, and the grader rejects it.
- **`signer.signMessage(ethers.id(msg))` without `ethers.getBytes`.** v6 signs the hex string as text.
- **Using `accounts[0]` instead of `await signer.getAddress()`.** It is the same address, but this activity checks for `getAddress()`.
- **Forgetting to store `message`** in Task 2. Task 3 needs the exact same string to rebuild the hash.
- **Leaving the word "Nonce" out of the message**, or renaming the buttons so they no longer contain Connect, Sign In and Verify.

---

## Breakdown of the Activity

**Variables Defined:**

- `account`: The connected address, read with `signer.getAddress()`. It is passed to `verify()` as the address the signature should match.

- `message`: The text that was hashed and signed, such as `Sign in to Dashboard\n\nNonce: 1730000000000`. Task 3 hashes it again with `ethers.id()`.

- `signature`: The 65-byte signature from MetaMask, as a hex string. It contains `r`, `s` and `v`.

- `isAuthenticated`: Becomes `true` once `verify()` returns `true`, which shows the dashboard.

- `msgHash`: `ethers.id(message)`, the keccak256 hash of the message text. You sign its 32 bytes, and the contract receives it as `bytes32`.

- `v, r, s`: The three parts of the signature, from `ethers.Signature.from(signature)`. `r` and `s` are 32 bytes each, and `v` is 27 or 28.

**Key Functions:**

- `connectWallet`:
  Checks for MetaMask, requests the account, builds a `BrowserProvider`, awaits the signer and stores `await signer.getAddress()`. Errors, including a missing wallet, go into `error`.

- `signMessage`:
  Builds a message containing a nonce, hashes it with `ethers.id`, and asks the signer to sign the 32 hash bytes, so that the wallet's `\n32` prefix matches the contract's. It stores both the message and the signature.

- `verifySignature`:
  Rebuilds the hash, splits the signature into `v`, `r` and `s`, and calls the contract's `verify()` through a read-only provider. `verify()` uses Solidity's `ecrecover` to recover the signer and compares it with `account`. On `true` it unlocks the dashboard. Otherwise it shows an error.
