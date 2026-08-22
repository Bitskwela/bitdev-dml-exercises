// TodoApp.js - Starter Code
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
    // TODO: Task 1 - Connect, read getTasksCount(), then read tasks(i) for each
    //                index and store them. Skip entries with empty content.
  };

  useEffect(() => {
    loadTasks();
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    // TODO: Task 2 - Send createTask(newTask), await the receipt, clear the
    //                field and reload
  };

  const handleToggle = async (taskId) => {
    // TODO: Task 3 - Send toggleDone(taskId), await the receipt, and flip the
    //                task in local state
  };

  if (loading) return <p>Loading tasks...</p>;

  return (
    <div>
      <h2>On-Chain To-Do List</h2>
      {/* TODO: Task 4 - New-task form and the task list with its checkboxes */}
      <p>Placeholder</p>
    </div>
  );
}
