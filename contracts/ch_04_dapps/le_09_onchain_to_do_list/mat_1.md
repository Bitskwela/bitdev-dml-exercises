## 🧑‍💻 Background Story

![On-Chain To-Do List](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+9.0+-+COVER.png)

Late nights at the University of Santo Tomas library were Neri’s ritual. As pages of blockchain whitepapers glowed on her laptop, she scribbled ideas in her notebook: “A to-do list… on the chain?” Fast forward—Odessa (“Det”) dragged her out of bed at 2 AM. “Let’s build it!” Neri exclaimed, eyes still heavy but mind racing.

![Neri and Det brainstorming](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+9.1.png)

Their vision was simple but daring: a decentralized to-do list where every task lives on Ethereum—no backend, no server—just pure on-chain state. In a cramped UST dorm room, they fired up Hardhat, wrote a Solidity contract for CRUD operations, and deployed to a local network. Odessa scaffolded a React app with Create React App, wired up Ethers.js, and sketched a UI inspired by their campus planner.

By dawn, Det had a live demo:

1. Connect MetaMask to the local network
2. Fetch and render tasks stored in the contract
3. Add new tasks with a form
4. Toggle “done” status and delete tasks—all on-chain

They tested it with instant block confirmations. Every click emitted events, updating the UI in real time. The feeling was electric: no databases, no REST APIs—just smart contracts and React hooks dancing together. That day, over sweet kapeng barako, they toasted to on-chain productivity and the future of Web3-powered student life. Their “UST-Do” dApp was born—a testament that even the most mundane apps can be revolutionized by blockchain. 🎓🧠🚀

---

## 📚 Theory & Web3 Lecture

Welcome to building an **On-Chain To-Do List**! This lesson teaches you how to build a full CRUD (Create, Read, Update, Delete) application that stores all data on the blockchain. No database servers, no backend—just pure decentralized storage!

---

### 1. Why Store Data On-Chain?

#### **Traditional vs Blockchain Storage**

```
Traditional To-Do App:
┌─────────────────────────────────────────────────────────────┐
│  User → Frontend → Backend API → Database (MongoDB/SQL)    │
│                                                             │
│  Problems:                                                  │
│  • Server can go down                                       │
│  • Database can be hacked                                   │
│  • Company can delete your data                             │
│  • You don't own your data                                  │
└─────────────────────────────────────────────────────────────┘

On-Chain To-Do App:
┌─────────────────────────────────────────────────────────────┐
│  User → Frontend → Smart Contract (Ethereum)               │
│                                                             │
│  Benefits:                                                  │
│  • Always available (blockchain never sleeps)               │
│  • Immutable (can't be secretly modified)                   │
│  • You own your data (tied to your wallet)                  │
│  • Transparent (anyone can verify)                          │
│                                                             │
│  Trade-offs:                                                │
│  • Costs gas for write operations                           │
│  • Slower than traditional databases                        │
│  • Data is public (unless encrypted)                        │
└─────────────────────────────────────────────────────────────┘
```

#### **When to Use On-Chain Storage**

| Use Case               | On-Chain? | Why                        |
| ---------------------- | --------- | -------------------------- |
| Public records         | ✅ Yes    | Transparency, immutability |
| Personal notes         | ⚠️ Maybe  | Consider privacy           |
| High-frequency updates | ❌ No     | Gas costs too high         |
| Financial transactions | ✅ Yes    | Trust, auditability        |
| Large files            | ❌ No     | Use IPFS instead           |

---

### 2. Smart Contract Design Patterns

#### **The Task Struct**

In Solidity, we use **structs** to group related data:

```solidity
struct Task {
    uint256 id;       // Unique identifier
    string content;   // Task description
    bool done;        // Completion status
}

// This is like a class or interface in JavaScript:
// { id: 1, content: "Buy groceries", done: false }
```

#### **Storage Patterns for Lists**

```solidity
// Pattern 1: Simple Array
Task[] public tasks;
// Pros: Simple, iterable
// Cons: Can't delete items cleanly

// Pattern 2: Mapping with Counter
mapping(uint256 => Task) public tasks;
uint256 public taskCount;
// Pros: Constant-time lookup
// Cons: Need separate counter, gaps on delete

// Pattern 3: Mapping + Array (Best of both)
mapping(uint256 => Task) public taskById;
uint256[] public taskIds;
// Pros: Fast lookup AND iteration
// Cons: More complex, more gas
```

#### **Our Contract Structure**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    // Data structure for a task
    struct Task {
        uint256 id;
        string content;
        bool done;
    }

    // Storage: array of all tasks
    Task[] public tasks;

    // Events for frontend reactivity
    event TaskCreated(uint256 indexed id, string content, bool done);
    event TaskToggled(uint256 indexed id, bool done);
    event TaskDeleted(uint256 indexed id);

    // Create a new task
    function createTask(string memory content) public {
        uint256 id = tasks.length;
        tasks.push(Task(id, content, false));
        emit TaskCreated(id, content, false);
    }

    // Toggle task completion
    function toggleDone(uint256 id) public {
        require(id < tasks.length, "Task doesn't exist");
        tasks[id].done = !tasks[id].done;
        emit TaskToggled(id, tasks[id].done);
    }

    // Delete a task (sets to empty)
    function deleteTask(uint256 id) public {
        require(id < tasks.length, "Task doesn't exist");
        delete tasks[id];
        emit TaskDeleted(id);
    }

    // Get total number of tasks
    function getTasksCount() public view returns (uint256) {
        return tasks.length;
    }
}
```

---

### 3. Understanding Solidity Events

#### **Why Events Matter**

Events are the bridge between smart contracts and your frontend:

```
Without Events:
┌─────────────────────────────────────────────────────────────┐
│  1. User creates task                                        │
│  2. Transaction confirmed                                    │
│  3. ??? How does UI know to update?                          │
│  4. Must manually refresh or poll                            │
└─────────────────────────────────────────────────────────────┘

With Events:
┌─────────────────────────────────────────────────────────────┐
│  1. User creates task                                        │
│  2. Contract emits TaskCreated event                         │
│  3. Frontend listener catches event                          │
│  4. UI updates automatically! ✨                             │
└─────────────────────────────────────────────────────────────┘
```

#### **Event Structure**

```solidity
// Declaring an event
event TaskCreated(
    uint256 indexed id,    // 'indexed' = searchable/filterable
    string content,        // Task content
    bool done              // Completion status
);

// Emitting an event
emit TaskCreated(newId, content, false);

// 'indexed' parameters (max 3) can be filtered:
// - Find all events where id = 5
// - Find all events from a specific address
```

#### **Listening to Events in JavaScript**

```js
// Subscribe to new events
contract.on("TaskCreated", (id, content, done, event) => {
  console.log(`New task #${id}: ${content}`);

  // event object contains:
  // - blockNumber
  // - transactionHash
  // - args (same as parameters)

  refreshTasks();
});

// Query past events
const filter = contract.filters.TaskCreated();
const events = await contract.queryFilter(filter, fromBlock, toBlock);
```

---

### 4. CRUD Operations with Ethers.js

#### **Architecture Overview**

```
Frontend CRUD Flow:
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│  CREATE (Write - requires Signer)                            │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  User types task → calls createTask() → tx confirmed    ││
│  │  → TaskCreated event → UI adds task                      ││
│  └─────────────────────────────────────────────────────────┘│
│                                                              │
│  READ (Read-only - Provider is enough)                       │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  getTasksCount() → loop tasks(i) → display list         ││
│  └─────────────────────────────────────────────────────────┘│
│                                                              │
│  UPDATE (Write - requires Signer)                            │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  User clicks toggle → toggleDone(id) → tx confirmed     ││
│  │  → TaskToggled event → UI updates checkbox              ││
│  └─────────────────────────────────────────────────────────┘│
│                                                              │
│  DELETE (Write - requires Signer)                            │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  User clicks delete → deleteTask(id) → tx confirmed     ││
│  │  → TaskDeleted event → UI removes task                  ││
│  └─────────────────────────────────────────────────────────┘│
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### **The ABI**

```js
const TODO_ABI = [
  // Read functions (view)
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",

  // Write functions
  "function createTask(string memory content)",
  "function toggleDone(uint256 id)",
  "function deleteTask(uint256 id)",

  // Events
  "event TaskCreated(uint256 indexed id, string content, bool done)",
  "event TaskToggled(uint256 indexed id, bool done)",
  "event TaskDeleted(uint256 indexed id)",
];
```

---

### 5. Reading Tasks (R in CRUD)

#### **Fetching All Tasks**

```js
async function loadTasks() {
  // Provider is enough for reading
  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, provider);

  // Get total count
  const count = await contract.getTasksCount();
  console.log(`Total tasks: ${count}`);

  // Fetch each task
  const tasks = [];
  for (let i = 0; i < count; i++) {
    const [id, content, done] = await contract.tasks(i);

    // Skip deleted tasks (content is empty)
    if (content !== "") {
      tasks.push({
        id: Number(id),
        content,
        done,
      });
    }
  }

  return tasks;
}
```

#### **Handling Deleted Tasks**

When you `delete` in Solidity, the slot becomes zero-values:

```js
// After delete tasks[2]:
// tasks[2] = { id: 0, content: "", done: false }

// Filter out deleted tasks:
const activeTasks = tasks.filter((t) => t.content !== "");
```

---

### 6. Creating Tasks (C in CRUD)

#### **Complete Create Flow**

```js
async function createTask(content) {
  // Validate input
  if (!content || !content.trim()) {
    throw new Error("Task content cannot be empty");
  }

  // Get signer for write operation
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, signer);

  // Send transaction
  console.log("Creating task...");
  const tx = await contract.createTask(content);

  // Wait for confirmation
  console.log("Waiting for confirmation...");
  const receipt = await tx.wait();

  // Get the new task ID from the event (parse receipt.logs in v6)
  const event = receipt.logs
    .map((log) => {
      try {
        return contract.interface.parseLog(log);
      } catch {
        return null;
      }
    })
    .find((parsed) => parsed && parsed.name === "TaskCreated");
  const newId = Number(event.args.id);

  console.log(`Task #${newId} created!`);
  return newId;
}
```

---

### 7. Updating Tasks (U in CRUD)

#### **Toggle Completion**

```js
async function toggleTask(taskId) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, signer);

  // Send toggle transaction
  const tx = await contract.toggleDone(taskId);
  await tx.wait();

  // Read the new status
  const [, , done] = await contract.tasks(taskId);
  console.log(`Task #${taskId} is now ${done ? "complete" : "incomplete"}`);

  return done;
}
```

---

### 8. Deleting Tasks (D in CRUD)

#### **Delete Operation**

```js
async function deleteTask(taskId) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, signer);

  // Confirm with user (optional but recommended)
  if (!confirm(`Delete task #${taskId}?`)) {
    return false;
  }

  // Send delete transaction
  const tx = await contract.deleteTask(taskId);
  await tx.wait();

  console.log(`Task #${taskId} deleted`);
  return true;
}
```

#### **Understanding Delete in Solidity**

```solidity
// delete doesn't remove from array, it zeros the slot
delete tasks[2];

// tasks[2] becomes: { id: 0, content: "", done: false }
// Array length stays the same!

// To truly remove, you'd need to:
// 1. Swap with last element
// 2. Pop the array
// But this changes IDs, which can be confusing
```

---

### 9. Real-Time Updates with Events

#### **Setting Up Event Listeners**

```jsx
function useTodoEvents(contractAddress, onUpdate) {
  useEffect(() => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const contract = new ethers.Contract(contractAddress, TODO_ABI, provider);

    // Listen for new tasks
    function onTaskCreated(id, content, done) {
      console.log(`Event: Task #${id} created`);
      onUpdate();
    }

    // Listen for toggles
    function onTaskToggled(id, done) {
      console.log(`Event: Task #${id} toggled to ${done}`);
      onUpdate();
    }

    // Listen for deletes
    function onTaskDeleted(id) {
      console.log(`Event: Task #${id} deleted`);
      onUpdate();
    }

    // Subscribe to all events
    contract.on("TaskCreated", onTaskCreated);
    contract.on("TaskToggled", onTaskToggled);
    contract.on("TaskDeleted", onTaskDeleted);

    // Cleanup on unmount
    return () => {
      contract.off("TaskCreated", onTaskCreated);
      contract.off("TaskToggled", onTaskToggled);
      contract.off("TaskDeleted", onTaskDeleted);
    };
  }, [contractAddress, onUpdate]);
}
```

---

### 10. Gas Considerations

#### **Understanding Gas Costs**

```
Gas Cost by Operation:
┌─────────────────────────────────────────────────────────────┐
│  Operation        │  Gas (approx)  │  Cost at 30 gwei       │
├───────────────────┼────────────────┼────────────────────────┤
│  Read tasks       │  0 (free!)     │  $0.00                 │
│  Create task      │  ~50,000       │  ~$2-5                 │
│  Toggle done      │  ~30,000       │  ~$1-3                 │
│  Delete task      │  ~20,000       │  ~$0.50-2              │
└───────────────────┴────────────────┴────────────────────────┘

Note: Actual costs vary with:
- Network congestion
- String length (longer = more gas)
- Gas price at the time
```

#### **Optimizing Gas**

```js
// ❌ Creating many tasks one by one (expensive!)
for (const content of contents) {
  await contract.createTask(content);
}

// ✅ Consider a batch function in your contract
function createTasks(string[] memory contents) public {
  for (uint i = 0; i < contents.length; i++) {
    // ... create each task
  }
}
// One transaction, lower total gas!
```

---

### 11. Complete React Component

```jsx
function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  // Load tasks on mount
  useEffect(() => {
    loadTasks();
  }, []);

  async function loadTasks() {
    try {
      setLoading(true);
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
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  async function handleCreate(e) {
    e.preventDefault();
    if (!newTask.trim()) return;

    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.createTask(newTask);
      await tx.wait();

      setNewTask("");
      loadTasks(); // Refresh list
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleToggle(taskId) {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.toggleDone(taskId);
      await tx.wait();

      loadTasks();
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleDelete(taskId) {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      const tx = await contract.deleteTask(taskId);
      await tx.wait();

      loadTasks();
    } catch (err) {
      setError(err.message);
    }
  }

  if (loading) return <p>Loading tasks...</p>;

  return (
    <div>
      <h1>On-Chain To-Do List</h1>

      <form onSubmit={handleCreate}>
        <input
          value={newTask}
          onChange={(e) => setNewTask(e.target.value)}
          placeholder="New task..."
        />
        <button type="submit">Add</button>
      </form>

      {error && <p style={{ color: "red" }}>{error}</p>}

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
            <button onClick={() => handleDelete(task.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

---

### 12. Common Mistakes to Avoid

#### **1. Forgetting to Handle Deleted Tasks**

```js
// ❌ Shows empty tasks
for (let i = 0; i < count; i++) {
  const task = await contract.tasks(i);
  tasks.push(task);
}

// ✅ Filter deleted tasks
for (let i = 0; i < count; i++) {
  const [id, content, done] = await contract.tasks(i);
  if (content !== "") {
    tasks.push({ id, content, done });
  }
}
```

#### **2. Not Cleaning Up Event Listeners**

```js
// ❌ Memory leak!
useEffect(() => {
  contract.on("TaskCreated", handleCreate);
}, []);

// ✅ Clean up on unmount
useEffect(() => {
  contract.on("TaskCreated", handleCreate);
  return () => contract.off("TaskCreated", handleCreate);
}, []);
```

---

### 13. Testing Your To-Do App

Before deploying, verify:

1. ✅ **Tasks load on page** - List displays correctly
2. ✅ **Create works** - New task appears after confirmation
3. ✅ **Toggle works** - Checkbox updates after confirmation
4. ✅ **Delete works** - Task disappears after confirmation
5. ✅ **Empty input rejected** - Validation works
6. ✅ **User rejection handled** - Doesn't crash on cancel
7. ✅ **Loading states shown** - User knows what's happening
8. ✅ **Events trigger updates** - Real-time sync works

---

### External References & Further Learning

- **Ethers.js Contract Events**: https://docs.ethers.org/v6/api/contract/#ContractEvent - Event handling
- **Solidity Data Structures**: https://docs.soliditylang.org/en/latest/types.html - Structs and arrays
- **Gas Optimization**: https://docs.soliditylang.org/en/latest/internals/optimizer.html - Reduce gas costs
- **React Hooks**: https://reactjs.org/docs/hooks-effect.html - useEffect for events
- **OpenZeppelin**: https://docs.openzeppelin.com - Secure contract patterns

---

## 🧪 Exercises

### Exercise 1: List All Tasks

**Problem Statement**  
Create a React component that connects to MetaMask, fetches `getTasksCount()`, loops through tasks, and renders each with its `content` and `done` status.

**Solidity Contract (`TodoList.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task { uint id; string content; bool done; }
    Task[] public tasks;

    event TaskCreated(uint id, string content, bool done);
    event TaskToggled(uint id, bool done);
    event TaskDeleted(uint id);

    function createTask(string memory content) public {
        uint id = tasks.length;
        tasks.push(Task(id, content, false));
        emit TaskCreated(id, content, false);
    }

    function toggleDone(uint id) public {
        Task storage t = tasks[id];
        t.done = !t.done;
        emit TaskToggled(id, t.done);
    }

    function deleteTask(uint id) public {
        delete tasks[id];
        emit TaskDeleted(id);
    }

    function getTasksCount() public view returns (uint) {
        return tasks.length;
    }
}
```

**Starter Code (`TaskList.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256, string, bool)",
];

export default function TaskList() {
  const [tasks, setTasks] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadTasks() {
      try {
        // TODO: Request accounts
        // TODO: Initialize provider & contract
        // TODO: Call getTasksCount()
        // TODO: Loop [0..count) and call tasks(i)
        // TODO: setTasks(arrayOfTasks)
      } catch (err) {
        setError(err.message);
      }
    }
    loadTasks();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>My On-Chain To-Do</h3>
      {tasks.map((t) => (
        <div key={t.id}>
          <input type="checkbox" checked={t.done} readOnly />
          <span>{t.content}</span>
        </div>
      ))}
    </div>
  );
}
```

**To Do List**

- [ ] `await window.ethereum.request({ method: "eth_requestAccounts" })`.
- [ ] `provider = new ethers.BrowserProvider(window.ethereum)`.
- [ ] `contract = new ethers.Contract(address, ABI, provider)`.
- [ ] `const count = await contract.getTasksCount()`.
- [ ] Loop `i < count`, call `contract.tasks(i)` and build `{ id, content, done }`.
- [ ] `setTasks(...)`.

**Full Solution**

```js
// TaskList.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",
];
const CONTRACT = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function TaskList() {
  const [tasks, setTasks] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadTasks() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.BrowserProvider(window.ethereum);
        const todo = new ethers.Contract(CONTRACT, ABI, provider);
        const count = await todo.getTasksCount();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [id, content, done] = await todo.tasks(i);
          items.push({ id: Number(id), content, done });
        }
        setTasks(items);
      } catch (err) {
        setError(err.message);
      }
    }
    loadTasks();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>My On-Chain To-Do</h3>
      {tasks.length === 0 && <p>No tasks yet.</p>}
      {tasks.map((t) => (
        <div key={t.id}>
          <input type="checkbox" checked={t.done} readOnly />
          <span>{t.content}</span>
        </div>
      ))}
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_CONTRACT_ADDRESS=0xYourDeployedContract
```

---

### Exercise 2: Create a New Task

**Problem Statement**  
Add a form component that lets users submit a new task via `createTask(content)`. After `tx.wait()`, refresh the task list.

**Starter Code (`CreateTask.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function createTask(string)"];
export default function CreateTask({ onTaskCreated }) {
  const [content, setContent] = useState("");
  const [error, setError] = useState("");

  async function addTask() {
    try {
      // TODO: Connect wallet
      // TODO: Get signer & contract
      // TODO: await contract.createTask(content)
      // TODO: await tx.wait()
      // TODO: call onTaskCreated() to reload list
      // TODO: clear content
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Add New Task</h4>
      <input
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="Task description"
      />
      <button onClick={addTask}>Add</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

**To Do List**

- [ ] `await window.ethereum.request({ method: "eth_requestAccounts" })`
- [ ] `provider = new ethers.BrowserProvider(window.ethereum)`
- [ ] `signer = await provider.getSigner()`
- [ ] `contract = new ethers.Contract(address, ABI, signer)`
- [ ] `const tx = await contract.createTask(content)`
- [ ] `await tx.wait()` and `onTaskCreated()`
- [ ] `setContent("")`.

**Full Solution**

```js
// CreateTask.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function createTask(string)"];
const CONTRACT = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function CreateTask({ onTaskCreated }) {
  const [content, setContent] = useState("");
  const [error, setError] = useState("");

  async function addTask() {
    setError("");
    if (!content.trim()) {
      setError("Task cannot be empty");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const todo = new ethers.Contract(CONTRACT, ABI, signer);
      const tx = await todo.createTask(content);
      await tx.wait();
      setContent("");
      onTaskCreated();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Add New Task</h4>
      <input
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="Task description"
      />
      <button onClick={addTask}>Add</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

### Exercise 3: Toggle & Delete Tasks

**Problem Statement**  
Extend your task list so each item has “Toggle” and “Delete” buttons. Call `toggleDone(id)` or `deleteTask(id)` then refresh the list.

**Starter Code (`TaskItem.js`)**

```js
import React from "react";
import { ethers } from "ethers";

const ABI = ["function toggleDone(uint256)", "function deleteTask(uint256)"];

export default function TaskItem({ task, onAction }) {
  async function toggle() {
    // TODO: signer & contract
    // TODO: await contract.toggleDone(task.id); await tx.wait()
    // TODO: onAction()
  }
  async function remove() {
    // TODO: signer & contract
    // TODO: await contract.deleteTask(task.id); await tx.wait()
    // TODO: onAction()
  }

  return (
    <div>
      <span style={{ textDecoration: task.done ? "line-through" : "none" }}>
        {task.content}
      </span>
      <button onClick={toggle}>Toggle</button>
      <button onClick={remove}>Delete</button>
    </div>
  );
}
```

**To Do List**

- [ ] Use `ethers.BrowserProvider` & `await getSigner()`
- [ ] `contract = new ethers.Contract(address, ABI, signer)`
- [ ] Call appropriate method, `await tx.wait()`
- [ ] Trigger `onAction()` to reload tasks.

**Full Solution**

```js
// TaskItem.js
import React from "react";
import { ethers } from "ethers";
const ABI = ["function toggleDone(uint256)", "function deleteTask(uint256)"];
const CONTRACT = process.env.REACT_APP_CONTRACT_ADDRESS;

export default function TaskItem({ task, onAction }) {
  async function toggle() {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const todo = new ethers.Contract(CONTRACT, ABI, signer);
    const tx = await todo.toggleDone(task.id);
    await tx.wait();
    onAction();
  }
  async function remove() {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const todo = new ethers.Contract(CONTRACT, ABI, signer);
    const tx = await todo.deleteTask(task.id);
    await tx.wait();
    onAction();
  }

  return (
    <div>
      <span style={{ textDecoration: task.done ? "line-through" : "none" }}>
        {task.content}
      </span>
      <button onClick={toggle}>Toggle</button>
      <button onClick={remove}>Delete</button>
    </div>
  );
}
```

---

## ✅ Test Cases

Create `__tests__/TodoApp.test.js` using Jest & React Testing Library.

```js
// __tests__/TodoApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import TodoApp from "../TodoApp";
import { ethers } from "ethers";

jest.mock("ethers");

describe("TodoApp Integration", () => {
  const fakeTasks = [
    { id: 0, content: "Task A", done: false },
    { id: 1, content: "Task B", done: true },
  ];
  const mockContract = {
    getTasksCount: jest.fn(),
    tasks: jest.fn(),
    createTask: jest.fn(),
    toggleDone: jest.fn(),
    deleteTask: jest.fn(),
  };
  const fakeProvider = {};
  const fakeSigner = {};

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.BrowserProvider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(mockContract);
  });

  beforeEach(() => {
    mockContract.getTasksCount.mockResolvedValue(2);
    mockContract.tasks
      .mockResolvedValueOnce([0, "Task A", false])
      .mockResolvedValueOnce([1, "Task B", true]);
  });

  it("loads and displays tasks", async () => {
    render(<TodoApp />);
    expect(await screen.findByText("Task A")).toBeInTheDocument();
    expect(screen.getByText("Task B")).toBeInTheDocument();
  });

  it("adds a new task", async () => {
    mockContract.createTask.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
    render(<TodoApp />);
    fireEvent.change(screen.getByPlaceholderText("Task description"), {
      target: { value: "New Task" },
    });
    fireEvent.click(screen.getByText("Add"));
    await waitFor(() =>
      expect(mockContract.createTask).toHaveBeenCalledWith("New Task")
    );
  });

  it("toggles and deletes tasks", async () => {
    mockContract.toggleDone.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
    mockContract.deleteTask.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
    render(<TodoApp />);
    await screen.findByText("Task A");
    fireEvent.click(screen.getAllByText("Toggle")[0]);
    await waitFor(() =>
      expect(mockContract.toggleDone).toHaveBeenCalledWith(0)
    );
    fireEvent.click(screen.getAllByText("Delete")[1]);
    await waitFor(() =>
      expect(mockContract.deleteTask).toHaveBeenCalledWith(1)
    );
  });
});
```

`jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: {
    "\\.(css|scss)$": "identity-obj-proxy",
  },
};
```

---

## 🌟 Closing Story

By midday, “UST-Do” was battle-tested: Neri added ten tasks, toggled deadlines, and even deleted her lunch reminder—all on-chain. Odessa grinned as the dorm cat walked across her keyboard. “Next,” she said, “we’ll add user accounts and IPFS-backed notes.” From UST library to MetaMask, their stateful dApp was now more than homework—it was a blueprint for permissionless productivity. Mabuhay, future Web3 full-stackers! 🇵🇭💪🚀
