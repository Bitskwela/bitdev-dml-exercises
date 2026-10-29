## 🧑‍💻 Background Story

![Read-Only DApps](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+2.0+-+COVER.png)

Odessa squished into the LRT car, earbuds in, phone buzzing with a DM from a California startup founder: “Show me you can fetch NFT metadata on‐chain.” Her heart raced. This was her chance to prove she wasn’t just another “crypto tourist.”

Moments earlier, at a Quiapo co‐working space, she’d deployed a simple NFT contract on the Sepolia testnet and minted a handful of “QuiapoArt” tokens. Each token had a URI pointing to Pinoy‐inspired artwork. Now, as the train rattled past church bells and sari‐sari stores, she sketched out a React UI. It would show the contract’s name, symbol and total minted count, plus a lookup field to fetch one token’s URI.

With every clack of the rails, Odessa pieced together Ethers.js calls: `contract.name()`, `contract.symbol()`, `contract.totalMinted()`, `contract.tokenURIs(id)`. By the time the train pulled into Monumento, her read‐only interface was pulling real Sepolia data into her browser. She tapped “Get Token URI” and watched the IPFS link appear.

That evening, Odessa dialed into the Zoom pitch. When the founder saw “QuiapoArt (QART) – Total Minted: 5” and a working URI lookup, he leaned in: “Impressive, you really know your stuff.” Odessa smiled at the Manila skyline on her laptop wallpaper. From LRT to VC approval, she’d nailed it.

![Read-Only DApps Zoom](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+2.1.png)

Welcome to **Read‐Only DApps**. Writing transactions comes next. Tonight, she basks in fetch‐only glory. 🇵🇭🚆💥

---

## 📚 Theory & Web3 Lecture

### 1. Understanding Read-Only DApp Architecture

Before diving into code, let's pin down what "reading from a smart contract" means and why it is different from other blockchain operations.

#### **What is a Read-Only Operation?**

Blockchain operations fall into two categories:

| Operation Type          | Gas Required? | Changes Blockchain? | Example                            |
| ----------------------- | ------------- | ------------------- | ---------------------------------- |
| **Read (View/Pure)**    | ❌ No         | ❌ No               | Getting NFT name, checking balance |
| **Write (Transaction)** | ✅ Yes        | ✅ Yes              | Minting NFT, transferring tokens   |

A read is answered by one node from its copy of the chain. Nothing gets mined, so it costs no gas and needs no wallet. This lesson is all reads. Writes come in the next lesson.

#### **The Three Players in Our Architecture**

**1. React Frontend** (Your User Interface)

- Uses React Hooks (`useState`, `useEffect`) to manage data
- Displays blockchain information in a user-friendly way
- Handles user interactions (like entering a token ID)

**2. Ethers.js v6** (The Communication Layer)

- Connects to the network through a JSON-RPC provider
- Turns your JavaScript calls into blockchain requests
- Turns the responses back into JavaScript values

**3. Smart Contract** (The Data Source)

- Lives on the blockchain at a unique address
- Exposes public functions that anyone can call
- For our NFT contract, these functions include:

```
┌─────────────────────────────────────────────────────┐
│                  SimpleNFT Contract                 │
├─────────────────────────────────────────────────────┤
│  name()           → returns "QuiapoArt"             │
│  symbol()         → returns "QART"                  │
│  totalMinted()    → returns 5n (a bigint)           │
│  tokenURIs(id)    → returns "ipfs://..." (metadata) │
└─────────────────────────────────────────────────────┘
```

#### **How Data Flows from Blockchain to Browser**

```
┌──────────┐    ┌───────────┐    ┌──────────────┐    ┌────────────┐
│  React   │───▶│ Ethers.js │───▶│ RPC Provider │───▶│ Blockchain │
│   UI     │◀───│           │◀───│ (Infura/etc) │◀───│ (Sepolia)  │
└──────────┘    └───────────┘    └──────────────┘    └────────────┘
     ▲                                                      │
     │              Your call: contract.name()              │
     └──────────────────────────────────────────────────────┘
                   Response: "QuiapoArt"
```

---

### 2. Key Concepts Explained

#### **What is a Provider?**

A **Provider** is your connection to the blockchain. Think of it as a phone line to Ethereum. Ethers v6 has two you will use all chapter:

- **`ethers.JsonRpcProvider(url)`** talks straight to an RPC node, such as Infura or Alchemy. It needs no wallet, which makes it perfect for reading.
- **`ethers.BrowserProvider(window.ethereum)`** talks through the user's MetaMask. You need it when the user must sign something (next lesson).

```js
import { ethers } from "ethers";

// Direct connection (no wallet needed) — use this for reads
const readProvider = new ethers.JsonRpcProvider(
  "https://sepolia.infura.io/v3/YOUR_KEY"
);

// Through MetaMask — needed later for writes
const walletProvider = new ethers.BrowserProvider(window.ethereum);
```

> If an older tutorial shows `ethers.providers.JsonRpcProvider` or `ethers.providers.Web3Provider`, that is ethers **version 5**. Version 6 removed the `providers` namespace, so that code throws on this platform. <!-- v5-ok -->

#### **What is a Contract Instance?**

A **Contract Instance** is a JavaScript object that stands for one deployed smart contract. To create one, you need:

1. **Contract Address**: where the contract lives on the blockchain (like `0x1234...`)
2. **ABI (Application Binary Interface)**: a description of the contract's functions
3. **Provider or Signer**: how to connect (a provider for reading, a signer for writing)

```js
const contract = new ethers.Contract(address, abi, provider);
```

Every function listed in the ABI becomes a method on `contract`, so `contract.name()` calls the contract's `name()` function.

#### **What is an ABI?**

The **ABI** tells Ethers.js which functions exist on the contract and how to encode a call to each one. It's like the menu at a carinderia: it lists what you can order.

Ethers v6 accepts a compact, "human-readable" ABI, which is a list of Solidity signatures. This is the ABI used in this lesson's activity:

```js
[
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function totalMinted() view returns (uint256)",
  "function tokenURIs(uint256) view returns (string)"
]
```

Compilers produce a longer JSON form of the same information, and ethers accepts that too. You typically get the ABI by:

- Compiling your Solidity contract with Hardhat or Foundry (look in the build output)
- Copying it from the "Contract" tab of a verified contract on Etherscan

---

### 3. Step-by-Step Setup Guide

#### **Step 1: Install Dependencies**

```bash
npm install ethers
```

This installs ethers version 6, the version this course uses.

#### **Step 2: Configure Environment Variables**

Put the RPC URL and contract address in a `.env` file in your project root. In a Vite React project, variables must start with `VITE_` and you read them with `import.meta.env`:

```bash
# .env (Vite project)
VITE_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
VITE_CONTRACT_ADDRESS=0xYourSimpleNFTAddress
```

```js
const rpcUrl = import.meta.env.VITE_RPC_URL;
```

**In this course's activity editor**, the values are already provided for you as `process.env.REACT_APP_RPC_URL` and `process.env.REACT_APP_CONTRACT_ADDRESS`, the older Create React App naming. Use those names in the activity. In your own Vite project, use the `VITE_` names above.

**⚠️ Important Security Notes:**

- Never commit `.env` to Git (add it to `.gitignore`).
- Anything a frontend reads ends up in the JavaScript the browser downloads, so a visitor can see your RPC URL. Use a key restricted to your site's domain, and keep truly secret keys on a server.

#### **Step 3: Get Your RPC URL**

You need an RPC endpoint for Sepolia. These providers have free tiers (check their sites for current limits):

| Provider      | Sign Up               |
| ------------- | --------------------- |
| **Infura**    | https://infura.io     |
| **Alchemy**   | https://alchemy.com   |
| **QuickNode** | https://quicknode.com |

#### **Step 4: Create the Contract Instance**

```js
import { ethers } from "ethers";
import abi from "./abi/SimpleNFT.json";

// Create provider (connection to blockchain)
const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);

// Create contract instance (JavaScript representation of the smart contract)
const contract = new ethers.Contract(
  import.meta.env.VITE_CONTRACT_ADDRESS, // Where the contract lives
  abi, // What functions it has
  provider // How to connect
);

// Now you can call any view function (inside an async function)
const name = await contract.name(); // "QuiapoArt"
```

---

### 4. Building the NFTReader Component

Now let's build a complete React component that reads NFT data, piece by piece. This version adds loading and error states. The activity uses a smaller version, and its instructions give you the exact code to write.

#### **Complete Component Code with Detailed Comments**

```js
// src/components/NFTReader.jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

// One read-only provider and contract for the whole module. They hold no
// per-user state, so there is no need to rebuild them on every render.
const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
const contract = new ethers.Contract(
  import.meta.env.VITE_CONTRACT_ADDRESS,
  abi,
  provider
);

export default function NFTReader() {
  // Contract metadata (loaded once on mount)
  const [name, setName] = useState(""); // NFT collection name
  const [symbol, setSymbol] = useState(""); // NFT ticker symbol
  const [total, setTotal] = useState(0); // Total NFTs minted

  // User input and fetched data
  const [tokenId, setTokenId] = useState(0); // Which token to look up
  const [uri, setUri] = useState(""); // The token's metadata URI

  // Loading and error states (good UX practice!)
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadContractData() {
      try {
        setLoading(true);
        setError(null);

        // Fetch three values in parallel instead of one after another
        const [fetchedName, fetchedSymbol, fetchedTotal] = await Promise.all([
          contract.name(), // string
          contract.symbol(), // string
          contract.totalMinted(), // bigint, e.g. 5n
        ]);

        setName(fetchedName);
        setSymbol(fetchedSymbol);
        // uint256 arrives as a JavaScript bigint in ethers v6.
        // A small count like this is safe to convert with Number().
        setTotal(Number(fetchedTotal));
      } catch (err) {
        console.error("Error loading contract data:", err);
        setError(
          "Failed to load contract data. Check your RPC URL and contract address."
        );
      } finally {
        setLoading(false);
      }
    }

    loadContractData();
  }, []); // Empty array = run once when the component mounts

  const fetchTokenURI = async () => {
    // Validate input before making a blockchain call
    if (!Number.isInteger(tokenId) || tokenId < 0 || tokenId >= total) {
      alert(`Please enter a token ID between 0 and ${total - 1}`);
      return;
    }

    try {
      const fetchedUri = await contract.tokenURIs(tokenId);
      setUri(fetchedUri);
    } catch (err) {
      console.error("Error fetching token URI:", err);
      alert("Failed to fetch URI. The token might not exist.");
    }
  };

  if (loading) {
    return <div style={{ padding: 20 }}>Loading contract data...</div>;
  }

  if (error) {
    return <div style={{ padding: 20, color: "red" }}>{error}</div>;
  }

  // Browsers cannot open ipfs:// links directly, so link through a gateway.
  const gatewayUrl = uri.replace("ipfs://", "https://ipfs.io/ipfs/");

  return (
    <div style={{ padding: 20 }}>
      <h2>
        {name} ({symbol})
      </h2>
      <p>Total Minted: {total}</p>

      <div style={{ marginTop: 20 }}>
        <label>
          Token ID:
          <input
            type="number"
            min="0"
            max={total - 1}
            value={tokenId}
            onChange={(e) => setTokenId(Number(e.target.value))}
            style={{ marginLeft: 10, width: 80 }}
          />
        </label>
        <button onClick={fetchTokenURI} style={{ marginLeft: 10 }}>
          Get Token URI
        </button>
      </div>

      {uri && (
        <div style={{ marginTop: 20 }}>
          <strong>URI: </strong>
          <a href={gatewayUrl} target="_blank" rel="noopener noreferrer">
            {uri}
          </a>
        </div>
      )}
    </div>
  );
}
```

#### **Understanding Key Patterns**

**Pattern 1: Using `Promise.all` for Parallel Requests**

```js
// ❌ SLOWER - three round trips, one after another
const name = await contract.name();
const symbol = await contract.symbol();
const total = await contract.totalMinted();

// ✅ FASTER - all three requests are in flight at the same time
const [name, symbol, total] = await Promise.all([
  contract.name(),
  contract.symbol(),
  contract.totalMinted(),
]);
```

Each call goes over the network to the RPC node, so waiting for one before sending the next adds up. `Promise.all` sends all three and waits once.

**Pattern 2: Handling `uint256` Values (bigint)**

Solidity's `uint256` can hold numbers far bigger than a normal JavaScript number can represent exactly. So ethers v6 returns them as a **bigint**, a built-in JavaScript type for whole numbers of any size. You can spot one by the `n` at the end:

```js
const total = await contract.totalMinted();
console.log(total); // 5n
console.log(typeof total); // "bigint"
console.log(Number(total)); // 5     — fine for small counts
console.log(total.toString()); // "5"  — safe for any size

// Math between a bigint and a normal number throws:
// total + 1  → TypeError: Cannot mix BigInt and other types
console.log(total + 1n); // 6n — keep both sides bigint
```

Use `Number(x)` only when you know the value is small, like a count of NFTs. For token balances in wei, keep the bigint and format it with `ethers.formatEther(x)` or `ethers.formatUnits(x, decimals)`. A later lesson covers this.

> Ethers **version 5** returned a `BigNumber` object instead, converted with `.toNumber()`. That method does not exist on a bigint, so v5 code that calls it fails here. <!-- v5-ok -->

**Pattern 3: Input Validation**

```js
// Always validate before making blockchain calls
if (!Number.isInteger(tokenId) || tokenId < 0 || tokenId >= total) {
  alert("Invalid token ID");
  return; // Stop here, don't make the call
}
```

If only 5 tokens exist, their IDs are 0 to 4. Asking for token 5 would make the contract revert, or return an empty string, depending on how it was written. Checking first saves a network trip and lets you give the user a clear message.

---

### 5. Security & Best Practices

#### **1. Always Validate User Input**

Never trust input from a text box. Check that it is a whole number and inside the valid range before you call the contract, as in Pattern 3.

#### **2. Always Use Try/Catch for RPC Calls**

Blockchain calls can fail for many reasons, so handle errors gracefully. Ethers v6 gives every error a `code`, and `ethers.isError` checks it for you:

```js
try {
  const uri = await contract.tokenURIs(tokenId);
  setUri(uri);
} catch (error) {
  console.error("RPC Error:", error);

  if (ethers.isError(error, "CALL_EXCEPTION")) {
    alert("The contract rejected that call — this token may not exist.");
  } else if (ethers.isError(error, "NETWORK_ERROR")) {
    alert("Network error. Please try again.");
  } else {
    alert("An error occurred. Check the console for details.");
  }
}
```

#### **3. Keep Your `.env` Out of Git**

```bash
# .gitignore - ALWAYS include this!
.env
.env.local
.env.*.local
```

Remember that this keeps the key out of your repository, not out of the browser. For production apps, consider:

- A backend proxy that holds the RPC key
- Domain restrictions on the key in your RPC provider's dashboard
- Rate limiting requests

#### **4. Handle Loading and Error States**

Good UX means showing users what's happening:

```js
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);

// In your fetch function
setLoading(true);
try {
  // ... fetch data
} catch (err) {
  setError(err.message);
} finally {
  setLoading(false);
}

// In your render
if (loading) return <p>Loading...</p>;
if (error) return <p style={{ color: "red" }}>{error}</p>;
```

---

### 6. Common Mistakes to Avoid

1. **Forgetting that `uint256` is a bigint**

   ```js
   const total = await contract.totalMinted();
   // ❌ Throws: Cannot mix BigInt and other types
   console.log(total + 1);

   // ✅ Correct
   console.log(Number(total) + 1); // 6
   ```

2. **Copying ethers v5 code from an old tutorial**

   `ethers.providers.JsonRpcProvider` and `.toNumber()` are version 5. In version 6, write `new ethers.JsonRpcProvider(url)` and `Number(x)`. <!-- v5-ok -->

3. **Building the provider during every render**

   ```js
   // ❌ Wasteful - a new provider every time the component renders
   function Component() {
     const provider = new ethers.JsonRpcProvider(url);
     // ...
   }

   // ✅ Good - create it once, outside the component (as in the example
   // above), inside the useEffect/handler that uses it, or with useMemo
   const provider = useMemo(() => new ethers.JsonRpcProvider(url), [url]);
   ```

4. **Updating state after the component is gone**

   ```js
   // ❌ Potential bug - component might unmount before the data arrives
   useEffect(() => {
     fetchData().then((data) => setData(data));
   }, []);

   // ✅ Better - ignore the result if the component unmounted
   useEffect(() => {
     let isMounted = true;
     fetchData().then((data) => {
       if (isMounted) setData(data);
     });
     return () => {
       isMounted = false;
     };
   }, []);
   ```

---

### 7. Testing Your Read Operations

After implementing, check these scenarios in your own app:

1. ✅ **Initial load**: contract name, symbol and total display correctly
2. ✅ **Valid token ID**: entering a valid ID and clicking "Get Token URI" shows the URI
3. ✅ **Invalid token ID**: an out-of-range ID shows a message and makes no call
4. ✅ **Network error**: a wrong RPC URL shows an error instead of a blank page
5. ✅ **Loading state**: a loading message appears while fetching

**How this is graded:** the platform mounts your component against a pretend Sepolia contract that returns `"Sining Chain"`, `"SNG"` and a total of `3n`. It checks that you used a `JsonRpcProvider`, read all three values, rendered them, and called `tokenURIs` when the **Get Token URI** button is clicked. It also checks that an out-of-range ID is refused without a call. The activity page lists the exact labels it looks for.

---

### 8. What's Next?

Now that you can **read** from smart contracts, the next steps are:

- **Writing to contracts** (sending a transaction signed by the user's wallet)
- **Listening to events** (real-time updates when something happens on-chain)
- **Displaying NFT images** (fetching and parsing IPFS metadata)

---

### External References & Further Learning

- **Ethers.js v6 Documentation**: https://docs.ethers.org/v6/ - Providers, contracts and the full API
- **Ethers v6 Migration Notes**: https://docs.ethers.org/v6/migrating/ - What changed from v5 to v6
- **ERC-721 Standard**: https://eips.ethereum.org/EIPS/eip-721 - The NFT specification
- **Vite Environment Variables**: https://vite.dev/guide/env-and-mode - How `VITE_` variables work
- **IPFS Gateways**: https://docs.ipfs.tech/concepts/ipfs-gateway/ - How `ipfs://` links are served over HTTPS

---

## 🌟 Closing Story

Later that night, Odessa replayed her Zoom pitch, watching the founder’s jaw drop as live Sepolia data filled her UI. She’d bridged Manila’s LRT chaos and Silicon Valley’s expectations with a few Ethers.js calls.

Tomorrow, she’ll write to a contract: send a transaction, wait for it to be mined, and update the screen. From read‐only glory to full DApp mastery, Odessa’s Pinoy spirit is unstoppable. Next stop: **Triggering a Function**! 🚀🪙✨
