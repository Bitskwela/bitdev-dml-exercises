import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);

  useEffect(() => {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const handleWinnerPicked = (winnerAddress) => {
      setWinner(winnerAddress);
      // Functional update: several events can land before React re-renders.
      setHistory((prev) => [winnerAddress, ...prev].slice(0, 5));
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    // Without this, every remount adds another listener and the UI
    // double-counts each event.
    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);

  return (
    <div>
      <h2>Raffle Listener</h2>
      <div>
        <h3>Latest Winner:</h3>
        <p>{winner || "Waiting for winner..."}</p>
      </div>
      <div>
        <h3>Winner History (Last 5):</h3>
        <ul>
          {history.map((w, i) => (
            <li key={i}>{w}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}
