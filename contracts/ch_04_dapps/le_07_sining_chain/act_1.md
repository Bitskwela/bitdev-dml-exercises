# SiningChain NFT Gallery Activity

**What you will build:** an `NFTGallery` component that (1) loads one NFT by its token ID and (2) lists every NFT your wallet owns, turning each token's `ipfs://` metadata link into a web address the browser can actually fetch.

## Initial Code

This is the starter in your editor. The contract address and RPC URL are already read from the environment for you as `CONTRACT_ADDRESS` and `RPC_URL`.

```js
// NFTGallery.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function tokenURI(uint256) view returns (string)",
  "function balanceOf(address) view returns (uint256)",
  "function tokenOfOwnerByIndex(address, uint256) view returns (uint256)",
  "function ownerOf(uint256) view returns (address)",
];

const CONTRACT_ADDRESS = process.env.REACT_APP_CONTRACT_ADDRESS;
const RPC_URL = process.env.REACT_APP_RPC_URL;

const convertToHttpUrl = (uri) => {
  // TODO: Task 1 - Turn an ipfs:// URI into an https gateway URL
  return uri;
};

export default function NFTGallery() {
  const [tokenId, setTokenId] = useState("");
  const [nft, setNft] = useState(null);
  const [ownedNFTs, setOwnedNFTs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchSingleNFT = async () => {
    // TODO: Task 2 - Read tokenURI(tokenId), fetch the metadata JSON, and store
    //                its name, description and image
  };

  const fetchOwnedNFTs = async () => {
    // TODO: Task 3 - Connect the wallet, read balanceOf(account), then walk
    //                tokenOfOwnerByIndex + tokenURI to build the collection
  };

  return (
    <div>
      <h2>SiningChain NFT Gallery</h2>
      {/* TODO: Task 4 - Token ID input, Load NFT button, My Collection button,
          the single NFT card, and the owned grid */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 40 minutes**

## Tasks for Learners

Topics Covered: ERC-721 `tokenURI`, IPFS gateways, fetching JSON metadata, `balanceOf` + `tokenOfOwnerByIndex` (ERC-721 Enumerable), empty states, ethers v6 providers

This one is longer than the last few lessons: two fetch flows plus a page layout. Take it task by task.

---

### Task 1: Convert IPFS links to the ipfs.io gateway

A browser cannot open `ipfs://QmSomething`. It needs an `https://` address served by an IPFS **gateway**. Replace the whole `convertToHttpUrl` helper with this version:

```js
// Helper function to convert IPFS URLs
const convertToHttpUrl = (uri) => {
  if (!uri) return "/placeholder.png";
  if (uri.startsWith("http")) return uri;
  if (uri.startsWith("ipfs://")) {
    return uri.replace("ipfs://", "https://ipfs.io/ipfs/");
  }
  if (uri.startsWith("Qm") || uri.startsWith("bafy")) {
    return `https://ipfs.io/ipfs/${uri}`;
  }
  return uri;
};
```

- **Required gateway: `https://ipfs.io/ipfs/`.** Other gateways (dweb.link, Pinata) work in real life, but the grader's offline copy of the metadata only answers ipfs.io addresses.
- It also passes through links that are already `http(s)`, and accepts bare CIDs (`Qm...` or `bafy...`).

---

### Task 2: Load a single NFT by token ID

Fill in `fetchSingleNFT`. Reading `tokenURI` needs no wallet, so use a read-only `JsonRpcProvider`. Then fetch the JSON that the URI points to and keep three fields.

```js
const fetchSingleNFT = async () => {
  try {
    setLoading(true);
    setError("");
    setNft(null);

    const provider = new ethers.JsonRpcProvider(RPC_URL);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

    const uri = await contract.tokenURI(tokenId);
    const httpUri = convertToHttpUrl(uri);
    const response = await fetch(httpUri);
    const metadata = await response.json();

    setNft({
      name: metadata.name,
      description: metadata.description,
      image: convertToHttpUrl(metadata.image),
    });
  } catch (err) {
    setError("Failed to load NFT: " + err.message);
  } finally {
    setLoading(false);
  }
};
```

Notice `convertToHttpUrl` runs **twice**: once on the token URI (to fetch the JSON) and once on `metadata.image` (which is usually another `ipfs://` link).

---

### Task 3: Load every NFT the wallet owns

Fill in `fetchOwnedNFTs`. Ask MetaMask for the account, read how many tokens it owns with `balanceOf`, then loop: `tokenOfOwnerByIndex(account, i)` gives the i-th token ID, and you load its metadata exactly as in Task 2.

```js
const fetchOwnedNFTs = async () => {
  try {
    setLoading(true);
    setError("");
    setOwnedNFTs([]);

    const [account] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });

    const provider = new ethers.BrowserProvider(window.ethereum);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

    const balance = await contract.balanceOf(account);
    const items = [];

    for (let i = 0; i < balance; i++) {
      const tokenId = await contract.tokenOfOwnerByIndex(account, i);
      const uri = await contract.tokenURI(tokenId);
      const httpUri = convertToHttpUrl(uri);
      const response = await fetch(httpUri);
      const metadata = await response.json();

      items.push({
        tokenId: tokenId.toString(),
        name: metadata.name,
        image: convertToHttpUrl(metadata.image),
      });
    }

    setOwnedNFTs(items);
  } catch (err) {
    setError("Failed to load collection: " + err.message);
  } finally {
    setLoading(false);
  }
};
```

- In ethers v6, `balance` is a `bigint` (for example `2n`). JavaScript can compare a normal number with a bigint, so `i < balance` works as you would expect.
- `ethers.BrowserProvider` (v6) replaces v5's `ethers.providers.Web3Provider`. <!-- v5-ok -->

---

### Task 4: Build the page

Replace the `<h2>`, the `{/* TODO: Task 4 ... */}` comment and `<p>Placeholder</p>`, that is, **everything inside the outer `<div>`**, with this:

```jsx
      <h2>🎨 SiningChain NFT Gallery</h2>

      {/* Single NFT Viewer */}
      <div>
        <h3>View Single NFT</h3>
        <input
          type="number"
          placeholder="Token ID"
          value={tokenId}
          onChange={(e) => setTokenId(e.target.value)}
        />
        <button onClick={fetchSingleNFT} disabled={loading}>
          Load NFT
        </button>
        {nft && (
          <div>
            <img src={nft.image} alt={nft.name} style={{ maxWidth: 300 }} />
            <h4>{nft.name}</h4>
            <p>{nft.description}</p>
          </div>
        )}
      </div>

      {/* Owned NFTs Gallery */}
      <div>
        <h3>My Collection</h3>
        <button onClick={fetchOwnedNFTs} disabled={loading}>
          Load My NFTs
        </button>
        {ownedNFTs.length === 0 && !loading && <p>No NFTs found.</p>}
        <div style={{ display: "flex", gap: 16, flexWrap: "wrap" }}>
          {ownedNFTs.map((item, i) => (
            <div key={i} style={{ border: "1px solid #ccc", padding: 8 }}>
              <img src={item.image} alt={item.name} style={{ width: 150 }} />
              <p>{item.name}</p>
            </div>
          ))}
        </div>
      </div>

      {loading && <p>Loading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
```

`disabled={loading}` stops a second click while a load is still running.

---

> **Graded details: labels and wording are checked.** The hidden test is strict about these, so copy them exactly:
>
> - The Token ID **`<input>` must be the first input on the page** (the test types `1` into the first input it finds).
> - Button labels: **`Load NFT`** for the single viewer and **`Load My NFTs`** for the collection.
> - The metadata must be fetched from an address starting with **`https://ipfs.io/ipfs/`** (Task 1).
> - After Load NFT, the NFT's **name must appear on screen** (the test's token is called `Sarimanok sa Umaga`).
> - After Load My NFTs, **`balanceOf` must be read and `tokenOfOwnerByIndex` called once per token** (the test wallet owns 2), and **both names** (`Sarimanok sa Umaga`, `Jeepney Barok`) must appear.
> - **Empty state:** before anything is loaded, the page must say the collection is empty, such as **`No NFTs found.`** A heading like "My Collection" alone does not count. Wording the grader accepts includes "No NFTs", "No tokens", "Nothing to show", "Empty" or "Wala pa".

### Common mistakes

- Fetching the `ipfs://` URI directly. `fetch("ipfs://...")` fails; always pass it through `convertToHttpUrl` first.
- Using `cloudflare-ipfs.com`: Cloudflare retired that public gateway in 2024, so links to it no longer load.
- Forgetting the second `convertToHttpUrl` on `metadata.image`, which gives you a broken picture.
- Writing `ethers.providers.JsonRpcProvider`: that is ethers v5 and crashes in v6. <!-- v5-ok -->

---

## Breakdown of the Activity

**Variables Defined:**

- `tokenId`: what the user typed into the Token ID box; passed to `tokenURI()`.
- `nft`: the single NFT being shown (`name`, `description`, `image`), or `null` when nothing is loaded.
- `ownedNFTs`: the wallet's collection, one `{ tokenId, name, image }` per token. Empty until Load My NFTs runs.
- `loading` / `error`: drive the "Loading..." line, the disabled buttons and the red error message.
- `ABI`: the ERC-721 functions we call: `tokenURI` for metadata, `balanceOf` for how many, `tokenOfOwnerByIndex` for which ones, and `ownerOf` (not used here, handy for later).

**Key Functions:**

- `convertToHttpUrl`: normalises `ipfs://` links and bare CIDs into `https://ipfs.io/ipfs/...` addresses, and leaves `http(s)` links alone.
- `fetchSingleNFT`: read-only provider, `tokenURI(tokenId)`, fetch the JSON, show name, description and image.
- `fetchOwnedNFTs`: connects the wallet, reads `balanceOf(account)`, then loops `tokenOfOwnerByIndex(account, i)` to find each token ID and loads its metadata. `tokenOfOwnerByIndex` only exists on contracts that use the **ERC-721 Enumerable** extension, which SiningChain does.
