# Activity 1: ProfileViewer — Show Your On-Chain Profile

**Time**: 10 minutes  
**Goal**: Build `ProfileViewer` that connects to MetaMask, fetches the current account's on-chain profile, and displays name, status, and all credentials in a list.

## Solidity Contract Baseline

Deploy this `ChainKilala.sol` contract first:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ChainKilala {
    struct Profile { string name; string status; uint256 credCount; }
    mapping(address => Profile) private profiles;
    mapping(address => mapping(uint256 => string)) private credentials;
    event ProfileUpdated(address indexed user);

    function setProfile(
        string calldata name,
        string calldata status,
        string[] calldata creds
    ) external {
        profiles[msg.sender] = Profile(name, status, creds.length);
        for (uint i = 0; i < creds.length; i++) {
            credentials[msg.sender][i] = creds[i];
        }
        emit ProfileUpdated(msg.sender);
    }

    function getProfile(address user)
        external view returns (string memory, string memory, uint256)
    {
        Profile memory p = profiles[user];
        return (p.name, p.status, p.credCount);
    }

    function getCredential(address user, uint256 idx)
        external view returns (string memory)
    {
        require(idx < profiles[user].credCount, "idx OOB");
        return credentials[user][idx];
    }
}
```

## Starter Code

Create `ProfileViewer.js`:

```javascript
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
        // 1. await window.ethereum.request(...)
        // 2. const provider = new ethers.providers.JsonRpcProvider(...)
        // 3. const identity = new ethers.Contract(address, ABI, provider)
        // 4. const [n, s, c] = await identity.getProfile(addr)
        // 5. loop i<c.toNumber(): await identity.getCredential(addr,i)
        // 6. setName, setStatus, setCreds
        // 7. identity.on("ProfileUpdated", ...) to re-call load()
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
    // cleanup on unmount
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

## To Do List

- [ ] Request accounts via `eth_requestAccounts`, set `addr`
- [ ] Instantiate `provider` & contract (`IDENTITY_ABI`, `IDENTITY_ADDRESS`)
- [ ] Call `getProfile(addr)` and parse results
- [ ] Loop to fetch each credential with `getCredential`
- [ ] Subscribe to `ProfileUpdated` events and reload on change

## Key Concepts

- **On-Chain Identity**: Storing user profiles and credentials on blockchain
- **Struct Handling**: Reading complex data structures from Solidity
- **Event Listening**: Real-time updates when profiles change
- **Loop Fetching**: Retrieving array-like data through indexed calls
