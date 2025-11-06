# Activity 2: Build DeployHistory Component ⏱️ 10 mins

Implement `DeployHistory.js` that receives an array of deployed addresses and timestamps, and renders them in a list. Persist history in `localStorage` so it survives page reload.

## 📋 Contract Baseline

Using the same `HelloWorld.sol` contract from Activity 1, this component focuses on frontend history management and persistence.

## 🚀 Starter Code

**`DeployHistory.js`**

```js
import React from "react";

export default function DeployHistory({ history }) {
  // TODO: if history is empty, show "No deployments yet."
  // TODO: map history to <li> items: address and new Date(ts).toLocaleString()
  return <ul>{/* your list here */}</ul>;
}
```

## ✅ To Do List

- [ ] Handle empty `history` gracefully.
- [ ] Display each entry with address and readable date/time.
- [ ] Style entries in a scrollable box.

## 🎯 Full Solution

```js
// DeployHistory.js
import React from "react";

export default function DeployHistory({ history }) {
  if (!history.length) {
    return <p>No deployments yet.</p>;
  }
  return (
    <div style={{ maxHeight: 200, overflowY: "auto" }}>
      <ul>
        {history.map((h, i) => (
          <li key={i} style={{ marginBottom: 8 }}>
            <code>{h.address}</code>
            <br />
            <small>{new Date(h.timestamp).toLocaleString()}</small>
          </li>
        ))}
      </ul>
    </div>
  );
}
```
