import { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getProposalCount() view returns (uint256)","function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)","function hasVoted(uint256, address) view returns (bool)","function vote(uint256, bool)","event Voted(address indexed voter, uint256 indexed proposalId, bool support)"];
const DAO = process.env.REACT_APP_DAO_ADDRESS;
export default function DAOVoting() {
  const [proposals, setProposals] = useState([]);
  const [account, setAccount] = useState("");
  useEffect(() => {
    (async () => {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const [me] = await window.ethereum.request({ method: "eth_requestAccounts" });
      setAccount(me);
      const dao = new ethers.Contract(DAO, ABI, provider);
      const n = Number(await dao.getProposalCount());
      const list = [];
      for (let i = 0; i < n; i++) {
        const [id, description, yes, no] = await dao.proposals(i);
        list.push({ id: Number(id), description, yes: Number(yes), no: Number(no), hasVoted: await dao.hasVoted(i, me) });
      }
      setProposals(list);
    })().catch((e) => console.error(e));
  }, []);
  useEffect(() => {
    const dao = new ethers.Contract(DAO, ABI, new ethers.BrowserProvider(window.ethereum));
    const onVoted = (voter, pid, support) => setProposals((prev) => prev.map((p) => p.id === Number(pid) ? { ...p, yes: p.yes + (support ? 1 : 0), no: p.no + (support ? 0 : 1) } : p));
    dao.on("Voted", onVoted);
    return () => dao.removeAllListeners("Voted");
  }, []);
  const castVote = async (id, support) => {
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    const dao = new ethers.Contract(DAO, ABI, signer);
    const tx = await dao.vote(id, support);
    await tx.wait();
    setProposals((prev) => prev.map((p) => (p.id === id ? { ...p, hasVoted: true } : p)));
  };
  return (
    <div>
      <h2>BarangayDAO Voting</h2>
      <p>Connected: {account.slice(0, 6)}…</p>
      {proposals.map((p) => (
        <div key={p.id}>
          <h3>{p.description}</h3>
          <p>Yes: {p.yes} · No: {p.no}</p>
          {p.hasVoted ? <em>Naka-boto ka na</em> : (<div>
            <button onClick={() => castVote(p.id, true)}>👍 Yes</button>
            <button onClick={() => castVote(p.id, false)}>👎 No</button>
          </div>)}
        </div>
      ))}
    </div>
  );
}
