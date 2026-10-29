# Token Tracker Activity

**What you will build:** a `TokenTracker` component that reads an ERC-20 token's name, symbol and decimals as soon as it loads, then shows *your* balance in human numbers (2.5, not 2500000000000000000) when you click a button.

## Initial Code

This is the starter in your editor. The token address is handed to your component as the `tokenAddress` prop, so you never type it in yourself.

```js
// TokenTracker.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTracker({ tokenAddress }) {
  const [info, setInfo] = useState({ name: "", symbol: "", decimals: 0 });
  const [balance, setBalance] = useState("");
  const [account, setAccount] = useState("");

  useEffect(() => {
    // TODO: Task 1 - Bail out unless tokenAddress is a valid address, then build
    //                a read-only provider and contract
    // TODO: Task 2 - Read name(), symbol() and decimals() and store them
  }, [tokenAddress]);

  const fetchBalance = async () => {
    // TODO: Task 3 - Connect the wallet, read balanceOf(user), and format the
    //                raw value using the token's decimals
  };

  return (
    <div>
      <h2>Token Information</h2>
      {/* TODO: Task 4 - Show name, symbol, decimals, a Fetch button and balance */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 25 minutes**

## Tasks for Learners

Topics Covered: ERC-20 metadata (`name`, `symbol`, `decimals`), address validation with `ethers.isAddress`, `Promise.all`, `ethers.formatUnits`, ethers v6 providers

> **Where does the RPC URL come from?** The grader supplies `process.env.REACT_APP_RPC_URL` for you (a Sepolia endpoint). Use exactly that name. In your own Vite project you would write `import.meta.env.VITE_RPC_URL` instead; see the lesson material.

---

### Task 1: Guard the address, then build a read-only provider and contract

`useEffect` cannot take an `async` function directly, so define one inside it (`fetchTokenInfo`) and call it at the bottom. The very first thing it does is check the address: a malformed address only reverts, so there is no point asking the chain.

```js
useEffect(() => {
  const fetchTokenInfo = async () => {
    // Task 1: A malformed address would make every read revert, so check first.
    if (!ethers.isAddress(tokenAddress)) return;

    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const contract = new ethers.Contract(tokenAddress, ABI, provider);

    // Task 2 goes here
  };

  if (tokenAddress) {
    fetchTokenInfo();
  }
}, [tokenAddress]);
```

- `ethers.isAddress` (v6) replaces the old `ethers.utils.isAddress` (v5). <!-- v5-ok -->
- `ethers.JsonRpcProvider` is read-only: no wallet, no gas, no pop-up.

---

### Task 2: Read name, symbol and decimals in one go

Replace the `// Task 2 goes here` line with three reads sent together through `Promise.all`, then store them:

```js
    // Task 2: One round trip instead of three sequential ones.
    const [name, symbol, decimals] = await Promise.all([
      contract.name(),
      contract.symbol(),
      contract.decimals(),
    ]);

    setInfo({ name, symbol, decimals });
```

In ethers v6, `decimals()` comes back as a `bigint` (`18n`), not a plain number. That is fine: `formatUnits` in Task 3 accepts it directly.

---

### Task 3: Fetch the connected wallet's balance

Fill in `fetchBalance`. Ask MetaMask for the account, read `balanceOf(user)`, then turn the raw integer into a human number with the decimals you stored in Task 2.

```js
const fetchBalance = async () => {
  try {
    const [user] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    setAccount(user);

    const provider = new ethers.BrowserProvider(window.ethereum);
    const contract = new ethers.Contract(tokenAddress, ABI, provider);

    // balanceOf returns the raw integer; decimals turns it back into a
    // human number. 2500000000000000000 with 18 decimals is 2.5, not 2.5e18.
    const rawBalance = await contract.balanceOf(user);
    const formatted = ethers.formatUnits(rawBalance, info.decimals);
    setBalance(`${formatted} ${info.symbol}`);
  } catch (err) {
    console.error("Error fetching balance:", err);
  }
};
```

- `ethers.BrowserProvider` (v6) wraps MetaMask's `window.ethereum`. It replaces v5's `ethers.providers.Web3Provider`. <!-- v5-ok -->
- `ethers.formatUnits` (v6) replaces `ethers.utils.formatUnits`. <!-- v5-ok -->
- Prefer `const signer = await provider.getSigner()` and `await signer.getAddress()`? That also works: `getSigner()` sends the same `eth_requestAccounts` request to MetaMask, which is what the grader looks for.

---

### Task 4: Show the token, a Fetch button, and the balance

Replace the `{/* TODO: Task 4 ... */}` comment **and** the `<p>Placeholder</p>` line with this:

```jsx
      <p>Name: {info.name || "Loading..."}</p>
      <p>Symbol: {info.symbol || "Loading..."}</p>
      <p>Decimals: {info.decimals}</p>
      <hr />
      <button onClick={fetchBalance}>Fetch My Balance</button>
      {balance && <p>Your Balance: {balance}</p>}
```

The `<h2>Token Information</h2>` heading above it stays as it is.

---

> **Graded details: labels and wording are checked.** The hidden test is strict about these, so copy them exactly:
>
> - The button's text must contain the word **`Fetch`** (the test clicks "Fetch"). `Fetch My Balance` works; `Check Balance` does not.
> - The token's **name and symbol must appear on screen** after loading (the test fixture is a token called `Barangay Peso`, symbol `BPSO`).
> - With an **invalid address**, `name()` must **never be called**: the `ethers.isAddress` guard must run before any read.
> - Clicking Fetch must send **`eth_requestAccounts`** (directly, or through `provider.getSigner()`) and then call **`balanceOf`**.
> - The balance must be **formatted**: the test's raw balance is `2500000000000000000` with 18 decimals, so the screen must show `2.5`, and the raw integer must **never** appear.

### Common mistakes

- Writing `ethers.utils.isAddress` or `ethers.providers.Web3Provider`: those are ethers v5 and do not exist in v6, so the whole component crashes. <!-- v5-ok -->
- Leaving `<p>Placeholder</p>` in place is harmless, but forgetting to render `info.name` and `info.symbol` fails Task 4.
- Showing `rawBalance.toString()` instead of `formatted`: you will see `2500000000000000000` and fail the formatting check.

---

## Breakdown of the Activity

**Variables Defined:**

- `info`: the token's metadata: `name` (like "Barangay Peso"), `symbol` (like "BPSO"), and `decimals` (precision, usually `18n`). Read once on mount, and again whenever `tokenAddress` changes.
- `balance`: a ready-to-display string such as `"2.5 BPSO"`.
- `account`: the wallet address MetaMask returned when you clicked Fetch.
- `ABI`: the four ERC-20 functions we call, written in ethers' human-readable ABI format.

**Key Functions:**

- `fetchTokenInfo` (inside `useEffect`): validates the address, builds a read-only `JsonRpcProvider` and a contract, then reads `name()`, `symbol()` and `decimals()` in parallel with `Promise.all`. Three requests in flight at once beat three waits in a row.
- `fetchBalance`: runs when the user clicks. It asks MetaMask for the account with `eth_requestAccounts`, reads `balanceOf(user)` as a raw `bigint` (for example `2500000000000000000n`), and converts it with `formatUnits(rawBalance, decimals)` into `"2.5"`, which is joined with the symbol for display.
