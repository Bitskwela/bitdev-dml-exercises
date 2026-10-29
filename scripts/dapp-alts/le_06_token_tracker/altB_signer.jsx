import { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function name() view returns (string)","function symbol() view returns (string)","function decimals() view returns (uint8)","function balanceOf(address) view returns (uint256)"];
// Alt B: v6 getSigner() (which prompts MetaMask itself) instead of a raw eth_requestAccounts.
export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  useEffect(() => {
    (async () => {
      if (!ethers.isAddress(tokenAddress)) return;
      const c = new ethers.Contract(tokenAddress, ABI, new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL));
      const [name, symbol, decimals] = await Promise.all([c.name(), c.symbol(), c.decimals()]);
      setInfo({ name, symbol, decimals });
    })();
  }, [tokenAddress]);
  const fetchBalance = async () => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const c = new ethers.Contract(tokenAddress, ABI, provider);
    const raw = await c.balanceOf(await signer.getAddress());
    setBalance(`${ethers.formatUnits(raw, info.decimals)} ${info.symbol}`);
  };
  return (
    <div>
      <p>Name: {info.name}</p><p>Symbol: {info.symbol}</p>
      <button onClick={fetchBalance}>Fetch My Balance</button>
      {balance && <p>Your Balance: {balance}</p>}
    </div>
  );
}
