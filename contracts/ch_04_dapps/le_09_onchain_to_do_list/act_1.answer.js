import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",
  "function createTask(string)",
  "function toggleDone(uint256)",
  "function deleteTask(uint256)",
];

const CONTRACT_ADDRESS = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState("");
  const [loading, setLoading] = useState(true);

  const loadTasks = async () => {
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

      const count = await contract.getTasksCount();
      const items = [];

      for (let i = 0; i < count; i++) {
        const [id, content, done] = await contract.tasks(i);
        if (content !== "") {
          items.push({ id: id.toNumber(), content, done });
        }
      }

      setTasks(items);
    } catch (err) {
      console.error("Error loading tasks:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadTasks();
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    if (!newTask.trim()) return;

    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.createTask(newTask);
      await tx.wait();

      setNewTask("");
      loadTasks();
    } catch (err) {
      console.error("Error creating task:", err);
    }
  };

  const handleToggle = async (taskId) => {
    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.toggleDone(taskId);
      await tx.wait();

      setTasks((prev) =>
        prev.map((t) => (t.id === taskId ? { ...t, done: !t.done } : t))
      );
    } catch (err) {
      console.error("Error toggling task:", err);
    }
  };

  if (loading) return <p>Loading tasks...</p>;

  return (
    <div>
      <h2>On-Chain To-Do List</h2>
      <form onSubmit={handleCreate}>
        <input
          value={newTask}
          onChange={(e) => setNewTask(e.target.value)}
          placeholder="New task..."
        />
        <button type="submit">Add</button>
      </form>
      <ul>
        {tasks.map((task) => (
          <li key={task.id}>
            <input
              type="checkbox"
              checked={task.done}
              onChange={() => handleToggle(task.id)}
            />
            <span
              style={{ textDecoration: task.done ? "line-through" : "none" }}
            >
              {task.content}
            </span>
          </li>
        ))}
      </ul>
    </div>
  );
}
