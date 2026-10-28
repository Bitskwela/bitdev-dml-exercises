import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";
// Alt A: provider + contract created once at module scope (stable reference).
const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
const raffle = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, provider);
export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);
  useEffect(() => {
    const onWinner = (w) => { setWinner(w); setHistory((p) => [w, ...p].slice(0, 5)); };
    raffle.on("WinnerPicked", onWinner);
    return () => raffle.off("WinnerPicked", onWinner);
  }, []);
  return (
    <div>
      <p>{winner || "Waiting for winner..."}</p>
      <ul>{history.map((w, i) => <li key={i}>{w}</li>)}</ul>
    </div>
  );
}
