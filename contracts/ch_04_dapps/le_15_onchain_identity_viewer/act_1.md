# ProfileViewer — Show Your On-Chain Profile Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=http://127.0.0.1:8545
// REACT_APP_IDENTITY_ADDRESS=0xYourChainKilalaAddress

// ProfileViewer.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProfile(address) view returns (string,string,uint256)",
  "function getCredential(address,uint256) view returns (string)",
  "event ProfileUpdated(address indexed user)",
];

export default function ProfileViewer() {
  const [addr, setAddr] = useState("");
  const [name, setName] = useState("");
  const [status, setStatus] = useState("");
  const [creds, setCreds] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    async function load() {
      try {
        // TODO: Implement profile loading
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
    return () => {};
  }, [addr]);

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
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: MetaMask accounts, struct return values, loop fetching, event listeners, cleanup

---

### Task 1: Connect MetaMask and Get User Address

Request account access from MetaMask and store the connected wallet address. Create a provider and contract instance for reading profile data.

```js
const accounts = await window.ethereum.request({
  method: "eth_requestAccounts",
});
const userAddress = accounts[0];
setAddr(userAddress);

const provider = new ethers.providers.Web3Provider(window.ethereum);
const identity = new ethers.Contract(
  process.env.REACT_APP_IDENTITY_ADDRESS,
  ABI,
  provider
);
```

---

### Task 2: Fetch Profile Data and Parse Struct Return

Call `getProfile()` which returns a tuple (name, status, credCount). Destructure the return values and convert the credential count from `BigNumber` to a number.

```js
const [n, s, c] = await identity.getProfile(userAddress);
setName(n);
setStatus(s);
const credCount = c.toNumber();
```

---

### Task 3: Loop to Fetch All Credentials

Iterate through the credential count and fetch each credential by index. Build an array of credentials and update state.

```js
const credList = [];
for (let i = 0; i < credCount; i++) {
  const cred = await identity.getCredential(userAddress, i);
  credList.push(cred);
}
setCreds(credList);
```

---

### Task 4: Subscribe to ProfileUpdated Events (Bonus)

Listen for `ProfileUpdated` events to automatically reload the profile when changes occur. Remember to remove the listener on component unmount.

```js
const handleUpdate = (user) => {
  if (user.toLowerCase() === userAddress.toLowerCase()) {
    load(); // Re-fetch profile
  }
};
identity.on("ProfileUpdated", handleUpdate);

// Cleanup in useEffect return
return () => {
  identity.off("ProfileUpdated", handleUpdate);
};
```

---

## Breakdown of the Activity

**Variables Defined:**

- `addr`: The connected wallet address from MetaMask. Used as the key to fetch the user's profile from the contract.

- `name` / `status`: Profile fields returned from `getProfile()`. Stored as strings directly from the contract.

- `creds`: Array of credential strings fetched through indexed calls to `getCredential()`. Each credential is fetched individually.

- `credCount`: The number of credentials stored for this user. Returned as a `BigNumber` from the contract, converted with `.toNumber()`.

**Key Functions:**

- `getProfile(address)`:
  Returns a Solidity struct as a tuple. In ethers.js, struct returns are destructured as arrays: `const [name, status, count] = await contract.getProfile(addr)`.

- `getCredential(address, index)`:
  Fetches a single credential by index. Since Solidity doesn't support returning dynamic arrays of strings, we fetch each credential individually in a loop.

- `identity.on("EventName", callback)`:
  Subscribes to contract events. The callback receives event parameters. Use `identity.off()` to unsubscribe and prevent memory leaks.

- `accounts[0]`:
  The `eth_requestAccounts` method returns an array of connected addresses. The first element is typically the active/selected account in MetaMask.
