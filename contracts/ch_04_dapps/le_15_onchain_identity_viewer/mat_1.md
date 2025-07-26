## 🧑‍💻 Background Story

In a sunlit hall at the Filipino Consulate in San Francisco, Odessa (“Det”) plugged her laptop into the projector. The banner read: **ChainKilala – Your On-Chain Identity, Dito Ka Kilala**. Filipino community leaders, students, and OFWs leaned forward. “Dito, ikaw ang profile mo,” Odessa smiled, unveiling a sleek UI that read on-chain profiles: name, status, and credentials—no centralized database needed.

Behind the scenes, Neri had deployed `ChainKilala.sol` on a Sepolia testnet and pre-registered profiles for several attendees. As each visitor connected MetaMask, the UI fetched their DID-style data: “Elias”, “Student”, credentials like “NBI Clear” or “OFW ID”. When profiles updated on-chain, a `ProfileUpdated` event fired and the browser refreshed automatically.

In under 30 minutes, Det had demonstrated decentralized identity to a room full of Pinoys far from home. No more paper forms at consulates—just code, wallets, and pride. After the demo, consulate officials asked about integration with PhilSys. Odessa grinned: “One step at a time. Next, we’ll bridge real-world IDs on-chain.” Mabuhay ChainKilala! 🇵🇭🆔🚀

---

## 📚 Theory & Web3 Lecture

1. DID-Style Profiles on-Chain

   - Store user profiles in a mapping: `mapping(address => Profile)`.
   - `struct Profile { string name; string status; uint256 credCount; }`
   - Credentials stored separately by index.

2. Solidity Contract Functions & Events

   - `function setProfile(string calldata name, string calldata status, string[] calldata creds) external`
   - `function getProfile(address user) external view returns (string name, string status, uint256 credCount)`
   - `function getCredential(address user, uint256 idx) external view returns (string cred)`
   - `event ProfileUpdated(address indexed user)` for frontend reactivity.

3. Ethers.js Integration

   - **Provider** (read-only):
     ```js
     const provider = new ethers.providers.JsonRpcProvider(
       process.env.REACT_APP_RPC_URL
     );
     ```
   - **Contract Instance**:
     ```js
     const identity = new ethers.Contract(
       process.env.REACT_APP_IDENTITY_ADDRESS,
       IDENTITY_ABI,
       provider
     );
     ```
   - **Reading Data**:
     ```js
     const [name, status, count] = await identity.getProfile(addr);
     const creds = [];
     for (let i = 0; i < count.toNumber(); i++) {
       creds.push(await identity.getCredential(addr, i));
     }
     ```
   - **Listening to Events**:
     ```js
     identity.on("ProfileUpdated", (user) => {
       if (user.toLowerCase() === addr.toLowerCase()) {
         // re-fetch profile
       }
     });
     ```

4. React Hooks & State

   - `useState` for `name`, `status`, `creds`, `loading`, `error`.
   - `useEffect` on mount (and on `selectedAddress`) to fetch data and subscribe to events.
   - Clean up listeners on unmount to prevent memory leaks.

5. Best Practices
   - Validate Ethereum addresses with `ethers.utils.isAddress()`.
   - Wrap on-chain calls in `try/catch` and show user-friendly messages.
   - Store `RPC_URL` & `IDENTITY_ADDRESS` in `.env`.
   - Keep UI responsive: show spinners while loading.

🔗 Further Reading

- Ethers.js: https://docs.ethers.org
- Solidity Events: https://docs.soliditylang.org
- DID Concepts: https://w3c.github.io/did-core

---

## 🧪 Exercises

### Exercise 1: ProfileViewer — Show Your On-Chain Profile

Problem Statement  
Build `ProfileViewer` that connects to MetaMask, fetches the current account’s on-chain profile, and displays name, status, and all credentials in a list.

**Solidity Contract (`ChainKilala.sol`)**

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

**Starter Code (`ProfileViewer.js`)**

```js
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

To Do List

- [ ] Request accounts via `eth_requestAccounts`, set `addr`
- [ ] Instantiate `provider` & contract (`IDENTITY_ABI`, `IDENTITY_ADDRESS`)
- [ ] Call `getProfile(addr)` and parse results
- [ ] Loop to fetch each credential with `getCredential`
- [ ] Subscribe to `ProfileUpdated` events and reload on change

**Full Solution**

```js
// ProfileViewer.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProfile(address) view returns (string,string,uint256)",
  "function getCredential(address,uint256) view returns (string)",
  "event ProfileUpdated(address indexed user)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_IDENTITY_ADDRESS;

export default function ProfileViewer() {
  const [addr, setAddr] = useState("");
  const [name, setName] = useState("");
  const [status, setStatus] = useState("");
  const [creds, setCreds] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    let identity;
    async function loadProfile(account) {
      try {
        setError("");
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        identity = new ethers.Contract(ADDR, ABI, provider);
        const [n, s, countBN] = await identity.getProfile(account);
        const count = countBN.toNumber();
        const arr = [];
        for (let i = 0; i < count; i++) {
          arr.push(await identity.getCredential(account, i));
        }
        setName(n);
        setStatus(s);
        setCreds(arr);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    async function init() {
      try {
        const [account] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setAddr(account);
        await loadProfile(account);
        identity.on("ProfileUpdated", (user) => {
          if (user.toLowerCase() === account.toLowerCase()) {
            loadProfile(account);
          }
        });
      } catch (err) {
        setError(err.message);
        setLoading(false);
      }
    }
    init();
    return () => {
      if (identity) identity.removeAllListeners("ProfileUpdated");
    };
  }, []);

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

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_IDENTITY_ADDRESS=0xYourChainKilalaAddress
```

---

### Exercise 2: ProfileSearch — Lookup Any Address

Problem Statement  
Create `ProfileSearch` that lets users input an Ethereum address, validates it, and displays that user’s on-chain profile using the same logic as `ProfileViewer`.

**Starter Code (`ProfileSearch.js`)**

```js
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

To Do List

- [ ] Import `ethers.utils.isAddress` and validate `input`.
- [ ] On valid search, pass `query` to a modified `ProfileViewer` that accepts `address` prop.
- [ ] Handle invalid input with error message.

**Full Solution**

```js
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

---

### Exercise 3: ProfileUpdated Listener Test

Problem Statement  
Write a test for `ProfileViewer` to ensure it re-fetches when `ProfileUpdated` fires for the current account.

**Test Suite (`__tests__/ProfileViewer.test.js`)**

```js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import ProfileViewer from "../ProfileViewer";
import { ethers } from "ethers";

jest.mock("ethers");

describe("ProfileViewer Component", () => {
  const fakeProvider = {};
  const fakeContract = {
    getProfile: jest.fn(),
    getCredential: jest.fn(),
    on: jest.fn(),
    removeAllListeners: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    // initial profile data
    fakeContract.getProfile.mockResolvedValue([
      "Alice",
      "Student",
      ethers.BigNumber.from("2"),
    ]);
    fakeContract.getCredential
      .mockResolvedValueOnce("NBI Clear")
      .mockResolvedValueOnce("PhilSys ID");
  });

  it("loads and displays profile", async () => {
    render(<ProfileViewer />);
    expect(await screen.findByText(/Name:/)).toHaveTextContent("Alice");
    expect(screen.getByText(/Status:/)).toHaveTextContent("Student");
    expect(screen.getByText("NBI Clear")).toBeInTheDocument();
    expect(screen.getByText("PhilSys ID")).toBeInTheDocument();
  });

  it("subscribes to ProfileUpdated event", async () => {
    render(<ProfileViewer />);
    await waitFor(() => {
      expect(fakeContract.on).toHaveBeenCalledWith(
        "ProfileUpdated",
        expect.any(Function)
      );
    });
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At the consulate, Odessa clicked on “Search” to show her mentor’s on-chain profile—“Juan dela Cruz”, “OFW”, credentials gleaming. The room buzzed: decentralized IDs for Pinoys worldwide. As cameras flashed, Odessa whispered, “Next up: on-chain auth and signed claims.” ChainKilala was only the beginning of the Philippine Web3 identity revolution. Mabuhay! 🇵🇭🆔🔥
