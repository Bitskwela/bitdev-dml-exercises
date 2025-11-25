import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  const [account, setAccount] = useState("");

  // Task 1 & 2: Fetch token info
  useEffect(() => {
    const fetchTokenInfo = async () => {
      // Task 1: Validate address and create contract instance
      if (!ethers.utils.isAddress(tokenAddress)) return;

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      // Task 2: Fetch token metadata using Promise.all
      const [name, symbol, decimals] = await Promise.all([
        contract.name(),
        contract.symbol(),
        contract.decimals(),
      ]);

      setInfo({ name, symbol, decimals });
    };

    if (tokenAddress) {
      fetchTokenInfo();
    }
  }, [tokenAddress]);

  // Task 3: Implement the fetchBalance function
  const fetchBalance = async () => {
    try {
      const [user] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(user);

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      const rawBalance = await contract.balanceOf(user);
      const formatted = ethers.utils.formatUnits(rawBalance, info.decimals);
      setBalance(`${formatted} ${info.symbol}`);
    } catch (err) {
      console.error("Error fetching balance:", err);
    }
  };

  return (
    <div>
      <h2>Token Information</h2>
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
      <hr />
      <button onClick={fetchBalance}>Fetch My Balance</button>
      {balance && <p>Your Balance: {balance}</p>}
    </div>
  );
}
