## 🧑‍💻 Background Story

![Read-Only DApps](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+2.0+-+COVER.png)

Odessa squished into the LRT car, earbuds in, phone buzzing with a DM from a California startup founder: “Show me you can fetch NFT metadata on‐chain.” Her heart raced—this was her ticket to proving she wasn’t just another “crypto tourist.”

Moments earlier, at a Quiapo co‐working space, she’d deployed a simple ERC-721 contract on Sepolia, minting a handful of “QuiapoArt” tokens with unique URIs, each pointing to Pinoy‐inspired artwork. Now, as the train rattled past church bells and sari–sari stores, she sketched out a React UI: display the contract’s name, symbol, total minted count, plus a lookup field to fetch a token’s URI.

With every clack of the rails, Odessa pieced together Ethers.js calls: `contract.name()`, `contract.symbol()`, `contract.totalMinted()`, `contract.tokenURIs(id)`. By the time she reached Ascencion Station, her read‐only interface was live—pulling real Sepolia data into her browser. She tapped “Get Token URI” and watched the IPFS link appear.

That evening, Odessa dialed into the Zoom pitch. As the founder saw “QuiapoArt (QART) – Total Minted: 5” and a live URI field, he leaned in: “Impressive, you really know your stuff.” Odessa closed her eyes, smiling at Manila’s skyline in her laptop wallpaper. From LRT to VC approval—she’d nailed it.

![Read-Only DApps Zoom](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+2.1.png)

Welcome to **Read‐Only DApps**. Next up: writing transactions to mint and transfer. But tonight, she basks in fetch‐only glory. 🇵🇭🚆💥

---

## 📚 Theory & Web3 Lecture

### 1. Understanding Read-Only DApp Architecture

Before diving into code, let's understand what "reading from a smart contract" actually means and why it's different from other blockchain operations.

#### **What is a Read-Only Operation?**

Blockchain operations fall into two categories:

| Operation Type          | Gas Required? | Changes Blockchain? | Example                            |
| ----------------------- | ------------- | ------------------- | ---------------------------------- |
| **Read (View/Pure)**    | ❌ No         | ❌ No               | Getting NFT name, checking balance |
| **Write (Transaction)** | ✅ Yes        | ✅ Yes              | Minting NFT, transferring tokens   |

This lesson focuses on **read operations**—they're free, fast, and perfect for displaying blockchain data in your UI!

#### **The Three Players in Our Architecture**

**1. React Frontend** (Your User Interface)

- Uses React Hooks (`useState`, `useEffect`) to manage data
- Displays blockchain information in a user-friendly way
- Handles user interactions (like entering a token ID)

**2. Ethers.js** (The Communication Layer)

- Connects to the Ethereum network via a JSON-RPC provider
- Translates your JavaScript calls into blockchain requests
- Parses blockchain responses back into JavaScript objects

**3. Smart Contract** (The Data Source)

- Lives on the blockchain with a unique address
- Exposes public functions that anyone can call
- For our NFT contract, these functions include:

```
┌─────────────────────────────────────────────────────┐
│                  SimpleNFT Contract                  │
├─────────────────────────────────────────────────────┤
│  name()           → returns "QuiapoArt"             │
│  symbol()         → returns "QART"                  │
│  totalMinted()    → returns 5 (number of NFTs)      │
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

A **Provider** is your connection to the blockchain. Think of it as a phone line to Ethereum:

- **Without MetaMask**: Use `JsonRpcProvider` with an RPC URL (like Infura or Alchemy)
- **With MetaMask**: Use `BrowserProvider` which connects through the user's wallet

For read-only operations, we don't need MetaMask! We can connect directly to the blockchain using a public RPC endpoint.

```js
// Direct connection (no wallet needed)
const provider = new ethers.JsonRpcProvider(
  "https://sepolia.infura.io/v3/YOUR_KEY"
);

// Through MetaMask (needed for write operations)
const provider = new ethers.BrowserProvider(window.ethereum);
```

#### **What is a Contract Instance?**

A **Contract Instance** is a JavaScript object that represents a smart contract. To create one, you need:

1. **Contract Address**: Where the contract lives on the blockchain (like `0x1234...`)
2. **ABI (Application Binary Interface)**: A JSON file describing the contract's functions
3. **Provider or Signer**: How to connect (Provider for reading, Signer for writing)

```js
const contract = new ethers.Contract(address, abi, provider);
```

#### **What is an ABI?**

The **ABI** tells Ethers.js what functions exist on the contract and how to call them. It's like a menu at a restaurant—it lists what's available!

```json
// Example ABI snippet for our NFT contract
[
  {
    "name": "name",
    "type": "function",
    "inputs": [],
    "outputs": [{ "type": "string" }]
  },
  {
    "name": "tokenURIs",
    "type": "function",
    "inputs": [{ "name": "tokenId", "type": "uint256" }],
    "outputs": [{ "type": "string" }]
  }
]
```

You typically get the ABI by:

- Compiling your Solidity contract (creates `artifacts/` folder)
- Copying from Etherscan's "Contract" tab
- Exporting from Hardhat/Foundry build output

---

### 3. Step-by-Step Setup Guide

#### **Step 1: Install Dependencies**

```bash
npm install ethers
```

#### **Step 2: Configure Environment Variables**

Create a `.env` file in your project root:

```bash
# .env
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
REACT_APP_CONTRACT_ADDRESS=0xYourSimpleNFTAddress
```

**⚠️ Important Security Notes:**

- Never commit `.env` to git (add it to `.gitignore`)
- In React, environment variables must start with `REACT_APP_`
- For production, use a backend proxy to hide your API keys

#### **Step 3: Get Your RPC URL**

You need an RPC endpoint to connect to the blockchain. Free options:

| Provider      | Free Tier             | Sign Up               |
| ------------- | --------------------- | --------------------- |
| **Infura**    | 100,000 requests/day  | https://infura.io     |
| **Alchemy**   | 300M compute units/mo | https://alchemy.com   |
| **QuickNode** | Limited free tier     | https://quicknode.com |

#### **Step 4: Create the Contract Instance**

```js
import { ethers } from "ethers";
import abi from "./abi/SimpleNFT.json";

// Create provider (connection to blockchain)
const provider = new ethers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);

// Create contract instance (JavaScript representation of the smart contract)
const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS, // Where the contract lives
  abi, // What functions it has
  provider // How to connect
);

// Now you can call any view function!
const name = await contract.name(); // "QuiapoArt"
```

---

### 4. Building the NFTReader Component

Now let's build a complete React component that reads NFT data. We'll break it down piece by piece.

#### **Complete Component Code with Detailed Comments**

```js
// src/components/NFTReader.js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NFTReader() {
  // ============================================
  // STATE VARIABLES
  // ============================================

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

  // ============================================
  // LOAD CONTRACT DATA ON COMPONENT MOUNT
  // ============================================

  useEffect(() => {
    async function loadContractData() {
      try {
        setLoading(true);
        setError(null);

        // Step 1: Create provider (connection to blockchain)
        const provider = new ethers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );

        // Step 2: Create contract instance
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        // Step 3: Fetch multiple values in parallel for efficiency
        // Promise.all runs all calls simultaneously instead of one-by-one
        const [fetchedName, fetchedSymbol, fetchedTotal] = await Promise.all([
          contract.name(), // Returns: string
          contract.symbol(), // Returns: string
          contract.totalMinted(), // Returns: bigint
        ]);

        // Step 4: Update state with fetched values
        setName(fetchedName);
        setSymbol(fetchedSymbol);

        // Note: in ethers v6, Solidity uint256 is returned as a native bigint
        // We convert to a regular JavaScript number for display
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
  }, []); // Empty array = run once when component mounts

  // ============================================
  // FETCH TOKEN URI (User-triggered action)
  // ============================================

  const fetchTokenURI = async () => {
    // Validate input before making blockchain call
    if (tokenId < 0 || tokenId >= total) {
      alert(`Please enter a token ID between 0 and ${total - 1}`);
      return;
    }

    try {
      const provider = new ethers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      // Call the tokenURIs function with the user's input
      const fetchedUri = await contract.tokenURIs(tokenId);
      setUri(fetchedUri);
    } catch (err) {
      console.error("Error fetching token URI:", err);
      alert("Failed to fetch URI. The token might not exist.");
    }
  };

  // ============================================
  // RENDER UI
  // ============================================

  // Show loading state
  if (loading) {
    return <div style={{ padding: 20 }}>Loading contract data...</div>;
  }

  // Show error state
  if (error) {
    return <div style={{ padding: 20, color: "red" }}>{error}</div>;
  }

  return (
    <div style={{ padding: 20 }}>
      {/* Display collection info */}
      <h2>
        {name} ({symbol})
      </h2>
      <p>Total Minted: {total}</p>

      {/* Token lookup section */}
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

      {/* Display fetched URI */}
      {uri && (
        <div style={{ marginTop: 20 }}>
          <strong>URI:</strong>
          <a href={uri} target="_blank" rel="noopener noreferrer">
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
// ❌ SLOW - Sequential calls (one after another)
const name = await contract.name();
const symbol = await contract.symbol();
const total = await contract.totalMinted();
// Total time: ~3 seconds (1s + 1s + 1s)

// ✅ FAST - Parallel calls (all at once)
const [name, symbol, total] = await Promise.all([
  contract.name(),
  contract.symbol(),
  contract.totalMinted(),
]);
// Total time: ~1 second (all run simultaneously)
```

**Pattern 2: Handling bigint**

```js
// In ethers v6, Solidity uint256 returns a native JavaScript bigint, not a regular number
const total = await contract.totalMinted();
console.log(total); // 5n  (note the trailing "n" — that's a bigint literal)
console.log(Number(total)); // 5
console.log(total.toString()); // "5"

// For very large numbers, use toString() to avoid precision loss
const hugeBalance = await contract.balanceOf(address);
console.log(hugeBalance.toString()); // "1000000000000000000" (1 ETH in wei)
```

**Pattern 3: Input Validation**

```js
// Always validate before making blockchain calls
if (tokenId < 0 || tokenId >= total) {
  alert("Invalid token ID");
  return; // Stop here, don't make the call
}
```

---

### 5. Security & Best Practices

#### **1. Always Validate User Input**

Never trust user input—validate before making blockchain calls:

```js
const fetchTokenURI = async () => {
  // Validate token ID is within valid range
  if (tokenId < 0 || tokenId >= total) {
    alert(`Token ID must be between 0 and ${total - 1}`);
    return;
  }

  // Validate it's actually a number
  if (isNaN(tokenId)) {
    alert("Please enter a valid number");
    return;
  }

  // Now safe to make the call
  const uri = await contract.tokenURIs(tokenId);
};
```

#### **2. Debounce Rapid Input Changes**

If you're fetching data on every keystroke, use debouncing to avoid spamming the RPC:

```js
import { useState, useEffect, useCallback } from "react";
import { debounce } from "lodash"; // npm install lodash

// Debounced version only fires after user stops typing for 500ms
const debouncedFetch = useCallback(
  debounce((id) => fetchTokenURI(id), 500),
  []
);

// In your input handler
const handleInputChange = (e) => {
  const newId = Number(e.target.value);
  setTokenId(newId);
  debouncedFetch(newId); // Won't fire until user pauses
};
```

#### **3. Always Use Try/Catch for RPC Calls**

Blockchain calls can fail for many reasons—handle errors gracefully:

```js
try {
  const uri = await contract.tokenURIs(tokenId);
  setUri(uri);
} catch (error) {
  // Common errors:
  // - Network issues (RPC down)
  // - Invalid token ID (doesn't exist)
  // - Contract reverted (custom error)

  console.error("RPC Error:", error);

  // Show user-friendly message
  if (error.code === "CALL_EXCEPTION") {
    alert("This token does not exist");
  } else if (error.code === "NETWORK_ERROR") {
    alert("Network error. Please try again.");
  } else {
    alert("An error occurred. Check console for details.");
  }
}
```

#### **4. Protect Your API Keys**

```bash
# .gitignore - ALWAYS include this!
.env
.env.local
.env.*.local
```

For production apps, consider:

- Using a backend proxy to hide RPC keys
- Rate limiting requests
- Using public RPC endpoints for read-only data

#### **5. Handle Loading and Error States**

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
if (loading) return <Spinner />;
if (error) return <ErrorMessage message={error} />;
return <YourComponent />;
```

---

### 6. Common Mistakes to Avoid

1. **Mixing bigint and number**

   ```js
   // ❌ Wrong - can't add a number to a bigint, this throws a TypeError
   const total = await contract.totalMinted(); // 5n
   console.log(total + 1); // TypeError: Cannot mix BigInt and other types

   // ✅ Correct - convert to a number first (or use a bigint literal: total + 1n)
   console.log(Number(total) + 1); // 6
   ```

2. **Creating provider inside render loop**

   ```js
   // ❌ Bad - creates new provider on every render
   function Component() {
     const provider = new ethers.JsonRpcProvider(url);
     // ...
   }

   // ✅ Good - create once, outside component or with useMemo
   const provider = useMemo(
     () => new ethers.JsonRpcProvider(url),
     [url]
   );
   ```

3. **Not handling async state updates**

   ```js
   // ❌ Potential bug - component might unmount before setState
   useEffect(() => {
     fetchData().then((data) => setData(data));
   }, []);

   // ✅ Better - check if still mounted
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

After implementing, verify these scenarios work:

1. ✅ **Initial load**: Contract name, symbol, and total display correctly
2. ✅ **Valid token ID**: Entering a valid ID and clicking "Get URI" shows the URI
3. ✅ **Invalid token ID**: Entering an out-of-range ID shows an error message
4. ✅ **Network error**: Disconnecting internet shows appropriate error
5. ✅ **Loading state**: Brief loading indicator appears while fetching

---

### 8. What's Next?

Now that you can **read** from smart contracts, the next steps are:

- **Writing to contracts** (minting NFTs, transferring tokens)
- **Handling gas estimation** (showing users transaction costs)
- **Listening to events** (real-time updates when NFTs are minted)
- **Displaying NFT images** (fetching and parsing IPFS metadata)

---

### External References & Further Learning

- **Ethers.js Documentation**: https://docs.ethers.org - Complete provider and contract API
- **ERC-721 Standard**: https://eips.ethereum.org/EIPS/eip-721 - The NFT specification
- **Infura**: https://infura.io - Popular RPC provider with free tier
- **Alchemy**: https://alchemy.com - RPC provider with enhanced APIs
- **IPFS Gateway**: https://ipfs.io - Understanding decentralized storage for NFT metadata

---

## 🌟 Closing Story

Later that night, Odessa replayed her Zoom pitch, watching the founder’s jaws drop as live Sepolia data populated her UI. She’d bridged Manila’s LRT chaos and Silicon Valley’s expectations with a few Ethers.js calls.

Tomorrow, she’ll write to the contract—mint new NFTs, transfer ownership, and power genuine Web3 interactions. From read‐only glory to full DApp mastery, Odessa’s Philippine spirit is unstoppable. Next stop: **Write Transactions & Gas Management**! 🚀🪙✨
