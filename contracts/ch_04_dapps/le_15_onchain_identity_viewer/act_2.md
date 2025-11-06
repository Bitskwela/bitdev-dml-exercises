# Activity 2: ProfileSearch — Lookup Any Address

**Time**: 10 minutes  
**Goal**: Create `ProfileSearch` that lets users input an Ethereum address, validates it, and displays that user's on-chain profile using the same logic as `ProfileViewer`.

## Background

Building on the ProfileViewer from Activity 1, this component adds search functionality to lookup any Ethereum address's on-chain profile, enabling users to explore other identities on the network.

## Starter Code

Create `ProfileSearch.js`:

```javascript
import React, { useState } from "react";
import ProfileViewer from "./ProfileViewer"; // reuse logic

export default function ProfileSearch() {
  const [input, setInput] = useState("");
  const [query, setQuery] = useState("");

  function onSearch() {
    // TODO: validate input with ethers.utils.isAddress
    // TODO: setQuery(input) to pass to ProfileLookup
  }

  return (
    <div>
      <h3>Search On-Chain Profile</h3>
      <input
        value={input}
        onChange={(e) => setInput(e.target.value)}
        placeholder="Enter Ethereum address"
      />
      <button onClick={onSearch}>Lookup</button>
      {query && <ProfileViewer address={query} />}
    </div>
  );
}
```

## To Do List

- [ ] Import `ethers.utils.isAddress` and validate `input`
- [ ] On valid search, pass `query` to a modified `ProfileViewer` that accepts `address` prop
- [ ] Handle invalid input with error message
- [ ] Reuse ProfileViewer component logic for consistency

## Key Concepts

- **Address Validation**: Using ethers.js to verify Ethereum address format
- **Component Reusability**: Leveraging existing ProfileViewer with props
- **User Input Handling**: Managing search state and validation flow
- **Conditional Rendering**: Showing results only after successful validation

## Full Solution

```javascript
// ProfileSearch.js
import React, { useState } from "react";
import { ethers } from "ethers";
import ProfileViewer from "./ProfileViewer";

export default function ProfileSearch() {
  const [input, setInput] = useState("");
  const [query, setQuery] = useState("");
  const [error, setError] = useState("");

  function onSearch() {
    setError("");
    if (!ethers.utils.isAddress(input)) {
      setError("Invalid Ethereum address");
      return;
    }
    setQuery(input);
  }

  return (
    <div>
      <h3>Search On-Chain Profile</h3>
      <input
        style={{ width: "300px" }}
        placeholder="0x…"
        value={input}
        onChange={(e) => setInput(e.target.value)}
      />
      <button onClick={onSearch}>Lookup</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
      {query && <ProfileViewer address={query} />}
    </div>
  );
}
```
