## 🧑‍💻 Background Story

Odessa ("Det") was on a late-night Zoom with a New York freelance client. "Send escrow first," the client insisted before the PHP dev could start. In typical PH–NY trust issues, money either sits in a bank or gets tangled in fees. She thought, "What if we build a pure-frontend escrow DApp to simulate P2P service?"

By sunrise, Det had sketched an **Escrow** Solidity contract on her local Hardhat node. The DApp flow was simple:

1. **Buyer** deposits ETH into escrow.
2. UI shows "Pending" with deposit amount.
3. Once the freelancer (Seller) delivers, the Buyer clicks **Release** to send funds.
4. If something goes wrong, the Seller can trigger a **Refund** back to Buyer.

No backend server, no custodian—just wallet-to-wallet logic. Odessa wired React + Ethers.js: a stats panel, a deposit form, and release/refund buttons. She pre-sets Buyer & Seller addresses in `.env`, deploys on Sepolia, and shares the link with her client. Now, both PH and NY sides can see funds locked, pending, and executed—trustless and transparent.

In 30 minutes, Det presented to her WhatsApp group: "Try send 0.01 ETH – I'll refund if not delivered!" Filipino ingenuity at its best: build fast, iterate, and earn trust one escrow at a time. 🇵🇭🤝🚀

---

## 📚 Theory & Web3 Lecture

1. Escrow Pattern  
   • **Actors**: Buyer (depositor), Seller (recipient).  
   • **Flow**: deposit → (release | refund).  
   • **State**: track `amount`, `deposited`, `released`.

2. Solidity Contract Breakdown

   ```solidity
   function deposit() external payable onlyBuyer { … }
   function release() external onlyBuyer onlyDeposited onlyNotReleased { … }
   function refund() external onlySeller onlyDeposited onlyNotReleased { … }
   ```

   • Modifiers: `onlyBuyer`, `onlySeller`, `onlyDeposited`, `onlyNotReleased`.  
   • Events: `Deposited(uint256)`, `Released(address,uint256)` for frontend reactivity.

3. Ethers.js Integration  
   • **Provider**: JsonRpcProvider or Web3Provider for MetaMask.  
   • **Signer**: for state-changing calls (`deposit`, `release`, `refund`).  
   • **Contract**:

   ```js
   const escrow = new ethers.Contract(
     process.env.REACT_APP_ESCROW_ADDRESS,
     ESCROW_ABI,
     signerOrProvider
   );
   ```

   • **Listening to Events**:

   ```js
   escrow.on("Deposited", (amt) => refreshStats());
   escrow.on("Released", (to, amt) => refreshStats());
   ```

4. React Hooks & UI  
   • `useState` for `buyer`, `seller`, `amount`, `deposited`, `released`, `error`, `loading`.  
   • `useEffect` to load initial state and subscribe to events.  
   • Forms and buttons disable when loading or unauthorized.  
   • `.env` holds `REACT_APP_RPC_URL`, `REACT_APP_ESCROW_ADDRESS`, `REACT_APP_BUYER`, `REACT_APP_SELLER`.

5. Best Practices  
   • Validate addresses with `ethers.utils.isAddress()`.  
   • Wrap async calls in `try/catch` and feedback errors.  
   • Clean up event listeners on unmount.  
   • Show spinners or disabled states during transactions.

🔗 Links  
– Ethers.js: https://docs.ethers.org/v5  
– Solidity: https://docs.soliditylang.org  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## ✅ Test Cases

Create `__tests__/EscrowApp.test.js`:

```js
// __tests__/EscrowApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import EscrowStats from "../EscrowStats";
import DepositFunds from "../DepositFunds";
import ReleaseControls from "../ReleaseControls";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Escrow DApp Components", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    buyer: jest.fn(),
    seller: jest.fn(),
    amount: jest.fn(),
    deposited: jest.fn(),
    released: jest.fn(),
    deposit: jest.fn(),
    release: jest.fn(),
    refund: jest.fn(),
  };

  beforeEach(() => {
    // Mock window.ethereum
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xBUYER"]),
    };
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({
      getSigner: () => fakeSigner,
    });
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("loads escrow stats", async () => {
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.amount.mockResolvedValue(ethers.utils.parseEther("0.5"));
    fakeContract.deposited.mockResolvedValue(true);
    fakeContract.released.mockResolvedValue(false);

    render(<EscrowStats />);
    expect(await screen.findByText(/Buyer:/)).toHaveTextContent("0xBUYER");
    expect(screen.getByText(/Seller:/)).toHaveTextContent("0xSELLER");
    expect(screen.getByText(/Amount:/)).toHaveTextContent("0.5");
    expect(screen.getByText(/Status:/)).toHaveTextContent("Pending");
  });

  it("deposits funds and calls onDeposited", async () => {
    fakeContract.deposit.mockResolvedValue({ wait: () => Promise.resolve() });
    const onDeposited = jest.fn();
    render(<DepositFunds onDeposited={onDeposited} />);
    fireEvent.change(screen.getByPlaceholderText("ETH amount"), {
      target: { value: "0.3" },
    });
    fireEvent.click(screen.getByText("Deposit"));
    await waitFor(() => expect(fakeContract.deposit).toHaveBeenCalled());
    expect(onDeposited).toHaveBeenCalled();
  });

  it("releases funds when buyer clicks", async () => {
    // Setup ReleaseControls state
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.deposited.mockResolvedValue(true);
    fakeContract.released.mockResolvedValue(false);
    fakeContract.release.mockResolvedValue({ wait: () => Promise.resolve() });

    const onAction = jest.fn();
    render(<ReleaseControls onAction={onAction} />);
    // Wait for buttons to load
    await waitFor(() => screen.getByText("Release Funds"));
    fireEvent.click(screen.getByText("Release Funds"));
    await waitFor(() => expect(fakeContract.release).toHaveBeenCalled());
    expect(onAction).toHaveBeenCalled();
  });

  it("refunds funds when seller clicks", async () => {
    // Simulate current account as seller
    global.window.ethereum.request.mockResolvedValue(["0xSELLER"]);
    fakeContract.buyer.mockResolvedValue("0xBUYER");
    fakeContract.seller.mockResolvedValue("0xSELLER");
    fakeContract.deposited.mockResolvedValue(true);
    fakeContract.released.mockResolvedValue(false);
    fakeContract.refund.mockResolvedValue({ wait: () => Promise.resolve() });

    const onAction = jest.fn();
    render(<ReleaseControls onAction={onAction} />);
    await waitFor(() => screen.getByText("Refund Buyer"));
    fireEvent.click(screen.getByText("Refund Buyer"));
    await waitFor(() => expect(fakeContract.refund).toHaveBeenCalled());
    expect(onAction).toHaveBeenCalled();
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

Odessa shared the link: PH Buyer deposits 0.02 ETH, NY Seller delivers code, clicks **Release**, and funds ring in—no middleman, no delays. Her freelancing group chat lit up: "Smooth, secure, sobrang Pinoy!" Next sprint: add arbiter voting and IPFS proof-of-work. Det's escrow DApp is just the start of a borderless gig economy. 🇵🇭🤝🌐
