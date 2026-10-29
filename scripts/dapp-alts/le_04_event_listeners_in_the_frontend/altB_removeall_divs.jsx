import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";
// Alt B: removeAllListeners() cleanup, history rendered as divs.
export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);
  useEffect(() => {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const contract = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, provider);
    contract.on("WinnerPicked", (w) => { setWinner(w); setHistory((p) => [w, ...p].slice(0, 5)); });
    return () => { contract.removeAllListeners(); };
  }, []);
  return (
    <div>
      <h3>Latest Winner:</h3>
      <p>{winner || "Waiting for winner..."}</p>
      <h3>History</h3>
      {history.map((w, i) => <div key={i}>{i + 1}. {w}</div>)}
    </div>
  );
}
