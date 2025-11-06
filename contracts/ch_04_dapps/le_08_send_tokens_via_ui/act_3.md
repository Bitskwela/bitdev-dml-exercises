# Transfer Event Listener activity:

```js
// TransferEventListener.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/ERC20.json";

export default function TransferEventListener() {
  const [transfers, setTransfers] = useState([]);

  useEffect(() => {
    // TODO: listen to Transfer events
  }, []);

  return (
    <div>
      <h3>Recent Transfers</h3>
      <ul>
        {transfers.map((transfer, idx) => (
          <li key={idx}>
            From: {transfer.from} To: {transfer.to} Amount: {transfer.amount}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: ERC-20 Transfer events, real-time event listening, event argument parsing

- Update the `TransferEventListener` component to:
  - Subscribe to the `Transfer` event from the ERC-20 contract.
  - Parse event arguments (from, to, amount) when events are emitted.
  - Accumulate transfer events in component state for display.
  - Format amounts properly using token decimals.
