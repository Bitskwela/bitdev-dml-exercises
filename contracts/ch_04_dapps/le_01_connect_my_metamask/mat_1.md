## 🧑‍💻 Background Story

In a cozy café in BGC, Neri leaned forward, latte foam dusting her laptop keyboard. Across from her, Odessa’s eyes sparkled with excitement—and jitters. “Next week, you pitch our decentralized street-food market app in NYC,” Neri reminded her. “But kung walang **Connect** button, it ain’t a DApp!”

Odessa took a deep breath. She imagined balikbayans craving sisig tacos, taho vendors tokenizing orders, and OFWs trading food vouchers—all powered by Ethereum. First step: MetaMask. With a sly grin, Neri typed `npx create-react-app dapp-foundation`. “We’ll inject Ethers.js, detect MetaMask, and call `eth_requestAccounts`.”

In fifteen minutes, Odessa saw “Install MetaMask” if no wallet was found. Ten more lines of React Hooks later, her screen displayed “Connected: 0xAbC…123”. She laughed—the same way she felt when she first tasted halo-halo in Manila. In that moment, bustling BGC felt like Ethereum’s mainnet: full of promise, a little wild, and utterly addictive.

As she sipped her iced matcha, Odessa realized this small widget held enormous power. It was her gateway for every future contract call: sari-sari store tokens, barangay voting DAOs, even rice subsidy NFTs. Next stop: smart contracts! But tonight, she’d celebrate her “Connect Me, MetaMask!” triumph with extra ube rolls.

Welcome to DApp Integration Foundations. Let’s elevate Filipino flavors to the global Web3 stage! 🇵🇭🍢🚀

---

## 📚 Theory & Web3 Lecture

### 1. Understanding DApp Architecture

Think of a DApp (Decentralized Application) as a bridge between the regular web you know and the blockchain. Let's break down the three main components:

#### **React Frontend** (The User Interface)
This is what users see and interact with—buttons, forms, and pages. React is a popular JavaScript library that makes building interactive websites easier. If you've used Facebook, Instagram, or Netflix, you've used React! In our case, React will display wallet connection buttons and show blockchain data in a user-friendly way.

#### **Ethers.js** (The Translator)
Ethers.js is a JavaScript library that acts as a translator between your website and the blockchain. Think of it like a waiter in a restaurant:
- You (the frontend) tell the waiter what you want
- The waiter (Ethers.js) communicates with the kitchen (blockchain)
- The waiter brings back your order (blockchain data)

It converts your simple JavaScript commands into blockchain-compatible requests and vice versa.

#### **MetaMask** (The Digital Wallet & Guardian)
MetaMask is a browser extension that serves three critical roles:
1. **Wallet**: Stores your cryptocurrency and digital assets securely
2. **Key Manager**: Keeps your private keys safe (think of these as super-secret passwords)
3. **Transaction Signer**: Approves and signs blockchain transactions on your behalf

When MetaMask is installed, it injects a special object called `window.ethereum` into your browser. This object is your app's doorway to interact with the user's wallet and the blockchain.

### 2. Key Concepts Explained Step-by-Step

#### **Concept 1: Detecting MetaMask**

Before your app can connect to a wallet, you need to check if MetaMask is installed. Here's the analogy:

Imagine knocking on a door before entering. `window.ethereum` is that door—if it exists, MetaMask is installed; if not, you need to politely ask the user to install it.

```js
if (window.ethereum) {
  // MetaMask is installed! We can proceed
} else {
  // Show message: "Please install MetaMask to continue"
}
```

#### **Concept 2: Requesting Account Access**

Just because MetaMask is installed doesn't mean your app automatically has access to the user's wallet. That would be a security nightmare! 

You must request permission using the `eth_requestAccounts` method. This triggers a MetaMask popup asking the user: "Do you want to connect your wallet to this website?"

```js
await window.ethereum.request({ method: "eth_requestAccounts" })
```

**Real-world analogy**: This is like asking someone for their phone number—they can say yes or no. Respect their choice!

**What happens when the user approves?**
- MetaMask returns an array of wallet addresses (usually just one)
- The first address `accounts[0]` is the currently selected account
- Your app can now see this address (but NOT the private keys—those stay in MetaMask)

#### **Concept 3: Listening to Events**

Blockchain wallets are dynamic. Users can:
- Switch between different wallet accounts
- Change networks (from Ethereum mainnet to a test network)
- Lock/disconnect their wallet

Your app needs to stay updated with these changes. That's why we listen to events:

**`accountsChanged` Event**
Fires when the user switches to a different account in MetaMask.

```js
window.ethereum.on("accountsChanged", (accounts) => {
  // Update your app with the new account
  setAccount(accounts[0] || null);
});
```

**`chainChanged` Event**
Fires when the user switches blockchain networks (e.g., from Ethereum mainnet to Goerli testnet).

```js
window.ethereum.on("chainChanged", (chainId) => {
  // Update your app with the new network
  // Often best to reload the page to avoid state issues
  window.location.reload();
});
```

**Why is this important?**
If your app displays "Connected: 0xABC" but the user switched accounts, showing outdated info confuses users and could lead to errors when they try to make transactions.

#### **Concept 4: Network Switching (Optional but Useful)**

Sometimes your smart contract only works on a specific network (like Polygon or Binance Smart Chain). You can programmatically ask MetaMask to switch networks:

```js
await window.ethereum.request({
  method: "wallet_switchEthereumChain",
  params: [{ chainId: "0x1" }], // 0x1 = Ethereum Mainnet
});
```

**Chain IDs you should know:**
- `0x1` = Ethereum Mainnet
- `0x5` = Goerli Testnet (being deprecated)
- `0xaa36a7` = Sepolia Testnet (recommended for testing)
- `0x89` = Polygon Mainnet

### 3. Code Walkthrough with Detailed Explanations

#### **Step 1: Install Dependencies**

First, install Ethers.js in your React project:

```bash
npm install ethers
```

This downloads the Ethers.js library so you can use it in your code.

#### **Step 2: Build the WalletConnector Component**

Let's break down each part of the component:

```js
// src/components/WalletConnector.js
import { useState, useEffect } from "react";
import { ethers } from "ethers";

export default function WalletConnector() {
  // State variables to store wallet information
  const [account, setAccount] = useState(null);  // Connected wallet address
  const [chainId, setChainId] = useState(null);  // Current blockchain network

  // useEffect runs when component loads
  useEffect(() => {
    // Exit early if MetaMask not installed
    if (!window.ethereum) return;
    
    // Function: Update account when user switches wallets
    const onAccountsChanged = (accounts) => {
      // If accounts array is empty, user disconnected
      setAccount(accounts[0] || null);
    };
    
    // Function: Update network when user switches chains
    const onChainChanged = (chainHex) => {
      setChainId(chainHex);
      // Best practice: reload page to clear stale state
      // window.location.reload();
    };
    
    // Register event listeners
    window.ethereum.on("accountsChanged", onAccountsChanged);
    window.ethereum.on("chainChanged", onChainChanged);

    // Cleanup function: runs when component unmounts
    // Prevents memory leaks by removing event listeners
    return () => {
      window.ethereum.removeListener("accountsChanged", onAccountsChanged);
      window.ethereum.removeListener("chainChanged", onChainChanged);
    };
  }, []); // Empty array = run once on component mount

  // Function: Handle wallet connection
  const connectWallet = async () => {
    // Safety check
    if (!window.ethereum) return alert("Please install MetaMask!");
    
    try {
      // Request account access (triggers MetaMask popup)
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      
      // Store the first account (user's primary address)
      setAccount(accounts[0]);
      
      // Get current network ID
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setChainId(hex);
      
    } catch (error) {
      // User clicked "Reject" or another error occurred
      console.error("User rejected wallet connection", error);
    }
  };

  // Render UI based on current state
  return (
    <div style={{ padding: 20 }}>
      {window.ethereum ? (
        // MetaMask is installed
        account ? (
          // Wallet is connected
          <div>
            <p>Connected: {account}</p>
            <p>Network: {chainId}</p>
          </div>
        ) : (
          // MetaMask installed but not connected
          <button onClick={connectWallet}>Connect MetaMask 🦊</button>
        )
      ) : (
        // MetaMask not installed
        <p>Please install MetaMask to continue.</p>
      )}
    </div>
  );
}
```

#### **Understanding React Hooks**

If you're new to React, here's what these hooks do:

- **`useState`**: Creates a variable that React watches. When it changes, React updates the UI automatically
  - `const [account, setAccount] = useState(null)` creates:
    - `account`: the current value
    - `setAccount`: a function to update the value
    - `null`: the initial value

- **`useEffect`**: Runs code when the component loads or when specified values change
  - Great for setting up event listeners
  - The cleanup function (return statement) prevents memory leaks

### 4. Security Best Practices Explained

#### **Always Verify `window.ethereum` Existence**
Never assume MetaMask is installed. Always check before making calls, or your app will crash with errors.

```js
if (!window.ethereum) {
  return alert("Please install MetaMask!");
}
```

#### **Handle User Rejections Gracefully**
Users have the right to say no. Don't let your app break when they reject the connection request.

```js
try {
  await window.ethereum.request({ method: "eth_requestAccounts" });
} catch (error) {
  console.error("Connection rejected:", error);
  // Show friendly message to user
}
```

#### **NEVER Expose Private Keys or Seed Phrases**
Private keys should NEVER appear in your frontend code. They stay securely in MetaMask. Your app only sees public addresses.

#### **Never Hardcode RPC URLs with API Keys**
If you use services like Infura or Alchemy, keep API keys in environment variables (`.env` files), not in your code.

```js
// ❌ BAD - API key exposed
const provider = new ethers.providers.JsonRpcProvider(
  "https://mainnet.infura.io/v3/YOUR_API_KEY"
);

// ✅ GOOD - API key hidden
const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);
```

#### **Listen to Chain Changes**
If your smart contract is on Ethereum mainnet but the user switches to a testnet, transactions will fail. Always monitor the network and warn users if they're on the wrong chain.

```js
const EXPECTED_CHAIN_ID = "0x1"; // Ethereum Mainnet

if (chainId !== EXPECTED_CHAIN_ID) {
  alert("Please switch to Ethereum Mainnet!");
}
```

#### **Validate User Input**
If users enter addresses or amounts, validate them before sending transactions:

```js
// Check if address is valid
if (!ethers.utils.isAddress(userAddress)) {
  alert("Invalid Ethereum address!");
}

// Check if amount is a valid number
if (isNaN(amount) || amount <= 0) {
  alert("Please enter a valid amount!");
}
```

---

### 5. Common Beginner Mistakes to Avoid

1. **Forgetting `await` with async functions**
   ```js
   // ❌ This won't work - missing await
   const accounts = window.ethereum.request({ method: "eth_requestAccounts" });
   
   // ✅ Correct
   const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
   ```

2. **Not handling MetaMask locked state**
   If MetaMask is locked, `eth_requestAccounts` will prompt the user to unlock it.

3. **Assuming the first account is always available**
   Always check if `accounts[0]` exists before using it.

4. **Not cleaning up event listeners**
   This causes memory leaks. Always remove listeners in the cleanup function.

---

### 6. Testing Your Connection

After implementing the component, test these scenarios:

1. ✅ **MetaMask not installed**: Should show "Please install MetaMask"
2. ✅ **Connect button clicked**: MetaMask popup appears
3. ✅ **User approves connection**: Address and network appear on screen
4. ✅ **User rejects connection**: No error, app continues working
5. ✅ **User switches accounts**: UI updates automatically
6. ✅ **User switches networks**: UI updates automatically

---

### 7. What's Next?

Now that you can connect to MetaMask, you're ready for:
- **Reading data from smart contracts** (checking token balances, NFT ownership)
- **Writing to smart contracts** (sending transactions, minting NFTs)
- **Listening to contract events** (real-time updates when things happen on-chain)

This wallet connection is the foundation for everything else in Web3 development!

---

### External References & Further Learning

- **Ethers.js Documentation**: https://docs.ethers.org - Complete guide to Ethers.js
- **MetaMask API Documentation**: https://docs.metamask.io - Official MetaMask developer docs
- **React Hooks Guide**: https://reactjs.org/docs/hooks-intro.html - Learn React fundamentals
- **Ethereum JSON-RPC API**: https://ethereum.org/en/developers/docs/apis/json-rpc/ - Understanding the underlying API calls
- **Web3 Modal**: https://web3modal.com/ - Library that supports multiple wallets (MetaMask, WalletConnect, etc.)


## 🌟 Closing Story

As Odessa closed her laptop, she grinned at Neri: “Check this out—my React app just talks to MetaMask!” In a few clicks, she’d turned a blank page into the gateway for all future contract calls. The aroma of ube pandesal from the café suddenly tasted sweeter.

Next, they’d wire this connector to a local Hardhat contract: reading and writing on-chain state. From wallet integration to full DApp—Odessa was one step closer to powering Filipino street-food vendors on Ethereum. Onward to smart contracts! 🚀🌮🪙
