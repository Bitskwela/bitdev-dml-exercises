# Chapter 4: dApps and User Interfaces 🏗️

Welcome to decentralized application (dApp) development! You already know how to write and deploy
Solidity contracts. Now you will build the React screens that let real people use them: connect a
wallet, read on-chain data, send transactions, and react to events as they happen.

## 🌟 What You'll Learn

This chapter bridges the gap between backend smart contracts and frontend user experiences. You'll learn to:

- Connect a MetaMask wallet to a React app
- Read data from smart contracts, with or without a connected wallet
- Send state-changing transactions and wait for them to be mined
- Listen to contract and wallet events, and clean the listeners up
- Combine these into complete mini-dApps: tokens, NFTs, voting, escrow, bridges

## 📚 Course Structure

### 🔗 Wallet Integration & Basics

- **[Lesson 1: Connect My MetaMask](./le_01_connect_my_metamask/)** - Detect MetaMask and connect a wallet
- **[Lesson 2: Read Smart Contract Data](./le_02_read_smart_contract_data/)** - Fetch and display on-chain data with a read-only provider
- **[Lesson 3: Triggering a Function](./le_03_triggering_a_function/)** - Send a state-changing transaction with a signer
- **[Lesson 4: Event Listeners in the Frontend](./le_04_event_listeners_in_the_frontend/)** - Real-time updates from contract events
- **[Lesson 5: Sign-In with Wallet Experience](./le_05_sign_in_with_wallet_experience/)** - Passwordless sign-in by signing a message

### 💰 Token & DeFi Interfaces

- **[Lesson 6: Token Tracker](./le_06_token_tracker/)** - Read ERC-20 name, symbol, decimals and your balance
- **[Lesson 7: Sining Chain](./le_07_sining_chain/)** - An ERC-721 NFT gallery with IPFS metadata
- **[Lesson 8: Send Tokens via UI](./le_08_send_tokens_via_ui/)** - A validated ERC-20 transfer form
- **[Lesson 12: DeFi Dashboard](./le_12_defi_dashboard/)** - Liquidity pool reserves and supply on a dashboard

### 🎯 dApp Applications

- **[Lesson 9: On-Chain To-Do List](./le_09_onchain_to_do_list/)** - Tasks stored and toggled on-chain
- **[Lesson 10: DAO Voting UI](./le_10_dao_voting_ui/)** - Proposals, votes and live tallies
- **[Lesson 11: Gas Fee Checker](./le_11_real_time_gas_fee_tracker/)** - Display the current base fee
- **[Lesson 15: On-Chain Identity Viewer](./le_15_onchain_identity_viewer/)** - Profiles and credentials stored on-chain
- **[Lesson 16: Escrow Status Viewer](./le_16_escrow_dapp/)** - Show the state of a buyer-seller escrow

### 🔧 Advanced Features

- **[Lesson 13: Multisig Proposal Viewer](./le_13_multisig_transaction_initiator/)** - List multisig proposals and their confirmations
- **[Lesson 14: Simulated Chain Oracle dApp](./le_14_simulated_chain_oracle_dapp/)** - Off-chain data that triggers on-chain actions
- **[Lesson 17: Network Detector](./le_17_multi_network_switch_ui/)** - Detect the current network and react when it changes
- **[Lesson 18: NFT Image Preview](./le_18_nft_minting_ui_with_image_preview/)** - Preview an image and its NFT metadata before minting
- **[Lesson 19: Contract Deployment Simulator](./le_19_contract_deployment_simulator/)** - Deploy a contract from the browser
- **[Lesson 20: LayerZero Inspired UI](./le_20_layer_zero_inspired_ui/)** - Simulated cross-chain lock-and-release bridge

## 🛠️ Tech Stack

Every activity in this chapter uses:

- **React** - Components with `useState` and `useEffect`
- **ethers.js v6** - `BrowserProvider` for the wallet, `JsonRpcProvider` for read-only calls, `Contract` for calling functions
- **MetaMask** - Wallet connection and transaction signing through `window.ethereum`

> **Watch out for old tutorials.** Many blog posts still use ethers v5 (`ethers.providers.Web3Provider`, <!-- v5-ok -->
> `ethers.utils.parseEther`). Those names do not exist in v6, which this course uses. In v6 it is <!-- v5-ok -->
> `ethers.BrowserProvider` and `ethers.parseEther`.

## 📋 Prerequisites

Before starting this chapter, make sure you have:

1. ✅ Completed Chapter 1 (Basic Solidity)
2. ✅ Familiarity with JavaScript and React basics
3. ✅ MetaMask installed in your browser
4. ✅ Some Sepolia testnet ETH
5. ✅ An understanding of how a smart contract is deployed

## 🎯 Learning Objectives

By the end of this chapter, you will be able to:

- 🔗 Connect MetaMask to a React application
- 📊 Read and display smart contract data in user-friendly interfaces
- ✍️ Execute smart contract functions through frontend forms
- 🎧 Listen to and handle blockchain events in real time
- 🌐 Detect which network the user is on and respond when it changes
- 🎨 Create intuitive user experiences for Web3 applications
- 🔐 Handle loading and error states so users are never left guessing
- 🚀 Deploy a contract straight from the browser

## 🌍 Real-World Context

Each lesson is set in the vibrant world of Filipino tech entrepreneurship, featuring:

- **Odessa ("Det")** - A determined developer building her Web3 startup from a BGC co-working space
- **Neri** - Odessa's friend and fellow builder, who brings dApps to barangay halls, workshops and community projects
- **Barangay scenarios** - Local governance and community applications

These stories make learning more engaging while showcasing how Web3 technology can solve real-world problems in the Filipino context.

## 🚀 Getting Started

1. **Create a React project with Vite and add ethers**:

   ```bash
   npm create vite@latest my-dapp -- --template react
   cd my-dapp
   npm install
   npm install ethers
   npm run dev
   ```

2. **Install MetaMask** browser extension

3. **Get Sepolia testnet ETH** from a Sepolia faucet

4. **Start with Lesson 1** and work through sequentially

## 💡 Tips for Success

- **Practice regularly** - Build each interface step by step
- **Test on testnets** - Always test with testnet ETH first
- **Handle errors gracefully** - Users reject transactions, switch networks and close tabs
- **Focus on UX** - Make your dApps user-friendly
- **Clean up listeners** - Every `.on(...)` in a `useEffect` needs a matching removal in its cleanup

## 🔗 Additional Resources

- [React Documentation](https://react.dev/)
- [Vite Documentation](https://vite.dev/)
- [Ethers.js v6 Documentation](https://docs.ethers.org/v6/)
- [MetaMask Developer Docs](https://docs.metamask.io/)

---

Ready to build the future of decentralized applications? Let's start with connecting your first wallet! 🚀

_Mabuhay Web3 development!_ 🇵🇭
