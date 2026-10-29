## 🧑‍💻 Background Story

![SiningChain](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+7.0+-+COVER.png)

The old warehouse in San Francisco's Mission District buzzed with anticipation. Bright murals of jeepneys and tinikling dancers covered the brick walls. This was Neri's moment: her carefully curated "SiningChain" exhibit was opening. Filipino street artists from Manila to Davao finally had an international stage. But she needed a seamless, dynamic gallery, one that fetched on-chain art in real time.

![Neri and Det](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+7.1.png)

Enter Det, Neri's go-getter friend. Fresh from her night classes at Pamantasan ng Lungsod ng Maynila, Det arrived with her laptop, eyes gleaming. "Tatay ko will flip when he sees Pinoy NFTs on display in SF," she laughed. The only catch? Neri's ERC-721 contract was already deployed on Sepolia. Det had 48 hours to spin up a React + ethers frontend that would:

1. Connect to MetaMask
2. Query token metadata (name, image URL)
3. Render a sleek, responsive gallery grid

As opening night approached, the pressure soared. Guests ranged from tech press to gallery regulars sipping chicha morada. The migraine kicked in. But Det remembered Neri's mantra: "Grit over glamour." She opened VS Code, scaffolded a React app with Vite, and wired up ethers. Line by line, state hooks came alive. When the gallery finally rendered, Filipino murals popping from the screen, the crowd gasped. For the first time, street art intersected Web3, bridging Manila's streets with San Francisco's art scene.

By dawn, "SiningChain" was live. Det leaned back, fatigue mixing with triumph. Neri hugged her, whispering, "We did it, for every artist back home." This MVP was just chapter one. Next up: auctions, fractional ownership, royalty splits. But tonight, under Mission District lights, Filipino artists had their moment, and a Filipino coder had proven she belonged in global Web3. 🇵🇭🧠🔥

---

## 📚 Theory & Web3 Lecture

Welcome to the world of **NFTs (Non-Fungible Tokens)**! In this lesson you build an NFT gallery that fetches and displays digital art from the blockchain. Think of it as your own mini OpenSea.

> **This lesson uses ethers v6** (`ethers.BrowserProvider`, `ethers.JsonRpcProvider`, values as `bigint`). Older tutorials that write `ethers.providers...` or `.toNumber()` are ethers v5 and will not run here. <!-- v5-ok -->

---

### 1. Understanding ERC-721 (the NFT Standard)

#### **What Makes NFTs Different from Regular Tokens?**

```
Fungible (ERC-20) vs Non-Fungible (ERC-721):
┌─────────────────────────────────────────────────────────────┐
│  ERC-20 (Fungible)              │  ERC-721 (Non-Fungible)   │
├─────────────────────────────────────────────────────────────┤
│  All tokens identical           │  Each token is unique     │
│  Like peso bills                │  Like artwork or deeds    │
│  1 BARYO = 1 BARYO              │  NFT #1 ≠ NFT #2          │
│  Balance: 100 tokens            │  Own: tokens #5, #12, #89 │
│  Divisible (0.5 tokens)         │  Indivisible (whole only) │
└─────────────────────────────────────────────────────────────┘

Real-World Analogy:
┌─────────────────────────────────────────────────────────────┐
│  ERC-20  = Peso bills (any ₱100 works the same)             │
│  ERC-721 = Land titles (each plot is unique and specific)   │
└─────────────────────────────────────────────────────────────┘
```

#### **ERC-721 Core Functions**

```solidity
// Ownership (every ERC-721)
function ownerOf(uint256 tokenId) external view returns (address);
function balanceOf(address owner) external view returns (uint256);

// Metadata (the "Metadata" extension, almost always present)
function name() external view returns (string memory);
function symbol() external view returns (string memory);
function tokenURI(uint256 tokenId) external view returns (string memory);

// Enumeration (the OPTIONAL "Enumerable" extension)
function totalSupply() external view returns (uint256);
function tokenByIndex(uint256 index) external view returns (uint256);
function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
```

The enumeration functions only exist if the contract includes **ERC721Enumerable**. Without them, you cannot ask "which tokens does this wallet own?" directly; you would have to scan `Transfer` events instead. SiningChain includes it (see Exercise 1).

#### **Token IDs**

Each NFT has a unique **token ID**:

```
NFT Contract: SiningChain
┌──────────────────────────────────────────────────────────┐
│  Token ID 0  →  Owner: 0xABC...  →  "Manila Sunset"      │
│  Token ID 1  →  Owner: 0xDEF...  →  "Tinikling Dance"    │
│  Token ID 2  →  Owner: 0xABC...  →  "Jeepney Art"        │
│  Token ID 3  →  Owner: 0x123...  →  "Palawan Beach"      │
└──────────────────────────────────────────────────────────┘

// To get all NFTs owned by 0xABC:
balanceOf(0xABC)              = 2
tokenOfOwnerByIndex(0xABC, 0) = 0   // first NFT
tokenOfOwnerByIndex(0xABC, 1) = 2   // second NFT
```

---

### 2. NFT Metadata: The Art Behind the Token

#### **What is tokenURI?**

The picture itself is **not** stored on the blockchain (that would cost a fortune). Instead each NFT points to a small **metadata JSON file** through `tokenURI()`:

```
On-Chain vs Off-Chain:
┌─────────────────────────────────────────────────────────────┐
│  Smart Contract (On-Chain)                                  │
│  ├── Token ID: 42                                           │
│  ├── Owner: 0xABC...                                        │
│  └── tokenURI: "ipfs://Qm.../42.json"                       │
│         │                                                   │
│         ▼                                                   │
│  Metadata JSON (Off-Chain, on IPFS or HTTP)                 │
│  {                                                          │
│    "name": "Manila Sunset #42",                             │
│    "description": "A beautiful sunset over Manila Bay",     │
│    "image": "ipfs://Qm.../sunset.png",                      │
│    "attributes": [                                          │
│      { "trait_type": "Location", "value": "Manila" }        │
│    ]                                                        │
│  }                                                          │
└─────────────────────────────────────────────────────────────┘
```

Fetching an NFT is therefore always **two hops**: ask the contract for the URI, then fetch the JSON at that URI. And the JSON's `image` is usually a third address to load.

#### **Metadata JSON Shape**

```json
{
  "name": "Artwork Title",
  "description": "Detailed description of the artwork",
  "image": "https://... or ipfs://...",
  "external_url": "https://yoursite.com/nft/42",
  "attributes": [
    { "trait_type": "Artist", "value": "Juan dela Cruz" },
    { "trait_type": "Year", "value": 2024 }
  ]
}
```

`name`, `description` and `image` come from the ERC-721 metadata schema in EIP-721. `attributes` and `external_url` are a popular convention started by marketplaces.

#### **Where is Metadata Stored?**

| Storage      | Pros                     | Cons                                      |
| ------------ | ------------------------ | ----------------------------------------- |
| **IPFS**     | Decentralized, by content hash | Someone must keep "pinning" the file |
| **Arweave**  | Permanent, pay once      | More expensive up front                   |
| **HTTPS**    | Easy to set up           | Centralized, can go offline or change     |
| **On-chain** | Fully decentralized      | Very expensive                            |

---

### 3. IPFS Gateways

**IPFS** finds files by their content hash, called a **CID** (for example `QmSiningOne...` or `bafy...`). A link like `ipfs://QmXYZ/42.json` means "the file with this hash", wherever it lives.

Browsers do not speak IPFS. So we use an **HTTP gateway**: a normal web server that fetches the IPFS file for you.

```
ipfs://QmXYZ/42.json
        │  replace "ipfs://" with a gateway prefix
        ▼
https://ipfs.io/ipfs/QmXYZ/42.json   ← fetch() and <img> can load this
```

```js
function convertToHttpUrl(uri) {
  if (!uri) return "/placeholder.png";
  if (uri.startsWith("http")) return uri;                 // already a web link
  if (uri.startsWith("ipfs://")) {
    return uri.replace("ipfs://", "https://ipfs.io/ipfs/"); // ipfs:// link
  }
  if (uri.startsWith("Qm") || uri.startsWith("bafy")) {
    return `https://ipfs.io/ipfs/${uri}`;                   // bare CID
  }
  return uri;
}
```

Public gateways you can rely on today:

- `https://ipfs.io/ipfs/` (the community public gateway; **the one the activity uses**)
- `https://dweb.link/ipfs/` (its sister public gateway)
- Your pinning service's own gateway, such as Pinata's dedicated gateway

Gateways come and go. `cloudflare-ipfs.com`, a once-popular choice in older tutorials, was retired by Cloudflare in 2024. That is why it pays to keep the gateway in **one** helper: when a gateway dies, you change one line.

---

### 4. Fetching NFT Metadata with ethers v6

#### **The ABI for NFT Operations**

```js
const NFT_ABI = [
  "function ownerOf(uint256 tokenId) view returns (address)",
  "function balanceOf(address owner) view returns (uint256)",
  "function totalSupply() view returns (uint256)",
  "function tokenByIndex(uint256 index) view returns (uint256)",
  "function tokenOfOwnerByIndex(address owner, uint256 index) view returns (uint256)",
  "function tokenURI(uint256 tokenId) view returns (string)",
];
```

#### **Fetching a Single NFT (no wallet needed)**

```js
async function fetchNFT(contractAddress, tokenId) {
  // Reading is free and needs no wallet: talk to an RPC node directly
  const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
  const contract = new ethers.Contract(contractAddress, NFT_ABI, provider);

  // Hop 1: ask the contract where the metadata lives
  const tokenURI = await contract.tokenURI(tokenId);
  // "ipfs://QmXYZ.../42.json"

  // Hop 2: fetch the JSON through a gateway
  const response = await fetch(convertToHttpUrl(tokenURI));
  if (!response.ok) throw new Error("Failed to fetch metadata");
  const metadata = await response.json();

  return {
    tokenId: tokenId.toString(),
    name: metadata.name,
    description: metadata.description,
    image: convertToHttpUrl(metadata.image), // hop 3 happens in <img>
    attributes: metadata.attributes || [],
  };
}
```

`import.meta.env.VITE_RPC_URL` is how a **Vite** app reads environment variables (they must start with `VITE_`). The activity's grader supplies `process.env.REACT_APP_RPC_URL` instead, and the starter already reads it for you.

#### **Fetching All NFTs a Wallet Owns**

```js
async function fetchOwnedNFTs(contractAddress) {
  const [owner] = await window.ethereum.request({ method: "eth_requestAccounts" });

  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(contractAddress, NFT_ABI, provider);

  const balance = await contract.balanceOf(owner); // a bigint, e.g. 2n
  console.log(`Owner holds ${balance} NFTs`);

  const nfts = [];
  for (let i = 0; i < balance; i++) {               // number < bigint works
    const tokenId = await contract.tokenOfOwnerByIndex(owner, i);
    nfts.push(await fetchNFT(contractAddress, tokenId));
  }
  return nfts;
}
```

In v6, `balanceOf` returns a `bigint`. You do not need to convert it to loop: JavaScript compares `0 < 2n` correctly. If you ever need a plain number (say, for an array length), use `Number(balance)`, which is safe for small counts like this.

---

### 5. Optimizing NFT Fetching

#### **The Problem: Waiting in Line**

```js
// ❌ SLOW: one request at a time
for (let i = 0; i < 10; i++) {
  const tokenId = await contract.tokenOfOwnerByIndex(user, i); // wait...
  const uri = await contract.tokenURI(tokenId);                // wait...
  const res = await fetch(convertToHttpUrl(uri));              // wait...
}
// 30 requests × ~200ms ≈ 6 seconds 😴
```

#### **Faster: Parallel Requests with Promise.all**

```js
// ✅ FASTER: three waves instead of thirty waits
async function fetchOwnedNFTsFast(contract, owner) {
  const count = Number(await contract.balanceOf(owner));

  const tokenIds = await Promise.all(
    Array.from({ length: count }, (_, i) => contract.tokenOfOwnerByIndex(owner, i)),
  );
  const uris = await Promise.all(tokenIds.map((id) => contract.tokenURI(id)));
  const metadatas = await Promise.all(
    uris.map((uri) => fetch(convertToHttpUrl(uri)).then((res) => res.json())),
  );
  return metadatas;
}
// ≈ 3 rounds × ~200ms ≈ 0.6 seconds 🚀
```

The activity uses the simple loop on purpose, so each step is easy to follow. Once it works, try swapping in this version.

#### **Batching to Avoid Rate Limits**

Free RPC endpoints and gateways limit how many requests you can make per second. For a big collection, fetch in small batches:

```js
async function fetchInBatches(items, fetchFn, batchSize = 5) {
  const results = [];
  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    results.push(...(await Promise.all(batch.map(fetchFn))));
    if (i + batchSize < items.length) {
      await new Promise((resolve) => setTimeout(resolve, 100)); // breathe
    }
  }
  return results;
}
```

---

### 6. Empty, Loading and Error States

A gallery has more states than "full of art":

| State   | When                                 | Show                       |
| ------- | ------------------------------------ | -------------------------- |
| Empty   | Nothing loaded yet, or wallet owns 0 | "No NFTs found."           |
| Loading | A fetch is running                   | "Loading..." + disabled buttons |
| Error   | A read or fetch failed               | A red, human message       |
| Loaded  | Items arrived                        | The grid                   |

```jsx
{ownedNFTs.length === 0 && !loading && <p>No NFTs found.</p>}
{loading && <p>Loading...</p>}
{error && <p style={{ color: "red" }}>{error}</p>}
```

A heading such as "My Collection" is **not** an empty state: a visitor seeing only a heading cannot tell "empty" from "broken". Say it in words.

---

### 7. Common Mistakes & Debugging

#### **1. Forgetting to Convert IPFS URLs**

```jsx
// ❌ Browsers cannot load this
<img src="ipfs://QmXYZ..." />

// ✅ Go through the gateway helper
<img src={convertToHttpUrl(metadata.image)} />
```

#### **2. Not Handling Missing Metadata**

```js
// ❌ Crashes or shows "undefined" if a field is missing
const name = metadata.name;

// ✅ Provide fallbacks
const name = metadata?.name || `Token #${tokenId}`;
const image = metadata?.image ? convertToHttpUrl(metadata.image) : "/placeholder.png";
```

#### **3. Asking About a Token That Does Not Exist**

In OpenZeppelin v5, `ownerOf` or `tokenURI` on a token that was never minted reverts with the custom error `ERC721NonexistentToken(tokenId)`. ethers v6 reports a reverted read as error code `CALL_EXCEPTION`:

```js
try {
  const uri = await contract.tokenURI(tokenId);
} catch (err) {
  if (err.code === "CALL_EXCEPTION") {
    setError("This NFT doesn't exist (yet)");
  }
}
```

---

### 8. How This Is Graded

The activity runs in a sandbox with a fake wallet that owns **2** SiningChain NFTs, and an offline copy of their metadata that answers only `https://ipfs.io/ipfs/...` addresses. The grader types a token ID, clicks **Load NFT** and **Load My NFTs**, and checks that you read `tokenURI`, `balanceOf` and `tokenOfOwnerByIndex`, fetch through the ipfs.io gateway, show the NFT names, and show an empty-state message before anything loads.

---

### External References & Further Learning

- **ethers v6 documentation**: https://docs.ethers.org/v6/
- **OpenZeppelin ERC-721 (v5)**: https://docs.openzeppelin.com/contracts/5.x/erc721
- **EIP-721 specification**: https://eips.ethereum.org/EIPS/eip-721
- **IPFS docs, "Address IPFS on the web" (gateways)**: https://docs.ipfs.tech/how-to/address-ipfs-on-web/
- **React: rendering lists**: https://react.dev/learn/rendering-lists

---

## 🧪 Exercises

### Exercise 1: Deploy a SiningChain Contract (OpenZeppelin v5)

**Problem Statement**
Write an ERC-721 that stores a URI per token **and** supports enumeration, so a frontend can list a wallet's tokens.

**Solidity Contract (`SiningNFT.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SiningNFT is ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    constructor() ERC721("SiningChain Gallery", "SINING") Ownable(msg.sender) {}

    function mint(address to, string memory uri) external onlyOwner {
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // Two parents define these functions, so Solidity asks us to say
    // "run both" explicitly. super.* walks through each parent in turn.
    function _update(address to, uint256 tokenId, address auth)
        internal override(ERC721, ERC721Enumerable) returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public view override(ERC721, ERC721URIStorage) returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public view override(ERC721Enumerable, ERC721URIStorage) returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```

What is new in OpenZeppelin v5:

- `Ownable(msg.sender)`: v5 makes you name the first owner.
- `_update` is the single hook every mint, transfer and burn passes through (v4 had `_beforeTokenTransfer` instead).
- Without `ERC721Enumerable`, there would be no `tokenOfOwnerByIndex` and the "My Collection" view could not work.

Deploy it to **Sepolia** (Remix + MetaMask is the quickest path) and mint a couple of tokens with `ipfs://` URIs.

---

### Exercise 2: Render a Single NFT by Token ID

**Problem Statement**
Build a component that takes a token ID, fetches its `tokenURI`, loads the metadata JSON through a gateway, and displays the image and name.

**Full Solution (`SingleNFT.jsx`)**

```jsx
import { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function tokenURI(uint256) view returns (string)"];
const CONTRACT = import.meta.env.VITE_CONTRACT_ADDRESS;

const toHttp = (uri) => uri.replace("ipfs://", "https://ipfs.io/ipfs/");

export default function SingleNFT() {
  const [tokenId, setTokenId] = useState("");
  const [meta, setMeta] = useState(null);
  const [error, setError] = useState("");

  async function fetchMetadata() {
    setError("");
    setMeta(null);
    try {
      const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
      const contract = new ethers.Contract(CONTRACT, ABI, provider);
      const uri = await contract.tokenURI(tokenId);
      const res = await fetch(toHttp(uri));
      if (!res.ok) throw new Error("Failed to load metadata");
      const json = await res.json();
      setMeta({ ...json, image: toHttp(json.image) });
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

**.env sample (Vite)**

```
VITE_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
VITE_CONTRACT_ADDRESS=0xYourDeployedAddress
```

---

### Exercise 3: Display All Minted NFTs (Public Gallery)

**Problem Statement**
Show every minted NFT, wallet or no wallet, by reading `totalSupply()` and walking `tokenByIndex`.

**Full Solution (`AllGallery.jsx`)**

```jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function totalSupply() view returns (uint256)",
  "function tokenByIndex(uint256) view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
];
const CONTRACT = import.meta.env.VITE_CONTRACT_ADDRESS;
const toHttp = (uri) => uri.replace("ipfs://", "https://ipfs.io/ipfs/");

export default function AllGallery() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadAll() {
      try {
        const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
        const contract = new ethers.Contract(CONTRACT, ABI, provider);
        const total = await contract.totalSupply();
        const all = [];
        for (let i = 0; i < total; i++) {
          const id = await contract.tokenByIndex(i);
          const res = await fetch(toHttp(await contract.tokenURI(id)));
          const meta = await res.json();
          all.push({ ...meta, image: toHttp(meta.image) });
        }
        setItems(all);
      } finally {
        setLoading(false);
      }
    }
    loadAll();
  }, []);

  if (loading) return <p>Loading the gallery...</p>;
  if (!items.length) return <p>No NFTs minted yet.</p>;

  return (
    <div>
      <h2>All SiningChain NFTs</h2>
      <div style={{ display: "flex", gap: 12, flexWrap: "wrap" }}>
        {items.map((m, i) => (
          <div key={i}>
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

## 🌟 Closing Story

With the gallery live, Neri's "SiningChain" exhibit drew tech blogs and art critics alike. Odessa watched as collectors browsed Filipino street art on-chain. From Pamantasan classrooms to SF gallery lights, she had bridged two worlds. As applause echoed, Det cracked a grin: "Next, we build an auction house with time-based bids!" Her React hooks and ethers were ready. Chapter two awaits: fractional NFTs, DAO governance, and royalty splits. Mabuhay, future Web3 builders! 🇵🇭🚀
