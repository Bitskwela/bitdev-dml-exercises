import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NFTReader() {
  const [info, setInfo] = useState({ name: "", symbol: "", total: 0 });
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");

  useEffect(() => {
    async function fetchInfo() {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      const [name, symbol, total] = await Promise.all([
        contract.name(),
        contract.symbol(),
        contract.totalMinted(),
      ]);

      setInfo({ name, symbol, total: total.toNumber() });
    }
    fetchInfo();
  }, []);

  const fetchTokenURI = async () => {
    if (tokenId < 0 || tokenId >= info.total) {
      alert(`Please enter a token ID between 0 and ${info.total - 1}`);
      return;
    }

    try {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      const fetchedUri = await contract.tokenURIs(tokenId);
      setUri(fetchedUri);
    } catch (error) {
      console.error("Error fetching token URI:", error);
      alert("Failed to fetch URI. The token might not exist.");
    }
  };

  return (
    <div>
      <h1>{info.name || "Loading..."}</h1>
      <h3>{info.symbol || "Loading..."}</h3>
      <p>Total Minted: {info.total}</p>
      <input
        type="number"
        value={tokenId}
        onChange={(e) => setTokenId(Number(e.target.value))}
      />
      <button onClick={fetchTokenURI}>Get Token URI</button>
      {uri && <p>URI: {uri}</p>}
    </div>
  );
}