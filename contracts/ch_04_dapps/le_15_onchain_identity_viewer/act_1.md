# On-Chain Profile Viewer Activity

**Goal:** show the connected user's on-chain profile (name, status and every credential), and keep it fresh by reloading whenever the contract emits `ProfileUpdated`, with **exactly one** listener that is removed on cleanup.

At the consulate demo, Det's visitors connect MetaMask and expect to see their ChainKilala profile. When Neri updates a profile on-chain, the screen should catch up by itself, without stacking up listeners that reload the page twice, then four times, then eight.

## Initial Code

This is the starter file you will edit (`ProfileViewer.jsx`):

```jsx
// ProfileViewer.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProfile(address) view returns (string,string,uint256)",
  "function getCredential(address,uint256) view returns (string)",
  "event ProfileUpdated(address indexed user)",
];
const CONTRACT = process.env.REACT_APP_IDENTITY_ADDRESS;

export default function ProfileViewer() {
  const [addr, setAddr] = useState("");
  const [name, setName] = useState("");
  const [status, setStatus] = useState("");
  const [creds, setCreds] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    // TODO: Task 1 - Build the provider and the identity contract once, here,
    //                so load() and the listener share them
    let userAddress = "";

    async function load() {
      // TODO: Task 1 - Connect the wallet and remember the address
      // TODO: Task 2 - Read getProfile(address); it returns name, status and a
      //                credential count as a tuple
      // TODO: Task 3 - Read getCredential(address, i) for each credential
    }

    // TODO: Task 4 - Subscribe to ProfileUpdated ONCE, here and not inside
    //                load(), and call load() again when the event is ours

    load();

    // TODO: Task 4 - Return a cleanup that removes that same listener
  }, []);

  // TODO: Task 5 - Render loading, error, then the address, name, status and
  //                the credential list
  return <p>Placeholder</p>;
}
```

`CONTRACT` is the ChainKilala contract's address, from the environment variable `REACT_APP_IDENTITY_ADDRESS`.

**Time Allotment: 35 minutes**

## Tasks for Learners

Topics Covered: `ethers.BrowserProvider` (ethers v6), destructuring a three-value tuple, indexed reads in a loop, `contract.on` / `contract.off`, effect cleanup in React.

**The shape that matters.** The effect (dependency array `[]`, so it runs once on mount) does five things, in this order: build the provider and contract **once**; define `load()`, which only **reads**; subscribe to the event **once**; call `load()`; and return a cleanup. `load()` never subscribes. That is what keeps one event from triggering two reloads.

**Why a wallet?** The profile data itself is public, and any provider could read it. But this page shows **your** profile, so it asks MetaMask which address is yours.

---

### Task 1: Build the provider and contract once, then connect inside `load()`

**1a.** Replace the first TODO (the one above `let userAddress = "";`) with a MetaMask check and the provider and contract. Because they are created here, at the top of the effect, `load()` and the listener in Task 4 share the very same `identity` object:

```jsx
if (!window.ethereum) {
  setError("Please install MetaMask to view your profile.");
  setLoading(false);
  return;
}

// One provider, one contract and one listener for the life of the effect.
// load() only reads, so reloading on an event never adds another listener.
const provider = new ethers.BrowserProvider(window.ethereum);
const identity = new ethers.Contract(CONTRACT, ABI, provider);
```

Keep the starter's `let userAddress = "";` line right after it.

**1b.** Inside `load()`, open a `try` block (you close it in Task 3), ask for the account, and remember it in both the local variable and state:

```jsx
try {
  const accounts = await window.ethereum.request({
    method: "eth_requestAccounts",
  });
  userAddress = accounts[0];
  setAddr(userAddress);
```

---

### Task 2: Read `getProfile(address)`, a three-value tuple

Still inside the `try`. `getProfile` returns **three** values: name, status and how many credentials there are. Destructure all three:

```jsx
  const [n, s, c] = await identity.getProfile(userAddress);
  setName(n);
  setStatus(s);
```

`n` and `s` are strings; `c` is a `bigint` (for example `2n`).

---

### Task 3: Read each credential by index, then finish `load()`

Convert the count with `Number()` (it is small), read one credential per index, save the list, and close the `try`. The `finally` block runs whether the reads worked or failed, so loading always ends:

```jsx
  const credCount = Number(c);
  const credList = [];
  for (let i = 0; i < credCount; i++) {
    const cred = await identity.getCredential(userAddress, i);
    credList.push(cred);
  }
  setCreds(credList);
} catch (err) {
  setError(err.message);
} finally {
  setLoading(false);
}
```

After Tasks 1 to 3, your whole `load()` should look exactly like this:

```jsx
async function load() {
  try {
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    userAddress = accounts[0];
    setAddr(userAddress);

    const [n, s, c] = await identity.getProfile(userAddress);
    setName(n);
    setStatus(s);

    const credCount = Number(c);
    const credList = [];
    for (let i = 0; i < credCount; i++) {
      const cred = await identity.getCredential(userAddress, i);
      credList.push(cred);
    }
    setCreds(credList);
  } catch (err) {
    setError(err.message);
  } finally {
    setLoading(false);
  }
}
```

---

### Task 4: Subscribe to `ProfileUpdated` once, and clean up

**4a.** Replace the Task 4 subscribe TODO (between `load`'s closing brace and the `load();` call) with a named handler and **one** subscription. The handler reloads only when the event is about *this* user. Addresses can differ in capitalisation, so compare them lower-cased:

```jsx
// Task 4: subscribe once, here, not inside load() — subscribing inside it
// would add a listener on every reload, and each one reloads again.
function handleProfileUpdated(user) {
  if (userAddress && user.toLowerCase() === userAddress.toLowerCase()) {
    load();
  }
}
identity.on("ProfileUpdated", handleProfileUpdated);
```

Leave the starter's `load();` line where it is, right after this.

**4b.** Replace the last TODO in the effect with a cleanup **returned from the effect itself**. It removes the same handler, which is why the handler has a name:

```jsx
return () => {
  identity.off("ProfileUpdated", handleProfileUpdated);
};
```

This `return` belongs to the **effect**, not to `load()`. A `return` inside the async `load()` is just a value its promise resolves to; React never sees it, so the listener would never be removed.

After Tasks 1 to 4, the whole effect should look exactly like this:

```jsx
useEffect(() => {
  if (!window.ethereum) {
    setError("Please install MetaMask to view your profile.");
    setLoading(false);
    return;
  }

  // One provider, one contract and one listener for the life of the effect.
  // load() only reads, so reloading on an event never adds another listener.
  const provider = new ethers.BrowserProvider(window.ethereum);
  const identity = new ethers.Contract(CONTRACT, ABI, provider);
  let userAddress = "";

  async function load() {
    // ... exactly as shown after Task 3 ...
  }

  // Task 4: subscribe once, here, not inside load() — subscribing inside it
  // would add a listener on every reload, and each one reloads again.
  function handleProfileUpdated(user) {
    if (userAddress && user.toLowerCase() === userAddress.toLowerCase()) {
      load();
    }
  }
  identity.on("ProfileUpdated", handleProfileUpdated);

  load();

  return () => {
    identity.off("ProfileUpdated", handleProfileUpdated);
  };
}, []);
```

---

### Task 5: Render loading, error, then the profile

Replace `return <p>Placeholder</p>;` with this. Here loading is checked **first**, because `loading` starts as `true`:

```jsx
if (loading) return <p>Loading profile…</p>;
if (error) return <p style={{ color: "red" }}>{error}</p>;
return (
  <div>
    <h3>Your On-Chain Profile</h3>
    <p>
      <strong>Address:</strong> {addr}
    </p>
    <p>
      <strong>Name:</strong> {name}
    </p>
    <p>
      <strong>Status:</strong> {status}
    </p>
    <h4>Credentials</h4>
    <ul>
      {creds.map((c, i) => (
        <li key={i}>{c}</li>
      ))}
    </ul>
  </div>
);
```

---

> **Graded details: labels and wording are checked.** In the hidden test the connected account is `0x1234…7890`, its profile is `("Neri Gomez", "Barangay Kagawad", 2)`, and it has two credentials. The test checks:
>
> - You call `window.ethereum.request` with `eth_requestAccounts`.
> - You call `getProfile(...)` with the **connected address** (`accounts[0]`).
> - Both `Neri Gomez` and `Barangay Kagawad` appear, so destructure all three tuple values.
> - You call `getCredential` **exactly twice** (once per credential the profile reports), and both `BS Computer Science` and `Certified Solidity Developer` appear.
> - You subscribe to the event named exactly `"ProfileUpdated"` with `contract.on`.
> - After **two** `ProfileUpdated` events for this user, `getProfile` has been read **exactly 3 times** (mount plus one per event). Subscribing inside `load()` fails this: the second event would trigger two reloads.
> - When the component unmounts, your cleanup calls `contract.off`.
> - Once the profile has arrived, the word `Loading` is gone.

## Common Mistakes

- **Subscribing inside `load()`.** Every reload adds another listener, so reloads double with each event. Subscribe once in the effect body.
- **Returning the cleanup from `load()`.** React only runs a cleanup that the **effect** returns. Put the `return () => { identity.off(...) }` at the end of the effect.
- **Building a new contract for the cleanup.** `off` must be called on the **same** contract with the **same** handler you passed to `on`. Create `identity` once at the top of the effect.
- **Keeping only two of the three tuple values.** `const [n, s] = ...` loses the count, so Task 3 has nothing to loop over.
- **Using ethers v5 syntax.** This course runs ethers v6: `ethers.BrowserProvider`, and `Number(c)` to convert a `bigint`.

## Breakdown of the Activity

**Variables Defined:**

- `addr`, `name`, `status`, `creds`: state for the connected address and the profile fields.
- `loading`: starts `true` and is set to `false` in `finally`, after the reads succeed or fail.
- `error`: an error message, empty when everything is fine.
- `provider` / `identity`: created once per effect run, shared by `load()`, the handler and the cleanup.
- `userAddress`: a plain variable (not state) so the event handler can always see the latest connected address.

**Key Functions:**

- `load()`: connects, reads the profile tuple, reads each credential, and stores the results. It only reads; it never subscribes.
- `handleProfileUpdated(user)`: the event handler. Reloads only if the update is for the connected user.
- `identity.on(event, handler)` / `identity.off(event, handler)`: start and stop listening to a contract event in ethers v6. The same handler must be passed to both.
