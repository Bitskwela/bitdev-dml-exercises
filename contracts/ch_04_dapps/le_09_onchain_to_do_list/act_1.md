# On-Chain To-Do List Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=http://127.0.0.1:8545
// REACT_APP_CONTRACT_ADDRESS=0xYourTodoListAddress

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

export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // TODO: Task 1 - Load all tasks from the contract
    // @note Get task count, loop through each index, fetch task data, filter deleted tasks
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    // TODO: Task 2 - Create new task
    // @note Connect with signer, call createTask(), wait for confirmation, refresh list
  };

  const handleToggle = async (taskId) => {
    // TODO: Task 3 - Toggle task completion
    // @note Call toggleDone() with task ID, wait for confirmation, update local state
  };

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
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: Struct parsing, array enumeration, CRUD operations, transaction confirmation, deleted item handling

---

### Task 1: Load All Tasks from the Contract

Implement the `useEffect` to fetch all tasks. Get the task count, loop through each index, fetch task data, and filter out deleted tasks (where content is empty).

```js
useEffect(() => {
  const loadTasks = async () => {
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        ABI,
        provider
      );

      const count = await contract.getTasksCount();
      const items = [];

      for (let i = 0; i < count; i++) {
        const [id, content, done] = await contract.tasks(i);
        // Skip deleted tasks (content is empty after delete)
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

  loadTasks();
}, []);
```

---

### Task 2: Implement the handleCreate Function

Create a new task by connecting with a signer, calling `createTask()`, waiting for confirmation, and refreshing the task list.

```js
const handleCreate = async (e) => {
  e.preventDefault();
  if (!newTask.trim()) return;

  try {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      ABI,
      signer
    );

    const tx = await contract.createTask(newTask);
    await tx.wait();

    setNewTask("");
    // Reload tasks
    window.location.reload();
  } catch (err) {
    console.error("Error creating task:", err);
  }
};
```

---

### Task 3: Implement the handleToggle Function

Toggle a task's completion status by calling `toggleDone()` with the task ID, waiting for confirmation, and refreshing the UI.

```js
const handleToggle = async (taskId) => {
  try {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      ABI,
      signer
    );

    const tx = await contract.toggleDone(taskId);
    await tx.wait();

    // Update local state
    setTasks((prev) =>
      prev.map((t) => (t.id === taskId ? { ...t, done: !t.done } : t))
    );
  } catch (err) {
    console.error("Error toggling task:", err);
  }
};
```

---

## Breakdown of the Activity

**Variables Defined:**

- `tasks`: An array of task objects, each containing `id` (unique identifier), `content` (task description), and `done` (completion status). Filtered to exclude deleted tasks where content is an empty string.

- `newTask`: State for the text input field when creating new tasks. Cleared after successful submission.

- `loading`: Boolean state to show a loading indicator while fetching tasks from the blockchain.

- `ABI`: Human-readable interface describing the contract's functions. Includes both read functions (`getTasksCount`, `tasks`) and write functions (`createTask`, `toggleDone`, `deleteTask`).

**Key Functions:**

- `loadTasks`:
  Fetches all tasks from the smart contract. First gets the total count using `getTasksCount()`, then loops through each index calling `tasks(i)` to retrieve struct data. Each task is returned as an array `[id, content, done]` which is destructured and converted to an object. Deleted tasks (where Solidity's `delete` leaves empty content) are filtered out.

- `handleCreate`:
  Creates a new task on-chain. Validates that input isn't empty, connects with a signer for transaction signing, calls `createTask(content)`, and waits for blockchain confirmation. After success, clears the input and reloads the task list.

- `handleToggle`:
  Toggles a task's completion status. Uses the signer to call `toggleDone(taskId)`, waits for confirmation, then optimistically updates local state using the functional form of `setTasks` to flip the `done` boolean for the matching task ID.
