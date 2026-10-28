import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";
// Alt B: module-scope provider, sequential awaits, separate state, exact label.
const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
const nft = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, provider);
export default function NFTReader() {
  const [name, setName] = useState("");
  const [symbol, setSymbol] = useState("");
  const [total, setTotal] = useState(0);
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");
  useEffect(() => {
    (async () => {
      setName(await nft.name());
      setSymbol(await nft.symbol());
      setTotal(Number(await nft.totalMinted()));
    })();
  }, []);
  const fetchTokenURI = async () => {
    if (tokenId < 0 || tokenId >= total) return alert("out of range");
    setUri(await nft.tokenURIs(tokenId));
  };
  return (
    <div>
      <h1>{name || "Loading..."}</h1><h3>{symbol}</h3><p>Total Minted: {total}</p>
      <input type="number" value={tokenId} onChange={(e) => setTokenId(Number(e.target.value))} />
      <button onClick={fetchTokenURI}>Get Token URI</button>
      {uri && <p>URI: {uri}</p>}
    </div>
  );
}
