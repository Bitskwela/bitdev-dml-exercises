# Toggle & Delete Tasks activity:

```js
// TaskManager.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/TodoContract.json";

export default function TaskManager({ task, taskId, onTaskUpdated }) {
  const [status, setStatus] = useState("");

  const toggleTask = async () => {
    // TODO: toggle task completion status
  };

  const deleteTask = async () => {
    // TODO: delete the task
  };

  return (
    <div>
      <span>{task.text}</span>
      <button onClick={toggleTask}>
        {task.completed ? "Mark Incomplete" : "Mark Complete"}
      </button>
      <button onClick={deleteTask}>Delete</button>
      {status && <p>{status}</p>}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Multiple contract functions, task state management, conditional operations

- Update the `TaskManager` component to:
  - Implement `toggleTask()` to call contract's toggle function.
  - Implement `deleteTask()` to call contract's delete function.
  - Handle transaction confirmations for both operations.
  - Call `onTaskUpdated()` callback after successful operations.
