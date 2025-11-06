# Connect & Display Account activity:

```js
// ConnectButton.js - Starter Code
import { useState } from "react";
export default function ConnectButton() {
  const [acct, setAcct] = useState(null);
  const connect = async () => {
    // TODO: eth_requestAccounts
  };
  return <div>{acct || <button onClick={connect}>Connect</button>}</div>;
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Web3 account connection, eth_requestAccounts API, React state management

- Update the `ConnectButton` component to:

  - Add a "Connect" button that requests accounts and shows the first address.
  - Request accounts via `window.ethereum.request` with `eth_requestAccounts` method.
  - Update state with the returned address and handle user rejections gracefully.

  ```js
  import { useState } from "react";
  export default function ConnectButton() {
    const [acct, setAcct] = useState(null);
    const connect = async () => {
      if (!window.ethereum) return alert("Install MetaMask!");
      const [addr] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAcct(addr);
    };
    return (
      <div>
        {acct ? (
          <p>Account: {acct}</p>
        ) : (
          <button onClick={connect}>Connect</button>
        )}
      </div>
    );
  }
  ```
