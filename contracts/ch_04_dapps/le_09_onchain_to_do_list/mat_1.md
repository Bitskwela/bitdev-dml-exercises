## 🧑‍💻 Background Story

Late nights at the University of Santo Tomas library were Neri’s ritual. As pages of blockchain whitepapers glowed on her laptop, she scribbled ideas in her notebook: “A to-do list… on the chain?” Fast forward—Odessa (“Det”) dragged her out of bed at 2 AM. “Let’s build it!” Neri exclaimed, eyes still heavy but mind racing.

Their vision was simple but daring: a decentralized to-do list where every task lives on Ethereum—no backend, no server—just pure on-chain state. In a cramped UST dorm room, they fired up Hardhat, wrote a Solidity contract for CRUD operations, and deployed to a local network. Odessa scaffolded a React app with Create React App, wired up Ethers.js, and sketched a UI inspired by their campus planner.

By dawn, Det had a live demo:

1. Connect MetaMask to the local network
2. Fetch and render tasks stored in the contract
3. Add new tasks with a form
4. Toggle “done” status and delete tasks—all on-chain

They tested it with instant block confirmations. Every click emitted events, updating the UI in real time. The feeling was electric: no databases, no REST APIs—just smart contracts and React hooks dancing together. That day, over sweet kapeng barako, they toasted to on-chain productivity and the future of Web3-powered student life. Their “UST-Do” dApp was born—a testament that even the most mundane apps can be revolutionized by blockchain. 🎓🧠🚀

---

## 📚 Theory & Web3 Lecture

1. Smart Contract Design (Solidity)  
   • Structs & Arrays: store each task’s `id`, `content`, and `done` flag.  
   • Events: emit `TaskCreated`, `TaskToggled`, `TaskDeleted` for UI reactivity.  
   • Public getters: `tasks(uint)` and `getTasksCount()` to retrieve tasks.

2. dApp Architecture  
   • React Frontend (CRA or Vite)  
   • Ethers.js for blockchain calls and event listeners  
   • MetaMask (or injected provider) for account management

3. Ethers.js Essentials  
   • Provider vs. Signer  
    – `provider = new ethers.providers.Web3Provider(window.ethereum)` (read)  
    – `signer = provider.getSigner()` (write)  
   • Contract Instance

   ```js
   const todoContract = new ethers.Contract(
     process.env.REACT_APP_CONTRACT_ADDRESS,
     TODO_ABI,
     signerOrProvider
   );
   ```

   • BigNumber & Iteration  
    – Use `await contract.getTasksCount()` to get `uint count`  
    – Loop from `0` to `count - 1`, call `await contract.tasks(i)`

4. React Hooks Pattern  
   • useState: store `tasks`, `loading`, `error`  
   • useEffect: on-mount connect wallet & fetch tasks  
   • Event Handling: `contract.on("TaskCreated", handler)` to auto-refresh

5. Gas & UX  
   • Read calls (view) cost no gas  
   • Write calls (create, toggle, delete) incur gas; use `await tx.wait()`  
   • Provide user feedback: disable buttons during tx, show spinners

6. Security & Best Practices  
   • Validate input lengths (e.g., non-empty task content)  
   • Clean up event listeners in `useEffect` cleanup  
   • Store RPC URL & contract address in `.env` (never commit secrets)  
   • Catch errors (`try/catch`) and display user-friendly messages

🔗 Further Reading  
– Ethers.js: https://docs.ethers.org  
– Solidity Structs & Arrays: https://docs.soliditylang.org  
– React Hooks: https://reactjs.org/docs/hooks-overview.html

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
- [ ] `provider = new ethers.providers.Web3Provider(window.ethereum)`.
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
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const todo = new ethers.Contract(CONTRACT, ABI, provider);
        const count = await todo.getTasksCount();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [id, content, done] = await todo.tasks(i);
          items.push({ id: id.toNumber(), content, done });
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
- [ ] `provider = new ethers.providers.Web3Provider(window.ethereum)`
- [ ] `signer = provider.getSigner()`
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
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
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

- [ ] Use `ethers.providers.Web3Provider` & `getSigner()`
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
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const todo = new ethers.Contract(CONTRACT, ABI, signer);
    const tx = await todo.toggleDone(task.id);
    await tx.wait();
    onAction();
  }
  async function remove() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
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
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
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
