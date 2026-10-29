# Gas Fee Checker Activity

**Goal:** read one public number, the current base fee, from a deployed `GasTracker` contract with a read-only provider (no wallet), and show it on screen with a clear loading state and a clear error state.

Det's investors want to see a live number, not a mockup. Your job is the smallest honest version of her dashboard: one read, one label, and an error message when the read fails.

## Initial Code

This is the starter file you will edit (`GasStats.jsx`):

```jsx
// GasStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      // TODO: Task 1 - Create a read-only JsonRpcProvider
      // TODO: Task 2 - Create the contract instance
      // TODO: Task 3 - Read getBaseFee(), store it, and record any error
    }
    fetchBaseFee();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, and the fee
  return <p>Placeholder</p>;
}
```

Two values are already provided for you as environment variables, so you do not type any URL or address yourself:

- `process.env.REACT_APP_RPC_URL`: the Sepolia RPC endpoint.
- `process.env.REACT_APP_GAS_TRACKER_ADDRESS`: the deployed `GasTracker` contract.

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: `ethers.JsonRpcProvider` (ethers v6), read-only `ethers.Contract`, `bigint` values, loading and error states.

Tasks 1, 2 and 3 all go **inside** `fetchBaseFee()`, in place of its three TODO lines. Task 4 replaces the `return <p>Placeholder</p>;` line.

---

### Task 1: Create a read-only provider

The base fee is public data, so you do not need MetaMask. A `JsonRpcProvider` talks straight to an RPC node. Start a `try` block (you will close it in Task 3) and create the provider inside it:

```jsx
try {
  // Task 1: Create the provider instance
  const provider = new ethers.JsonRpcProvider(
    process.env.REACT_APP_RPC_URL
  );
```

In ethers v6 this is `ethers.JsonRpcProvider`, directly on `ethers`. There is no `providers.` in the middle.

---

### Task 2: Create the contract instance

Still inside the `try`, connect the ABI to the deployed address. Passing the **provider** (not a signer) makes this contract read-only:

```jsx
  // Task 2: Create the contract instance
  const contract = new ethers.Contract(
    process.env.REACT_APP_GAS_TRACKER_ADDRESS,
    ABI,
    provider
  );
```

---

### Task 3: Read the base fee, store it, and catch any error

Call `getBaseFee()`, save the result in state, then close the `try` with a `catch` that saves the error message. Without the `catch`, a failed read leaves `base` at `null` forever and the user stares at "Loading" with no explanation.

```jsx
  // Task 3: Fetch base fee and update state
  const fee = await contract.getBaseFee();
  setBase(fee);
} catch (err) {
  setError(err.message);
}
```

After Tasks 1 to 3, your whole `fetchBaseFee()` should look exactly like this:

```jsx
async function fetchBaseFee() {
  try {
    // Task 1: Create the provider instance
    const provider = new ethers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );

    // Task 2: Create the contract instance
    const contract = new ethers.Contract(
      process.env.REACT_APP_GAS_TRACKER_ADDRESS,
      ABI,
      provider
    );

    // Task 3: Fetch base fee and update state
    const fee = await contract.getBaseFee();
    setBase(fee);
  } catch (err) {
    setError(err.message);
  }
}
```

`fee` is a JavaScript `bigint` (for example `24000000000n`), not a regular number. It is in **wei**.

---

### Task 4: Render the error, the loading state, and the fee

Replace `return <p>Placeholder</p>;` with these three lines. The order matters: error first, then loading, then the value.

```jsx
if (error) return <p style={{ color: "red" }}>{error}</p>;
if (base === null) return <p>Loading base fee…</p>;
return <p>Current Base Fee: {base.toString()} wei</p>;
```

`base.toString()` turns the `bigint` into text such as `24000000000`. Showing gwei instead is also accepted, as long as the number is exact: `{ethers.formatUnits(base, "gwei")} gwei` renders `24.0 gwei`.

---

> **Graded details: labels and wording are checked.** The hidden test checks these exact things:
>
> - You create the provider with `new ethers.JsonRpcProvider(...)`. A `BrowserProvider` (wallet) does not count for this lesson.
> - You call `getBaseFee()` on the contract when the component mounts.
> - The page shows the exact fee the contract returned, either as raw wei (`24000000000`) or as gwei (`24`, `24.0` or `24.00`). A rounded or wrongly scaled number such as `2.4` or `240` fails.
> - The value carries a label: the text must contain `wei`, `gwei` or `fee`. A bare number fails.
> - Once the fee has arrived, the word `Loading` must be gone.
> - When `getBaseFee()` reverts, the page must **not** still say `Loading`, and it must show an error. Rendering `err.message` (which contains words like "reverted") is enough.

## Common Mistakes

- **Using ethers v5 syntax.** This course runs ethers v6. The v5 form with `providers.` in the middle is rejected by the grader. <!-- v5-ok -->
- **Forgetting the `catch`.** If the read fails, the test expects an error message, not an endless loading line.
- **Forgetting the unit.** `Current Base Fee: 24000000000` without `wei` still passes because of the word "fee", but a lone `24000000000` does not. Always say what the number is.
- **Dividing by hand.** `Number(base) / 1e9` works for small values but can lose digits; `ethers.formatUnits(base, "gwei")` is exact.

## Breakdown of the Activity

**Variables Defined:**

- `base`: state that holds the `bigint` returned by the contract. It starts as `null`, which is how the component knows it is still loading.
- `error`: state that holds an error message. It starts as an empty string, which counts as "no error".
- `provider`: an `ethers.JsonRpcProvider` connected to the RPC URL. Unlike `ethers.BrowserProvider`, it needs no browser wallet.
- `contract`: an `ethers.Contract` for the deployed `GasTracker`. The ABI tells ethers that `getBaseFee()` exists and returns a `uint256`.

**Key Functions:**

- `fetchBaseFee`: runs once on mount (the effect has an empty dependency array `[]`). It builds the provider and contract, reads `getBaseFee()`, and stores either the value or the error message.
- `base.toString()`: turns the `bigint` into a string for display. ethers v6 returns `bigint` for every `uint256` because regular JavaScript numbers lose precision above about 9 quadrillion, and wei values pass that easily.
