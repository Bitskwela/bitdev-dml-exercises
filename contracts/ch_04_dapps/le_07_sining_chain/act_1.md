# SiningChain NFT Gallery Activity

## Initial Code

```solidity
// SiningNFT.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SiningNFT is ERC721URIStorage, ERC721Enumerable, Ownable {
    uint256 public nextTokenId;

    constructor() ERC721("SiningChain Gallery", "SINING") {}

    function mint(address to, string memory uri) external onlyOwner {
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, uri);
        nextTokenId++;
    }

    // Required overrides for multiple inheritance
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(uint256 tokenId)
        public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
}
```

```js
// NFTGallery.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function tokenURI(uint256) view returns (string)",
  "function balanceOf(address) view returns (uint256)",
  "function tokenOfOwnerByIndex(address, uint256) view returns (uint256)",
  "function ownerOf(uint256) view returns (address)",
];

export default function NFTGallery() {
  const [tokenId, setTokenId] = useState("");
  const [nft, setNft] = useState(null);
  const [ownedNFTs, setOwnedNFTs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchSingleNFT = async () => {
    // TODO: Fetch single NFT by token ID
  };

  const fetchOwnedNFTs = async () => {
    // TODO: Fetch all NFTs owned by connected wallet
  };

  return (
    <div>
      <h2>🎨 SiningChain NFT Gallery</h2>

      {/* Single NFT Viewer */}
      <div>
        <h3>View Single NFT</h3>
        <input
          type="number"
          placeholder="Token ID"
          value={tokenId}
          onChange={(e) => setTokenId(e.target.value)}
        />
        <button onClick={fetchSingleNFT}>Load NFT</button>
        {nft && (
          <div>
            <img src={nft.image} alt={nft.name} style={{ maxWidth: 300 }} />
            <h4>{nft.name}</h4>
            <p>{nft.description}</p>
          </div>
        )}
      </div>

      {/* Owned NFTs Gallery */}
      <div>
        <h3>My Collection</h3>
        <button onClick={fetchOwnedNFTs}>Load My NFTs</button>
        <div style={{ display: "flex", gap: 16, flexWrap: "wrap" }}>
          {ownedNFTs.map((item, i) => (
            <div key={i} style={{ border: "1px solid #ccc", padding: 8 }}>
              <img src={item.image} alt={item.name} style={{ width: 150 }} />
              <p>{item.name}</p>
            </div>
          ))}
        </div>
      </div>

      {loading && <p>Loading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_CONTRACT_ADDRESS=0xYourSiningNFTAddress
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: ERC-721 tokenURI, IPFS metadata fetching, JSON parsing, `balanceOf`, `tokenOfOwnerByIndex`, gallery rendering

---

### Task 1: Fetch a Single NFT by Token ID

Implement the `fetchSingleNFT` function to get the tokenURI from the contract, fetch the JSON metadata, convert IPFS URLs to HTTP gateway URLs, and display the NFT.

```js
const fetchSingleNFT = async () => {
  try {
    setLoading(true);
    setError("");
    setNft(null);

    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      ABI,
      provider
    );

    // Fetch tokenURI from contract
    const uri = await contract.tokenURI(tokenId);

    // Convert IPFS to HTTP gateway if needed
    const httpUri = uri.replace("ipfs://", "https://ipfs.io/ipfs/");

    // Fetch metadata JSON
    const response = await fetch(httpUri);
    const metadata = await response.json();

    // Convert image URL if IPFS
    const imageUrl = metadata.image.replace("ipfs://", "https://ipfs.io/ipfs/");

    setNft({
      name: metadata.name,
      description: metadata.description,
      image: imageUrl,
    });
  } catch (err) {
    setError("Failed to load NFT: " + err.message);
  } finally {
    setLoading(false);
  }
};
```

---

### Task 2: Fetch All NFTs Owned by Connected Wallet

Implement the `fetchOwnedNFTs` function to connect to MetaMask, get the user's balance, loop through each owned token using `tokenOfOwnerByIndex`, and fetch all metadata.

```js
const fetchOwnedNFTs = async () => {
  try {
    setLoading(true);
    setError("");
    setOwnedNFTs([]);

    // Connect wallet
    const [account] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      ABI,
      provider
    );

    // Get number of NFTs owned
    const balance = await contract.balanceOf(account);
    const items = [];

    // Loop through each owned token
    for (let i = 0; i < balance; i++) {
      const tokenId = await contract.tokenOfOwnerByIndex(account, i);
      const uri = await contract.tokenURI(tokenId);
      const httpUri = uri.replace("ipfs://", "https://ipfs.io/ipfs/");
      const response = await fetch(httpUri);
      const metadata = await response.json();

      items.push({
        tokenId: tokenId.toString(),
        name: metadata.name,
        image: metadata.image.replace("ipfs://", "https://ipfs.io/ipfs/"),
      });
    }

    setOwnedNFTs(items);
  } catch (err) {
    setError("Failed to load collection: " + err.message);
  } finally {
    setLoading(false);
  }
};
```

---

### Task 3: Create an IPFS URL Converter Helper Function

Create a reusable helper function to convert various IPFS URL formats to HTTP gateway URLs, handling edge cases like raw CIDs and already-HTTP URLs.

```js
const convertToHttpUrl = (uri) => {
  if (!uri) return "/placeholder.png";

  // Already HTTP/HTTPS
  if (uri.startsWith("http")) {
    return uri;
  }

  // IPFS protocol
  if (uri.startsWith("ipfs://")) {
    return uri.replace("ipfs://", "https://ipfs.io/ipfs/");
  }

  // Raw CID (starts with Qm or bafy)
  if (uri.startsWith("Qm") || uri.startsWith("bafy")) {
    return `https://ipfs.io/ipfs/${uri}`;
  }

  return uri;
};

// Usage in your code:
const imageUrl = convertToHttpUrl(metadata.image);
```

---

## Complete Solution

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function tokenURI(uint256) view returns (string)",
  "function balanceOf(address) view returns (uint256)",
  "function tokenOfOwnerByIndex(address, uint256) view returns (uint256)",
  "function ownerOf(uint256) view returns (address)",
];

const CONTRACT_ADDRESS = process.env.REACT_APP_CONTRACT_ADDRESS;
const RPC_URL = process.env.REACT_APP_RPC_URL;

// Helper function to convert IPFS URLs
const convertToHttpUrl = (uri) => {
  if (!uri) return "/placeholder.png";
  if (uri.startsWith("http")) return uri;
  if (uri.startsWith("ipfs://")) {
    return uri.replace("ipfs://", "https://ipfs.io/ipfs/");
  }
  if (uri.startsWith("Qm") || uri.startsWith("bafy")) {
    return `https://ipfs.io/ipfs/${uri}`;
  }
  return uri;
};

export default function NFTGallery() {
  const [tokenId, setTokenId] = useState("");
  const [nft, setNft] = useState(null);
  const [ownedNFTs, setOwnedNFTs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchSingleNFT = async () => {
    try {
      setLoading(true);
      setError("");
      setNft(null);

      const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

      const uri = await contract.tokenURI(tokenId);
      const httpUri = convertToHttpUrl(uri);
      const response = await fetch(httpUri);
      const metadata = await response.json();

      setNft({
        name: metadata.name,
        description: metadata.description,
        image: convertToHttpUrl(metadata.image),
      });
    } catch (err) {
      setError("Failed to load NFT: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const fetchOwnedNFTs = async () => {
    try {
      setLoading(true);
      setError("");
      setOwnedNFTs([]);

      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

      const balance = await contract.balanceOf(account);
      const items = [];

      for (let i = 0; i < balance; i++) {
        const tokenId = await contract.tokenOfOwnerByIndex(account, i);
        const uri = await contract.tokenURI(tokenId);
        const httpUri = convertToHttpUrl(uri);
        const response = await fetch(httpUri);
        const metadata = await response.json();

        items.push({
          tokenId: tokenId.toString(),
          name: metadata.name,
          image: convertToHttpUrl(metadata.image),
        });
      }

      setOwnedNFTs(items);
    } catch (err) {
      setError("Failed to load collection: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h2>🎨 SiningChain NFT Gallery</h2>

      {/* Single NFT Viewer */}
      <div>
        <h3>View Single NFT</h3>
        <input
          type="number"
          placeholder="Token ID"
          value={tokenId}
          onChange={(e) => setTokenId(e.target.value)}
        />
        <button onClick={fetchSingleNFT} disabled={loading}>
          Load NFT
        </button>
        {nft && (
          <div>
            <img src={nft.image} alt={nft.name} style={{ maxWidth: 300 }} />
            <h4>{nft.name}</h4>
            <p>{nft.description}</p>
          </div>
        )}
      </div>

      {/* Owned NFTs Gallery */}
      <div>
        <h3>My Collection</h3>
        <button onClick={fetchOwnedNFTs} disabled={loading}>
          Load My NFTs
        </button>
        {ownedNFTs.length === 0 && !loading && <p>No NFTs found.</p>}
        <div style={{ display: "flex", gap: 16, flexWrap: "wrap" }}>
          {ownedNFTs.map((item, i) => (
            <div key={i} style={{ border: "1px solid #ccc", padding: 8 }}>
              <img src={item.image} alt={item.name} style={{ width: 150 }} />
              <p>{item.name}</p>
            </div>
          ))}
        </div>
      </div>

      {loading && <p>Loading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `tokenId`: State for the user-entered token ID when viewing a single NFT. Used as input to `tokenURI()` to fetch that specific NFT's metadata.

- `nft`: Object containing the currently displayed single NFT's metadata: `name`, `description`, and `image` URL. Set to `null` when no NFT is loaded.

- `ownedNFTs`: Array of NFT objects representing all tokens owned by the connected wallet. Each object contains `tokenId`, `name`, and `image` for rendering in the gallery grid.

- `ABI`: Human-readable interface for ERC-721 functions. Includes `tokenURI` for metadata, `balanceOf` for ownership count, `tokenOfOwnerByIndex` for enumeration, and `ownerOf` for ownership lookup.

**Key Functions:**

- `fetchSingleNFT`:
  Fetches a single NFT by its token ID. Creates a read-only provider (no wallet needed), calls `tokenURI(tokenId)` to get the metadata URL, converts IPFS URLs to HTTP gateway URLs, then fetches and parses the JSON metadata. Displays the NFT's name, description, and image.

- `fetchOwnedNFTs`:
  Fetches all NFTs owned by the connected wallet. First connects to MetaMask, then calls `balanceOf(account)` to determine how many NFTs the user owns. Loops through each index using `tokenOfOwnerByIndex(account, i)` to get token IDs, fetches each token's URI and metadata, and builds an array for display.

- `convertToHttpUrl`:
  A helper function that normalizes various URI formats to HTTP URLs. Handles IPFS protocol URLs (`ipfs://`), raw CIDs (starting with `Qm` or `bafy`), and passes through already-HTTP URLs. Essential because browsers can't directly load `ipfs://` URLs—they must go through an HTTP gateway like `ipfs.io`.
