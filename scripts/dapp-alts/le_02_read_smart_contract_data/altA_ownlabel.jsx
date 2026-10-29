import { useState, useEffect, useMemo } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";
// Alt A: v6, memoised contract, .then chain, own (reasonable) button label.
export default function NFTReader() {
  const [info, setInfo] = useState({ name: "", symbol: "", total: 0 });
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");
  const contract = useMemo(() => {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    return new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, provider);
  }, []);
  useEffect(() => {
    Promise.all([contract.name(), contract.symbol(), contract.totalMinted()])
      .then(([name, symbol, total]) => setInfo({ name, symbol, total: total.toString() }));
  }, [contract]);
  const lookUp = async () => setUri(await contract.tokenURIs(tokenId));
  return (
    <div>
      <h1>{info.name}</h1><h3>{info.symbol}</h3><p>Total Minted: {info.total}</p>
      <input type="number" value={tokenId} onChange={(e) => setTokenId(Number(e.target.value))} />
      <button onClick={lookUp}>Look up token</button>
      {uri && <p>URI: {uri}</p>}
    </div>
  );
}
