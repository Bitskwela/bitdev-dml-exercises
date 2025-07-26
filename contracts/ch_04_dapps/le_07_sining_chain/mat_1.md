## 🧑‍💻 Background Story

The old warehouse in San Francisco’s Mission District buzzed with anticipation. Bright murals of jeepneys and tinikling dancers covered the brick walls. This was Neri’s moment: her carefully curated “SiningChain” exhibit was opening. Filipino street artists from Manila to Davao finally had an international stage. But she needed a seamless, dynamic gallery—one that fetched on‐chain art in real time.

Enter Odessa (“Det”), Neri’s go‐getter friend. Fresh from her night classes at Pamantasan ng Lungsod ng Maynila, Det arrived with her laptop, eyes gleaming. “Tatay ko will flip when he sees Pinoy NFTs on display in SF,” she laughed. The only catch? Neri’s Solidity ERC-721 contract was already deployed on Sepolia. Det had 48 hours to spin up a React + Ethers.js frontend that would:

1. Connect to MetaMask
2. Query token metadata (name, image URL)
3. Render a sleek, responsive gallery grid

As opening night approached, the pressure soared. Guests ranged from tech press to gallery regulars sipping chicha morada. The migraine kicked in. But Det remembered Neri’s mantra: “Grit over glamour.” She opened VS Code, scaffolded a React app, and wired Ethers.js. Line by line, state hooks and useEffects came alive. When the gallery finally rendered—Filipino murals popping from the screen—the crowd gasped. QR codes let collectors buy on‐chain. For the first time, street art intersected Web3, bridging Manila’s streets with San Francisco’s art scene.

By dawn, “SiningChain” was live. Det leaned back, fatigue mixing with triumph. Neri hugged her, whispering, “We did it—for every artist back home.” This MVP was just chapter one. Next up: auctions, fractional ownership, royalty splits. But tonight, under Mission District lights, Filipino artists had their moment—and a Filipino coder had proven she belonged in global Web3. 🇵🇭🧠🔥

---

## 📚 Theory & Web3 Lecture

1. ERC-721 & Metadata

   - ERC-721 is the non-fungible token standard. Each token has a `tokenURI(tokenId)` pointing to a JSON metadata blob.
   - Metadata JSON must include at least `name`, `description`, and `image` fields (images usually hosted on IPFS or HTTPS).

2. dApp Architecture

   - React Frontend (Create React App or Vite)
   - Ethers.js for blockchain interactions
   - MetaMask or any injected Web3 wallet

3. Key Concepts

   - Provider vs. Signer:  
     • Provider (read-only) for `.call()` methods (e.g., `tokenURI`)  
     • Signer for state-changing txs (not needed here)
   - Hooks:  
     • `useState` to store `tokenURIs`, metadata arrays, loading states  
     • `useEffect` for on-mount or wallet-change side effects
   - Gas & Efficiency:  
     • Reading `tokenURI` costs zero gas on the client side  
     • Batch requests: throttle or parallelize calls, but beware rate limits

4. Sample Ethers.js Code

```js
import { ethers } from "ethers";
const ABI = [
  "function balanceOf(address owner) view returns (uint256)",
  "function tokenOfOwnerByIndex(address owner, uint256 index) view returns (uint256)",
  "function tokenURI(uint256 tokenId) view returns (string)",
];
const provider = new ethers.providers.Web3Provider(window.ethereum);
const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  ABI,
  provider
);

// Fetch user's token count
const balance = await contract.balanceOf(userAddress);
// Loop to fetch each tokenId
const tokenIds = [];
for (let i = 0; i < balance; i++) {
  const id = await contract.tokenOfOwnerByIndex(userAddress, i);
  tokenIds.push(id.toString());
}
// Fetch metadata
const metadata = await Promise.all(
  tokenIds.map(async (id) => {
    const uri = await contract.tokenURI(id);
    const res = await fetch(uri);
    return res.json();
  })
);
```

5. Best Practices & Security Tips
   - Always `await window.ethereum.request({ method: 'eth_requestAccounts' })`
   - Handle `try/catch` for RPC errors and user rejections
   - Sanitize external URLs (only allow HTTPS/IPFS)
   - Use `.env` for RPC endpoints and contract addresses (never commit secrets)
   - Debounce or cache repeated calls to avoid rate-limiting

📖 Further Reading

- Ethers.js docs: https://docs.ethers.org
- Solidity ERC-721: https://docs.soliditylang.org/en/v0.8.17/
- React Hooks: https://reactjs.org/docs/hooks-intro.html

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

- [ ] Add `provider = new ethers.providers.Web3Provider(window.ethereum)` and `await ethereum.request({ method: "eth_requestAccounts" })`.
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
      const provider = new ethers.providers.Web3Provider(window.ethereum);
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
- [ ] `provider = new ethers.providers.Web3Provider(...)` & contract
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
        const provider = new ethers.providers.Web3Provider(window.ethereum);
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
      const provider = new ethers.providers.JsonRpcProvider(
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
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({});
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
