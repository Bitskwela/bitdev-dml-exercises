import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function buyer() view returns (address)","function seller() view returns (address)","function amount() view returns (uint256)","function deposited() view returns (bool)","function released() view returns (bool)"];
export default function EscrowStats() {
  const [s, setS] = useState(null); const [error, setError] = useState("");
  useEffect(() => {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const escrow = new ethers.Contract(process.env.REACT_APP_ESCROW_ADDRESS, ABI, provider);
    (async () => {
      try {
        const buyer = await escrow.buyer(); const seller = await escrow.seller(); const amount = await escrow.amount();
        const deposited = await escrow.deposited(); const released = await escrow.released();
        setS({ buyer, seller, amount, deposited, released });
      } catch (e) { setError(e.message); }
    })();
  }, []);
  if (error) return <p>{error}</p>;
  if (!s) return <p>Loading…</p>;
  const status = s.released ? "Released" : s.deposited ? "Awaiting release" : "Not Deposited";
  return (<div><p>Buyer: {s.buyer}</p><p>Seller: {s.seller}</p><p>Amount: {ethers.formatUnits(s.amount, 18)} ETH</p><p>Status: {status}</p></div>);
}
