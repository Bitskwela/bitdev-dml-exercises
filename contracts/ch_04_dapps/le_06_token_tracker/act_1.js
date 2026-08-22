// TokenTracker.js - Starter Code
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

  useEffect(() => {
    // TODO: Task 1 - Bail out unless tokenAddress is a valid address, then build
    //                a read-only provider and contract
    // TODO: Task 2 - Read name(), symbol() and decimals() and store them
  }, [tokenAddress]);

  const fetchBalance = async () => {
    // TODO: Task 3 - Connect the wallet, read balanceOf(user), and format the
    //                raw value using the token's decimals
  };

  return (
    <div>
      <h2>Token Information</h2>
      {/* TODO: Task 4 - Show name, symbol, decimals, a Fetch button and balance */}
      <p>Placeholder</p>
    </div>
  );
}
