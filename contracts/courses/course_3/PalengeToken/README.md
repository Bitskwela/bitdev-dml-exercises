## 📖 Neri’s New Mission – The Rise of a Community Currency

The sun was setting over the Manila skyline, and Neri found herself in a local palengke (public market) in Quezon City. Vendors were shouting out their prices, trying to sell their fresh produce before nightfall.

She approached Aling Norma, a vegetable seller she had known since childhood.

> "Neri, hija, kung may paraan lang sana para hindi kami laging lugi sa singil ng mga e-wallet at bangko... 5% ang kinakaltas sa amin, tapos delayed pa ang bayad. Pero wala kaming choice, wala nang gustong magbayad ng cash!"
> (If only there were a way for us to avoid the high fees of e-wallets and banks... They take 5% from us, and payments are delayed. But we have no choice since people no longer want to pay with cash!)

Neri listened carefully. She knew that centralized payment systems controlled the financial infrastructure—taking high fees and delaying transactions. What if she could create a **community-driven digital currency** that vendors and customers could use **without relying on banks or e-wallet providers?**

That’s when she decided:

**💡 She will build an ERC20 token for the palengke—allowing vendors to transact with zero fees and instant payments! 💡**

This would be a decentralized community currency backed by smart contracts—no banks, no intermediaries, just **direct transactions between vendors and buyers**.

# 🌟 Mission Objective: Build and Integrate an ERC20 Token into a Frontend DApp

Neri’s challenge for you is simple but powerful:

- ✅ Create a fully functional ERC20 token that can be used by vendors and customers.
- ✅ Deploy it on a local blockchain (Hardhat).
- ✅ Build a frontend DApp (React + ethers.js) where users can send/receive tokens.
- ✅ Ensure the system is secure, transparent, and easy to use.

Are you ready to fix real-world financial inefficiencies with blockchain? Let’s get started! 🚀

# 📌 PART 1: Setting Up the Development Environment

Before we begin coding, we need the right tools installed on our local machine.

🛠 Tools You Need
To build this ERC20 token DApp, you will need the following:

- ✔ Node.js & npm – JavaScript runtime & package manager
- ✔ Hardhat – Ethereum smart contract development framework
- ✔ Metamask – Web3 wallet for transactions
- ✔ Ethers.js – Library to interact with Ethereum blockchain
- ✔ React.js – Frontend framework to create the user interface

### ✅ Setup Checklist

Run the following command to check if the tools are installed properly:

```bash
node -v    # Should return Node.js version
npm -v     # Should return npm version
npx hardhat --version  # Should return Hardhat version
```

# 📌 PART 2: Writing the ERC20 Smart Contract

In Solidity, **ERC20** is the standard for fungible tokens. Our goal is to create a **PalengkeToken (PLT)** that users can send and receive instantly.

### 📜 TODO: Write the ERC20 Token Contract

🚩 Inside your Hardhat project, create a new file:

📂 `contracts/PalengkeToken.sol`

**Here’s your task: Implement an ERC20 token using OpenZeppelin’s ERC20 library.**

```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import Openzeppelin's ERC20 and Ownable packages
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PalengkeToken is ERC20, Ownable {

    // 🚩 TODO: Initialize the contract with the Token name and Symbol
    constructor(uint256 initialSupply) ERC20("PalengkeToken", "PLT") {
        _mint(msg.sender, initialSupply);
    }

    // 🚩 TODO: Add a mint function accepting address of the token
    // recipient and the amount they are going to receive. This function
    // can be executed by the contract owner only.
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
```

### ✅ Checklist Before Deployment

- Ensure the contract compiles (`npx hardhat compile`)
- Make sure OpenZeppelin dependencies are installed (`npm install @openzeppelin/contracts`)

# 📌 PART 3: Deploying the Smart Contract (Hardhat Local Network)

To test our contract, we will deploy it to Hardhat’s local blockchain.

🚩 **Create a deployment script**:

📂 `scripts/deploy.js`

```javascript
// 🚩 TODO: Deploy the ERC20 token contract

const { ethers } = require("hardhat")

async function main() {
  const initialSupply = ethers.utils.parseEther("1000000") // 1M PLT
  const PalengkeToken = await ethers.getContractFactory("PalengkeToken")
  const token = await PalengkeToken.deploy(initialSupply)

  console.log("PalengkeToken deployed to:", token.address)
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
```

### ✅ Checklist After Deployment

- Run `npx hardhat run scripts/deploy.js --network localhost`
- Check if the contract is successfully deployed.

# 📌 PART 4: Building the Frontend DApp (React + ethers.js)

Now, we need a simple interface for vendors and buyers to send and receive PLT tokens.

### 📜 TODO: Create a React DApp UI

🚩 **Inside your frontend React app, create the following component**:

📂 `src/components/Wallet.js`

```jsx
// 🚩 TODO: Implement the frontend integration
import React, { useState } from "react"
import { ethers } from "ethers"
import PalengkeTokenABI from "../artifacts/contracts/PalengkeToken.json"

const CONTRACT_ADDRESS = "YOUR_DEPLOYED_CONTRACT_ADDRESS"

function Wallet() {
  const [account, setAccount] = useState("")
  const [balance, setBalance] = useState("0")

  async function connectWallet() {
    // 🚩 TODO: Implement wallet connection using ethers.js
    if (!window.ethereum) return alert("Please install MetaMask!")
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const signer = provider.getSigner()
    const accounts = await provider.send("eth_requestAccounts", [])

    setAccount(accounts[0])

    const contract = new ethers.Contract(
      CONTRACT_ADDRESS,
      PalengkeTokenABI.abi,
      signer
    )
    const userBalance = await contract.balanceOf(accounts[0])
    setBalance(ethers.utils.formatEther(userBalance))
  }

  return (
    <div>
      <button onClick={connectWallet}>Connect Wallet</button>
      <p>Account: {account}</p>
      <p>Balance: {balance} PLT</p>
    </div>
  )
}

export default Wallet
```

### ✅ Frontend Integration Checklist

- Ensure MetaMask is connected
- Make sure ethers.js is installed (`npm install ethers`)
- Update `CONTRACT_ADDRESS` with the deployed contract address
- Run `npm start` to test the frontend

# 📌 PART 5: Final Knowledge Check

🤔 Answer the Following Before Moving to the Next Lesson

- 1️⃣ What is the purpose of an ERC20 token?
- 2️⃣ Why do we use OpenZeppelin libraries?
- 3️⃣ How does ethers.js help us interact with the contract?
- 4️⃣ How do vendors benefit from using PalengkeToken (PLT) instead of traditional e-wallets?

## 📌 Conclusion

Neri has now built a real blockchain-based financial solution for her community! Vendors and customers can send and receive PalengkeTokens instantly, without any fees or delays.

🎉 YOU DID IT! 🎉 You have successfully built and integrated your first real-world ERC20 token DApp!
