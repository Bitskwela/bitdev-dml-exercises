import { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function tokenURI(uint256) view returns (string)","function balanceOf(address) view returns (uint256)","function tokenOfOwnerByIndex(address, uint256) view returns (uint256)"];
const toHttp = (u) => (u && u.startsWith("ipfs://") ? u.replace("ipfs://", "https://ipfs.io/ipfs/") : u);
const load = async (c, id) => { const m = await (await fetch(toHttp(await c.tokenURI(id)))).json(); return { ...m, image: toHttp(m.image) }; };
export default function NFTGallery() {
  const [tokenId, setTokenId] = useState("");
  const [nft, setNft] = useState(null);
  const [owned, setOwned] = useState([]);
  const one = async () => {
    const c = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, ABI, new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL));
    setNft(await load(c, tokenId));
  };
  const mine = async () => {
    const [account] = await window.ethereum.request({ method: "eth_requestAccounts" });
    const c = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, ABI, new ethers.BrowserProvider(window.ethereum));
    const n = Number(await c.balanceOf(account));
    const ids = await Promise.all(Array.from({ length: n }, (_, i) => c.tokenOfOwnerByIndex(account, i)));
    setOwned(await Promise.all(ids.map((id) => load(c, id))));
  };
  return (
    <div>
      <input placeholder="Token ID" value={tokenId} onChange={(e) => setTokenId(e.target.value)} />
      <button onClick={one}>View NFT</button>
      {nft && <h4>{nft.name}</h4>}
      <h3>My Collection</h3>
      <button onClick={mine}>Show my NFTs</button>
      {owned.map((o, i) => <p key={i}>{o.name}</p>)}
    </div>
  );
}
