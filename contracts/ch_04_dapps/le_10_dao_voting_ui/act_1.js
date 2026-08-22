// DAOVoting.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "function hasVoted(uint256, address) view returns (bool)",
  "function vote(uint256, bool)",
  "event Voted(address indexed voter, uint256 indexed proposalId, bool support)",
];

const DAO_ADDRESS = process.env.REACT_APP_DAO_ADDRESS;

export default function DAOVoting() {
  const [proposals, setProposals] = useState([]);
  const [userAddress, setUserAddress] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // TODO: Task 1 - Connect, read getProposalCount(), then for each index read
    //                proposals(i) and hasVoted(i, account)
  }, []);

  useEffect(() => {
    // TODO: Task 3 - Subscribe to the "Voted" event and update the tally live.
    //                Return a cleanup that unsubscribes.
  }, []);

  const castVote = async (proposalId, support) => {
    // TODO: Task 2 - Send vote(proposalId, support), await the receipt, then
    //                update the tally and mark the proposal as voted
  };

  if (loading) return <p>Loading proposals...</p>;

  return (
    <div>
      <h2>BarangayDAO Voting</h2>
      {/* TODO: Task 4 - Render each proposal with its tally, and either the
          Yes/No buttons or a "you've voted" note */}
      <p>Placeholder</p>
    </div>
  );
}
