# Read Smart Contract Data Activity

## Initial Code


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
    // TODO: Fetch contract metadata
  }, []);

  const fetchTokenURI = async () => {
    // TODO: Implement token URI lookup
  };

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
}
```



**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: Provider instantiation, contract instance creation, view function calls, `Promise.all`, BigNumber conversion, React state management

---

### Task 1: Create Provider and Contract Instance

Inside the `useEffect`, create a `JsonRpcProvider` using the RPC URL from environment variables, then instantiate the contract using the contract address, ABI, and provider.

```js
const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);

const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  abi,
  provider
);
```

---

### Task 2: Fetch Contract Metadata Using `Promise.all`

Complete the `useEffect` to fetch the contract's `name`, `symbol`, and `totalMinted` values in parallel using `Promise.all`. Update the `info` state with the fetched data. Remember to convert `totalMinted` from BigNumber to a regular number.

```js
useEffect(() => {
  async function fetchInfo() {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
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

    setInfo({ name, symbol, total: total.toNumber() });
  }
  fetchInfo();
}, []);
```

---

### Task 3: Implement the `fetchTokenURI` Function

Complete the `fetchTokenURI` function to look up a token's metadata URI based on the `tokenId` state. Include input validation to ensure the token ID is within the valid range before making the blockchain call.

```js
const fetchTokenURI = async () => {
  if (tokenId < 0 || tokenId >= info.total) {
    alert(`Please enter a token ID between 0 and ${info.total - 1}`);
    return;
  }

  try {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
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

---


## Breakdown of the Activity

**Variables Defined:**

- `info`: A React state object that holds the contract's metadata including `name` (the NFT collection name), `symbol` (the ticker symbol like "QART"), and `total` (the number of NFTs minted). This data is fetched once when the component mounts.

- `tokenId`: A state variable that stores the user's input for which token they want to look up. Used as a parameter when calling `contract.tokenURIs()`.

- `uri`: A state variable that stores the fetched metadata URI for a specific token. This typically points to an IPFS link containing the NFT's metadata (image, attributes, etc.).

- `provider`: A `JsonRpcProvider` instance that establishes a connection to the Ethereum network via an RPC URL (like Infura or Alchemy). This is required for making read-only calls to the blockchain without needing a wallet.

- `contract`: An Ethers.js contract instance that represents the deployed `SimpleNFT` smart contract. Created using the contract address, ABI, and provider. This object exposes all the contract's public functions as JavaScript methods.

**Key Functions:**

- `fetchInfo` (inside useEffect):
  An async function that runs when the component mounts. It creates a provider and contract instance, then uses `Promise.all` to fetch `name()`, `symbol()`, and `totalMinted()` in parallel for better performance. The `totalMinted` value is converted from BigNumber to a regular JavaScript number using `.toNumber()` before storing in state. Using `Promise.all` is more efficient than sequential calls because all three RPC requests happen simultaneously.

- `fetchTokenURI`:
  An async function triggered when the user clicks "Get Token URI". It first validates that the `tokenId` is within the valid range (0 to total-1) to prevent unnecessary blockchain calls. If valid, it creates a contract instance and calls `tokenURIs(tokenId)` to fetch the metadata URI for that specific token. The function includes try-catch error handling to gracefully handle scenarios where the token doesn't exist or network errors occur.
