import { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getTasksCount() view returns (uint256)","function tasks(uint256) view returns (uint256 id, string content, bool done)","function createTask(string)","function toggleDone(uint256)"];
const ADDR = process.env.REACT_APP_CONTRACT_ADDRESS;
export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [text, setText] = useState("");
  const [busy, setBusy] = useState(false);
  async function load() {
    const c = new ethers.Contract(ADDR, ABI, new ethers.BrowserProvider(window.ethereum));
    const n = Number(await c.getTasksCount());
    const rows = await Promise.all([...Array(n).keys()].map((i) => c.tasks(i)));
    setTasks(rows.filter((r) => r[1] !== "").map(([id, content, done]) => ({ id: Number(id), content, done })));
  }
  useEffect(() => { load().catch(console.error); }, []);
  async function withSigner() {
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    return new ethers.Contract(ADDR, ABI, signer);
  }
  async function add(e) {
    e.preventDefault();
    if (!text.trim()) return;
    setBusy(true);
    try { const c = await withSigner(); const tx = await c.createTask(text); await tx.wait(); setText(""); await load(); }
    finally { setBusy(false); }
  }
  async function toggle(id) {
    const c = await withSigner(); const tx = await c.toggleDone(id); await tx.wait();
    setTasks((p) => p.map((t) => (t.id === id ? { ...t, done: !t.done } : t)));
  }
  return (
    <div>
      <h2>On-Chain To-Do List</h2>
      <form onSubmit={add}><input placeholder="New task..." value={text} onChange={(e) => setText(e.target.value)} /><button type="submit">Add</button></form>
      <ul>{tasks.map((t) => <li key={t.id}><input type="checkbox" checked={t.done} onChange={() => toggle(t.id)} />{t.content}</li>)}</ul>
    </div>
  );
}
