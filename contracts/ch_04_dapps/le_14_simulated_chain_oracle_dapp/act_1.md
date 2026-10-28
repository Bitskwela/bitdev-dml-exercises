# Display Typhoon Relief Stats Activity

**Goal:** read two values the oracle has written on-chain (`windSpeed()` and `released()`) plus the relief pool's ETH balance, and show them so a barangay captain can see at a glance whether the funds have gone out.

After Typhoon Ulysses, Det and Neri's relief contract holds donations until the reported wind speed crosses a threshold. The stats panel is the part everyone watches: donors, the barangay, and the oracle operator alike.

## Initial Code

This is the starter file you will edit (`ReliefStats.jsx`):

```jsx
// ReliefStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      // TODO: Task 1 - Connect the wallet and build the contract
      // TODO: Task 2 - Read windSpeed() and released() together
      // TODO: Task 3 - Read the pool's ETH balance from the provider and format it
    }
    loadStats();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, then wind speed,
  //                pool balance, and whether funds were dispatched
  return <p>Placeholder</p>;
}
```

`CONTRACT` is the relief contract's address, provided by the environment variable `REACT_APP_RELIEF_ADDRESS`. The contract *is* the pool: donations sit in its own ETH balance.

**Time Allotment: 25 minutes**

## Tasks for Learners

Topics Covered: `ethers.BrowserProvider` (ethers v6), `Promise.all` for parallel reads, `provider.getBalance`, `ethers.formatEther`, rendering a status from a `bool`.

Tasks 1, 2 and 3 all go **inside** `loadStats()`, in place of its three TODO lines, inside one `try`/`catch`. Task 4 replaces the `return <p>Placeholder</p>;` line.

> **Why connect a wallet here?** These three reads are public, and a `JsonRpcProvider` could do them (as in the Gas Fee Checker lesson). The relief app, though, also has **Donate** and **Oracle Feed** widgets that send transactions, and those need MetaMask. This panel connects through the same `BrowserProvider` so the whole app uses one wallet connection.

---

### Task 1: Connect the wallet and build the contract

Open a `try` block (you close it in Task 3). Ask MetaMask for access, wrap it in a v6 `BrowserProvider`, and build a read-only contract on that provider:

```jsx
try {
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.BrowserProvider(window.ethereum);
  const relief = new ethers.Contract(CONTRACT, ABI, provider);
```

---

### Task 2: Read `windSpeed()` and `released()` together

The two reads do not depend on each other, so start both at once with `Promise.all` and wait for both. The results come back in the same order you asked:

```jsx
  const [ws, rel] = await Promise.all([
    relief.windSpeed(),
    relief.released(),
  ]);
```

`ws` is a `bigint` (for example `185n`) and `rel` is a plain `true` or `false`.

---

### Task 3: Read the pool's ETH balance and format it

ETH held by a contract is **chain state**, not a contract variable, so you ask the **provider**, passing the **contract's** address (`CONTRACT`), not the user's wallet. Then store all three values and close the `try`:

```jsx
  const bal = await provider.getBalance(CONTRACT);

  setWind(Number(ws));
  setReleased(rel);
  setBalance(ethers.formatEther(bal));
} catch (err) {
  setError(err.message);
}
```

- `Number(ws)` is safe because a wind speed is a small number.
- `ethers.formatEther(3250000000000000000n)` gives `"3.25"`.

After Tasks 1 to 3, your whole `loadStats()` should look exactly like this:

```jsx
async function loadStats() {
  try {
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const relief = new ethers.Contract(CONTRACT, ABI, provider);

    const [ws, rel] = await Promise.all([
      relief.windSpeed(),
      relief.released(),
    ]);
    const bal = await provider.getBalance(CONTRACT);

    setWind(Number(ws));
    setReleased(rel);
    setBalance(ethers.formatEther(bal));
  } catch (err) {
    setError(err.message);
  }
}
```

---

### Task 4: Render the error, the loading state, and the three stats

Replace `return <p>Placeholder</p>;` with this. The release status is computed **from the `released` flag**, so it changes when the chain changes:

```jsx
if (error) return <p style={{ color: "red" }}>{error}</p>;
if (wind === null) return <p>Loading relief stats…</p>;
return (
  <div>
    <h3>Typhoon Relief Chain Stats</h3>
    <p>
      Wind Speed: <strong>{wind}</strong> km/h
    </p>
    <p>
      Pool Balance: <strong>{balance}</strong> ETH
    </p>
    <p>
      Released:{" "}
      <strong>{released ? "✅ Funds Dispatched" : "❌ Pending"}</strong>
    </p>
  </div>
);
```

---

> **Graded details: labels and wording are checked.** In the hidden test the contract reports a wind speed of `185`, `released()` is `true`, and the pool holds `3250000000000000000` wei. The test checks:
>
> - You call both `windSpeed()` and `released()`.
> - You call `provider.getBalance(...)` with the **relief contract's address** (`CONTRACT`). Asking for the user's own wallet balance fails.
> - `185` appears on the page.
> - The balance shows in **ether**: `3.25` must appear, and the raw wei `3250000000000000000` must **not**.
> - The page contains the word `dispatched` or `released` (any capitalisation).
> - Because `released()` is `true`, **nothing** on the page may still say `Pending`, `not released`, `not yet dispatched` or `hindi pa`. A status hardcoded as "Released: Pending" fails. Render it from the flag with `released ? … : …`.
> - **Writing the status in Filipino?** Keep the word `Dispatched` (or the `Released:` label) in the text, for example `✅ Funds Dispatched (naipadala na)`, and never use "Hindi pa" for the released case.

## Common Mistakes

- **Reading the wrong balance.** `provider.getBalance(await signer.getAddress())` shows *your* wallet, not the pool. Pass `CONTRACT`.
- **Hardcoding the status.** Text that always says "Pending" (or always says "Dispatched") ignores the chain. Use the `released` state.
- **Showing raw wei.** `{bal.toString()}` puts 19 digits on screen and fails. Use `ethers.formatEther`.
- **Using ethers v5 syntax.** This course runs ethers v6: `ethers.BrowserProvider`, `provider.getBalance`, and `ethers.formatEther` directly on `ethers`.

## Breakdown of the Activity

**Variables Defined:**

- `wind`: wind speed in km/h as a regular number. Starts as `null`, which signals loading.
- `balance`: the pool's balance as a formatted ether string, such as `"3.25"`.
- `released`: whether the contract has already sent the pool to the barangay.
- `error`: an error message, empty when everything is fine.
- `provider` / `relief`: the v6 `BrowserProvider` and the relief contract built on it.

**Key Functions:**

- `Promise.all([...])`: starts several independent reads at once and waits for all of them, which is faster than awaiting them one by one.
- `provider.getBalance(address)`: returns the ETH balance (in wei, as a `bigint`) of any address, including a contract.
- `ethers.formatEther(value)`: converts wei into a readable ether string.
