# Cast Vote Transaction activity:

```js
// CastVote.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    // TODO: implement write transaction
  };

  return (
    <div>
      <select onChange={(e) => setSelected(e.target.value)}>
        {proposals.map((p) => (
          <option key={p}>{p}</option>
        ))}
      </select>
      <button onClick={castVote} disabled={status === "pending"}>
        {status === "pending" ? "Voting…" : "Vote"}
      </button>
      {status && <p>{status}</p>}
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=http://localhost:8545
REACT_APP_CONTRACT_ADDRESS=0xYourDeployedAddress
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Web3Provider, transaction signing, gas management, error handling, UI state management

- Update the `CastVote` component to:

  - Check `window.ethereum` availability and alert if MetaMask is not installed.
  - Request accounts using `eth_requestAccounts` method.
  - Create `Web3Provider` with signer to enable transaction sending.
  - Call `contract.vote(selected, { gasLimit: 100_000 })` and handle pending state.
  - Await transaction confirmation with `tx.wait()` and update status accordingly.
  - Implement comprehensive error handling for transaction failures.

  ```js
  const castVote = async () => {
    if (!window.ethereum) {
      alert("Please install MetaMask");
      return;
    }
    try {
      setStatus("pending");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = web3Provider.getSigner();
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );
      const tx = await contract.vote(selected, { gasLimit: 100_000 });
      console.log("Tx Hash:", tx.hash);
      await tx.wait();
      setStatus("confirmed ✅");
      onVoted();
    } catch (err) {
      console.error(err);
      setStatus("error: " + (err.data?.message || err.message));
    }
  };
  ```
