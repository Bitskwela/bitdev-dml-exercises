## 🧑‍💻 Background Story

Under the neon glow of Tondo's mural walls, Odessa ("Det") met a spoken‐word poet named Lakan. He had powerful lines about hope and Manila's heartbeat—but no way to "own" them. Odessa grinned: "Kahit spoken word, pwedeng i-mint." Within an hour, she deployed a minimal `PoetNFT.sol` on her local Hardhat node. Then she scaffolded a React app with three widgets:

1. **Input Form** – Title, Description, and Image Upload (a snapshot of the poet's expression)
2. **NFT Preview** – Live preview of the metadata JSON and image
3. **Mint Button** – Calls `mintNFT(tokenURI)` on the contract and shows the minted Token ID

When Lakan uploaded his poem's cover art, typed "Tondo Sunrise" and "Lines of resilience…," the preview popped up like magic. A click on **Mint** simulated a real on-chain call. Ten seconds later, Token ID #1 appeared, with metadata viewable on the UI. Over gulaman at taho, Lakan raised his phone: "My poem as NFT—para sa future collectors!" Filipino creativity + Web3, one spoken line at a time. 🇵🇭🎤🪙

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build an **NFT minting UI** with live image preview and metadata generation. Users input title, description, and upload an image—then mint their creation as an ERC-721 token directly from the browser.

---

### 📐 NFT Minting Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    NFT MINTING FLOW                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    USER INPUT                            │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ Title: "Tondo Sunrise"                           │    │   │
│   │  │ Description: "Lines of resilience..."            │    │   │
│   │  │ Image: [sunrise.png] 📷                          │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                                ▼                                │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                  PREVIEW PANEL                           │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ ┌───────────────┐  {                            │    │   │
│   │  │ │               │    "name": "Tondo Sunrise",   │    │   │
│   │  │ │   🌅 Image    │    "description": "Lines...", │    │   │
│   │  │ │   Preview     │    "image": "data:image/..."  │    │   │
│   │  │ │               │  }                            │    │   │
│   │  │ └───────────────┘                               │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                         [Mint NFT]                              │
│                                │                                │
│   ┌────────────────────────────▼────────────────────────────┐   │
│   │                  BLOCKCHAIN                              │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ PoetNFT.mintNFT(tokenURI)                        │    │   │
│   │  │ ├── _tokenIds.increment()                        │    │   │
│   │  │ ├── _safeMint(msg.sender, tokenId)               │    │   │
│   │  │ ├── _setTokenURI(tokenId, tokenURI)              │    │   │
│   │  │ └── emit Minted(owner, tokenId, tokenURI)        │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   │                         │                                │   │
│   │                         ▼                                │   │
│   │            🎉 Token ID #42 Minted!                       │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. ERC-721 Token Standard

| Component | Description |
|-----------|-------------|
| `tokenId` | Unique identifier for each NFT (1, 2, 3...) |
| `tokenURI` | URL/URI pointing to metadata JSON |
| `ownerOf(tokenId)` | Returns address that owns the token |
| `balanceOf(owner)` | Returns count of NFTs owned |
| `transferFrom()` | Moves NFT between addresses |

#### 2. NFT Metadata Standard

The `tokenURI` should return JSON following this schema:

```json
{
    "name": "Tondo Sunrise",
    "description": "Lines of resilience from Manila's heartbeat",
    "image": "ipfs://QmXxx.../image.png",
    "attributes": [
        { "trait_type": "Artist", "value": "Lakan" },
        { "trait_type": "Year", "value": "2024" },
        { "trait_type": "Medium", "value": "Digital" }
    ]
}
```

#### 3. Token URI Options

| Method | Pros | Cons |
|--------|------|------|
| **IPFS** | Decentralized, permanent | Requires pinning service |
| **Data URI** | Fully on-chain | Size limits, gas costs |
| **HTTP URL** | Easy setup | Centralized, can break |
| **Arweave** | Permanent storage | Requires AR tokens |

```javascript
// Data URI approach (for small metadata)
const metadata = {
    name: title,
    description: description,
    image: `data:${file.type};base64,${imageBase64}`
};

// Encode metadata as data URI
const metadataString = JSON.stringify(metadata);
const metadataBase64 = Buffer.from(metadataString).toString("base64");
const tokenURI = `data:application/json;base64,${metadataBase64}`;
```

#### 4. Smart Contract Implementation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PoetNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    event Minted(
        address indexed owner, 
        uint256 indexed tokenId, 
        string tokenURI
    );
    
    constructor() ERC721("PoetNFT", "POET") {}
    
    function mintNFT(string calldata _tokenURI) 
        external 
        returns (uint256) 
    {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);
        
        emit Minted(msg.sender, newTokenId, _tokenURI);
        return newTokenId;
    }
    
    function totalSupply() external view returns (uint256) {
        return _tokenIds.current();
    }
}
```

---

### 🏗️ React Component Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    MINT NFT COMPONENTS                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                      MintApp                             │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: title, description, file, preview,       │    │   │
│   │  │        tokenId, loading, error                  │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │  Input  │      │   Preview   │     │   Mint      │         │
│   │  Form   │      │   Panel     │     │   Result    │         │
│   │         │      │             │     │             │         │
│   │ Title:  │      │  🖼️ Image   │     │ Token ID:   │         │
│   │ [_____] │      │  { JSON }   │     │   #42 ✅    │         │
│   │ Desc:   │      │             │     │             │         │
│   │ [_____] │      │             │     │ [View on    │         │
│   │ 📷 File │      │             │     │  OpenSea]   │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Image Preview with FileReader

```javascript
import { useState } from "react";

function ImageUpload({ onFileChange }) {
    const [preview, setPreview] = useState(null);

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (!file) return;

        // Validate file type
        if (!file.type.startsWith("image/")) {
            alert("Please select an image file");
            return;
        }

        // Validate file size (max 5MB)
        if (file.size > 5 * 1024 * 1024) {
            alert("File size must be less than 5MB");
            return;
        }

        // Create preview URL
        const previewUrl = URL.createObjectURL(file);
        setPreview(previewUrl);

        // Pass file to parent
        onFileChange(file);
    };

    return (
        <div>
            <input
                type="file"
                accept="image/*"
                onChange={handleFileChange}
            />
            {preview && (
                <img 
                    src={preview} 
                    alt="Preview" 
                    style={{ maxWidth: "300px" }}
                />
            )}
        </div>
    );
}
```

#### Complete Minting Flow

```javascript
import { ethers } from "ethers";

async function mintNFT(title, description, file) {
    // Step 1: Convert image to base64
    const imageBase64 = await fileToBase64(file);
    
    // Step 2: Create metadata object
    const metadata = {
        name: title,
        description: description,
        image: `data:${file.type};base64,${imageBase64}`
    };
    
    // Step 3: Encode metadata as data URI
    const metadataString = JSON.stringify(metadata);
    const metadataBase64 = btoa(unescape(encodeURIComponent(metadataString)));
    const tokenURI = `data:application/json;base64,${metadataBase64}`;
    
    // Step 4: Connect to contract
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(
        process.env.REACT_APP_POETNFT_ADDRESS,
        POETNFT_ABI,
        signer
    );
    
    // Step 5: Mint the NFT
    const tx = await contract.mintNFT(tokenURI);
    const receipt = await tx.wait();
    
    // Step 6: Extract token ID from event
    const mintEvent = receipt.events.find(e => e.event === "Minted");
    const tokenId = mintEvent.args.tokenId.toNumber();
    
    return tokenId;
}

// Helper: Convert file to base64
function fileToBase64(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => {
            const base64 = reader.result.split(",")[1];
            resolve(base64);
        };
        reader.onerror = reject;
        reader.readAsDataURL(file);
    });
}
```

---

### 📊 Data URI vs IPFS Comparison

| Aspect | Data URI | IPFS |
|--------|----------|------|
| **Storage** | On-chain (in tokenURI) | Off-chain (pinned) |
| **Gas Cost** | Higher (longer string) | Lower (just CID) |
| **Size Limit** | ~24KB practical | Unlimited |
| **Permanence** | Forever on-chain | Requires pinning |
| **Decentralization** | Fully on-chain | Distributed network |
| **Best For** | Small images, SVGs | Photos, videos |

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Large images as data URI | Transaction fails | Use IPFS for >50KB |
| Missing file validation | Wrong file types | Check `file.type.startsWith("image/")` |
| Not awaiting `tx.wait()` | Token ID unavailable | Always await receipt |
| No loading state | User clicks multiple times | Disable button while minting |
| Forgetting URL.revokeObjectURL | Memory leaks | Clean up preview URLs |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] File input accepts only images
- [ ] File size validation works (< 5MB)
- [ ] Image preview displays correctly
- [ ] Metadata JSON preview updates in real-time
- [ ] Mint button disabled without complete form
- [ ] Loading spinner during transaction
- [ ] Token ID displays after successful mint
- [ ] Error handling for rejected transaction
- [ ] Minted event captured correctly

---

### 🔗 External Resources

| Resource | Link |
|----------|------|
| OpenZeppelin ERC721 | https://docs.openzeppelin.com/contracts/4.x/erc721 |
| NFT Metadata Standard | https://docs.opensea.io/docs/metadata-standards |
| IPFS Documentation | https://docs.ipfs.tech/ |
| FileReader API | https://developer.mozilla.org/en-US/docs/Web/API/FileReader |



---

## ✅ Test Cases

Create `__tests__/MintNFT.test.js`:

```js
// __tests__/MintNFT.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import MintNFT from "../MintNFT";
import { ethers } from "ethers";

jest.mock("ethers");
jest.mock("buffer", () => ({
  Buffer: { from: (x) => ({ toString: () => "BASE64" }) },
}));

describe("MintNFT Component", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    mintNFT: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({
      getSigner: () => fakeSigner,
    });
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("calls mintNFT and shows tokenId", async () => {
    // Mock transaction & event
    const fakeReceipt = {
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Minted", args: { tokenId: ethers.BigNumber.from("42") } },
          ],
        }),
    };
    fakeContract.mintNFT.mockResolvedValue(fakeReceipt);

    // Mock file
    const file = new File(["dummy"], "test.png", { type: "image/png" });
    render(<MintNFT title="My Poem" description="Lines..." file={file} />);

    fireEvent.click(screen.getByText("Mint NFT"));

    await waitFor(() => screen.getByText(/Minted Token ID: 42/));
    expect(fakeContract.mintNFT).toHaveBeenCalled();
  });

  it("shows error on user rejection", async () => {
    fakeContract.mintNFT.mockRejectedValue(new Error("User rejected"));
    const file = new File(["dummy"], "test.png", { type: "image/png" });
    render(<MintNFT title="X" description="Y" file={file} />);

    fireEvent.click(screen.getByText("Mint NFT"));
    await waitFor(() => screen.getByText("User rejected"));
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

Lakan clicked **Mint NFT**, watched Token #1 emerge, and shared it on Twitter: "My spoken‐word, now immortalized on-chain!" Odessa smiled—her Tondo poet had a digital legacy. Next, they'll add IPFS uploads and on-chain royalties. Filipino creativity meets Web3 magic—one poem at a time. Mabuhay Kabataan! 🇵🇭🎤🚀