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
