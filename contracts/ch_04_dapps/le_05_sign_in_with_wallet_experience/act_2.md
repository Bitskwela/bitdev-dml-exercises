# Sign Nonce Message activity:

```js
// MessageSigner.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";

export default function MessageSigner() {
  const [account, setAccount] = useState("");
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [nonce, setNonce] = useState("");

  const generateNonce = () => {
    const randomNonce = Math.random().toString(36).substring(2);
    setNonce(randomNonce);
    setMessage(`Sign in to our DApp. Nonce: ${randomNonce}`);
  };

  const signMessage = async () => {
    // TODO: sign the message with MetaMask
  };

  return (
    <div>
      <button onClick={generateNonce}>Generate Nonce</button>
      {message && (
        <div>
          <p>Message to sign: {message}</p>
          <button onClick={signMessage}>Sign Message</button>
        </div>
      )}
      {signature && (
        <div>
          <p>Signature: {signature}</p>
          <p>Signer: {account}</p>
        </div>
      )}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Message signing, personal_sign, nonce generation, Web3Provider

- Update the `MessageSigner` component to:

  - Connect to MetaMask using Web3Provider when signing.
  - Get the signer from the provider to access signing capabilities.
  - Use `signer.signMessage()` to create a cryptographic signature.
  - Handle the signing process and display both signature and signer address.
  - Implement proper error handling for signature rejection.

  ```js
  const signMessage = async () => {
    try {
      if (!window.ethereum) {
        alert("Please install MetaMask!");
        return;
      }

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();

      const signature = await signer.signMessage(message);
      const address = await signer.getAddress();

      setSignature(signature);
      setAccount(address);
    } catch (err) {
      console.error("Signing failed:", err);
      alert("Failed to sign message");
    }
  };
  ```
