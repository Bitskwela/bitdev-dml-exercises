## 🧑‍💻 Background Story

![Sign-In with Ethereum](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+5.0+-+COVER.png)

At a Manila Web3 startup, the HR team wanted a better way into their internal “Hire Filipino Talent” dashboard. Paper resumes and password resets? Nakakabored! Neri had an idea: “Let’s sign in with Ethereum.”

That evening, Odessa joined via Zoom from her co-working nook in Brooklyn. Neri had deployed a tiny `Authenticator` contract on Sepolia. Its only job was to check, with math, whether a signature really came from a given wallet. Odessa’s mission was the React side:

1. **Connect** the user’s MetaMask wallet
2. **Build** a sign-in message that includes a nonce
3. **Ask** the user to sign it
4. **Call** the contract’s read-only `verify()` to check that the signer matches the wallet
5. **Unlock** the dashboard on success

Odessa wired up Ethers.js, signed, called `verify()`, and watched the dashboard appear. No passwords anywhere. The HR team gasped: “Ayos ‘to!”

Then Neri, ever the careful one, added: “Ganda. But remember, this only proves the signature math in the browser. Before real HR data goes behind it, a server has to check the signature too.” Odessa nodded and wrote it on a sticky note. You will see exactly why below.

![SIWE Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+5.1.png)

---

## 📚 Theory & Web3 Lecture

Instead of a username and password stored in a database, a user can prove they control a wallet by **signing a message** with it. This lesson builds that flow in React with ethers v6, verifies the signature with a smart contract, and is honest about what a frontend-only check can and cannot protect.

---

### 1. What Is Sign-In with Ethereum?

#### **Passwords vs. Signatures**

```
Traditional Login:
┌─────────────────────────────────────────────────────────────┐
│  User → enters username/password → Server checks database   │
│                                                             │
│  Problems:                                                  │
│  • Password databases get breached                          │
│  • Users forget passwords                                   │
│  • Needs "Forgot Password" flows                            │
└─────────────────────────────────────────────────────────────┘

Wallet Login:
┌─────────────────────────────────────────────────────────────┐
│  User → signs a message with wallet → Signature is checked  │
│                                                             │
│  Benefits:                                                  │
│  • No password to steal or forget                           │
│  • The private key never leaves the wallet                  │
│  • The same wallet works across many apps                   │
└─────────────────────────────────────────────────────────────┘
```

#### **How Does It Work?**

Your wallet holds a **private key** (your secret stamp) and shows a **public address** (like an ID number). When you sign a message:

1. Your private key produces a signature for that exact message
2. Anyone with the message and the signature can work out which address signed it
3. Nobody can produce a valid signature for your address without your private key

```
Signing:
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
                                       Does it match the claimed address?
                                       ✅ Yes = signature is genuine
                                       ❌ No  = reject
```

#### **EIP-4361: The SIWE Standard**

"Sign-In with Ethereum" (SIWE) is a standard, EIP-4361, for what a login message should say, so that wallets can show it clearly and apps can check it the same way. A SIWE message includes:

| Field         | Purpose                     | Example                       |
| ------------- | --------------------------- | ----------------------------- |
| **Domain**    | Which site is asking        | `app.example.com`             |
| **Address**   | The signing wallet          | `0xABC...123`                 |
| **Statement** | Human-readable purpose      | "Sign in to access dashboard" |
| **URI**       | Full URL of the app         | `https://app.example.com`     |
| **Version**   | Message format version      | `1`                           |
| **Chain ID**  | Which network               | `11155111` (Sepolia)          |
| **Nonce**     | Value the server issued     | `abc123xyz`                   |
| **Issued At** | When the message was made   | `2026-01-15T10:30:00Z`        |

This lesson uses a simpler message, `Sign in to Dashboard` plus a nonce, to keep the focus on signing and verifying. A production app should use the full format, usually through a SIWE library.

---

### 2. Understanding Cryptographic Signatures

#### **What Is ECDSA?**

Ethereum signs with **ECDSA** (Elliptic Curve Digital Signature Algorithm). A signature is 65 bytes, made of three parts:

| Component               | What It Is                    | Purpose                    |
| ----------------------- | ----------------------------- | -------------------------- |
| **Message Hash**        | keccak256 of what was signed  | A fixed-size fingerprint   |
| **r**                   | First 32 bytes                | Part of the proof          |
| **s**                   | Next 32 bytes                 | Part of the proof          |
| **v**                   | Last byte: 27 or 28           | Recovery ID, picks the key |

In ethers v6, `ethers.Signature.from(signature)` splits a signature into `v`, `r` and `s` for you.

#### **The Ethereum Signed Message Prefix**

`signer.signMessage(...)` never signs your bytes raw. It first adds a prefix plus the **length** of what you are signing, then hashes that. The prefix stops a website from tricking you into signing something that is secretly a transaction.

```js
// You sign the text:
"Hello, World!";

// The wallet actually hashes:
"\x19Ethereum Signed Message:\n13Hello, World!";
//  ↑ fixed prefix              ↑ length: 13 characters
```

That length is the detail this whole lesson turns on, so keep it in mind.

---

### 3. The Authenticator Smart Contract

#### **The `ecrecover` Function**

Solidity has a built-in, `ecrecover`, that recovers the signing address from a hash and `v`, `r`, `s`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authenticator {
    /// @notice Check that `user` signed the 32-byte `msgHash`
    function verify(
        address user,
        bytes32 msgHash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external pure returns (bool) {
        // The prefix for signing exactly 32 bytes
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";

        // Hash the prefixed message, exactly as the wallet did
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, msgHash));

        // Recover the signer's address from the signature
        address recovered = ecrecover(prefixedHash, v, r, s);

        return recovered == user;
    }
}
```

#### **Read the Prefix Carefully: `\n32`**

The contract hard-codes the length **32**. It expects the wallet to have signed exactly **32 bytes**: the hash `msgHash` itself. So the frontend must:

1. Hash the message text: `const msgHash = ethers.id(message)` (keccak256 of the text, a 32-byte value shown as hex)
2. Sign those **32 bytes**: `signer.signMessage(ethers.getBytes(msgHash))`

```js
const msgHash = ethers.id(message); // "0x5f2c..." (32 bytes as hex)
const signature = await signer.signMessage(ethers.getBytes(msgHash));
```

Why not just `signer.signMessage(message)`? Then the wallet would hash `"\x19Ethereum Signed Message:\n" + <length of the text> + <the text>`. Our message (`Sign in to Dashboard`, two newlines, then `Nonce: ` and a 13-digit timestamp) is 42 characters long, so the prefix would say `\n42`, not `\n32`. The contract would rebuild a different hash, `ecrecover` would return some unrelated address, and `verify()` would return `false` every time, however correct the rest of your code is.

And why `ethers.getBytes(...)`? In ethers v6, `signMessage` treats a **string** as text, even a hex string like `"0x5f2c..."`. It would sign those 66 characters as text, length 66. `ethers.getBytes` turns the hex into a real 32-byte `Uint8Array`, which is what the contract expects.

| What you pass to `signMessage`        | Prefix the wallet uses | Verifies with this contract? |
| ------------------------------------- | ---------------------- | ---------------------------- |
| `message` (the text)                  | `\n` + text length     | ❌ Never                     |
| `ethers.id(message)` (a hex string)   | `\n66`                 | ❌ Never                     |
| `ethers.getBytes(ethers.id(message))` | `\n32`                 | ✅ Yes                       |

One honest trade-off: because the user signs a hash, MetaMask shows them a string of hex characters instead of your readable message. Real SIWE signs the readable text and checks it on a server with `ethers.verifyMessage(message, signature)`. Contracts that check readable text use a length-aware helper, such as OpenZeppelin's `MessageHashUtils.toEthSignedMessageHash(bytes)`. This lesson's contract is the simple 32-byte kind, so we sign the hash.

#### **Key Points**

1. **`pure` function**: it neither reads nor changes state. Called from the frontend, it runs as a free read (an `eth_call`) and costs no gas.
2. **The prefix must match**: the contract's `\n32` decides what you must sign.
3. **`ecrecover` returns `address(0)` for an invalid signature.** With this contract, passing `user = 0x000…000` and garbage `v, r, s` would return `true`. Audited libraries like OpenZeppelin's `ECDSA.recover` revert on invalid signatures instead, which is why real projects use them.

---

### 4. React + Ethers.js v6 Sign-In Flow

#### **Complete Authentication Flow**

```
┌─────────────────────────────────────────────────────────────────┐
│                    Wallet Sign-In Flow                          │
├─────────────────────────────────────────────────────────────────┤
│  Step 1: Connect     → MetaMask popup → read signer.getAddress()│
│  Step 2: Sign In     → build message with nonce                 │
│                        → sign getBytes(id(message))             │
│  Step 3: Verify      → split signature into v, r, s             │
│                        → contract.verify(account, id(message),  │
│                                          v, r, s)               │
│  Step 4: Unlock      → ✅ true  → show dashboard                │
│                        ❌ false → show error                    │
└─────────────────────────────────────────────────────────────────┘
```

#### **Step-by-Step Code (ethers v6)**

**Step 1: Connect Wallet**

```js
// Ask MetaMask for permission
await window.ethereum.request({ method: "eth_requestAccounts" });

// Wrap MetaMask and get the signer (await: getSigner() is async in v6)
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();

// The address of the account that will sign
const userAddress = await signer.getAddress();
console.log("Connected:", userAddress); // "0xABC...123"
```

> Ethers **version 5** wrote `new ethers.providers.Web3Provider(window.ethereum)` with a synchronous `getSigner()`. That throws on v6. <!-- v5-ok -->

**Step 2: Build the Message**

```js
const nonce = Date.now().toString();
const message = `Sign in to Dashboard\n\nNonce: ${nonce}`;
```

**Step 3: Sign the 32-Byte Hash**

```js
// MetaMask opens a "Signature request" popup
const signature = await signer.signMessage(
  ethers.getBytes(ethers.id(message))
);
console.log("Signature:", signature); // "0x7f8a2b..." (65 bytes as hex)
```

**Step 4: Prepare for Verification**

```js
// The same hash the user signed
const msgHash = ethers.id(message);

// Split the signature into v, r, s
const { v, r, s } = ethers.Signature.from(signature);

console.log("v:", v); // 27 or 28
console.log("r:", r); // "0x..." (32 bytes)
console.log("s:", s); // "0x..." (32 bytes)
```

> In ethers **version 5** these were `ethers.utils.id` and `ethers.utils.splitSignature`. In v6 they are `ethers.id` and `ethers.Signature.from`. <!-- v5-ok -->

**Step 5: Verify with the Contract**

```js
// verify() is pure, so a read-only provider is enough
const readProvider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
const contract = new ethers.Contract(
  import.meta.env.VITE_CONTRACT_ADDRESS,
  authenticatorAbi,
  readProvider
);

const isValid = await contract.verify(userAddress, msgHash, v, r, s);

if (isValid) {
  console.log("✅ Signature verified");
} else {
  console.log("❌ Invalid signature");
}
```

You can check the same thing without any contract: `ethers.verifyMessage(ethers.getBytes(msgHash), signature)` returns the signer's address.

---

### 5. Security: What This Flow Does and Does Not Protect

This is the most important section of the lesson. Read it slowly.

#### **What a Signature Proves**

A valid signature proves one thing: **whoever produced it controls the private key of that address.** That is a strong, useful fact.

#### **What a Frontend-Only Gate Does Not Protect**

In this lesson, the "dashboard" appears because a React state variable flips to `true`. All of that runs in the user's own browser, which they control completely. Anyone can open the developer tools and set that variable to `true`, or simply read data that was already sent to the page. So:

- **Never put secret data behind a frontend-only check.** If the browser already received it, it is not protected.
- Real protection needs a **server**. The server checks the signature, then issues a session (a cookie or token). It sends private data only to requests that carry a valid session.

#### **Nonces and Replay: The Honest Version**

A **replay attack** is when someone captures a valid signed message and presents it again later to log in as you.

A nonce defends against replay **only if a server controls it**:

1. The server generates a random nonce and remembers it
2. The user signs a message containing that nonce
3. The server checks the signature **and** that the nonce is one it issued and has not used yet
4. The server marks the nonce as used, so the same signature never works twice

In this lesson's activity, the nonce is `Date.now()`, made **in the browser**, and nothing remembers it. That makes each message different, which is good practice and shows you where the nonce goes. It does **not** stop a replay: anyone holding an old message and signature could pass them to `verify()` again, and it would still return `true`, because the contract has no memory of past nonces. Treat the activity as practice in the signing and verifying mechanics, not as a secure login.

#### **Message Expiration**

Add an issued-at time and an expiry to the message, and have the **server** reject old ones:

```js
const issuedAt = new Date().toISOString();
const expiresAt = new Date(Date.now() + 5 * 60 * 1000).toISOString(); // 5 minutes

const message = `Sign in to Dashboard

Nonce: ${nonce}
Issued At: ${issuedAt}
Expiration Time: ${expiresAt}`;
```

#### **Common Security Mistakes**

| Mistake                              | Risk                                | Solution                                    |
| ------------------------------------ | ----------------------------------- | ------------------------------------------- |
| Trusting a frontend-only check       | Anyone can flip the state           | Verify on a server, then issue a session    |
| Nonce made and checked nowhere       | Old signatures can be replayed      | Server issues, stores and consumes nonces   |
| No expiration                        | Old signatures stay valid           | Add an expiry, enforce it on the server     |
| Signing the text for a `\n32` check  | Never verifies                      | Sign `ethers.getBytes(ethers.id(message))`  |
| Hand-rolled `ecrecover`              | `address(0)` and malleability traps | Use OpenZeppelin `ECDSA` in contracts       |
| Storing private keys in the app      | Keys can be stolen                  | Never. The wallet signs; the app never sees keys |

---

### 6. Common Mistakes & Debugging

#### **1. `verify()` Always Returns `false`**

Almost always this is a hash or prefix mismatch:

```js
// ❌ Signs the text: wallet prefixes "\n42" (the text's length), contract expects "\n32"
const signature = await signer.signMessage(message);

// ❌ Signs the hex string as text: wallet prefixes "\n66"
const signature = await signer.signMessage(ethers.id(message));

// ✅ Signs the 32 hash bytes: wallet prefixes "\n32", matching the contract
const signature = await signer.signMessage(ethers.getBytes(ethers.id(message)));
```

Also check that you pass `ethers.id(message)` (the hash) to `verify()`, not the message text, and that `message` is exactly the same string you signed.

#### **2. User Rejects Signing**

```js
try {
  const signature = await signer.signMessage(ethers.getBytes(ethers.id(message)));
} catch (err) {
  if (ethers.isError(err, "ACTION_REJECTED")) {
    // The user clicked "Reject" in MetaMask
    console.log("User cancelled signing");
    return;
  }
  throw err;
}
```

#### **3. Wrong Contract Address**

```js
// Check that there is a contract at the address
const code = await readProvider.getCode(contractAddress);
if (code === "0x") {
  throw new Error("No contract at this address!");
}
```

---

### 7. Testing Your Sign-In Flow

On Sepolia, check:

1. ✅ **MetaMask popup appears** when clicking "Sign In"
2. ✅ **A new nonce** appears in each message you build
3. ✅ **User rejection handled** gracefully
4. ✅ **A wrong signature is rejected** (try changing one character of the message before verifying)
5. ✅ **Dashboard unlocks** only after `verify()` returns `true`

**How this is graded:** the platform mounts your component against a pretend MetaMask and a pretend `Authenticator`. It clicks **Connect**, **Sign In** and **Verify** in turn. It checks that you read the address with `signer.getAddress()`, and that the message you hash with `ethers.id()` contains a nonce. It also checks that what you pass to `signMessage` is the 32 hash bytes, not text. Finally it checks that you call `contract.verify(...)` and then show the dashboard. The activity page lists the exact labels and wording it looks for.

---

### External References & Further Learning

- **EIP-4361 (Sign-In with Ethereum)**: https://eips.ethereum.org/EIPS/eip-4361 - The message standard
- **EIP-191 (Signed Data Standard)**: https://eips.ethereum.org/EIPS/eip-191 - Where the `\x19Ethereum Signed Message` prefix comes from
- **Ethers v6 Signers**: https://docs.ethers.org/v6/api/providers/#Signer - `signMessage` and `getAddress`
- **Ethers v6 Signatures**: https://docs.ethers.org/v6/api/crypto/#Signature - `Signature.from` and `v`, `r`, `s`
- **Solidity `ecrecover`**: https://docs.soliditylang.org/en/latest/units-and-global-variables.html#mathematical-and-cryptographic-functions - The built-in
- **OpenZeppelin ECDSA (v5)**: https://docs.openzeppelin.com/contracts/5.x/api/utils#ECDSA - Safe signature recovery

---

## 🌟 Closing Story

With a few clicks and a signed message, Odessa unlocked the “Hire Filipino Talent” dashboard with no password in sight. Neri beamed from Laguna. Then she pointed at the sticky note on Odessa’s monitor: “Server checks the signature. Server owns the nonce.”

Next on their roadmap: a small backend that issues nonces and sessions, so the wallet login protects real data. For now, Odessa understands exactly what a signature proves, and what it doesn't. That is how Pinoy builders ship auth: maganda *and* tapat. 🇵🇭🔑🚀
