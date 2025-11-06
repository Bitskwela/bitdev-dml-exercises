# Verify Signature On-Chain activity:

```solidity
// SignatureVerifier.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SignatureVerifier {
    function verifySignature(
        string memory message,
        bytes memory signature,
        address expectedSigner
    ) public pure returns (bool) {
        bytes32 messageHash = keccak256(abi.encodePacked(message));
        bytes32 ethSignedMessageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)
        );

        address recoveredSigner = recoverSigner(ethSignedMessageHash, signature);
        return recoveredSigner == expectedSigner;
    }

    function recoverSigner(bytes32 hash, bytes memory signature)
        internal pure returns (address) {
        require(signature.length == 65, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        return ecrecover(hash, v, r, s);
    }
}
```

```js
// SignatureVerifier.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/SignatureVerifier.json";

export default function SignatureVerifier() {
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [signer, setSigner] = useState("");
  const [isValid, setIsValid] = useState(null);

  const verifyOnChain = async () => {
    // TODO: call contract to verify signature
  };

  return (
    <div>
      <input
        placeholder="Message"
        value={message}
        onChange={(e) => setMessage(e.target.value)}
      />
      <input
        placeholder="Signature"
        value={signature}
        onChange={(e) => setSignature(e.target.value)}
      />
      <input
        placeholder="Expected Signer Address"
        value={signer}
        onChange={(e) => setSigner(e.target.value)}
      />
      <button onClick={verifyOnChain}>Verify Signature</button>
      {isValid !== null && (
        <p>Signature is: {isValid ? "✅ Valid" : "❌ Invalid"}</p>
      )}
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA
REACT_APP_VERIFIER_ADDRESS=0xYourVerifierAddress
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: On-chain signature verification, contract interaction, ECDSA recovery, message hashing

- Update the `SignatureVerifier` component to:

  - Create provider and contract instance for the SignatureVerifier contract.
  - Call the `verifySignature()` function with message, signature, and expected signer.
  - Handle the contract call response to determine if signature is valid.
  - Display verification result in a user-friendly format.
  - Implement error handling for invalid inputs or contract call failures.

  ```js
  const verifyOnChain = async () => {
    try {
      if (!message || !signature || !signer) {
        alert("Please fill all fields");
        return;
      }

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_VERIFIER_ADDRESS,
        abi,
        provider
      );

      const result = await contract.verifySignature(message, signature, signer);
      setIsValid(result);
    } catch (err) {
      console.error("Verification failed:", err);
      alert("Verification failed");
      setIsValid(false);
    }
  };
  ```
