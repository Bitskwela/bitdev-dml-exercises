import { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getTasksCount() view returns (uint256)","function tasks(uint256) view returns (uint256 id, string content, bool done)","function createTask(string)","function toggleDone(uint256)"];
const CONTRACT_ADDRESS = process.env.REACT_APP_CONTRACT_ADDRESS;
export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState("");
  const loadTasks = async () => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const c = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);
    const count = await c.getTasksCount();
    const items = [];
    for (let i = 0; i < count; i++) {
      const [id, content, done] = await c.tasks(i);
      if (content !== "") items.push({ id: Number(id), content, done });
    }
    setTasks(items);
  };
  useEffect(() => { loadTasks(); }, []);
  const handleCreate = async (e) => {
    e.preventDefault();
    if (!newTask.trim()) return;
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    const c = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
    const tx = await c.createTask(newTask); await tx.wait();
    setNewTask(""); loadTasks();
  };
  const handleToggle = async (id) => {
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    const c = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
    const tx = await c.toggleDone(id); await tx.wait();
    setTasks((p) => p.map((t) => (t.id === id ? { ...t, done: !t.done } : t)));
  };
  return (
    <div>
      <h2>On-Chain To-Do List</h2>
      <ul>
        {tasks.map((t) => (
          <li key={t.id}><input type="checkbox" checked={t.done} onChange={() => handleToggle(t.id)} /> {t.content}</li>
        ))}
      </ul>
      <form onSubmit={handleCreate}>
        <input placeholder="New task..." value={newTask} onChange={(e) => setNewTask(e.target.value)} />
        <button type="submit">Add</button>
      </form>
    </div>
  );
}
