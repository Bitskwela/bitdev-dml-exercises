# MetaMask Detection activity:

```js
// DetectWallet.js - Starter Code
export default function DetectWallet() {
  return (
    <div>
      {/* TODO: Detect window.ethereum */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: MetaMask detection, window.ethereum API, conditional rendering

- Update the `DetectWallet` component to:

  - Check if MetaMask is installed by detecting `window.ethereum`.
  - Show "Install MetaMask" prompt when no wallet is installed.
  - Render "Wallet detected!" if MetaMask is available.

  ```js
  export default function DetectWallet() {
    const hasWallet = Boolean(window.ethereum);
    return (
      <div>
        {hasWallet ? (
          <p>Wallet detected! 🦊</p>
        ) : (
          <p>Please install MetaMask to continue.</p>
        )}
      </div>
    );
  }
  ```
