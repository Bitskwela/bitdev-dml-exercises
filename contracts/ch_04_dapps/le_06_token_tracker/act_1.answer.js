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
      // Task 1: A malformed address would make every read revert, so check first.
      if (!ethers.isAddress(tokenAddress)) return;

      const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      // Task 2: One round trip instead of three sequential ones.
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

      const provider = new ethers.BrowserProvider(window.ethereum);
      const contract = new ethers.Contract(tokenAddress, ABI, provider);

      // balanceOf returns the raw integer; decimals turns it back into a
      // human number. 2500000000000000000 with 18 decimals is 2.5, not 2.5e18.
      const rawBalance = await contract.balanceOf(user);
      const formatted = ethers.formatUnits(rawBalance, info.decimals);
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
