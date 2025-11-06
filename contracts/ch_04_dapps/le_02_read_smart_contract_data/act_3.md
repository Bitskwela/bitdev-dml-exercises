# Token URI Lookup activity:

```js
// TokenURI.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function TokenURI() {
  const [id, setId] = useState(0);
  const [uri, setUri] = useState("");
  const fetchUri = async () => {
    // TODO
  };
  return (
    <div>
      <input
        type="number"
        value={id}
        onChange={(e) => setId(+e.target.value)}
      />
      <button onClick={fetchUri}>Fetch URI</button>
      {uri && <p>{uri}</p>}
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA_KEY
REACT_APP_CONTRACT_ADDRESS=0xYourSimpleNFTAddress
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Dynamic contract calls, error handling, user input validation, mapping access

- Update the `TokenURI` component to:

  - Validate that the input ID is within valid range (0 <= id < totalMinted).
  - Call `contract.tokenURIs(id)` to fetch the URI for a specific token ID.
  - Update `uri` state with the result.
  - Handle errors gracefully (invalid ID or RPC errors) with user-friendly alerts.

  ```js
  const fetchUri = async () => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );
    try {
      const result = await contract.tokenURIs(id);
      setUri(result);
    } catch (err) {
      alert("Invalid ID or RPC error");
    }
  };
  ```
