---
title: "Introduction to Ethers.js & Connecting MetaMask"
description: "Introduction to Ethers.js & Connecting MetaMask"

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "ethersjs-metamask"

# Can be the same as permaname but can be changed if needed.
slug: "ethersjs-metamask"
---

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

## 📜 Code Activity: Connect MetaMask and Display Wallet Address

Inside your `script.js` file, follow the guided steps below:

### Step 1: Import Ethers.js

At the top of script.js, import Ethers.js via a CDN (Content Delivery Network).

```js
const { ethers } = window;
```

**Why?** Since we are using an online editor, we don’t need to install anything. The browser will load Ethers.js automatically.

### Step 2: Detect MetaMask

Before connecting to MetaMask, **we must check if the user has it installed**. Complete the `checkMetamask` function inside the `script.js`:

```js
function checkMetaMask() {
  // 🚩TODO #1: Create an If-else statement to check if `window.ethereum` exists.
  // If it exists, send a message on the console saying "Metamask is installed!" and return `true`
  if (window.ethereum) {
    // ✅ Answer:
    // console.log("MetaMask is installed!")
    // return true
  } else {
    // 🚩TODO #2: Create an else statement that will trigger if `window.ethereum` did not exists.
    // Send a message on the console saying "MetaMask is not installed. Please install MetaMask" and return `false`
    // ✅ Answer:
    // console.log("MetaMask is not installed. Please install MetaMask.")
    // return false
  }
}
```

#### What’s happening?

- We write a code to see if `window.ethereum` exists. If it does, meaning MetaMask is installed and we send a message to the console via `console.log`

- If not, we alert the user by sending a console message to install MetaMask.

### Step 3: Connect to MetaMask

Now, let’s create a function to request the user’s wallet connection:

```js
async function connectWallet() {
  // @note Ensure MetaMask is installed by calling the checkMetamask function we create earlier
  if (!checkMetaMask()) return;

  try {
    const accounts = await window.ethereum.request({
      // 🚩TODO #1: Complete this function by implementing the
      // correct request method in getting the user address. Checkout the lesson above to refresh your memory.
      // ✅ Answer: method: "eth_requestAccounts",
    });

    document.getElementById(
      "walletAddress"
    ).innerText = `Connected: ${accounts[0]}`;
    console.log("Wallet connected:", accounts[0]);
  } catch (error) {
    console.error("❌ Connection failed:", error);
  }
}
```

#### What’s happening?

- 1️⃣ The function calls `eth_requestAccounts` method, prompting the user to connect their wallet.
- 2️⃣ If successful, it displays the wallet address on the screen.
- 3️⃣ If the user rejects the request, it logs an error.

### Step 4: Handle Wallet State Changes

Sometimes, users switch **accounts** or **disconnect MetaMask**. We must listen for these events:

```js
window.ethereum.on("accountsChanged", (accounts) => {
  if (accounts.length > 0) {
    // 🚩TOODs:
    // 1. Get the elementID "walletAddress", and changes its innerText to "Connected: "WALLET_ADDRESS_OF_THE_ACCOUNT"
    // 2. In order to get the correct value for "WALLET_ADDRESS_OF_THE_ACCOUNT",
    // get the first element of the accounts array
    // ✅ Answer:
    // document.getElementById("walletAddress").innerText = `Connected: ${accounts[0]}`
    // console.log("Account switched:", accounts[0])
  } else {
    // 🚩 TODOs:
    // 1. Get the elementID "walletAddress" and change its innerText property to "Disconnected"
    // 2. Send a console message: "Wallet disconnected"
    // ✅ Answer:
    // document.getElementById("walletAddress").innerText = "Disconnected"
    // console.log("Wallet disconnected")
  }
});
```

#### What’s happening?

- When the user switches accounts, we **update the displayed wallet address**.
- If all accounts are removed, we **update the UI to show “Disconnected”**.

### Step 5: Link to the HTML Button

Your provided HTML file already has a button with the id `connectButton`.

Now, let’s make it work! Add this at the bottom of `script.js`:

```js
// 🚩TODO: Get the elementID "connectButton" and attach an "click" event listener to it, passing the connectWallet function as paramerter

// ✅ Answer:
document;
// .getElementById("connectButton")
// .addEventListener("click", connectWallet)
```

#### What’s happening?

- When the **“Connect Wallet”** button is clicked, it calls `connectWallet()`.

## 📌 Full Expected Solution

Here’s the final `script.js` file with all steps combined:

```js
// Import Ethers.js
const { ethers } = window;

// Check if MetaMask is installed
function checkMetaMask() {
  if (window.ethereum) {
    console.log("✅ MetaMask is installed!");
    return true;
  } else {
    console.log("❌ MetaMask is not installed. Please install MetaMask.");
    return false;
  }
}

// Connect to MetaMask
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

// Listen for account changes
window.ethereum.on("accountsChanged", (accounts) => {
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

// Attach event listener to the button
document
  .getElementById("connectButton")
  .addEventListener("click", connectWallet);
```

## 💡 Knowledge Check (AI agent will analyze and grade the learner's answers)

Before moving to the next lesson, answer these questions:

- 1️⃣ What does `window.ethereum.request({ method: "eth_requestAccounts" })` do?
- 2️⃣ How can we detect if the user switches accounts in MetaMask?
- 3️⃣ What will happen if MetaMask is not installed when loading the page?

## ✅ Lesson Summary

- ✔️ You integrated Ethers.js into a frontend app.
- ✔️ You connected MetaMask and displayed the user’s wallet address.
- ✔️ You handled wallet connection states dynamically.
- ✔️ You listened for account changes.

🚀 Congratulations! You’ve taken the first step into Web3 development.
Next, we’ll fetch the user’s Ethereum balance. Stay tuned!
