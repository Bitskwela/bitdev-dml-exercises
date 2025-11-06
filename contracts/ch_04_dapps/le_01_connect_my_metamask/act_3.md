# Listen to Account & Network Changes activity:

```js
// LiveConnector.js - Starter Code
import { useState, useEffect } from "react";
export default function LiveConnector() {
  const [acct, setAcct] = useState(null);
  const [chain, setChain] = useState(null);
  // TODO: useEffect for listeners
  const connect = async () => {
    /* same as before */
  };
  return <div>{/* display acct & chain */}</div>;
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Event listeners, useEffect hook, wallet state management, cleanup functions

- Update the `LiveConnector` component to:

  - Extend the connector to re-render when user switches accounts or networks.
  - In `useEffect`, bind to `accountsChanged` and `chainChanged` events.
  - Clean up listeners on unmount to prevent memory leaks.
  - Update `acct` and `chain` state accordingly when events are triggered.

  ```js
  import { useState, useEffect } from "react";
  export default function LiveConnector() {
    const [acct, setAcct] = useState(null);
    const [chain, setChain] = useState(null);

    useEffect(() => {
      if (!window.ethereum) return;

      const onAccountsChanged = (accounts) => {
        setAcct(accounts[0] || null);
      };

      const onChainChanged = (chainHex) => {
        setChain(chainHex);
      };

      window.ethereum.on("accountsChanged", onAccountsChanged);
      window.ethereum.on("chainChanged", onChainChanged);

      return () => {
        window.ethereum.removeListener("accountsChanged", onAccountsChanged);
        window.ethereum.removeListener("chainChanged", onChainChanged);
      };
    }, []);

    const connect = async () => {
      if (!window.ethereum) return alert("Install MetaMask!");
      const [addr] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAcct(addr);
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setChain(hex);
    };

    return (
      <div>
        {acct ? (
          <div>
            <p>Account: {acct}</p>
            <p>Network: {chain}</p>
          </div>
        ) : (
          <button onClick={connect}>Connect MetaMask 🦊</button>
        )}
      </div>
    );
  }
  ```
