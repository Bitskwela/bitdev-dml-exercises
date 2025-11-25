# On-Chain To-Do List Activity

## Initial Code

```solidity
// TodoList.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        uint256 id;
        string content;
        bool done;
    }

    Task[] public tasks;

    event TaskCreated(uint256 id, string content, bool done);
    event TaskToggled(uint256 id, bool done);
    event TaskDeleted(uint256 id);

    function createTask(string memory content) public {
        uint256 id = tasks.length;
        tasks.push(Task(id, content, false));
        emit TaskCreated(id, content, false);
    }

    function toggleDone(uint256 id) public {
        tasks[id].done = !tasks[id].done;
        emit TaskToggled(id, tasks[id].done);
    }

    function deleteTask(uint256 id) public {
        delete tasks[id];
        emit TaskDeleted(id);
    }

    function getTasksCount() public view returns (uint256) {
        return tasks.length;
    }
}
```

```js
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
    // TODO: Load tasks from contract
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    // TODO: Create new task
  };

  const handleToggle = async (taskId) => {
    // TODO: Toggle task completion
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
            <span style={{ textDecoration: task.done ? "line-through" : "none" }}>
              {task.content}
            </span>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_CONTRACT_ADDRESS=0xYourTodoListAddress
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
      prev.map((t) =>
        t.id === taskId ? { ...t, done: !t.done } : t
      )
    );
  } catch (err) {
    console.error("Error toggling task:", err);
  }
};
```

---

## Complete Solution

```js
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
            <span style={{ textDecoration: task.done ? "line-through" : "none" }}>
              {task.content}
            </span>
          </li>
        ))}
      </ul>
    </div>
  );
}
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
