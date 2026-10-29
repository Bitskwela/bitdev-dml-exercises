# Read Smart Contract Data Activity

Odessa's founder wants proof she can pull NFT data straight from the chain. In this activity you build `NFTReader`: on load it reads the collection's name, symbol and total minted, and a **Get Token URI** button looks up one token's metadata link.

**What you will learn:** how to read from a smart contract with ethers v6, using a read-only `JsonRpcProvider` (no wallet needed) and an `ethers.Contract`, and how to handle the `bigint` that a `uint256` comes back as.

## Initial Code

This is the starter that opens in your editor. The comment on line 1 says `.js`, but the file you are editing is `NFTReader.jsx`.

```js
// NFTReader.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NFTReader() {
  const [info, setInfo] = useState({ name: "", symbol: "", total: 0 });
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");

  useEffect(() => {
    // TODO: Task 1 - Read name(), symbol() and totalMinted() from the contract
    // @note Build a read-only JsonRpcProvider, then an ethers.Contract, then
    //       store the three values in `info`. totalMinted() returns a bigint.
  }, []);

  const fetchTokenURI = async () => {
    // TODO: Task 2 - Read tokenURIs(tokenId) and store it in `uri`
  };

  return (
    <div>
      {/* TODO: Task 3 - Show the name, symbol, total, and the fetched URI */}
      <p>Placeholder</p>
    </div>
  );
}
```

The editor already provides the two settings you need: `process.env.REACT_APP_RPC_URL` (a Sepolia RPC URL) and `process.env.REACT_APP_CONTRACT_ADDRESS`. The ABI file `../abi/SimpleNFT.json` is provided too.

**Time Allotment: 25 minutes**

## Tasks for Learners

Topics Covered: `ethers.JsonRpcProvider`, `ethers.Contract`, view function calls, `Promise.all`, bigint conversion, React state

This lesson uses **ethers v6**. If you have seen `ethers.providers.JsonRpcProvider` or `.toNumber()` elsewhere, that is version 5 and will fail here. <!-- v5-ok -->

---

### Task 1: Read the Contract's Name, Symbol and Total on Mount

Replace the Task 1 `TODO` inside `useEffect` with an async function that builds a provider and a contract, reads three values in parallel, and stores them:

```js
async function fetchInfo() {
  // Read-only work needs no wallet, so a JsonRpcProvider is enough.
  const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
  const contract = new ethers.Contract(
    process.env.REACT_APP_CONTRACT_ADDRESS,
    abi,
    provider
  );

  const [name, symbol, total] = await Promise.all([
    contract.name(),
    contract.symbol(),
    contract.totalMinted(),
  ]);

  // uint256 arrives as a native bigint in ethers v6.
  setInfo({ name, symbol, total: Number(total) });
}
fetchInfo();
```

- `useEffect` cannot itself be `async`, which is why you define `fetchInfo` inside it and call it straight away.
- You **must** use `new ethers.JsonRpcProvider(...)`. The grader checks for it, because reading public data should never demand a wallet.
- `totalMinted()` returns a bigint such as `3n`. `Number(total)` turns it into `3`. If you store the bigint as it is, it can show up on screen as `3n`, and the grader rejects that.

---

### Task 2: Implement the `fetchTokenURI` Function

Replace the body of `fetchTokenURI`. Check the range **first**, then read the URI:

```js
const fetchTokenURI = async () => {
  if (tokenId < 0 || tokenId >= info.total) {
    alert(`Please enter a token ID between 0 and ${info.total - 1}`);
    return;
  }

  try {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const fetchedUri = await contract.tokenURIs(tokenId);
    setUri(fetchedUri);
  } catch (error) {
    console.error("Error fetching token URI:", error);
    alert("Failed to fetch URI. The token might not exist.");
  }
};
```

- If 3 tokens were minted, the valid IDs are `0`, `1` and `2`. For anything else, you must tell the user (the `alert` does that) and `return` **before** calling `tokenURIs`. The grader types `5`, clicks the button, and fails you if `tokenURIs` was called anyway. This range check is graded under the Task 3 heading, but it lives in this function.
- Building the provider and contract again here is fine. You could also create them once at the top of the file, outside the component. Both pass.

---

### Task 3: Render the Values

Replace the whole `return (...)` block (including `<p>Placeholder</p>`) with:

```js
return (
  <div>
    <h1>{info.name || "Loading..."}</h1>
    <h3>{info.symbol || "Loading..."}</h3>
    <p>Total Minted: {info.total}</p>
    <input
      type="number"
      value={tokenId}
      onChange={(e) => setTokenId(Number(e.target.value))}
    />
    <button onClick={fetchTokenURI}>Get Token URI</button>
    {uri && <p>URI: {uri}</p>}
  </div>
);
```

- `Number(e.target.value)` matters. An input always gives you text, and comparing the text `"5"` with a number is a bug waiting to happen.
- `{uri && ...}` shows the URI line only after one has been fetched.

> **Graded details: labels and wording are checked.**
>
> - On mount, your component must call `contract.name()`, `contract.symbol()` and `contract.totalMinted()`, and build a `new ethers.JsonRpcProvider(...)`.
> - The rendered page must contain the name, the symbol and the total (`Sining Chain`, `SNG` and `3` in the test contract), and must **not** contain `3n`.
> - The button label must contain **Get Token URI**. The grader clicks it by that text.
> - Clicking it with a valid ID must call `contract.tokenURIs(...)` and render the returned URI (`ipfs://QmSiningTokenTwo` in the test).
> - The token-ID field must be an `<input>` with an `onChange`, and it must be the first input on the page. The grader types `5` into it. With 3 tokens minted, it then expects **no** `tokenURIs` call and some feedback, either an `alert` or a change in what the page shows.

---

## Common Mistakes

- **v5 syntax:** `ethers.providers.JsonRpcProvider` and `total.toNumber()` fail on ethers v6. Use `ethers.JsonRpcProvider` and `Number(total)`. <!-- v5-ok -->
- **Checking the range after the call.** The check must come before `contract.tokenURIs(...)`, or the grader sees the call.
- **Renaming the button** to something like "Look up". The grader clicks the text `Get Token URI`.
- **Making the `useEffect` callback itself `async`.** React expects the effect to return nothing or a cleanup function, not a Promise. Use an inner `async function`.

---

## Breakdown of the Activity

**Variables Defined:**

- `info`: A state object holding the contract's `name` (the collection name), `symbol` (the ticker, like "QART") and `total` (how many NFTs were minted, as a normal number). It is filled once when the component mounts.

- `tokenId`: The token the user wants to look up. It is passed to `contract.tokenURIs()`.

- `uri`: The metadata URI fetched for that token. It usually points to IPFS, where the image and attributes live.

- `provider`: A `JsonRpcProvider` connected to an RPC URL. It can read from the chain without a wallet.

- `contract`: An `ethers.Contract` for the deployed `SimpleNFT`, built from its address, its ABI and the provider. Each ABI function becomes a JavaScript method on it.

**Key Functions:**

- `fetchInfo` (inside `useEffect`):
  Runs once on mount. It builds a provider and contract, then uses `Promise.all` to fetch `name()`, `symbol()` and `totalMinted()` at the same time. It converts the bigint total with `Number()` before storing it.

- `fetchTokenURI`:
  Runs when the user clicks **Get Token URI**. It refuses an ID outside `0` to `total - 1` before touching the network. If the ID is valid, it calls `tokenURIs(tokenId)` and stores the result. The `try/catch` turns a failed call into a friendly message.
