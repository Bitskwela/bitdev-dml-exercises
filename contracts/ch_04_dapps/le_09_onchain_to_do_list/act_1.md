# List All Tasks activity:

```js
// TaskList.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/TodoContract.json";

export default function TaskList() {
  const [tasks, setTasks] = useState([]);

  useEffect(() => {
    // TODO: fetch all tasks from contract
  }, []);

  return (
    <div>
      <h3>Your Tasks</h3>
      <ul>
        {tasks.map((task, idx) => (
          <li key={idx}>
            <input type="checkbox" checked={task.completed} readOnly />
            {task.text}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Contract state reading, struct parsing, array enumeration

- Update the `TaskList` component to:
  - Connect to the TodoContract using provider and ABI.
  - Fetch task count using `getTaskCount()` or similar function.
  - Loop through tasks and retrieve each task data structure.
  - Parse task properties (text, completed status) for display.
