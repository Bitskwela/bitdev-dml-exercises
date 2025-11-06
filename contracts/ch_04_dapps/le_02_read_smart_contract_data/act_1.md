# Name & Symbol Reader activity:

```solidity
// SimpleNFT.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleNFT {
    string public name = "QuiapoArt";
    string public symbol = "QART";
    uint256 public totalMinted;

    mapping(uint256 => string) public tokenURIs;

    function mint(string calldata uri) external {
        tokenURIs[totalMinted] = uri;
        totalMinted++;
    }
}
```

```js
// NameSymbol.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NameSymbol() {
  const [info, setInfo] = useState({ name: "", symbol: "" });
  useEffect(() => {
    // TODO
  }, []);
  return (
    <div>
      <h1>{info.name || "Loading..."}</h1>
      <h3>{info.symbol || "Loading..."}</h3>
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

Topics Covered: Contract instantiation, view function calls, Promise.all, React state management

- Update the `NameSymbol` component to:

  - Instantiate provider & contract using environment variables.
  - Call `contract.name()` and `contract.symbol()` to fetch contract metadata.
  - Update `info` state with the fetched name and symbol.
  - Handle async operations properly in useEffect.

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
      const [n, s] = await Promise.all([contract.name(), contract.symbol()]);
      setInfo({ name: n, symbol: s });
    }
    fetchInfo();
  }, []);
  ```
