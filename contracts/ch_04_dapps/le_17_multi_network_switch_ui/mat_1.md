## 🧑‍💻 Background Story

![Multi-Network Switch UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+17.0+-+COVER.png)

Under the bright lights of DevCon Cebu, Neri and Odessa demoed their dApp to a packed room. It worked perfectly, on Neri's laptop. A week later, at a hackathon in Los Angeles, a judge tried it with MetaMask still set to Polygon. The app showed balances of zero and buttons that did nothing. Nobody on the screen knew why.

Back in Cebu over halo-halo, Odessa wrote the rule on a napkin: **"Never guess the network. Ask the wallet, show it, and follow it when it changes."** Their first fix was a small panel: *Chain ID: 11155111, Chain Name: Sepolia*. It works even for a visitor with no wallet, and it updates the moment someone switches networks in MetaMask. Only after that did they add a "Switch to Sepolia" button.

That detector panel is what you build in this lesson's activity. The switch and add-network requests are covered in the lecture so you know the next step.

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

- What a **chain id** is, and the ids of today's live networks.
- How to read the current chain in ethers v6, and why asking the **wallet/provider** is more portable than asking a contract.
- How to follow the wallet live with the `chainChanged` event, and clean up the listener.
- How to ask the wallet to switch or add a network (`wallet_switchEthereumChain`, `wallet_addEthereumChain`).

**Activity:** build `NetworkStats`, a network detector. It uses the wallet's provider when there is one and a read-only provider when there is not, shows the chain id and its name, and updates on `chainChanged`.

---

### 📐 How network detection flows

```
 MetaMask (on Sepolia)                 Your React app
 ┌──────────────────────┐   eth_chainId   ┌──────────────────────────┐
 │ network: Sepolia     │ ──"0xaa36a7"──▶ │ Chain ID: 11155111       │
 └──────────┬───────────┘                 │ Chain Name: Sepolia      │
            │ user picks Polygon          └────────────▲─────────────┘
            ▼                                          │
 ┌──────────────────────┐  chainChanged("0x89")        │
 │ network: Polygon     │ ─────────────────────────────┘  → Chain ID: 137, Polygon
 └──────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. Chain ids

Every EVM network has a unique **chain id**. Wallets use it to know where to send a transaction, and signatures include it so a transaction signed for Sepolia cannot be replayed on Mainnet. Wallet APIs give it as a hex string. Your UI shows it as a decimal number.

| Network          | Chain ID (decimal) | Hex        | Type    | Gas token |
| ---------------- | ------------------ | ---------- | ------- | --------- |
| Ethereum Mainnet | 1                  | `0x1`      | Mainnet | ETH       |
| Sepolia          | 11155111           | `0xaa36a7` | Testnet | ETH (test)|
| Hoodi            | 560048             | `0x88bb0`  | Testnet | ETH (test)|
| Polygon PoS      | 137                | `0x89`     | Mainnet | POL       |
| Polygon Amoy     | 80002              | `0x13882`  | Testnet | POL (test)|
| Arbitrum One     | 42161              | `0xa4b1`   | L2      | ETH       |
| OP Mainnet       | 10                 | `0xa`      | L2      | ETH       |

**Dead networks.** The Goerli (5) and Mumbai (80001) testnets have been shut down. <!-- v5-ok --> Old tutorials still list them, but use Sepolia or Hoodi for Ethereum testing and Amoy for Polygon. Polygon's gas token was also renamed from MATIC to **POL** in 2024.

#### 2. Three ways to read the chain id (ethers v6)

```javascript
const provider = new ethers.BrowserProvider(window.ethereum);

// A. Ask the provider for its network (idiomatic ethers v6)
const network = await provider.getNetwork();
network.chainId;              // 11155111n  ← a bigint in v6
Number(network.chainId);      // 11155111

// B. Send the raw JSON-RPC request through the provider
const hex = await provider.send("eth_chainId", []); // "0xaa36a7"
parseInt(hex, 16);                                   // 11155111

// C. Ask the wallet directly, without ethers
const hex2 = await window.ethereum.request({ method: "eth_chainId" });
```

The activity also uses a fourth way: a tiny contract whose function returns Solidity's `block.chainid`.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NetworkDetector {
    function getChainId() external view returns (uint256) {
        return block.chainid;
    }
}
```

```javascript
const contract = new ethers.Contract(CONTRACT, ["function getChainId() view returns (uint256)"], provider);
const id = Number(await contract.getChainId()); // bigint → number
```

#### 3. Why reading from the wallet is the portable way

A contract lives at **one address on one chain**. If `NetworkDetector` was deployed on Sepolia at `0x9999…`, then on Polygon that same address is just empty space. Calling `getChainId()` there either fails or returns nothing useful, so the contract can only confirm a chain you are already on. The chain id, on the other hand, is a property of the **connection itself**. `getNetwork()` and `eth_chainId` answer correctly on every network, need no deployed contract, and cost no extra contract call. In a real dApp, read the chain id from the provider or wallet. The activity accepts any of these approaches, and the lesson's contract is there to show that `block.chainid` and the wallet agree.

#### 4. Wallet first, read-only fallback

```javascript
let provider;
if (window.ethereum) {
  provider = new ethers.BrowserProvider(window.ethereum); // follows the user's wallet
} else {
  provider = new ethers.JsonRpcProvider(RPC);             // fixed node, read-only
}
```

A visitor without MetaMask still sees something useful: the network your RPC URL points to. Keep in mind that a `JsonRpcProvider` never "switches". It always reports the chain its URL serves.

#### 5. Following the wallet: `chainChanged`

```javascript
function handleChange(chainHex) {           // e.g. "0x89"
  const id = parseInt(chainHex, 16);        // 137
  setChainId(id);
}

window.ethereum.on("chainChanged", handleChange);
// in the effect's cleanup:
window.ethereum.removeListener("chainChanged", handleChange);
```

The event hands you a **hex string**, not a number. MetaMask's own docs recommend the simplest robust reaction: reload the page (`window.location.reload()`), so that every provider, contract and cached value is rebuilt for the new chain. Updating state in place, as the activity does, is fine for a display-only panel.

#### 6. Asking the wallet to switch (EIP-3326)

```javascript
async function switchNetwork(chainId) {
  try {
    await window.ethereum.request({
      method: "wallet_switchEthereumChain",
      params: [{ chainId: "0x" + chainId.toString(16) }], // must be hex
    });
  } catch (error) {
    if (error.code === 4902) {
      // the wallet does not know this chain yet: add it first (below)
    } else if (error.code === 4001) {
      // the user clicked Reject
    } else {
      throw error;
    }
  }
}
```

#### 7. Adding a network the wallet does not know (EIP-3085)

```javascript
await window.ethereum.request({
  method: "wallet_addEthereumChain",
  params: [{
    chainId: "0x13882",
    chainName: "Polygon Amoy",
    nativeCurrency: { name: "POL", symbol: "POL", decimals: 18 },
    rpcUrls: ["https://polygon-amoy.drpc.org"],
    blockExplorerUrls: ["https://amoy.polygonscan.com/"],
  }],
});
```

Public RPC URLs change from time to time. Check the current one on the network's official docs or on chainlist.org before you ship.

---

### 📊 Error codes from `window.ethereum.request`

| Code   | Meaning                 | What to do                     |
| ------ | ----------------------- | ------------------------------ |
| 4001   | User rejected request   | Show "Cancelled", let them retry |
| 4902   | Chain not in wallet     | Call `wallet_addEthereumChain` |
| -32002 | A request is already pending | Ask the user to open MetaMask |

These are raw wallet codes. When the same rejection goes through ethers (for example `contract.someFunction()`), ethers v6 reports it as `ethers.isError(err, "ACTION_REJECTED")`.

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
| ------- | ------- | -------- |
| Treating `chainId` from ethers v6 as a number | It is a `bigint` (`11155111n`) | `Number(network.chainId)` |
| `parseInt(hex)` without radix 16 | Wrong or `NaN` results for some ids | `parseInt(hex, 16)` |
| Sending a decimal id to `wallet_switchEthereumChain` | Request rejected | `"0x" + id.toString(16)` |
| Not handling 4902 | Switch fails for unknown chains | Add the network, then switch |
| No listener cleanup | Handlers stack on every remount | `removeListener` in the effect cleanup |
| Assuming a wallet exists | Crash for visitors without MetaMask | Fall back to `JsonRpcProvider` |
| Still listing Goerli/Mumbai <!-- v5-ok --> | Shut-down networks confuse users | Sepolia, Hoodi, Amoy |

---

### 🧪 How this is graded

Your `NetworkStats` is mounted twice, once with a wallet on Sepolia and once with no wallet. The grader checks which provider you built in each case, that you read the chain id (any of the methods above), and that the screen shows `11155111` and `Sepolia`. It then fires `chainChanged` with `"0x89"` and expects `Polygon`, and finally checks that unmounting removes the listener.

---

### 🔗 External Resources

| Resource | Link |
| -------- | ---- |
| ethers v6: BrowserProvider | https://docs.ethers.org/v6/api/providers/#BrowserProvider |
| MetaMask: detect the network | https://docs.metamask.io/wallet/how-to/manage-networks/detect-network/ |
| MetaMask JSON-RPC methods | https://docs.metamask.io/wallet/reference/json-rpc-methods/ |
| EIP-3326 (switch chain) | https://eips.ethereum.org/EIPS/eip-3326 |
| EIP-3085 (add chain) | https://eips.ethereum.org/EIPS/eip-3085 |
| Chainlist | https://chainlist.org/ |

---

## 🌟 Closing Story

At the next hackathon a judge's MetaMask was on Polygon again. This time the panel read "Chain ID: 137, Chain Name: Polygon", and a banner said "This demo runs on Sepolia." One click, one approval in MetaMask, and the panel flipped to "Sepolia" without a refresh. "Finally, an app that tells me what's wrong," the judge laughed. From Cebu to LA, Neri and Odessa's rule held: never guess the network. 🇵🇭🔄🌐
