## 🧑‍💻 Background Story

Odessa sat in a chic SoHo café, sipping kapeng barako over Zoom with her New York mentor. "In the Philippines, corporate boards need at least three of five signatures to greenlight a decision," she explained. "Kung wala kang quorum, wala kang chain move." Inspired by this real-world governance rule, she sketched a UI for a Multisig DApp: a proposal form, a live list of pending transactions, and signer buttons that flip green when each of the five owners signs off.

Back in her Makati apartment, Det spun up Hardhat and coded a `MultisigWallet.sol` with five owners and a threshold of three. She deployed it on Sepolia; next, she scaffolded a React app with Create React App. In under 30 minutes, she had:

1. A **Proposal Form** where board members enter destination address, ETH value, and call data.
2. A **Proposal List** showing each tx's ID, to-address, value, data preview, confirmation count, and "Execute" button (disabled until quorum).
3. **Confirm Buttons** for each owner—simulated via MetaMask's multiple accounts—so Det could log in as Owner #1, #2, #3, etc.

Every time an owner clicked "Confirm," the UI listened to the `Confirmation` event, updated the confirmation tally, and marked that owner in the proposal's row. Once three signatures were in, the "Execute" button lit up, and a follow-up click triggered the on-chain call.

By midnight, Odessa demoed to her mentor: "See? Three signatures, transaction executed, and funds moved." Her mentor nodded, impressed that Filipino governance customs had been encoded in Solidity and rendered in a sleek React UI. That night, under the glow of neon jeepneys, Det toasted: "To real-world multisig, PH style!" 🇵🇭🔐🚀

---

## 📚 Theory & Web3 Lecture

1. Multisig Wallet Pattern  
   • Owners & threshold: security by committee.  
   • Proposals stored on-chain: struct with `to`, `value`, `data`, `executed`, confirmation count.  
   • Confirmation mapping: each owner can sign once per tx.  
   • Events: `Submit`, `Confirmation`, `Execution` for frontend reactivity.

2. Contract Functions & ABI  
   • `submitTransaction(address to, uint256 value, bytes data) returns (uint256 txId)`  
   • `confirmTransaction(uint256 txId)`  
   • `executeTransaction(uint256 txId)`  
   • Views: `getTransactionCount()`, `transactions(uint256)`, `isConfirmed(uint256, address)`, `getConfirmations(uint256)`.

3. Ethers.js & React Integration  
   • Provider: `new ethers.providers.Web3Provider(window.ethereum)`  
   • Signer: `provider.getSigner()` for state-changing calls  
   • Contract:

   ```js
   const wallet = new ethers.Contract(
     process.env.REACT_APP_MULTISIG_ADDRESS,
     MULTISIG_ABI,
     signerOrProvider
   );
   ```

   • Listening to events:

   ```js
   wallet.on("Confirmation", (owner, txId) => {
     // update UI state
   });
   ```

4. React Hooks & State  
   • useState: `proposals`, `loading`, `error`  
   • useEffect: on-mount load proposals & subscribe to events  
   • Async handlers: `try/catch`, `await tx.wait()`  
   • Quorum logic: disable "Execute" until confirmations ≥ threshold

5. UX & Security  
   • Validate input address with `ethers.utils.isAddress()`  
   • Ensure only owners see confirm buttons  
   • Clean up event listeners in `useEffect` cleanup  
   • Use `.env` for RPC URL & contract address

🔗 Links  
– Ethers.js: https://docs.ethers.org/v5  
– Solidity Multisig example: https://docs.openzeppelin.com/contracts/4.x/api/governance

---

## ✅ Test Cases

Create `__tests__/MultisigUI.test.js`:

```js
// __tests__/MultisigUI.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import ProposalList from "../ProposalList";
import SubmitProposal from "../SubmitProposal";
import ConfirmButton from "../ConfirmButton";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Multisig UI Integration", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    getTransactionCount: jest.fn(),
    transactions: jest.fn(),
    submitTransaction: jest.fn(),
    confirmations: jest.fn(),
    confirmTransaction: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("lists proposals", async () => {
    fakeContract.getTransactionCount.mockResolvedValue({ toNumber: () => 1 });
    fakeContract.transactions.mockResolvedValue([
      "0xTo",
      ethers.BigNumber.from("1000000000000000000"),
      "0x1234",
      false,
      ethers.BigNumber.from("2"),
    ]);
    render(<ProposalList contractAddress="0xWallet" />);
    expect(await screen.findByText(/ID #0/)).toBeInTheDocument();
  });

  it("submits a new proposal", async () => {
    const receipt = {
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Submit", args: { txId: ethers.BigNumber.from("5") } },
          ],
        }),
    };
    fakeContract.submitTransaction.mockResolvedValue(receipt);
    const onSubmitted = jest.fn();
    render(
      <SubmitProposal contractAddress="0xWallet" onSubmitted={onSubmitted} />
    );
    fireEvent.change(screen.getByPlaceholderText("To Address"), {
      target: { value: "0xTo" },
    });
    fireEvent.change(screen.getByPlaceholderText("Value (ETH)"), {
      target: { value: "1" },
    });
    fireEvent.change(screen.getByPlaceholderText("Data (hex)"), {
      target: { value: "0x1234" },
    });
    fireEvent.click(screen.getByText("Submit"));
    await waitFor(() => screen.getByText(/Submitted TX ID: 5/));
    expect(onSubmitted).toHaveBeenCalled();
  });

  it("confirms a proposal", async () => {
    fakeContract.confirmations.mockResolvedValue(false);
    const onConfirmed = jest.fn();
    render(
      <ConfirmButton
        contractAddress="0xWallet"
        txId={0}
        onConfirmed={onConfirmed}
      />
    );
    await waitFor(() => screen.getByText("Confirm"));
    fireEvent.click(screen.getByText("Confirm"));
    await waitFor(() =>
      expect(fakeContract.confirmTransaction).toHaveBeenCalledWith(0)
    );
    expect(onConfirmed).toHaveBeenCalled();
  });
});
```

jest.config.js:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

With her Multisig UI live, Odessa clicked through a full governance cycle: propose, three confirmations, execute. Her NY mentor gave a thumbs-up on Zoom: "Exactly PH-style corporate security." Next up: transaction execution and on-chain audit logs—Det's multisig saga is just beginning. Mabuhay decentralized governance! 🇵🇭🔐🚀