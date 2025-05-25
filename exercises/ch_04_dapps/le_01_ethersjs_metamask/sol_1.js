// Import Ethers.js
const { ethers } = window

// Check if MetaMask is installed
function checkMetaMask() {
  if (window.ethereum) {
    console.log("✅ MetaMask is installed!")
    return true
  } else {
    console.log("❌ MetaMask is not installed. Please install MetaMask.")
    return false
  }
}

// Connect to MetaMask
async function connectWallet() {
  if (!checkMetaMask()) return

  try {
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    })
    document.getElementById(
      "walletAddress"
    ).innerText = `Connected: ${accounts[0]}`
    console.log("Wallet connected:", accounts[0])
  } catch (error) {
    console.error("❌ Connection failed:", error)
  }
}

// Listen for account changes
window.ethereum.on("accountsChanged", (accounts) => {
  if (accounts.length > 0) {
    document.getElementById(
      "walletAddress"
    ).innerText = `Connected: ${accounts[0]}`
    console.log("Account switched:", accounts[0])
  } else {
    document.getElementById("walletAddress").innerText = "Disconnected"
    console.log("Wallet disconnected")
  }
})

// Attach event listener to the button
document
  .getElementById("connectButton")
  .addEventListener("click", connectWallet)
