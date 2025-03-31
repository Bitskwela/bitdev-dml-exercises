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
