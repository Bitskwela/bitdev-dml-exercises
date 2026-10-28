## 🧑‍💻 Background Story

![On-Chain To-Do List](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+9.0+-+COVER.png)

Late nights at the University of Santo Tomas library were Neri's ritual. As pages of blockchain whitepapers glowed on her laptop, she scribbled ideas in her notebook: "A to-do list... on the chain?" Fast forward: Odessa ("Det") dragged her out of bed at 2 AM. "Let's build it!" Neri exclaimed, eyes still heavy but mind racing.

![Neri and Det brainstorming](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+9.1.png)

Their vision was simple but daring: a decentralized to-do list where every task lives on Ethereum. No backend, no server, just on-chain state. In a cramped UST dorm room, they fired up Hardhat, wrote a Solidity contract to create, read, update and delete tasks, and deployed it to a local network. Odessa scaffolded a React app with Vite, wired up ethers, and sketched a UI inspired by their campus planner.

By dawn, Det had a live demo:

1. Connect MetaMask to the local network
2. Fetch and render tasks stored in the contract
3. Add new tasks with a form
4. Toggle "done" status, all on-chain

Hardhat's local chain mines instantly, so every click felt snappy. No databases, no REST APIs, just smart contracts and React hooks working together. Over sweet kapeng barako, they toasted to on-chain productivity. Their "UST-Do" dApp was born, proof that even the most ordinary app can be rebuilt on a blockchain. 🎓🧠🚀

---

## 📚 Theory & Web3 Lecture

Welcome to building an **On-Chain To-Do List**! This lesson puts reads and writes together in one app, a **CRUD** app: **C**reate, **R**ead, **U**pdate, **D**elete. All the data lives in a smart contract.

> **This lesson uses ethers v6**: `ethers.BrowserProvider`, `await provider.getSigner()`, and numbers as `bigint` (convert with `Number(x)`). Snippets that use `ethers.providers...` or `.toNumber()` come from ethers v5 and will not run here. <!-- v5-ok -->

---

### 1. Why Store Data On-Chain?

```
Traditional To-Do App:
┌─────────────────────────────────────────────────────────────┐
│  User → Frontend → Backend API → Database (MongoDB/SQL)     │
│                                                             │
│  • The server can go down                                   │
│  • The company controls (and can delete) your data          │
└─────────────────────────────────────────────────────────────┘

On-Chain To-Do App:
┌─────────────────────────────────────────────────────────────┐
│  User → Frontend → Smart Contract (Ethereum)                │
│                                                             │
│  Benefits:                                                  │
│  • No server of yours to keep running                       │
│  • History can't be secretly rewritten                      │
│  • Anyone can verify what is stored                         │
│                                                             │
│  Trade-offs:                                                │
│  • Every write costs gas                                    │
│  • Writes wait for a block (about 12s on Sepolia)           │
│  • Everything is PUBLIC, unless you encrypt it              │
└─────────────────────────────────────────────────────────────┘
```

| Use Case               | On-Chain? | Why                              |
| ---------------------- | --------- | -------------------------------- |
| Public records         | ✅ Yes    | Transparency, tamper-evidence    |
| Personal notes         | ⚠️ Maybe  | Anyone can read them             |
| High-frequency updates | ❌ No     | Gas for every single change      |
| Financial transactions | ✅ Yes    | Trust, auditability              |
| Large files            | ❌ No     | Store on IPFS, keep the CID on-chain |

A to-do list is a learning project: it is small enough to understand completely, and it uses every CRUD operation.

---

### 2. The Smart Contract

#### **The Task Struct**

A **struct** groups related values, like an object in JavaScript:

```solidity
struct Task {
    uint256 id;       // unique number
    string content;   // what to do
    bool done;        // finished yet?
}
// JavaScript picture: { id: 1, content: "Bumili ng bigas", done: false }
```

#### **Storage Patterns for Lists**

```solidity
// Pattern 1: an array             (our choice)
Task[] public tasks;
// + simple, and the index is the id
// - "deleting" leaves an empty slot behind

// Pattern 2: a mapping plus a counter
mapping(uint256 => Task) public tasks;
uint256 public taskCount;
// + constant-time lookup by id
// - you track the count yourself

// Pattern 3: a mapping plus an array of ids
mapping(uint256 => Task) public taskById;
uint256[] public taskIds;
// + fast lookup AND easy iteration
// - more code, more gas
```

#### **Our Contract**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    struct Task {
        uint256 id;
        string content;
        bool done;
    }

    Task[] public tasks;

    event TaskCreated(uint256 indexed id, string content, bool done);
    event TaskToggled(uint256 indexed id, bool done);
    event TaskDeleted(uint256 indexed id);

    function createTask(string memory content) public {
        uint256 id = tasks.length;
        tasks.push(Task(id, content, false));
        emit TaskCreated(id, content, false);
    }

    function toggleDone(uint256 id) public {
        require(id < tasks.length, "Task doesn't exist");
        tasks[id].done = !tasks[id].done;
        emit TaskToggled(id, tasks[id].done);
    }

    function deleteTask(uint256 id) public {
        require(id < tasks.length, "Task doesn't exist");
        delete tasks[id];
        emit TaskDeleted(id);
    }

    function getTasksCount() public view returns (uint256) {
        return tasks.length;
    }
}
```

Two things to notice:

- `Task[] public tasks;` makes Solidity generate a **getter**, `tasks(uint256 index)`, that returns **one** task. There is no built-in "give me the whole array", which is why the frontend loops.
- This contract lets **anyone** toggle or delete **any** task. Fine for a demo; a real app would store an `owner` per task and check `msg.sender`.

---

### 3. Events, the Contract's Announcements

You met events in Lesson 04. A contract **emits** an event to say "this just happened", and frontends can listen for it.

```solidity
event TaskCreated(uint256 indexed id, string content, bool done);
emit TaskCreated(newId, content, false);
```

`indexed` parameters (up to 3) can be used as filters, for example "only TaskCreated events where id = 5".

```js
// Listen for new ones
contract.on("TaskCreated", (id, content, done) => {
  console.log(`New task #${id}: ${content}`);
});

// Look up past ones
const events = await contract.queryFilter(contract.filters.TaskCreated(), fromBlock, toBlock);
```

---

### 4. CRUD with ethers v6

```
┌─────────────────────────────────────────────────────────────┐
│ READ   (provider is enough, free)                           │
│   getTasksCount() → loop tasks(i) → show the list           │
│                                                             │
│ CREATE (signer, costs gas)                                  │
│   createTask(content) → tx.wait() → reload                  │
│                                                             │
│ UPDATE (signer, costs gas)                                  │
│   toggleDone(id) → tx.wait() → flip it in local state       │
│                                                             │
│ DELETE (signer, costs gas)                                  │
│   deleteTask(id) → tx.wait() → reload                       │
└─────────────────────────────────────────────────────────────┘
```

#### **The ABI**

```js
const TODO_ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",
  "function createTask(string content)",
  "function toggleDone(uint256 id)",
  "function deleteTask(uint256 id)",
  "event TaskCreated(uint256 indexed id, string content, bool done)",
  "event TaskToggled(uint256 indexed id, bool done)",
  "event TaskDeleted(uint256 indexed id)",
];
```

---

### 5. Reading Tasks (the R)

```js
async function loadTasks() {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, provider);

  const count = await contract.getTasksCount(); // bigint, e.g. 2n

  const tasks = [];
  for (let i = 0; i < count; i++) {
    const [id, content, done] = await contract.tasks(i);
    if (content !== "") {
      tasks.push({ id: Number(id), content, done });
    }
  }
  return tasks;
}
```

- A struct comes back as an ethers **Result**: you can destructure it in order (`[id, content, done]`) or read it by name (`task.content`), because the ABI names the outputs.
- `id` is a `bigint`. `Number(id)` is safe for small counters like a task id. (Never use `Number()` on a token balance: precision loss, see Lesson 06.)

#### **What Delete Really Does**

```solidity
delete tasks[2];
// tasks[2] becomes { id: 0, content: "", done: false }
// The array length stays the same!
```

`delete` resets the slot to zero values; it does not shrink the array. So the frontend skips any task whose `content` is empty. (Swapping with the last element and calling `pop()` would truly remove it, but then ids would change, which is confusing for a list.)

---

### 6. Creating Tasks (the C)

```js
async function createTask(content) {
  if (!content.trim()) throw new Error("Task cannot be empty");

  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();               // v6: await!
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, signer);

  const tx = await contract.createTask(content);           // MetaMask pop-up
  const receipt = await tx.wait();                         // mined

  // Find our event in the receipt. ethers decodes logs whose event is in the ABI.
  const created = receipt.logs.find((log) => log.eventName === "TaskCreated");
  return Number(created.args.id);
}
```

Empty input check first: an empty task should never cost a transaction.

---

### 7. Updating Tasks (the U)

```js
async function toggleTask(taskId) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, signer);

  const tx = await contract.toggleDone(taskId);
  await tx.wait();

  const task = await contract.tasks(taskId);
  return task.done; // read by name
}
```

#### **Updating the Screen After a Write**

You have three choices after a write:

1. **Reload everything** (simple; one read per task, slow for big lists).
2. **Update local state after the receipt**: you know exactly what changed, so flip just that task. This is what the activity does for toggling.
3. **Optimistic update**: change the screen *immediately*, send the transaction, and undo the change if it fails. It feels instant, but you must handle the rollback.

```js
// Option 2, as in the activity
await tx.wait();
setTasks((prev) => prev.map((t) => (t.id === taskId ? { ...t, done: !t.done } : t)));
```

---

### 8. Deleting Tasks (the D)

```js
async function deleteTask(taskId) {
  if (!window.confirm(`Delete task #${taskId}?`)) return false;

  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDRESS, TODO_ABI, signer);

  const tx = await contract.deleteTask(taskId);
  await tx.wait();
  return true;
}
```

---

### 9. Real-Time Updates with Events

If several people use the same list, listen for events so everyone's screen stays in sync:

```jsx
function useTodoEvents(contractAddress, onUpdate) {
  useEffect(() => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const contract = new ethers.Contract(contractAddress, TODO_ABI, provider);

    contract.on("TaskCreated", onUpdate);
    contract.on("TaskToggled", onUpdate);
    contract.on("TaskDeleted", onUpdate);

    return () => {
      contract.off("TaskCreated", onUpdate);
      contract.off("TaskToggled", onUpdate);
      contract.off("TaskDeleted", onUpdate);
    };
  }, [contractAddress, onUpdate]);
}
```

Always remove listeners in the cleanup function. Otherwise every re-render adds another listener and your handler fires many times.

---

### 10. Gas Considerations

- **Reads** (`getTasksCount`, `tasks(i)`) are free.
- **Writes** cost gas. Writing to a storage slot that was empty is the most expensive thing a contract does, so `createTask` (three new slots, plus the string) costs noticeably more than `toggleDone` (one slot changed).
- Longer task text means more storage, so more gas.

Don't guess, measure. ethers v6 can ask the node:

```js
const gas = await contract.createTask.estimateGas("Bumili ng bigas");
console.log(`createTask needs about ${gas} gas`);
```

On Sepolia you pay in free test ETH from a faucet, so experiment freely.

---

### 11. The Complete Component, With Delete

The activity builds create, read and toggle. Here is the same component with delete added, so you can see the whole CRUD shape:

```jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",
  "function createTask(string)",
  "function toggleDone(uint256)",
  "function deleteTask(uint256)",
];
const CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS;

async function writeContract() {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  return new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
}

export default function TodoApp() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  async function loadTasks() {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);
      const count = await contract.getTasksCount();
      const items = [];
      for (let i = 0; i < count; i++) {
        const [id, content, done] = await contract.tasks(i);
        if (content !== "") items.push({ id: Number(id), content, done });
      }
      setTasks(items);
    } catch (err) {
      setError(err.shortMessage || err.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadTasks();
  }, []);

  async function run(action) {
    try {
      setError("");
      const contract = await writeContract();
      const tx = await action(contract);
      await tx.wait();
      await loadTasks();
    } catch (err) {
      setError(err.shortMessage || err.message);
    }
  }

  async function handleCreate(e) {
    e.preventDefault();
    if (!newTask.trim()) return;
    await run((c) => c.createTask(newTask));
    setNewTask("");
  }

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
      {error && <p style={{ color: "red" }}>{error}</p>}
      {tasks.length === 0 && <p>No tasks yet.</p>}
      <ul>
        {tasks.map((task) => (
          <li key={task.id}>
            <input
              type="checkbox"
              checked={task.done}
              onChange={() => run((c) => c.toggleDone(task.id))}
            />
            <span style={{ textDecoration: task.done ? "line-through" : "none" }}>
              {task.content}
            </span>
            <button type="button" onClick={() => run((c) => c.deleteTask(task.id))}>
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

Note `type="button"` on Delete: a `<button>` inside a `<form>` is a **submit** button by default, which would also fire `handleCreate`. These Delete buttons sit outside the form, but adding `type="button"` is a good habit for any button that should not submit.

In a Vite project, the address comes from `.env`:

```
VITE_CONTRACT_ADDRESS=0xYourDeployedContract
```

(The activity's grader supplies `process.env.REACT_APP_CONTRACT_ADDRESS` instead, and the starter already reads it.)

---

### 12. Common Mistakes to Avoid

#### **1. Showing Deleted Tasks**

```js
// ❌ deleted slots show up as empty rows
items.push(await contract.tasks(i));

// ✅ skip slots whose content is empty
const [id, content, done] = await contract.tasks(i);
if (content !== "") items.push({ id: Number(id), content, done });
```

#### **2. An `async` useEffect**

```js
// ❌ React expects nothing or a cleanup function back, not a Promise
useEffect(async () => { await loadTasks(); }, []);

// ✅ call the async function from a normal effect
useEffect(() => { loadTasks(); }, []);
```

#### **3. Not Cleaning Up Event Listeners**

```js
// ❌ a new listener every time the component mounts
useEffect(() => { contract.on("TaskCreated", onUpdate); }, []);

// ✅ remove it on unmount
useEffect(() => {
  contract.on("TaskCreated", onUpdate);
  return () => contract.off("TaskCreated", onUpdate);
}, []);
```

---

### 13. How This Is Graded

The activity runs in a sandbox with a fake wallet and a fake contract holding two tasks: "Bumili ng bigas" (not done) and "Bayaran ang kuryente" (done). The grader checks that you read the count and each task, render both with correctly checked boxes, fill the field whose placeholder contains **"New task"**, submit the form, and see `createTask` called with exactly that text followed by `tx.wait()`, that an empty submit sends nothing, and that ticking the first box calls `toggleDone(0)`.

---

### External References & Further Learning

- **ethers v6, Contracts (calls, events, `estimateGas`)**: https://docs.ethers.org/v6/api/contract/
- **Solidity, structs and arrays**: https://docs.soliditylang.org/en/latest/types.html
- **Solidity, `delete`**: https://docs.soliditylang.org/en/latest/types.html#delete
- **React `useEffect`**: https://react.dev/reference/react/useEffect
- **Hardhat, getting started**: https://hardhat.org/hardhat-runner/docs/getting-started

---

## 🧪 Exercises

### Exercise 1: List All Tasks (Read Only)

**Problem Statement**
Build a read-only list: fetch `getTasksCount()`, loop through `tasks(i)`, and render each task's `content` and `done` status. No wallet signature needed.

**Full Solution (`TaskList.jsx`)**

```jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTasksCount() view returns (uint256)",
  "function tasks(uint256) view returns (uint256 id, string content, bool done)",
];
const CONTRACT = import.meta.env.VITE_CONTRACT_ADDRESS;

export default function TaskList() {
  const [tasks, setTasks] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadTasks() {
      try {
        const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
        const todo = new ethers.Contract(CONTRACT, ABI, provider);
        const count = await todo.getTasksCount();
        const items = [];
        for (let i = 0; i < count; i++) {
          const t = await todo.tasks(i);
          if (t.content !== "") items.push({ id: Number(t.id), content: t.content, done: t.done });
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

A read-only list can use `JsonRpcProvider`, so even visitors without MetaMask see the tasks.

---

### Exercise 2: Get the New Task's ID From the Event

**Problem Statement**
After `createTask` is mined, show "Task #N created!" using the id from the `TaskCreated` event instead of reloading the list.

**Solution Snippet**

```js
const ABI = [
  "function createTask(string)",
  "event TaskCreated(uint256 indexed id, string content, bool done)",
];

const tx = await contract.createTask(newTask);
const receipt = await tx.wait();
const created = receipt.logs.find((log) => log.eventName === "TaskCreated");
setMessage(`Task #${created.args.id} created!`);
```

The event must be listed in your ABI, or ethers cannot decode the log and `eventName` will be missing.

---

### Exercise 3: Only the Owner Can Change a Task

**Problem Statement**
Right now anyone can toggle or delete anyone's task. Add an `owner` to each task and reject changes from anyone else.

**Solution Sketch (Solidity)**

```solidity
struct Task {
    uint256 id;
    string content;
    bool done;
    address owner;
}

function createTask(string memory content) public {
    uint256 id = tasks.length;
    tasks.push(Task(id, content, false, msg.sender));
    emit TaskCreated(id, content, false);
}

function toggleDone(uint256 id) public {
    require(id < tasks.length, "Task doesn't exist");
    require(tasks[id].owner == msg.sender, "Not your task");
    tasks[id].done = !tasks[id].done;
    emit TaskToggled(id, tasks[id].done);
}
```

Remember to update your ABI (`tasks(uint256)` now also returns `address owner`), and show the error nicely in the UI when someone else's toggle reverts with `CALL_EXCEPTION`.

---

## 🌟 Closing Story

By midday, "UST-Do" was battle-tested: Neri added ten tasks, ticked off deadlines, and even deleted her lunch reminder, all on-chain. Odessa grinned as the dorm cat walked across her keyboard. "Next," she said, "we add owners per task and IPFS-backed notes." From the UST library to MetaMask, their dApp was now more than homework: it was a blueprint for permissionless productivity. Mabuhay, future Web3 full-stackers! 🇵🇭💪🚀
