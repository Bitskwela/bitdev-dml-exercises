# Create New Task activity:

```js
// CreateTask.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/TodoContract.json";

export default function CreateTask({ onTaskCreated }) {
  const [taskText, setTaskText] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    // TODO: create new task on contract
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>Add New Task</h3>
      <input
        placeholder="Enter task description"
        value={taskText}
        onChange={(e) => setTaskText(e.target.value)}
      />
      <button type="submit">Add Task</button>
      {status && <p>{status}</p>}
    </form>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Contract write functions, transaction execution, state updates

- Update the `CreateTask` component to:
  - Connect to MetaMask and get signer for transaction signing.
  - Call the `createTask()` or `addTask()` function with task text.
  - Handle transaction confirmation and status updates.
  - Call `onTaskCreated()` callback after successful task creation.
