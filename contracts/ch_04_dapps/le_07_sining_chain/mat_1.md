## 🧑‍💻 Background Story

![SiningChain](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+7.0+-+COVER.png)

The old warehouse in San Francisco’s Mission District buzzed with anticipation. Bright murals of jeepneys and tinikling dancers covered the brick walls. This was Neri’s moment: her carefully curated “SiningChain” exhibit was opening. Filipino street artists from Manila to Davao finally had an international stage. But she needed a seamless, dynamic gallery—one that fetched on‐chain art in real time.

![Neri and Det](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+7.1.png)

Enter Det, Neri’s go‐getter friend. Fresh from her night classes at Pamantasan ng Lungsod ng Maynila, Det arrived with her laptop, eyes gleaming. “Tatay ko will flip when he sees Pinoy NFTs on display in SF,” she laughed. The only catch? Neri’s Solidity ERC-721 contract was already deployed on Sepolia. Det had 48 hours to spin up a React + Ethers.js frontend that would:

1. Connect to MetaMask
2. Query token metadata (name, image URL)
3. Render a sleek, responsive gallery grid

As opening night approached, the pressure soared. Guests ranged from tech press to gallery regulars sipping chicha morada. The migraine kicked in. But Det remembered Neri’s mantra: “Grit over glamour.” She opened VS Code, scaffolded a React app, and wired Ethers.js. Line by line, state hooks and useEffects came alive. When the gallery finally rendered—Filipino murals popping from the screen—the crowd gasped. QR codes let collectors buy on‐chain. For the first time, street art intersected Web3, bridging Manila’s streets with San Francisco’s art scene.

By dawn, “SiningChain” was live. Det leaned back, fatigue mixing with triumph. Neri hugged her, whispering, “We did it—for every artist back home.” This MVP was just chapter one. Next up: auctions, fractional ownership, royalty splits. But tonight, under Mission District lights, Filipino artists had their moment—and a Filipino coder had proven she belonged in global Web3. 🇵🇭🧠🔥

---

## 📚 Theory & Web3 Lecture

Welcome to the world of **NFTs (Non-Fungible Tokens)**! In this lesson, you'll build an NFT gallery that fetches and displays digital art from the blockchain. Think of it as building your own OpenSea-style gallery!

---

### 1. Understanding ERC-721 (NFT Standard)

#### **What Makes NFTs Different from Regular Tokens?**

```
Fungible (ERC-20) vs Non-Fungible (ERC-721):
┌─────────────────────────────────────────────────────────────┐
│  ERC-20 (Fungible)              │  ERC-721 (Non-Fungible)   │
├─────────────────────────────────────────────────────────────┤
│  All tokens identical           │  Each token is unique     │
│  Like peso bills                │  Like artwork or deeds    │
│  1 BARYO = 1 BARYO             │  NFT #1 ≠ NFT #2          │
│  Balance: 100 tokens            │  Own: tokens #5, #12, #89 │
│  Divisible (0.5 tokens)         │  Indivisible (whole only) │
└─────────────────────────────────────────────────────────────┘

Real-World Analogy:
┌─────────────────────────────────────────────────────────────┐
│  ERC-20 = Peso bills (any ₱100 works the same)             │
│  ERC-721 = Land titles (each plot is unique and specific)  │
└─────────────────────────────────────────────────────────────┘
```

#### **ERC-721 Core Functions**

```solidity
// Ownership
function ownerOf(uint256 tokenId) external view returns (address);
function balanceOf(address owner) external view returns (uint256);

// Enumeration (optional but common)
function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
function totalSupply() external view returns (uint256);
function tokenByIndex(uint256 index) external view returns (uint256);

// Metadata
function name() external view returns (string);
function symbol() external view returns (string);
function tokenURI(uint256 tokenId) external view returns (string);
```

#### **Token IDs**

Each NFT has a unique **token ID**:

```
NFT Contract: SiningChain
┌──────────────────────────────────────────────────────────┐
│  Token ID 0  →  Owner: 0xABC...  →  "Manila Sunset"     │
│  Token ID 1  →  Owner: 0xDEF...  →  "Tinikling Dance"   │
│  Token ID 2  →  Owner: 0xABC...  →  "Jeepney Art"       │
│  Token ID 3  →  Owner: 0x123...  →  "Palawan Beach"     │
└──────────────────────────────────────────────────────────┘

// To get all NFTs owned by 0xABC:
balanceOf(0xABC) = 2
tokenOfOwnerByIndex(0xABC, 0) = 0  // First NFT
tokenOfOwnerByIndex(0xABC, 1) = 2  // Second NFT
```

---

### 2. NFT Metadata: The Art Behind the Token

#### **What is tokenURI?**

Each NFT points to a **metadata JSON file** via `tokenURI()`. This file describes the NFT:

```
On-Chain vs Off-Chain:
┌─────────────────────────────────────────────────────────────┐
│  Smart Contract (On-Chain)                                  │
│  ├── Token ID: 42                                           │
│  ├── Owner: 0xABC...                                        │
│  └── tokenURI: "ipfs://Qm.../42.json"                      │
│         │                                                   │
│         ▼                                                   │
│  Metadata JSON (Off-Chain - IPFS/HTTP)                      │
│  {                                                          │
│    "name": "Manila Sunset #42",                             │
│    "description": "A beautiful sunset over Manila Bay",    │
│    "image": "ipfs://Qm.../sunset.png",                     │
│    "attributes": [                                          │
│      { "trait_type": "Location", "value": "Manila" },      │
│      { "trait_type": "Time", "value": "Sunset" }           │
│    ]                                                        │
│  }                                                          │
└─────────────────────────────────────────────────────────────┘
```

#### **Metadata JSON Standard**

```json
{
  "name": "Artwork Title",
  "description": "Detailed description of the artwork",
  "image": "https://... or ipfs://...",
  "external_url": "https://yoursite.com/nft/42",
  "attributes": [
    { "trait_type": "Artist", "value": "Juan dela Cruz" },
    { "trait_type": "Year", "value": 2024 },
    { "trait_type": "Rarity", "value": "Legendary" }
  ]
}
```

#### **Where is Metadata Stored?**

| Storage      | Pros                     | Cons                        |
| ------------ | ------------------------ | --------------------------- |
| **IPFS**     | Decentralized, permanent | Needs pinning service       |
| **Arweave**  | Permanent, pay once      | More expensive              |
| **HTTPS**    | Easy to set up           | Centralized, can go offline |
| **On-chain** | Fully decentralized      | Very expensive              |

---

### 3. dApp Architecture for NFT Gallery

#### **Component Structure**

```
NFT Gallery Architecture:
┌─────────────────────────────────────────────────────────────┐
│                        App.js                                │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  SingleNFT.js                                           ││
│  │  • Input: Token ID                                       ││
│  │  • Fetches: tokenURI → metadata JSON → displays         ││
│  └─────────────────────────────────────────────────────────┘│
│  ┌─────────────────────────────────────────────────────────┐│
│  │  OwnedGallery.js                                        ││
│  │  • Connects wallet                                       ││
│  │  • Loops: balanceOf → tokenOfOwnerByIndex → tokenURI    ││
│  │  • Displays grid of user's NFTs                          ││
│  └─────────────────────────────────────────────────────────┘│
│  ┌─────────────────────────────────────────────────────────┐│
│  │  AllGallery.js                                          ││
│  │  • Public view (no wallet needed)                        ││
│  │  • Loops: totalSupply → tokenByIndex → tokenURI          ││
│  │  • Shows all minted NFTs                                 ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

#### **Data Flow**

```
Fetching NFT Data:
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│  1. User enters Token ID: 42                                 │
│           │                                                  │
│           ▼                                                  │
│  2. Call contract.tokenURI(42)                               │
│           │                                                  │
│           ▼                                                  │
│  3. Returns: "ipfs://QmXYZ.../42.json"                       │
│           │                                                  │
│           ▼                                                  │
│  4. fetch("https://ipfs.io/ipfs/QmXYZ.../42.json")          │
│           │                                                  │
│           ▼                                                  │
│  5. Parse JSON: { name, description, image }                 │
│           │                                                  │
│           ▼                                                  │
│  6. Display: <img src={image} /> <h3>{name}</h3>            │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

### 4. Fetching NFT Metadata with Ethers.js

#### **The ABI for NFT Operations**

```js
const NFT_ABI = [
  // Ownership
  "function ownerOf(uint256 tokenId) view returns (address)",
  "function balanceOf(address owner) view returns (uint256)",

  // Enumeration
  "function totalSupply() view returns (uint256)",
  "function tokenByIndex(uint256 index) view returns (uint256)",
  "function tokenOfOwnerByIndex(address owner, uint256 index) view returns (uint256)",

  // Metadata
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function tokenURI(uint256 tokenId) view returns (string)",
];
```

#### **Fetching a Single NFT**

```js
async function fetchNFT(contractAddress, tokenId) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(contractAddress, NFT_ABI, provider);

  // Step 1: Get the token URI from the contract
  const tokenURI = await contract.tokenURI(tokenId);
  console.log("Token URI:", tokenURI);
  // "ipfs://QmXYZ.../42.json" or "https://api.example.com/42"

  // Step 2: Convert IPFS to HTTP gateway if needed
  const httpURL = tokenURI.replace("ipfs://", "https://ipfs.io/ipfs/");

  // Step 3: Fetch the metadata JSON
  const response = await fetch(httpURL);
  if (!response.ok) {
    throw new Error("Failed to fetch metadata");
  }
  const metadata = await response.json();

  // Step 4: Return structured data
  return {
    tokenId,
    name: metadata.name,
    description: metadata.description,
    image: metadata.image.replace("ipfs://", "https://ipfs.io/ipfs/"),
    attributes: metadata.attributes || [],
  };
}
```

#### **Fetching All NFTs Owned by a User**

```js
async function fetchOwnedNFTs(contractAddress, userAddress) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(contractAddress, NFT_ABI, provider);

  // Step 1: Get how many NFTs the user owns
  const balance = await contract.balanceOf(userAddress);
  console.log(`User owns ${Number(balance)} NFTs`);

  // Step 2: Get each token ID
  const nfts = [];
  for (let i = 0; i < Number(balance); i++) {
    // Get the token ID at this index
    const tokenId = await contract.tokenOfOwnerByIndex(userAddress, i);

    // Fetch the metadata
    const nft = await fetchNFT(contractAddress, tokenId);
    nfts.push(nft);
  }

  return nfts;
}
```

---

### 5. Optimizing NFT Fetching

#### **The Problem: Too Many Requests**

```js
// ❌ SLOW: Sequential requests (one at a time)
for (let i = 0; i < 10; i++) {
  const tokenId = await contract.tokenOfOwnerByIndex(user, i); // Wait...
  const uri = await contract.tokenURI(tokenId); // Wait...
  const metadata = await fetch(uri); // Wait...
}
// Total time: 30 requests × 200ms = 6 seconds! 😴
```

#### **Solution 1: Parallel Requests with Promise.all**

```js
// ✅ FASTER: Parallel requests
async function fetchOwnedNFTsFast(contract, userAddress) {
  const balance = Number(await contract.balanceOf(userAddress));

  // Fetch all token IDs in parallel
  const tokenIdPromises = [];
  for (let i = 0; i < balance; i++) {
    tokenIdPromises.push(contract.tokenOfOwnerByIndex(userAddress, i));
  }
  const tokenIds = await Promise.all(tokenIdPromises);

  // Fetch all URIs in parallel
  const uriPromises = tokenIds.map((id) => contract.tokenURI(id));
  const uris = await Promise.all(uriPromises);

  // Fetch all metadata in parallel
  const metadataPromises = uris.map((uri) =>
    fetch(uri.replace("ipfs://", "https://ipfs.io/ipfs/")).then((res) =>
      res.json()
    )
  );
  const metadatas = await Promise.all(metadataPromises);

  return metadatas;
}
// Total time: ~600ms (3 batches × 200ms) 🚀
```

#### **Solution 2: Batching to Avoid Rate Limits**

```js
// Process in batches to avoid overwhelming the RPC
async function fetchInBatches(items, fetchFn, batchSize = 5) {
  const results = [];

  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    const batchResults = await Promise.all(batch.map(fetchFn));
    results.push(...batchResults);

    // Small delay between batches
    if (i + batchSize < items.length) {
      await new Promise((resolve) => setTimeout(resolve, 100));
    }
  }

  return results;
}
```

---

### 6. Handling IPFS URLs

#### **IPFS Gateway Conversion**

```js
function convertToHttpUrl(uri) {
  if (!uri) return null;

  // IPFS protocol
  if (uri.startsWith("ipfs://")) {
    return uri.replace("ipfs://", "https://ipfs.io/ipfs/");
  }

  // Already HTTP
  if (uri.startsWith("http")) {
    return uri;
  }

  // Just a CID
  if (uri.startsWith("Qm") || uri.startsWith("bafy")) {
    return `https://ipfs.io/ipfs/${uri}`;
  }

  return uri;
}

// Popular IPFS Gateways:
const GATEWAYS = [
  "https://ipfs.io/ipfs/",
  "https://gateway.pinata.cloud/ipfs/",
  "https://dweb.link/ipfs/",
  "https://nftstorage.link/ipfs/",
];
```

---

### 7. React Component Patterns

#### **NFT Gallery Component**

```jsx
function NFTGallery({ contractAddress }) {
  const [nfts, setNfts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadNFTs() {
      try {
        setLoading(true);

        // Connect wallet
        const [account] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });

        // Fetch owned NFTs
        const provider = new ethers.BrowserProvider(window.ethereum);
        const contract = new ethers.Contract(contractAddress, ABI, provider);

        const balance = await contract.balanceOf(account);
        const items = [];

        for (let i = 0; i < balance; i++) {
          const tokenId = await contract.tokenOfOwnerByIndex(account, i);
          const uri = await contract.tokenURI(tokenId);
          const res = await fetch(convertToHttpUrl(uri));
          const metadata = await res.json();

          items.push({
            tokenId: tokenId.toString(),
            ...metadata,
            image: convertToHttpUrl(metadata.image),
          });
        }

        setNfts(items);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    loadNFTs();
  }, [contractAddress]);

  if (loading) return <p>Loading your NFTs...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (!nfts.length) return <p>No NFTs found in your wallet.</p>;

  return (
    <div className="gallery-grid">
      {nfts.map((nft) => (
        <div key={nft.tokenId} className="nft-card">
          <img src={nft.image} alt={nft.name} />
          <h3>{nft.name}</h3>
          <p>{nft.description}</p>
        </div>
      ))}
    </div>
  );
}
```

---

### 8. Common Mistakes & Debugging

#### **1. Forgetting to Convert IPFS URLs**

```js
// ❌ This won't work in browsers!
<img src="ipfs://QmXYZ..." />

// ✅ Convert to HTTP gateway
<img src={convertToHttpUrl(metadata.image)} />
```

#### **2. Not Handling Missing Metadata**

```js
// ❌ Will crash if metadata is malformed
const name = metadata.name;

// ✅ Provide fallbacks
const name = metadata?.name || `Token #${tokenId}`;
const image = metadata?.image || "/placeholder.png";
```

#### **3. Not Checking Token Existence**

```js
// ❌ Will revert if token doesn't exist
const owner = await contract.ownerOf(9999);

// ✅ Catch the error
try {
  const owner = await contract.ownerOf(tokenId);
} catch (err) {
  if (err.message.includes("nonexistent token")) {
    setError("This NFT doesn't exist");
  }
}
```

---

### 9. Testing Your NFT Gallery

Before deploying, verify:

1. ✅ **Single NFT loads** - Image and name display
2. ✅ **Gallery loads** - All owned NFTs appear
3. ✅ **IPFS URLs convert** - Images load from gateway
4. ✅ **Loading states shown** - Spinner while fetching
5. ✅ **Empty state handled** - Message when no NFTs
6. ✅ **Errors display** - Invalid token shows message
7. ✅ **Images have fallbacks** - Placeholder if image fails

---

### External References & Further Learning

- **Ethers.js Documentation**: https://docs.ethers.org - Contract interactions
- **OpenZeppelin ERC-721**: https://docs.openzeppelin.com/contracts/4.x/erc721 - Standard implementation
- **EIP-721 Specification**: https://eips.ethereum.org/EIPS/eip-721 - The official NFT standard
- **IPFS Documentation**: https://docs.ipfs.tech - Decentralized storage
- **OpenSea Metadata Standards**: https://docs.opensea.io/docs/metadata-standards - Marketplace compatibility
- **NFT.Storage**: https://nft.storage - Free IPFS pinning for NFTs

---

## 🧪 Exercises

### Exercise 1: Render a Single NFT by Token ID

**Problem Statement**  
Build a React component that, given a token ID input, fetches its `tokenURI`, loads the metadata JSON, and displays the image and name.

**Solidity Contract (`SiningNFT.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SiningNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    constructor() ERC721("SiningChain Gallery", "SINING") {}

    function mint(address to, string memory uri) external onlyOwner {
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, uri);
        nextTokenId++;
    }
}
```

**Starter Code (`SingleNFT.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function tokenURI(uint256 tokenId) view returns (string)"];

export default function SingleNFT() {
  const [tokenId, setTokenId] = useState("");
  const [meta, setMeta] = useState(null);
  const [error, setError] = useState("");

  async function fetchMetadata() {
    try {
      // TODO: Instantiate provider & contract
      // TODO: Call tokenURI(tokenId)
      // TODO: Fetch JSON & setMeta
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h2>Fetch a Single NFT</h2>
      <input
        type="number"
        placeholder="token ID"
        value={tokenId}
        onChange={(e) => setTokenId(e.target.value)}
      />
      <button onClick={fetchMetadata}>Load NFT</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
      {meta && (
        <div>
          <img src={meta.image} alt={meta.name} width="300" />
          <h3>{meta.name}</h3>
        </div>
      )}
    </div>
  );
}
```

**To Do List**

- [ ] Add `provider = new ethers.BrowserProvider(window.ethereum)` and `await ethereum.request({ method: "eth_requestAccounts" })`.
- [ ] Create `contract = new ethers.Contract(address, ABI, provider)`.
- [ ] Call `tokenURI(tokenId)` and `fetch()` the JSON.
- [ ] Update `setMeta` with parsed JSON.
- [ ] Handle errors with `try/catch`.

**Full Solution**

```js
// SingleNFT.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function tokenURI(uint256) view returns (string)"];
const CONTRACT = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function SingleNFT() {
  const [tokenId, setTokenId] = useState("");
  const [meta, setMeta] = useState(null);
  const [error, setError] = useState("");

  async function fetchMetadata() {
    setError("");
    setMeta(null);
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const contract = new ethers.Contract(CONTRACT, ABI, provider);
      const uri = await contract.tokenURI(tokenId);
      const res = await fetch(uri);
      if (!res.ok) throw new Error("Failed to load metadata");
      const json = await res.json();
      setMeta(json);
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div style={{ textAlign: "center" }}>
      <h2>Fetch a Single NFT</h2>
      <input
        type="number"
        placeholder="Token ID"
        value={tokenId}
        onChange={(e) => setTokenId(e.target.value)}
      />
      <button onClick={fetchMetadata}>Load NFT</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
      {meta && (
        <div>
          <img src={meta.image} alt={meta.name} width="300" />
          <h3>{meta.name}</h3>
          <p>{meta.description}</p>
        </div>
      )}
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
REACT_APP_CONTRACT_ADDRESS=0xYourDeployedAddress
```

---

### Exercise 2: List NFTs Owned by Connected Wallet

**Problem Statement**  
Create a gallery component that connects to MetaMask, reads `balanceOf`, then loops `tokenOfOwnerByIndex` to fetch each NFT’s metadata and render a grid.

**Starter Code (`OwnedGallery.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function balanceOf(address) view returns (uint256)",
  "function tokenOfOwnerByIndex(address,uint256) view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
];

export default function OwnedGallery() {
  const [account, setAccount] = useState("");
  const [metaList, setMetaList] = useState([]);

  useEffect(() => {
    async function load() {
      // TODO: Request accounts, setAccount
      // TODO: Instantiate provider & contract
      // TODO: Fetch balance, loop indexes, fetch URIs & metadata
      // TODO: setMetaList([...])
    }
    load();
  }, []);

  return (
    <div>
      <h2>Your NFT Collection</h2>
      <div className="grid">
        {metaList.map((m, i) => (
          <div key={i}>
            <img src={m.image} alt={m.name} width="150" />
            <p>{m.name}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
```

**To Do List**

- [ ] `await ethereum.request({ method: "eth_requestAccounts" })`
- [ ] `provider = new ethers.BrowserProvider(...)` & contract
- [ ] `balance = await contract.balanceOf(account)`
- [ ] Loop `i < balance`, fetch `tokenOfOwnerByIndex(account, i)`
- [ ] Fetch each `tokenURI` JSON, accumulate array, `setMetaList`.

**Full Solution**

```js
// OwnedGallery.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function balanceOf(address) view returns (uint256)",
  "function tokenOfOwnerByIndex(address,uint256) view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
];
const CONTRACT = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function OwnedGallery() {
  const [account, setAccount] = useState("");
  const [metaList, setMetaList] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      try {
        const [user] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setAccount(user);
        const provider = new ethers.BrowserProvider(window.ethereum);
        const contract = new ethers.Contract(CONTRACT, ABI, provider);
        const balance = await contract.balanceOf(user);
        const metadatas = [];
        for (let i = 0; i < balance; i++) {
          const tokenId = await contract.tokenOfOwnerByIndex(user, i);
          const uri = await contract.tokenURI(tokenId);
          const res = await fetch(uri);
          metadatas.push(await res.json());
        }
        setMetaList(metadatas);
      } catch (e) {
        console.error(e);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  if (loading) return <p>Loading your NFTs...</p>;
  if (!metaList.length) return <p>No NFTs found in your wallet.</p>;

  return (
    <div>
      <h2>
        {account.slice(0, 6)}…{account.slice(-4)}’s Collection
      </h2>
      <div className="grid">
        {metaList.map((m, i) => (
          <div key={i} className="card">
            <img src={m.image} alt={m.name} width="150" />
            <p>{m.name}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
```

---

### Exercise 3: Display All Minted NFTs (Total Supply)

**Problem Statement**  
Show a public gallery of **every** minted NFT by querying `totalSupply()` and then fetching each token’s metadata.

**Starter Code (`AllGallery.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function totalSupply() view returns (uint256)",
  "function tokenByIndex(uint256) view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
];

export default function AllGallery() {
  const [items, setItems] = useState([]);

  useEffect(() => {
    async function loadAll() {
      // TODO: provider & contract
      // TODO: total = await contract.totalSupply()
      // TODO: for each index, get tokenByIndex & metadata
    }
    loadAll();
  }, []);

  return (
    <div className="grid">
      {items.map((m, i) => (
        <div key={i}>
          <img src={m.image} alt={m.name} width="120" />
          <h4>{m.name}</h4>
        </div>
      ))}
    </div>
  );
}
```

**To Do List**

- [ ] Instantiate `provider` and `contract`
- [ ] Call `totalSupply()`
- [ ] Loop `i < total`, call `tokenByIndex(i)` & `tokenURI(id)`
- [ ] Fetch JSON metadata, push to array, `setItems`

**Full Solution**

```js
// AllGallery.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function totalSupply() view returns (uint256)",
  "function tokenByIndex(uint256) view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
];
const CONTRACT = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function AllGallery() {
  const [items, setItems] = useState([]);

  useEffect(() => {
    async function loadAll() {
      const provider = new ethers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(CONTRACT, ABI, provider);
      const total = await contract.totalSupply();
      const all = [];
      for (let i = 0; i < total; i++) {
        const id = await contract.tokenByIndex(i);
        const uri = await contract.tokenURI(id);
        const res = await fetch(uri);
        all.push(await res.json());
      }
      setItems(all);
    }
    loadAll();
  }, []);

  return (
    <div>
      <h2>All SiningChain NFTs</h2>
      <div className="grid">
        {items.map((m, i) => (
          <div key={i} className="card-small">
            <img src={m.image} alt={m.name} width="120" />
            <h4>{m.name}</h4>
          </div>
        ))}
      </div>
    </div>
  );
}
```

---

## ✅ Test Cases

Create `__tests__/OwnedGallery.test.js` using React Testing Library & Jest.

```js
// __tests__/OwnedGallery.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import OwnedGallery from "../OwnedGallery";
import { ethers } from "ethers";

jest.mock("ethers");

describe("OwnedGallery Component", () => {
  const fakeAccount = "0xAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAa";
  const fakeContract = {
    balanceOf: jest.fn(),
    tokenOfOwnerByIndex: jest.fn(),
    tokenURI: jest.fn(),
  };

  beforeAll(() => {
    // Mock window.ethereum
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue([fakeAccount]),
    };

    // Mock provider & contract
    ethers.BrowserProvider = jest.fn().mockReturnValue({});
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("renders loading state then shows owned NFTs", async () => {
    fakeContract.balanceOf.mockResolvedValue(2);
    fakeContract.tokenOfOwnerByIndex
      .mockResolvedValueOnce(10)
      .mockResolvedValueOnce(20);
    fakeContract.tokenURI
      .mockResolvedValueOnce("https://meta/10.json")
      .mockResolvedValueOnce("https://meta/20.json");

    // Mock fetch for metadata
    global.fetch = jest
      .fn()
      .mockResolvedValueOnce({
        ok: true,
        json: () =>
          Promise.resolve({ name: "Art #10", image: "https://ipfs/10.png" }),
      })
      .mockResolvedValueOnce({
        ok: true,
        json: () =>
          Promise.resolve({ name: "Art #20", image: "https://ipfs/20.png" }),
      });

    render(<OwnedGallery />);

    expect(screen.getByText(/Loading your NFTs/i)).toBeInTheDocument();

    // Wait for two images to appear
    await waitFor(() => expect(screen.getAllByRole("img")).toHaveLength(2));

    expect(screen.getByText("Art #10")).toBeInTheDocument();
    expect(screen.getByText("Art #20")).toBeInTheDocument();
    expect(screen.getAllByRole("img")[0]).toHaveAttribute(
      "src",
      "https://ipfs/10.png"
    );
  });

  it("shows no NFTs message when balance is zero", async () => {
    fakeContract.balanceOf.mockResolvedValue(0);
    render(<OwnedGallery />);
    await waitFor(() =>
      expect(screen.getByText(/No NFTs found/i)).toBeInTheDocument()
    );
  });
});
```

Test configuration (`jest.config.js`):

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: {
    "\\.(css|scss)$": "identity-obj-proxy",
  },
};
```

---

## 🌟 Closing Story

With the gallery live, Neri’s “SiningChain” exhibit drew tech blogs and art critics alike. Odessa watched as QR‐code collectors snapped up Filipino street art on‐chain. From Pamantasan classrooms to SF gallery lights, she’d bridged two worlds. As applause echoed, Det cracked a grin: “Next, we build an auction house with time‐based bids!” She already had her React hooks and Ethers.js ready. Chapter two awaits—fractional NFTs, DAO governance, and royalty splits. Mabuhay, future Web3 elite! 🇵🇭🚀
