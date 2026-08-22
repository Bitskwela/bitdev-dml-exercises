// RaffleListener.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // TODO: Task 1 - Build a read-only provider and contract
    // TODO: Task 2 - Subscribe to the "WinnerPicked" event; on each one, store
    //                the winner and prepend it to a history capped at 5
    // TODO: Task 3 - Return a cleanup that unsubscribes, so remounting the
    //                component does not stack duplicate listeners
  }, []);

  return (
    <div>
      <h2>Raffle Listener</h2>
      {/* TODO: Task 4 - Show the latest winner and the history list */}
      <p>Placeholder</p>
    </div>
  );
}
