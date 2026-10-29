import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";
// Alt C: bullets' logic exactly; own empty-state copy and an <ol>.
export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);
  useEffect(() => {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const contract = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, provider);
    const handleWinnerPicked = (w) => { setWinner(w); setHistory((p) => [w, ...p].slice(0, 5)); };
    contract.on("WinnerPicked", handleWinnerPicked);
    return () => contract.off("WinnerPicked", handleWinnerPicked);
  }, []);
  return (
    <div>
      <p>{winner ? `Winner: ${winner}` : "No winner yet - abangan!"}</p>
      <ol>{history.map((w, i) => <li key={i}>{w}</li>)}</ol>
    </div>
  );
}
