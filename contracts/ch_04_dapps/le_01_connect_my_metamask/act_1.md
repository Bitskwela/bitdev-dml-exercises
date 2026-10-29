# MetaMask Wallet Connection Activity

Odessa's street-food dApp needs a front door. By the end of this activity your component will notice whether the visitor has MetaMask, offer a **Connect** button if they do, and show their address once they say yes.

**What you will learn:** how a React component detects a wallet, asks it for an account with `eth_requestAccounts`, and renders a different screen for each of the three states (no wallet, not connected, connected).

## Initial Code

This is the starter that opens in your editor. The comment on line 1 says `.js`, but the file you are editing is `WalletConnector.jsx`.

```js
// WalletConnector.js - Starter Code
import { useState } from "react";

export default function WalletConnector() {
  const [account, setAccount] = useState(null);

  // TODO: Task 1 - Detect MetaMask installation
  // @note Create a boolean variable that checks if window.ethereum exists

  const connectWallet = async () => {
    // TODO: Task 2 - Implement wallet connection logic
    // @note Check for MetaMask, request accounts, and store the connected address
  };

  return (
    <div>
      {/* TODO: Task 3 - Implement conditional rendering */}
      {/* @note Handle three states: no MetaMask, not connected, and connected */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: MetaMask detection, the `window.ethereum` object, `eth_requestAccounts`, React state, conditional rendering

You only need the code in the three tasks below. Each code block replaces the `// TODO` comment with the same task number in the starter. Nothing in this lesson uses ethers.js yet, so there is no `ethers` import to add.

---

### Task 1: Detect MetaMask Installation

MetaMask adds an object called `window.ethereum` to every page the browser opens. If it is there, a wallet is installed. Replace the Task 1 `TODO` with a boolean you can check while rendering:

```js
const hasWallet = Boolean(window.ethereum);
```

`Boolean(...)` turns "an object" or "undefined" into a plain `true` or `false`.

Graded under Task 1: when there is no wallet, the page must show a message containing the words **install** and **MetaMask**, in that order (the test checks `/install.*metamask/i`). You will render that message in Task 3, using `hasWallet`.

---

### Task 2: Implement the `connectWallet` Function

Replace the body of `connectWallet` so it asks MetaMask for an account and saves the first one:

```js
const connectWallet = async () => {
  if (!window.ethereum) return alert("Please install MetaMask!");

  try {
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    setAccount(accounts[0]);
  } catch (error) {
    console.error("User rejected wallet connection", error);
  }
};
```

- `eth_requestAccounts` is the method that opens the MetaMask popup. Use exactly this one. A similar method, `eth_accounts`, never opens the popup, so a visitor who has not connected before gets back an empty list.
- The call returns an array of addresses. `accounts[0]` is the account selected in MetaMask, and storing it in `account` re-renders the component.
- If the visitor clicks **Reject**, the promise throws. The `try/catch` keeps your app running.

---

### Task 3: Implement Conditional Rendering

Replace the whole `return (...)` block (including `<p>Placeholder</p>`) with three states:

- **No wallet installed:** the text `Please install MetaMask to continue.`
- **Wallet installed, not connected:** a `<button>` labelled `Connect MetaMask 🦊` that calls `connectWallet`.
- **Connected:** the text `Connected:` followed by the address.

```js
return (
  <div>
    {hasWallet ? (
      account ? (
        <p>Connected: {account}</p>
      ) : (
        <button onClick={connectWallet}>Connect MetaMask 🦊</button>
      )
    ) : (
      <p>Please install MetaMask to continue.</p>
    )}
  </div>
);
```

Read the nested ternary from the outside in. First the code checks whether there is a wallet, then whether there is an account.

> **Graded details: labels and wording are checked.**
>
> - With no wallet, the text must match `install ... MetaMask` (for example `Please install MetaMask to continue.`).
> - With a wallet and no account, there must be a `<button>` whose label contains the word **Connect**. The grader clicks the first button that contains `Connect`.
> - Clicking it must call `window.ethereum.request` with `method: "eth_requestAccounts"`.
> - After connecting, the full address (`0x1234...7890` in the test wallet) must appear on screen.
> - After connecting, no button labelled with the word "connect" may remain. A **Disconnect** button is fine, because "Disconnect" does not start with "connect". A leftover "Connect" button fails.

---

## Common Mistakes

- **Using `eth_accounts` instead of `eth_requestAccounts`.** It looks right but never asks the visitor, so the account list comes back empty.
- **Forgetting `await`.** Without it, `accounts` is a Promise and `accounts[0]` is `undefined`.
- **Keeping the Connect button visible after connecting.** The grader checks that it is gone.
- **Rewording the no-wallet message so it drops "install" or "MetaMask".** "Get a wallet first" reads fine to a person, but the grader looks for those two words.

---

## Breakdown of the Activity

**Variables Defined:**

- `account`: A React state variable that holds the connected wallet address. It starts as `null`, meaning not connected. After a successful connection it holds an address such as `0xAbC...123`.

- `hasWallet`: A boolean that is `true` when `window.ethereum` exists. MetaMask (and most other browser wallets) inject that object into the page.

**Key Functions:**

- `connectWallet`:
  An async function that starts the connection. It checks for MetaMask first, then calls `eth_requestAccounts`, which opens the MetaMask popup. If the visitor approves, it stores the first address in state. The `try/catch` handles a rejection, which is normal in Web3: the visitor can always say no.

- **Conditional Rendering Logic**:
  Two nested ternaries choose one of three screens: install MetaMask, Connect, or Connected. The visitor always sees the screen that matches their wallet's actual state.
