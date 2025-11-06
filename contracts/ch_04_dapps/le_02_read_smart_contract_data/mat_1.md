## 🧑‍💻 Background Story

Odessa squished into the LRT car, earbuds in, phone buzzing with a DM from a California startup founder: “Show me you can fetch NFT metadata on‐chain.” Her heart raced—this was her ticket to proving she wasn’t just another “crypto tourist.”

Moments earlier, at a Quiapo co‐working space, she’d deployed a simple ERC-721 contract on Goerli, minting a handful of “QuiapoArt” tokens with unique URIs, each pointing to Pinoy‐inspired artwork. Now, as the train rattled past church bells and sari–sari stores, she sketched out a React UI: display the contract’s name, symbol, total minted count, plus a lookup field to fetch a token’s URI.

With every clack of the rails, Odessa pieced together Ethers.js calls: `contract.name()`, `contract.symbol()`, `contract.totalMinted()`, `contract.tokenURIs(id)`. By the time she reached Ascencion Station, her read‐only interface was live—pulling real Goerli data into her browser. She tapped “Get Token URI” and watched the IPFS link appear.

That evening, Odessa dialed into the Zoom pitch. As the founder saw “QuiapoArt (QART) – Total Minted: 5” and a live URI field, he leaned in: “Impressive, you really know your stuff.” Odessa closed her eyes, smiling at Manila’s skyline in her laptop wallpaper. From LRT to VC approval—she’d nailed it.

Welcome to **Read‐Only DApps**. Next up: writing transactions to mint and transfer. But tonight, she basks in fetch‐only glory. 🇵🇭🚆💥

---

## 📚 Theory & Web3 Lecture

### 1. DApp Architecture

- **React Frontend**: Hooks manage state & lifecycle.
- **Ethers.js**: Connect via JSON-RPC provider to call `view` functions (no gas).
- **Pre-deployed NFT Contract**: Exposes public getters:  
  • name() → string  
  • symbol() → string  
  • totalMinted() → uint256  
  • tokenURIs(uint256) → string

### 2. Provider & Contract Setup

1. Install Ethers.js
   ```bash
   npm install ethers
   ```
2. `.env` variables
   ```bash
   REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA_KEY
   REACT_APP_CONTRACT_ADDRESS=0xYourSimpleNFTAddress
   ```
3. Instantiate provider & contract

   ```js
   import { ethers } from "ethers";
   import abi from "./abi/SimpleNFT.json";

   const provider = new ethers.providers.JsonRpcProvider(
     process.env.REACT_APP_RPC_URL
   );
   const contract = new ethers.Contract(
     process.env.REACT_APP_CONTRACT_ADDRESS,
     abi,
     provider
   );
   ```

### 3. Fetching Data in React

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/SimpleNFT.json";

export default function NFTReader() {
  const [name, setName] = useState("");
  const [symbol, setSymbol] = useState("");
  const [total, setTotal] = useState(0);
  const [tokenId, setTokenId] = useState(0);
  const [uri, setUri] = useState("");

  useEffect(() => {
    async function load() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );
        const [n, s, t] = await Promise.all([
          contract.name(),
          contract.symbol(),
          contract.totalMinted(),
        ]);
        setName(n);
        setSymbol(s);
        setTotal(t.toNumber());
      } catch (err) {
        console.error("Error loading contract data:", err);
      }
    }
    load();
  }, []);

  const fetchTokenURI = async () => {
    try {
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );
      const fetched = await contract.tokenURIs(tokenId);
      setUri(fetched);
    } catch (err) {
      console.error("Error fetching token URI:", err);
      alert("Failed to fetch URI");
    }
  };

  return (
    <div style={{ padding: 20 }}>
      <h2>
        {name} ({symbol})
      </h2>
      <p>Total Minted: {total}</p>
      <input
        type="number"
        min="0"
        max={total - 1}
        value={tokenId}
        onChange={(e) => setTokenId(Number(e.target.value))}
      />
      <button onClick={fetchTokenURI}>Get Token URI</button>
      {uri && <p>URI: {uri}</p>}
    </div>
  );
}
```

### 4. Security & Best Practices

- **Validate** `tokenId` within `[0, totalMinted-1]`.
- **Debounce** input changes if you call on each keystroke.
- Wrap RPC calls in `try/catch` and surface errors.
- Never commit your `.env`—use `.gitignore`.

External Docs

- Ethers.js: https://docs.ethers.org
- ERC-721 Spec: https://eips.ethereum.org/EIPS/eip-721

---

## ✅ Test Cases

```js
// __tests__/NFTReader.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import NFTReader from "../components/NFTReader";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  const fake = {
    name: jest.fn().mockResolvedValue("QuiapoArt"),
    symbol: jest.fn().mockResolvedValue("QART"),
    totalMinted: jest.fn().mockResolvedValue(original.BigNumber.from(5)),
    tokenURIs: jest.fn((id) => Promise.resolve(`https://ipfs.io/${id}.json`)),
  };
  return {
    ...original,
    ethers: {
      ...original.ethers,
      providers: { JsonRpcProvider: jest.fn(() => ({})) },
      Contract: jest.fn(() => fake),
    },
  };
});

test("renders name, symbol, total", async () => {
  render(<NFTReader />);
  await waitFor(() => {
    expect(screen.getByText(/QuiapoArt/)).toBeInTheDocument();
    expect(screen.getByText(/QART/)).toBeInTheDocument();
    expect(screen.getByText(/Total Minted: 5/)).toBeInTheDocument();
  });
});

test("fetches tokenURI on click", async () => {
  render(<NFTReader />);
  await waitFor(() => screen.getByText(/Total Minted: 5/));
  fireEvent.change(screen.getByRole("spinbutton"), { target: { value: "3" } });
  fireEvent.click(screen.getByText(/Get Token URI/));
  await waitFor(() => {
    expect(screen.getByText("URI: https://ipfs.io/3.json")).toBeInTheDocument();
  });
});
```

---

## 🌟 Closing Story

Later that night, Odessa replayed her Zoom pitch, watching the founder’s jaws drop as live Goerli data populated her UI. She’d bridged Manila’s LRT chaos and Silicon Valley’s expectations with a few Ethers.js calls.

Tomorrow, she’ll write to the contract—mint new NFTs, transfer ownership, and power genuine Web3 interactions. From read‐only glory to full DApp mastery, Odessa’s Philippine spirit is unstoppable. Next stop: **Write Transactions & Gas Management**! 🚀🪙✨
