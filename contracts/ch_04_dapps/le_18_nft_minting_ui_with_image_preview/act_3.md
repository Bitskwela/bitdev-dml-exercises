# Activity 3: NFTGallery Component ⏱️ 10 mins

Build `NFTGallery` that reads all minted NFTs from the contract, fetches their metadata, and displays a gallery view with images, titles, and token IDs. Subscribe to `Minted` events for real-time updates.

## 📋 Contract Baseline

Using the same `PoetNFT.sol` contract with additional view functions:

```solidity
// Additional functions for gallery functionality
function totalSupply() external view returns (uint256) {
    return _tokenIds.current();
}

function ownerOf(uint256 tokenId) external view returns (address) {
    return _ownerOf(tokenId);
}

function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId), "Nonexistent token");
    return _tokenURIs[tokenId];
}
```

## 🚀 Starter Code

**`NFTGallery.js`**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function totalSupply() view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
  "function ownerOf(uint256) view returns (address)",
  "event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI)",
];

export default function NFTGallery() {
  const [nfts, setNfts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadGallery() {
      try {
        // TODO: create provider and contract instance
        // TODO: get totalSupply()
        // TODO: loop through tokenIds 1 to totalSupply
        // TODO: for each tokenId, get tokenURI and owner
        // TODO: parse tokenURI (data URI) to extract metadata
        // TODO: setNfts with array of { tokenId, metadata, owner }
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    loadGallery();

    // TODO: subscribe to Minted events and refresh gallery

    return () => {
      // TODO: cleanup event listeners
    };
  }, []);

  if (loading) return <p>Loading gallery...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div>
      <h3>🖼️ NFT Gallery</h3>
      <div
        style={{
          display: "grid",
          gridTemplateColumns: "repeat(auto-fill, minmax(250px, 1fr))",
          gap: 16,
        }}
      >
        {nfts.map((nft) => (
          <div
            key={nft.tokenId}
            style={{ border: "1px solid #ccc", padding: 12 }}
          >
            {/* TODO: render NFT card with image, title, tokenId, owner */}
          </div>
        ))}
      </div>
    </div>
  );
}
```

## ✅ To Do List

- [ ] Create provider and contract instance with `totalSupply()`, `tokenURI()`, `ownerOf()` functions
- [ ] Get total supply and loop through all token IDs
- [ ] For each token, fetch URI and owner address
- [ ] Parse Data URI metadata (extract JSON from base64)
- [ ] Display grid of NFT cards with image, title, token ID, and owner
- [ ] Subscribe to `Minted` events and refresh gallery on new mints

## 🎯 Full Solution

```js
// NFTGallery.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function totalSupply() view returns (uint256)",
  "function tokenURI(uint256) view returns (string)",
  "function ownerOf(uint256) view returns (address)",
  "event Minted(address indexed minter, uint256 indexed tokenId, string tokenURI)",
];

const RPC = process.env.REACT_APP_RPC_URL;
const ADDRESS = process.env.REACT_APP_POETNFT_ADDRESS;

export default function NFTGallery() {
  const [nfts, setNfts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    let contract;

    async function loadGallery() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        contract = new ethers.Contract(ADDRESS, ABI, provider);

        const totalSupply = await contract.totalSupply();
        const nftData = [];

        for (let i = 1; i <= totalSupply.toNumber(); i++) {
          try {
            const [tokenURI, owner] = await Promise.all([
              contract.tokenURI(i),
              contract.ownerOf(i),
            ]);

            // Parse Data URI: "data:application/json;base64,..."
            if (tokenURI.startsWith("data:application/json;base64,")) {
              const base64 = tokenURI.split(",")[1];
              const jsonString = atob(base64);
              const metadata = JSON.parse(jsonString);

              nftData.push({
                tokenId: i,
                metadata,
                owner,
              });
            }
          } catch (tokenError) {
            console.warn(`Error loading token ${i}:`, tokenError);
          }
        }

        setNfts(nftData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    loadGallery();

    // Subscribe to new mints
    async function setupListener() {
      if (window.ethereum) {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        contract = new ethers.Contract(ADDRESS, ABI, provider);

        contract.on("Minted", (minter, tokenId, tokenURI) => {
          // Refresh gallery when new NFT is minted
          loadGallery();
        });
      }
    }

    setupListener();

    return () => {
      if (contract) {
        contract.removeAllListeners("Minted");
      }
    };
  }, []);

  if (loading) return <p>Loading gallery...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div>
      <h3>🖼️ NFT Gallery ({nfts.length} items)</h3>
      {nfts.length === 0 ? (
        <p>No NFTs minted yet. Be the first to mint!</p>
      ) : (
        <div
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(auto-fill, minmax(250px, 1fr))",
            gap: 16,
          }}
        >
          {nfts.map((nft) => (
            <div
              key={nft.tokenId}
              style={{
                border: "1px solid #ddd",
                borderRadius: 8,
                padding: 12,
                background: "#f9f9f9",
              }}
            >
              <img
                src={nft.metadata.image}
                alt={nft.metadata.name}
                style={{
                  width: "100%",
                  height: 150,
                  objectFit: "cover",
                  borderRadius: 4,
                }}
              />
              <h4 style={{ margin: "8px 0 4px" }}>{nft.metadata.name}</h4>
              <p
                style={{ margin: "0 0 8px", fontSize: "0.9em", color: "#666" }}
              >
                {nft.metadata.description}
              </p>
              <p style={{ margin: 0, fontSize: "0.8em" }}>
                <strong>Token ID:</strong> {nft.tokenId}
                <br />
                <strong>Owner:</strong> {nft.owner.slice(0, 6)}...
                {nft.owner.slice(-4)}
              </p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
```
