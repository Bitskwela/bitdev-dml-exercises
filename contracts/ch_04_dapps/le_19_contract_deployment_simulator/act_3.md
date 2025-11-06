# Activity 3: Integrate Simulator & History in App ⏱️ 10 mins

Create `App.js` that ties `DeploySimulator` and `DeployHistory` together. Store history in React state and `localStorage`.

## 📋 Contract Baseline

Using the same `HelloWorld.sol` contract, this activity focuses on integrating the deployment simulator with persistent history tracking.

## 🚀 Starter Code

**`App.js`**

```js
import React, { useState, useEffect } from "react";
import DeploySimulator from "./DeploySimulator";
import DeployHistory from "./DeployHistory";

export default function App() {
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // TODO: load history from localStorage
  }, []);

  function handleDeployed(address) {
    // TODO: append { address, timestamp: Date.now() } to state & localStorage
  }

  return (
    <div>
      <h2>Contract Deployment Simulator</h2>
      <DeploySimulator onDeployed={handleDeployed} />
      <h4>Deploy History</h4>
      <DeployHistory history={history} />
    </div>
  );
}
```

## ✅ To Do List

- [ ] On mount, read `localStorage.getItem("deployHistory")` and parse JSON.
- [ ] In `handleDeployed`, update state and write back to `localStorage`.
- [ ] Pass history array to `DeployHistory`.

## 🎯 Full Solution

```js
// App.js
import React, { useState, useEffect } from "react";
import DeploySimulator from "./DeploySimulator";
import DeployHistory from "./DeployHistory";

const STORAGE_KEY = "deployHistory";

export default function App() {
  const [history, setHistory] = useState([]);

  useEffect(() => {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved) {
      setHistory(JSON.parse(saved));
    }
  }, []);

  function handleDeployed(address) {
    const entry = { address, timestamp: Date.now() };
    const updated = [entry, ...history];
    setHistory(updated);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
  }

  return (
    <div style={{ padding: 24, fontFamily: "sans-serif" }}>
      <h2>Contract Deployment Simulator</h2>
      <DeploySimulator onDeployed={handleDeployed} />
      <h4>Deploy History</h4>
      <DeployHistory history={history} />
    </div>
  );
}
```
