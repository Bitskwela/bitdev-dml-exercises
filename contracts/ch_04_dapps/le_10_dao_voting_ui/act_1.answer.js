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

  // Load proposals
  useEffect(() => {
    const loadProposals = async () => {
      try {
        const [account] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setUserAddress(account);

        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const contract = new ethers.Contract(DAO_ADDRESS, ABI, provider);

        const count = await contract.getProposalCount();
        const items = [];

        for (let i = 0; i < count; i++) {
          const [id, description, yes, no] = await contract.proposals(i);
          const voted = await contract.hasVoted(i, account);

          items.push({
            id: id.toNumber(),
            description,
            yes: yes.toNumber(),
            no: no.toNumber(),
            hasVoted: voted,
          });
        }

        setProposals(items);
      } catch (err) {
        console.error("Error loading proposals:", err);
      } finally {
        setLoading(false);
      }
    };

    loadProposals();
  }, []);

  // Real-time vote updates
  useEffect(() => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(DAO_ADDRESS, ABI, provider);

    const handleVote = (voter, proposalId, support) => {
      setProposals((prev) =>
        prev.map((p) =>
          p.id === proposalId.toNumber()
            ? {
                ...p,
                yes: support ? p.yes + 1 : p.yes,
                no: support ? p.no : p.no + 1,
              }
            : p
        )
      );
    };

    contract.on("Voted", handleVote);
    return () => contract.off("Voted", handleVote);
  }, []);

  const castVote = async (proposalId, support) => {
    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(DAO_ADDRESS, ABI, signer);

      const tx = await contract.vote(proposalId, support);
      await tx.wait();

      setProposals((prev) =>
        prev.map((p) =>
          p.id === proposalId
            ? {
                ...p,
                yes: support ? p.yes + 1 : p.yes,
                no: support ? p.no : p.no + 1,
                hasVoted: true,
              }
            : p
        )
      );
    } catch (err) {
      console.error("Error casting vote:", err);
    }
  };

  if (loading) return <p>Loading proposals...</p>;

  return (
    <div>
      <h2>🏛️ BarangayDAO Voting</h2>
      <p>
        Connected: {userAddress.slice(0, 6)}...{userAddress.slice(-4)}
      </p>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ border: "1px solid #ccc", padding: 16, margin: 8 }}
        >
          <h3>
            #{p.id}: {p.description}
          </h3>
          <p>
            👍 {p.yes} | 👎 {p.no}
          </p>
          {p.hasVoted ? (
            <span>You've voted</span>
          ) : (
            <div>
              <button onClick={() => castVote(p.id, true)}>Vote Yes</button>
              <button onClick={() => castVote(p.id, false)}>Vote No</button>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
