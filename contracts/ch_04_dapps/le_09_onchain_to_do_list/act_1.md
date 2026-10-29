# On-Chain To-Do List Activity

**What you will build:** a `TodoApp` that reads every task stored in a smart contract, lets you add a new task, and lets you tick a task as done. Every add and every tick is a real transaction.

## Initial Code

This is the starter in your editor. The contract address is already read from the environment as `CONTRACT_ADDRESS`.

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
```

**Time Allotment: 40 minutes**

## Tasks for Learners

Topics Covered: reading an array from a contract by index, struct return values in ethers v6, write transactions with `await provider.getSigner()`, `tx.wait()`, React forms and checkboxes

You already know reads (Lesson 02) and writes (Lessons 03 and 08). This lesson combines them in one app, which is where it starts to feel like a real dApp. It is the longest activity so far, so go one task at a time.

---

### Task 1: Load every task from the contract

Solidity cannot hand you a whole array of structs cheaply, so the contract exposes two things: how many tasks there are (`getTasksCount()`), and one task by index (`tasks(i)`). Fill in `loadTasks`:

```js
const loadTasks = async () => {
  try {
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

    const count = await contract.getTasksCount();
    const items = [];

    for (let i = 0; i < count; i++) {
      const [id, content, done] = await contract.tasks(i);
      if (content !== "") {
        items.push({ id: Number(id), content, done });
      }
    }

    setTasks(items);
  } catch (err) {
    console.error("Error loading tasks:", err);
  } finally {
    setLoading(false);
  }
};
```

- `tasks(i)` returns the struct as a list `[id, content, done]`, so you can destructure it. (`task.content` by name works too in v6.)
- `id` comes back as a `bigint`; `Number(id)` makes it a plain number for React keys and comparisons.
- A deleted task keeps its slot but has empty `content`, so we skip it.
- `finally { setLoading(false) }` runs whether the read worked or not, so the page never sticks on "Loading tasks...".

---

### Task 2: Create a task from the form

Keep the `e.preventDefault();` already in the starter, then fill in the rest of `handleCreate`:

```js
    if (!newTask.trim()) return;

    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.createTask(newTask);
      await tx.wait();

      setNewTask("");
      loadTasks();
    } catch (err) {
      console.error("Error creating task:", err);
    }
```

- The first line ignores an empty (or spaces-only) task: no transaction, no gas.
- Creating a task **writes** to the chain, so the contract is built with a **signer** (`await provider.getSigner()`).
- `await tx.wait()` waits for **this** `createTask` transaction to be mined. Only then do we clear the field and reload the list.

---

### Task 3: Toggle a task when its checkbox changes

Fill in `handleToggle`:

```js
  const handleToggle = async (taskId) => {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
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
```

After the transaction is mined we flip just that one task in local state instead of re-reading every task from the chain. `setTasks((prev) => ...)` uses the latest state even if other updates happened in between.

---

### Task 4: Build the form and the task list

Replace the `{/* TODO: Task 4 ... */}` comment **and** `<p>Placeholder</p>` with this. The `<h2>` heading stays.

```jsx
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
```

---

> **Graded details: labels and wording are checked.** The hidden test is strict about these, so copy them exactly:
>
> - The new-task field must have a placeholder containing **`New task`** (the test fills it by placeholder). `New task...` works; `What needs doing?` does not.
> - The new-task `<form>` with `onSubmit={handleCreate}` must be the **first form** on the page (the test submits the first one).
> - On load: **`getTasksCount()` must be read, then `tasks(i)` once per task** (the test contract holds 2).
> - **Every task's `content` must appear** (`Bumili ng bigas`, `Bayaran ang kuryente`).
> - **One `<input type="checkbox">` per task**, with `checked={task.done}` (the second test task is done, so its box must be checked).
> - Submitting the form must call **`createTask` with exactly what was typed**, then **`await tx.wait()`**. Submitting an **empty** field must **not** call `createTask`.
> - Changing a checkbox must call **`toggleDone` with that task's id** (the first task's id is `0`).

### Common mistakes

- Writing `useEffect(async () => ...)`: React effects cannot be async. The starter already calls `loadTasks()` from a plain effect; leave it as it is.
- Forgetting `await` on `provider.getSigner()`: in v6 it returns a Promise, and the write fails.
- Building the write contract with `provider` instead of `signer`: reads work, but `createTask` throws because nobody can sign it.

---

## Breakdown of the Activity

**Variables Defined:**

- `tasks`: the task list, each `{ id, content, done }`. Deleted tasks (empty `content`) are left out.
- `newTask`: what the user is typing in the new-task box. Cleared after a successful create.
- `loading`: `true` until the first read finishes; while true the component shows "Loading tasks...".
- `ABI`: the contract's read functions (`getTasksCount`, `tasks`) and write functions (`createTask`, `toggleDone`, `deleteTask`). `deleteTask` is not used in this activity, but it is why empty slots can exist.

**Key Functions:**

- `loadTasks`: reads `getTasksCount()`, then loops `tasks(i)` for each index, destructures `[id, content, done]`, and stores every non-deleted task.
- `handleCreate`: ignores an empty input, gets a signer, sends `createTask(content)`, waits for that transaction's receipt, then clears the input and reloads.
- `handleToggle`: gets a signer, sends `toggleDone(taskId)`, waits for the receipt, then flips that task's `done` in local state.
