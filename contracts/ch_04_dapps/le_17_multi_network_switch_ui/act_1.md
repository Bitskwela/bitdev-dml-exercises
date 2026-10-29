# Network Detector Activity

**Goal:** detect which chain the user is on, show its chain id and a friendly name, and keep the display correct when they switch networks in their wallet.

Neri and Odessa's demo at DevCon Cebu broke the moment a judge's MetaMask was on the wrong network. This time you build `NetworkStats`, a small panel that always tells the truth about the current chain. It works with or without a wallet, and it updates live when the wallet switches.

## Initial Code

```js
// NetworkStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getChainId() view returns (uint256)"];
const RPC = process.env.REACT_APP_RPC_URL;
const CONTRACT = process.env.REACT_APP_NETWORK_DETECTOR;

// Live networks only (Sepolia, Hoodi, Polygon Amoy); the older Ethereum and
// Polygon testnets were shut down. Polygon's gas token is POL now, not MATIC.
const NAMES = {
  1: "Ethereum Mainnet",
  11155111: "Sepolia",
  560048: "Hoodi",
  137: "Polygon",
  80002: "Polygon Amoy",
};

export default function NetworkStats() {
  const [chainId, setChainId] = useState(null);
  const [chainName, setChainName] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    let provider, contract;

    async function loadChain() {
      // TODO: Task 1 - Use the wallet's provider when one is installed, and a
      //                read-only JsonRpcProvider when it is not
      // TODO: Task 2 - Read getChainId() and map it to a friendly name
    }

    // TODO: Task 3 - Handle the wallet's chainChanged event (its argument is a
    //                hex string) and update the display

    loadChain();

    // TODO: Task 3 - Subscribe to chainChanged, and return a cleanup that
    //                removes the listener

  }, []);

  // TODO: Task 4 - Render the error, the detecting state, then the chain id
  //                and its name
  return <p>Placeholder</p>;
}
```

**Time Allotment: 30 minutes**

> **Where do `RPC` and `CONTRACT` come from?** The grader supplies `process.env.REACT_APP_RPC_URL` (a Sepolia RPC) and `process.env.REACT_APP_NETWORK_DETECTOR` (the address of a tiny `NetworkDetector` contract whose `getChainId()` returns `block.chainid`). Leave those lines as they are. In a Vite project you would use `import.meta.env.VITE_...` instead.

## Tasks for Learners

Topics Covered: `ethers.BrowserProvider`, `ethers.JsonRpcProvider` fallback, reading the chain id, bigint to number, the `chainChanged` event, effect cleanup

The numbered tasks match the `TODO` comments in the starter. Task 3 has two `TODO` comments, one for the handler and one for the subscription.

---

### Task 1: Pick a provider (wallet first, read-only fallback)

If MetaMask (or another wallet) is installed, it puts an object at `window.ethereum`. Wrap it in `ethers.BrowserProvider` so you see the chain the **wallet** is on. If there is no wallet, fall back to a read-only `ethers.JsonRpcProvider(RPC)`, so the page still shows something instead of crashing.

Replace the two `TODO` lines inside `loadChain()` with this `try`/`catch`:

```js
async function loadChain() {
  try {
    // Task 1: Create provider based on wallet availability
    if (window.ethereum) {
      provider = new ethers.BrowserProvider(window.ethereum);
      await window.ethereum.request({ method: "eth_requestAccounts" });
    } else {
      provider = new ethers.JsonRpcProvider(RPC);
    }

    // Task 2 goes here
  } catch (err) {
    setError(err.message);
  }
}
```

Note that `provider` is assigned, not declared with `const`, because the starter already declares `let provider, contract;` at the top of the effect.

---

### Task 2: Read the chain id and map it to a name

Put this where it says `// Task 2 goes here`:

```js
// Task 2: Fetch chain ID and map to friendly name
contract = new ethers.Contract(CONTRACT, ABI, provider);
const idBN = await contract.getChainId();
const id = Number(idBN);
setChainId(id);
setChainName(NAMES[id] || "Unknown");
```

In ethers v6 a `uint256` comes back as a JavaScript `bigint` (`11155111n`). `Number(idBN)` converts it to a normal number, so it can be used as a key in `NAMES` and rendered as `11155111`. Any id that is not in the table shows as `"Unknown"`.

> **The more portable way.** This lesson's contract answers with `block.chainid`, but a contract only exists at its address on the chain where it was deployed. On a different network, that address is empty and the call fails. Asking the connection itself always works on any chain: `Number((await provider.getNetwork()).chainId)`, or `parseInt(await provider.send("eth_chainId", []), 16)`. The grader accepts any of these three reads, so either version passes. The lecture explains why the connection-based read is the one to prefer in real apps.

---

### Task 3: Follow the wallet when it switches network

When the user picks another network in MetaMask, the wallet fires a `chainChanged` event. Its argument is the new chain id as a **hex string**, such as `"0x89"`, not a number.

**First `TODO: Task 3`** (above `loadChain();`): define the handler.

```js
// Task 3: Define handler for chainChanged event
function handleChange(chainHex) {
  const id = parseInt(chainHex, 16);
  setChainId(id);
  setChainName(NAMES[id] || "Unknown");
}
```

`parseInt("0x89", 16)` is `137`, which is Polygon.

**Second `TODO: Task 3`** (below `loadChain();`): subscribe, and return a cleanup function. React calls the cleanup when the component unmounts. Without it, every remount would stack another listener.

```js
// Subscribe to chainChanged event
if (window.ethereum) {
  window.ethereum.on("chainChanged", handleChange);
}

// Cleanup listener on unmount
return () => {
  if (window.ethereum) {
    window.ethereum.removeListener("chainChanged", handleChange);
  }
};
```

---

### Task 4: Render the error, the detecting state, then the network

Replace the starter's `return <p>Placeholder</p>;` with:

```js
if (error) return <p style={{ color: "red" }}>{error}</p>;
if (chainId === null) return <p>Detecting network…</p>;

return (
  <div>
    <h3>Current Network</h3>
    <p>
      Chain ID: <strong>{chainId}</strong>
    </p>
    <p>
      Chain Name: <strong>{chainName}</strong>
    </p>
  </div>
);
```

---

> **Graded details: labels and wording are checked.** The grader runs your component twice, once with a wallet on Sepolia (`0xaa36a7`) and once with **no wallet at all**, and checks all of these:
>
> - With a wallet, it creates `new ethers.BrowserProvider(...)`.
> - With no wallet, it creates `new ethers.JsonRpcProvider(...)`. If you skip this branch, the no-wallet run fails.
> - It reads the chain id with `contract.getChainId()`, `provider.getNetwork()`, or an `eth_chainId` request.
> - The screen shows the number `11155111` **and** the name `Sepolia`. The grader reports this check under "Task 2", because it checks the values Task 2 produces, even though you write the markup in Task 4.
> - It subscribes with `window.ethereum.on("chainChanged", ...)`. The event name is case-sensitive.
> - After the grader fires `chainChanged` with `"0x89"`, the screen shows `Polygon`. Your handler must parse the hex string.
> - On unmount it calls `window.ethereum.removeListener(...)`.

## Common mistakes

| Mistake | What happens | Fix |
| ------- | ------------ | --- |
| `new ethers.providers.Web3Provider(...)` <!-- v5-ok --> | `TypeError` in ethers v6 <!-- v5-ok --> | `new ethers.BrowserProvider(window.ethereum)` |
| `idBN.toNumber()` <!-- v5-ok --> | `toNumber is not a function`: v6 returns a `bigint` <!-- v5-ok --> | `Number(idBN)` |
| `NAMES[idBN]` with the raw bigint | Works by accident for small ids, but is confusing | Convert with `Number()` first |
| `Number("0x89")` or `parseInt(chainHex)` without the radix | Wrong or `NaN` ids for some inputs | `parseInt(chainHex, 16)` |
| No `else` branch | Users without MetaMask get an error, and the no-wallet check fails | Fall back to `ethers.JsonRpcProvider(RPC)` |
| Cleanup not returned from the effect | Listeners pile up on every remount | `return () => window.ethereum.removeListener(...)` |

## Breakdown of the Activity

- **`BrowserProvider(window.ethereum)`** sees the network the user's wallet is connected to.
- **`JsonRpcProvider(RPC)`** is a fixed, read-only connection to one node. It is the fallback when no wallet exists.
- **`getChainId()`** returns `block.chainid` from the lesson's `NetworkDetector` contract, as a `bigint`.
- **`NAMES[id] || "Unknown"`** turns a number into something a human recognises. The table only lists live networks: Goerli and Mumbai have been shut down, and their replacements are Sepolia/Hoodi and Polygon Amoy. <!-- v5-ok -->
- **`chainChanged`** gives a hex string, so parse it with `parseInt(hex, 16)`.
- **The cleanup function** returned from `useEffect` unsubscribes, so listeners never stack up.
