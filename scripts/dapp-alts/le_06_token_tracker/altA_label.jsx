import { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function name() view returns (string)","function symbol() view returns (string)","function decimals() view returns (uint8)","function balanceOf(address) view returns (uint256)"];
// Alt A: .then chain, own button label.
export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  useEffect(() => {
    if (!ethers.isAddress(tokenAddress)) return;
    const c = new ethers.Contract(tokenAddress, ABI, new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL));
    Promise.all([c.name(), c.symbol(), c.decimals()]).then(([name, symbol, decimals]) => setInfo({ name, symbol, decimals: Number(decimals) }));
  }, [tokenAddress]);
  const check = async () => {
    const [user] = await window.ethereum.request({ method: "eth_requestAccounts" });
    const c = new ethers.Contract(tokenAddress, ABI, new ethers.BrowserProvider(window.ethereum));
    setBalance(`${ethers.formatUnits(await c.balanceOf(user), info.decimals)} ${info.symbol}`);
  };
  return (
    <div>
      <p>{info.name} ({info.symbol}) - {info.decimals} decimals</p>
      <button onClick={check}>Check Balance</button>
      {balance && <p>Balance: {balance}</p>}
    </div>
  );
}
