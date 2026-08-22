// NFTGallery.js - Starter Code
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

const convertToHttpUrl = (uri) => {
  // TODO: Task 1 - Turn an ipfs:// URI into an https gateway URL
  return uri;
};

export default function NFTGallery() {
  const [tokenId, setTokenId] = useState("");
  const [nft, setNft] = useState(null);
  const [ownedNFTs, setOwnedNFTs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchSingleNFT = async () => {
    // TODO: Task 2 - Read tokenURI(tokenId), fetch the metadata JSON, and store
    //                its name, description and image
  };

  const fetchOwnedNFTs = async () => {
    // TODO: Task 3 - Connect the wallet, read balanceOf(account), then walk
    //                tokenOfOwnerByIndex + tokenURI to build the collection
  };

  return (
    <div>
      <h2>SiningChain NFT Gallery</h2>
      {/* TODO: Task 4 - Token ID input, Load NFT button, My Collection button,
          the single NFT card, and the owned grid */}
      <p>Placeholder</p>
    </div>
  );
}
