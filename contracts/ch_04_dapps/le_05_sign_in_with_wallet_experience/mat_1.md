## 🧑‍💻 Background Story

![Sign-In with Ethereum](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+5.0+-+COVER.png)

In the heart of a Manila-based Web3 startup, the HR team struggled to secure their internal “Hire Filipino Talent” dashboard. Paper resumes and password resets? Nakakabored! Neri stepped in with an idea: “Let’s do Sign-In with Ethereum (SIWE).”

That evening in Brooklyn, Odessa joined via Zoom from her co-working nook, eyes gleaming. “No backend? No problem,” Neri said. She deployed a tiny `Authenticator` contract on Hardhat: it simply recovers your signed message on-chain. Odessa’s mission was to build the React interface:

1. **Connect** the user’s MetaMask wallet
2. **Generate & display** a nonce message
3. **Request** the user’s signature
4. **Call** the contract’s `verify()` (read-only) to ensure the signer matches the wallet
5. **Unlock** the “Hire Filipino Talent” dashboard on success

As the local Hardhat node hummed, Odessa wired up Ethers.js to MetaMask, signed a nonce, called `verify()`, and watched the dashboard appear—no refresh, no passwords, pure crypto. The HR team gasped: “Ayos ‘to!”

![SIWE Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+5.1.png)

From Manila’s startup hustle to Brooklyn’s café vibe, Odessa had just mastered SIWE without a real server. Next stop: securing APIs, role-based access, and cross-chain identity. But tonight, she celebrates that “Welcome, 0x…!” screen on her “Hire Filipino Talent” dashboard. 🇵🇭🔐✨

---

## 📚 Theory & Web3 Lecture

Welcome to **Sign-In with Ethereum (SIWE)**—a revolutionary way to authenticate users without passwords! Instead of usernames and passwords stored in databases, users prove they own a wallet by signing a message. It's like showing your signature to prove you're you—but cryptographically secure!

---

### 1. What Is Sign-In with Ethereum (SIWE)?

#### **The Problem with Traditional Authentication**

```
Traditional Login:
┌─────────────────────────────────────────────────────────────┐
│  User → enters username/password → Server checks database  │
│                                                             │
│  Problems:                                                  │
│  • Passwords can be stolen (data breaches)                 │
│  • Users forget passwords                                   │
│  • Servers store sensitive data                             │
│  • Need "Forgot Password" flows                             │
└─────────────────────────────────────────────────────────────┘

Web3 Login (SIWE):
┌─────────────────────────────────────────────────────────────┐
│  User → signs message with wallet → Signature verified     │
│                                                             │
│  Benefits:                                                  │
│  • No passwords to steal                                    │
│  • Nothing stored in database                               │
│  • User controls their identity                             │
│  • Works across all Web3 apps                               │
└─────────────────────────────────────────────────────────────┘
```

#### **How Does It Work?**

Think of it like this: Your wallet has a **private key** (your secret signature stamp) and a **public address** (your ID card number). When you sign a message:

1. You use your private key to create a unique signature
2. Anyone can verify that signature came from your address
3. But nobody can forge your signature without your private key

```
Signing Process:
┌──────────────┐      ┌─────────────────┐      ┌──────────────────┐
│   Message    │  +   │   Private Key   │  →   │    Signature     │
│ "Login: 123" │      │   (Secret!)     │      │   "0x7f8a2..."   │
└──────────────┘      └─────────────────┘      └──────────────────┘
                                                        │
Verification:                                           ▼
┌──────────────┐      ┌─────────────────┐      ┌──────────────────┐
│   Message    │  +   │    Signature    │  →   │ Recovered Address│
│ "Login: 123" │      │   "0x7f8a2..."  │      │   "0xABC..."     │
└──────────────┘      └─────────────────┘      └──────────────────┘
                                                        │
                                               Does it match user's address?
                                               ✅ Yes = Authenticated!
                                               ❌ No = Rejected!
```

#### **EIP-4361: The SIWE Standard**

EIP-4361 standardizes the message format for Sign-In with Ethereum. The message includes:

| Field         | Purpose                 | Example                       |
| ------------- | ----------------------- | ----------------------------- |
| **Domain**    | Which app is requesting | `app.example.com`             |
| **Address**   | User's wallet address   | `0xABC...123`                 |
| **Statement** | Human-readable purpose  | "Sign in to access dashboard" |
| **URI**       | Full URL of the app     | `https://app.example.com`     |
| **Nonce**     | Unique random value     | `abc123xyz`                   |
| **Issued At** | Timestamp               | `2024-01-15T10:30:00Z`        |

---

### 2. Understanding Cryptographic Signatures

#### **What is ECDSA?**

Ethereum uses **Elliptic Curve Digital Signature Algorithm (ECDSA)**. Here's what you need to know:

| Component               | What It Is               | Purpose                  |
| ----------------------- | ------------------------ | ------------------------ |
| **Message**             | The text being signed    | What you're agreeing to  |
| **Message Hash**        | keccak256 of the message | Fixed-size fingerprint   |
| **Signature (v, r, s)** | The actual signature     | Proves ownership         |
| **v**                   | Recovery ID (27 or 28)   | Helps recover public key |
| **r**                   | First half of signature  | Part of the proof        |
| **s**                   | Second half of signature | Part of the proof        |

#### **The Ethereum Signed Message Prefix**

When signing with MetaMask, a prefix is added to prevent signing malicious transactions:

```js
// What you sign:
"Hello, World!";

// What's actually hashed:
"\x19Ethereum Signed Message:\n13Hello, World!";
//  ↑ Prefix                  ↑ Length of message

// This prefix protects you from signing actual transactions!
```

---

### 3. The Authenticator Smart Contract

#### **Why Verify On-Chain?**

You can verify signatures off-chain (in JavaScript), but on-chain verification:

- Creates an auditable, trustless proof
- Can be combined with other contract logic
- Proves verification happened at a specific block

#### **The `ecrecover` Function**

Solidity has a built-in function to recover the signer's address:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authenticator {
    /// @notice Verify that `signature` was created by `user` for `msgHash`
    /// @param user The expected signer's address
    /// @param msgHash The keccak256 hash of the original message
    /// @param v Recovery ID (27 or 28)
    /// @param r First 32 bytes of signature
    /// @param s Second 32 bytes of signature
    /// @return bool True if signature is valid
    function verify(
        address user,
        bytes32 msgHash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external pure returns (bool) {
        // Ethereum adds this prefix when signing messages
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";

        // Hash the prefixed message
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, msgHash));

        // Recover the signer's address from the signature
        address recovered = ecrecover(prefixedHash, v, r, s);

        // Check if recovered address matches expected user
        return recovered == user;
    }
}
```

#### **Key Points:**

1. **`pure` function** - Doesn't read or modify state, costs **no gas** when called externally
2. **Prefix matching** - Must match exactly what Ethers.js uses
3. **`ecrecover`** - Returns `address(0)` if signature is invalid

---

### 4. React + Ethers.js SIWE Flow

#### **Complete Authentication Flow**

```
┌─────────────────────────────────────────────────────────────────┐
│                    SIWE Authentication Flow                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Step 1: Connect Wallet                                          │
│  ┌─────────────┐         ┌─────────────┐                        │
│  │   User      │ ──────▶ │  MetaMask   │                        │
│  │   Clicks    │         │   Popup     │                        │
│  │  "Connect"  │         │  Appears    │                        │
│  └─────────────┘         └─────────────┘                        │
│                                                                  │
│  Step 2: Generate & Sign Message                                 │
│  ┌─────────────┐         ┌─────────────┐         ┌────────────┐ │
│  │  Generate   │ ──────▶ │  MetaMask   │ ──────▶ │ Signature  │ │
│  │   Nonce     │         │   "Sign"    │         │  Created   │ │
│  │  Message    │         │   Popup     │         │            │ │
│  └─────────────┘         └─────────────┘         └────────────┘ │
│                                                                  │
│  Step 3: Verify On-Chain                                         │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  Split signature → Call contract.verify() → Check result    ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                  │
│  Step 4: Grant Access                                            │
│  ✅ Valid signature → Show dashboard                             │
│  ❌ Invalid → Show error message                                 │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### **Step-by-Step Code Implementation**

**Step 1: Connect Wallet**

```js
// Request permission to access wallet
await window.ethereum.request({ method: "eth_requestAccounts" });

// Create provider and signer
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();

// Get the connected address
const userAddress = await signer.getAddress();
console.log("Connected:", userAddress); // "0xABC...123"
```

**Step 2: Generate Nonce & Create Message**

```js
// Generate a unique nonce (prevents replay attacks)
const nonce = Date.now().toString(); // or use UUID, random bytes

// Create the message to sign
const message = `Sign in to HR Dashboard

Nonce: ${nonce}
Issued At: ${new Date().toISOString()}`;

// This message is shown to the user in MetaMask
```

**Step 3: Request Signature**

```js
// MetaMask will show a popup asking user to sign
const signature = await signer.signMessage(message);
console.log("Signature:", signature);
// "0x7f8a2b4c5d6e7f8a2b4c5d6e7f8a2b4c5d6e7f8a2b4c5d6e..."
```

**Step 4: Prepare for Verification**

```js
// Hash the message (same way Solidity will)
const messageHash = ethers.id(message); // keccak256

// Split signature into v, r, s components (v6 replaced utils.splitSignature)
const { v, r, s } = ethers.Signature.from(signature);

console.log("v:", v); // 27 or 28
console.log("r:", r); // "0x..." (32 bytes)
console.log("s:", s); // "0x..." (32 bytes)
```

**Step 5: Verify On-Chain**

```js
// Create contract instance (read-only, so provider is enough)
const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  authenticatorABI,
  provider
);

// Call the verify function
const isValid = await contract.verify(userAddress, messageHash, v, r, s);

if (isValid) {
  console.log("✅ Signature verified! User authenticated.");
  unlockDashboard();
} else {
  console.log("❌ Invalid signature!");
  showError("Authentication failed");
}
```

---

### 5. Security Best Practices

#### **Nonce: Preventing Replay Attacks**

A **nonce** (number used once) ensures each sign-in request is unique:

```js
// ❌ BAD: Static message (can be replayed forever)
const message = "Sign in to Dashboard";

// ✅ GOOD: Unique nonce per session
const nonce = crypto.randomUUID(); // or Date.now()
const message = `Sign in to Dashboard\n\nNonce: ${nonce}`;
```

#### **Message Expiration**

Add a timestamp and reject old signatures:

```js
const issuedAt = new Date().toISOString();
const expirationTime = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes

const message = `
Sign in to Dashboard

Nonce: ${nonce}
Issued At: ${issuedAt}
Expiration: ${expirationTime.toISOString()}
`;

// Server should reject if current time > expiration
```

#### **Common Security Mistakes**

| Mistake              | Risk                         | Solution                          |
| -------------------- | ---------------------------- | --------------------------------- |
| No nonce             | Replay attacks               | Generate unique nonce per session |
| Static message       | Signature reuse              | Include timestamp/nonce           |
| No expiration        | Old signatures valid forever | Add expiration time               |
| Wrong prefix         | Signature won't verify       | Use Ethers.js `signMessage`       |
| Storing private keys | Keys can be stolen           | Never store private keys          |

---

### 6. Common Mistakes & Debugging

#### **1. Signature Verification Fails**

```js
// ❌ Problem: Hash calculated differently than contract expects
const hash = ethers.keccak256(message); // Wrong!

// ✅ Solution: Use ethers.id() for string messages
const hash = ethers.id(message); // Correct!
```

#### **2. User Rejects Signing**

```js
try {
  const signature = await signer.signMessage(message);
} catch (err) {
  if (err.code === 4001) {
    // User clicked "Reject" in MetaMask
    console.log("User cancelled signing");
    return;
  }
  throw err;
}
```

#### **3. Wrong Contract Address**

```js
// Always validate contract address exists
const code = await provider.getCode(contractAddress);
if (code === "0x") {
  throw new Error("No contract at this address!");
}
```

---

### 7. Testing Your SIWE Implementation

Before deploying, verify:

1. ✅ **MetaMask popup appears** when clicking "Sign In"
2. ✅ **Message content is readable** in the popup
3. ✅ **Nonce is unique** for each sign-in attempt
4. ✅ **User rejection handled** gracefully
5. ✅ **Invalid signatures rejected** properly
6. ✅ **Dashboard unlocks** only after verification
7. ✅ **Session persists** appropriately (if needed)

---

### External References & Further Learning

- **EIP-4361 Specification**: https://eips.ethereum.org/EIPS/eip-4361 - The official SIWE standard
- **Ethers.js signMessage**: https://docs.ethers.org/v6/api/providers/#Signer-signMessage - Signing documentation
- **Solidity ecrecover**: https://docs.soliditylang.org/en/latest/units-and-global-variables.html - Built-in functions
- **Sign-In with Ethereum Website**: https://login.xyz - Official SIWE resources
- **OpenZeppelin ECDSA**: https://docs.openzeppelin.com/contracts/5.x/api/utils#ECDSA - Safe signature verification

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
- Create `provider = new ethers.BrowserProvider(window.ethereum)`.
- `const signer = await provider.getSigner()` (async in ethers v6).
- `setAccount(await signer.getAddress())`.

**Full Solution**

```js
const connect = async () => {
  if (!window.ethereum) {
    alert("Install MetaMask");
    return;
  }
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
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

- Use existing `BrowserProvider` & `signer` (await `getSigner()`).
- Create `message = \`Nonce: ${Date.now()}\``.
- `const sig = await signer.signMessage(message)`.
- `setSignature(sig)`.

**Full Solution**

```js
const sign = async () => {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
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

1. Hash the message: `const msgHash = ethers.id(message)`.
2. `ethers.Signature.from(signature)` → `{ v, r, s }`.
3. Instantiate `provider = new ethers.JsonRpcProvider(RPC_URL)`.
4. `const contract = new ethers.Contract(addr, abi, provider)`.
5. `const ok = await contract.verify(account, msgHash, v, r, s)`.
6. `if ok, setIsValid(true)`; else alert failure.

**Full Solution**

```js
const verifyOnChain = async () => {
  const msgHash = ethers.id(message);
  const { v, r, s } = ethers.Signature.from(signature);
  const provider = new ethers.JsonRpcProvider(
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
    BrowserProvider: jest.fn(() => ({
      getSigner: async () => ({
        getAddress: () => Promise.resolve("0xABC"),
      }),
    })),
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
    BrowserProvider: jest.fn(() => ({
      getSigner: async () => ({
        signMessage: () => Promise.resolve(fakeSig),
      }),
    })),
    JsonRpcProvider: jest.fn(),
    id: jest.fn(() => "0xhash"),
    Signature: {
      ...original.Signature,
      from: jest.fn(() => ({ v: 27, r: "0x1", s: "0x2" })),
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
