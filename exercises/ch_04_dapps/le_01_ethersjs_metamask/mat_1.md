
# Lesson 1: Introduction to Ethers.js & Connecting MetaMask

🚀 Welcome to your first hands-on experience with Web3 development!

## 📖 Learning Material

In this lesson, you will:

- ✅ Learn what Ethers.js is and why it’s essential for interacting with the blockchain.
- ✅ Connect MetaMask to a simple HTML page.
- ✅ Fetch and display the user’s wallet address.
- ✅ Handle wallet connection states dynamically.

By the end of this lesson, you will have a functional webpage where users can connect their MetaMask wallet and see their Ethereum address displayed on the screen.

## 🛠 What is Ethers.js?

Ethers.js is a powerful and lightweight JavaScript library designed for interacting with the Ethereum blockchain. It allows developers to send transactions, sign messages, connect to smart contracts, and retrieve blockchain data in a simple and efficient way.

These interactions happen using JSON-RPC request methods, which allow your app to communicate with the blockchain.

Unlike other libraries, ethers.js is known for:

- ✅ Easy integration with wallets like MetaMask.
- ✅ Lightweight and optimized for dApps.
- ✅ Built-in utilities for formatting and encoding blockchain data.

## Why Do We Use ethers.js Request Methods?

When building a decentralized application (dApp), we need to communicate with the Ethereum network and interact with users’ wallets. Request methods in ethers.js allow us to:

- Connect wallets (e.g., MetaMask) to our dApp.
- Send transactions securely.
- Retrieve balances & blockchain data.
- Sign messages for authentication.
- Switch networks easily.

Now, let’s go through some of the most commonly used ethers.js request methods! 🚀

### Commonly Used ethers.js Request Methods

#### 1. Requesting User Wallet Access

```js
await window.ethereum.request({ method: "eth_requestAccounts" });
```

- Prompts the user to connect their wallet (e.g., MetaMask) to your dApp.
- Returns an array of account addresses.

#### 2. Checking Connected Accounts

```js
await window.ethereum.request({ method: "eth_accounts" });
```

- Retrieves the list of accounts currently connected to your dApp.

#### 3. Getting Network Chain ID

```js
await window.ethereum.request({ method: "eth_chainId" });
```

- Returns the current network’s chain ID (e.g., 0x1 for Ethereum Mainnet, 0x5 for Goerli testnet).

#### 4. Fetching Account Balance

```js
await window.ethereum.request({
  method: "eth_getBalance",
  params: ["0xYourWalletAddress", "latest"],
});
```

- Returns the ETH balance of an address in wei (smallest unit of ETH).
- Convert to ETH using `ethers.utils.formatEther()`.

#### 5. Sending Transactions

```js
await window.ethereum.request({
  method: "eth_sendTransaction",
  params: [
    {
      from: "0xYourWallet",
      to: "0xRecipient",
      value: ethers.utils.parseEther("0.01").toHexString(),
    },
  ],
});
```

- Sends ETH from the user’s wallet to another address.
- The user must approve the transaction in MetaMask.

#### 6. Signing Messages for Authentication

```js
await window.ethereum.request({
  method: "personal_sign",
  params: ["Hello, sign this message!", "0xYourWallet"],
});
```

- Signs a message without exposing the private key.
- Used for authentication in Web3 apps.

#### 7. Switching Blockchain Networks

```js
await window.ethereum.request({
  method: "wallet_switchEthereumChain",
  params: [{ chainId: "0x5" }], // Switch to Goerli testnet
});
```

- Prompts MetaMask to switch networks automatically.

#### 8. Adding a New Custom Network

```js
await window.ethereum.request({
  method: "wallet_addEthereumChain",
  params: [
    {
      chainId: "57054",
      rpcUrls: ["https://rpc.blaze.soniclabs.com"],
      chainName: "Sonic Blaze Testnet",
      nativeCurrency: {
        name: "Sonic Blaze Testnet",
        symbol: "S",
        decimals: 18,
      },
    },
  ],
});
```

- Adding Sonic Blaze Testnet as custom netwrok the to the user’s wallet.

## In Summary

ethers.js makes it easy and efficient to interact with Ethereum wallets and smart contracts. Whether you’re connecting a wallet, fetching balances, signing transactions, or switching networks, these request methods are fundamental for building dApps.

For now, we’ll focus on connecting a MetaMask wallet and fetching the user's wallet address.

## 🌐 Setting Up the Project

We have preloaded a browser-based code editor for you. Inside, you’ll find:

- 🔹 An HTML file with buttons and placeholders.
- 🔹 A CSS file for styling (already linked).
- 🔹 A JavaScript file where you’ll write Ethers.js code to interact with MetaMask.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Connect MetaMask with Ethers.js</title>
    <script src="https://cdn.ethers.io/lib/ethers-5.7.umd.min.js"></script>
    <style>
      body {
        font-family: Arial, sans-serif;
        text-align: center;
        padding: 20px;
      }
      .container {
        max-width: 400px;
        margin: auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
      }
      button {
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border: none;
        background-color: #007bff;
        color: white;
        border-radius: 5px;
      }
      button:disabled {
        background-color: gray;
        cursor: not-allowed;
      }
      #walletAddress {
        margin-top: 20px;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>🔗 Connect to MetaMask</h2>
      <button id="connectButton">Connect Wallet</button>
      <p id="walletAddress">Not connected</p>
    </div>

    <script>
      // 🚩 TODO: Import Ethers.js library
      const { ethers } = window;

      // 🚩 TODO: Create the function to check if MetaMask is installed
      function checkMetaMask() {
        if (window.ethereum) {
          console.log("✅ MetaMask is installed!");
          return true;
        } else {
          console.log("❌ MetaMask is not installed. Please install MetaMask.");
          return false;
        }
      }

      // 🚩 TODO: Create the function to connect to MetaMask
      async function connectWallet() {
        if (!checkMetaMask()) return;
        try {
          const accounts = await window.ethereum.request({
            method: "eth_requestAccounts",
          });
          document.getElementById(
            "walletAddress"
          ).innerText = `Connected: ${accounts[0]}`;
          console.log("Wallet connected:", accounts[0]);
        } catch (error) {
          console.error("❌ Connection failed:", error);
        }
      }

      // 🚩 TODO: Create a function to listen for account changes and update UI
      window.ethereum?.on("accountsChanged", (accounts) => {
        if (accounts.length > 0) {
          document.getElementById(
            "walletAddress"
          ).innerText = `Connected: ${accounts[0]}`;
          console.log("Account switched:", accounts[0]);
        } else {
          document.getElementById("walletAddress").innerText = "Disconnected";
          console.log("Wallet disconnected");
        }
      });

      // 🚩 TODO: Attach event listener to the button
      document
        .getElementById("connectButton")
        .addEventListener("click", connectWallet);
    </script>
  </body>
</html>
```

Now, let’s dive in!
