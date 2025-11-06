## 🧑‍💻 Background Story

Under the neon glow of Tondo's mural walls, Odessa ("Det") met a spoken‐word poet named Lakan. He had powerful lines about hope and Manila's heartbeat—but no way to "own" them. Odessa grinned: "Kahit spoken word, pwedeng i-mint." Within an hour, she deployed a minimal `PoetNFT.sol` on her local Hardhat node. Then she scaffolded a React app with three widgets:

1. **Input Form** – Title, Description, and Image Upload (a snapshot of the poet's expression)
2. **NFT Preview** – Live preview of the metadata JSON and image
3. **Mint Button** – Calls `mintNFT(tokenURI)` on the contract and shows the minted Token ID

When Lakan uploaded his poem's cover art, typed "Tondo Sunrise" and "Lines of resilience…," the preview popped up like magic. A click on **Mint** simulated a real on-chain call. Ten seconds later, Token ID #1 appeared, with metadata viewable on the UI. Over gulaman at taho, Lakan raised his phone: "My poem as NFT—para sa future collectors!" Filipino creativity + Web3, one spoken line at a time. 🇵🇭🎤🪙

---

## 📚 Theory & Web3 Lecture

1. ERC-721 Basics  
   • Each NFT has a unique `tokenId` and `tokenURI`.  
   • `tokenURI` returns a JSON metadata link (IPFS or Data URI).  
   • We override `tokenURI()` in Solidity to serve on-chain metadata

2. Smart Contract (`PoetNFT.sol`)  
   • Uses OpenZeppelin's ERC721  
   • `_tokenIds` counter for unique IDs  
   • `mintNFT(string calldata tokenURI)` mints to `msg.sender`  
   • `event Minted(address indexed, uint256 indexed, string)` fires on mint

3. Frontend Architecture  
   • **Form State**: React useState for `title`, `desc`, `file`  
   • **Preview**: URL.createObjectURL(file) + JSON preview  
   • **Metadata**: Construct a JS object `{ name, description, image }`, Base64-encode to Data URI  
   • **Ethers.js**:

   ```js
   const provider = new ethers.providers.Web3Provider(window.ethereum);
   const signer = provider.getSigner();
   const contract = new ethers.Contract(
     process.env.REACT_APP_POETNFT_ADDRESS,
     ABI,
     signer
   );
   const tx = await contract.mintNFT(tokenURI);
   await tx.wait();
   ```

   • **Event Handling**: listen to `Minted` event to update UI

4. React Hooks & UX  
   • `useEffect` to request accounts on-mount  
   • Disable **Mint** until preview is valid  
   • Show loading spinner during `await tx.wait()`  
   • Catch errors (e.g. user rejects, insufficient gas) and display

5. Security & Best Practices  
   • Validate image file type (`image/*`) and size (< 5 MB)  
   • Never commit private keys—use `.env` for `RPC_URL` and contract address  
   • Clean up event listeners on unmount

🔗 Links  
– Ethers.js: https://docs.ethers.org/v5  
– OpenZeppelin ERC721: https://docs.openzeppelin.com/contracts/4.x/api/token/erc721

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