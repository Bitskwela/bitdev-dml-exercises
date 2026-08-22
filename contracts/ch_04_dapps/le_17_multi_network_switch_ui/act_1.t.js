// Hidden grading test for le-17-multi-network-switch-ui.

describe("Lesson 17: Multi-Network Switch UI", () => {
  it("Task 1: uses the wallet's provider when MetaMask is installed", async () => {
    const ui = await render(Submission);

    expect(ui.called("new ethers.BrowserProvider")).to.equal(
      true,
      "With a wallet present, read the chain through ethers.BrowserProvider.",
    );
  });

  it("Task 1: falls back to a read-only provider when there is no wallet", async () => {
    const ui = await render(Submission, { wallet: "absent" });

    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "Without a wallet the page should still work — fall back to ethers.JsonRpcProvider(RPC).",
    );
  });

  it("Task 2: reads the chain id from the contract", async () => {
    const ui = await render(Submission);

    expect(ui.called("contract.getChainId")).to.equal(true, "Call getChainId().");
  });

  it("Task 2: renders the chain id and its friendly name", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("11155111", `The chain id should render. Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain(
      "Sepolia",
      `11155111 is Sepolia — map the id to a name rather than showing a bare number. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: subscribes to the wallet's chainChanged event", async () => {
    const ui = await render(Submission);
    const events = ui.calls("window.ethereum.on").map(([e]) => e);

    expect(events).to.contain(
      "chainChanged",
      `Subscribe to chainChanged so the UI follows the wallet. Subscribed to: ${JSON.stringify(events)}`,
    );
  });

  it("Task 3: updates the display when the wallet switches network", async () => {
    const ui = await render(Submission);
    await ui.emit("chainChanged", "0x89");

    expect(ui.text()).to.contain(
      "Polygon",
      `0x89 is 137, Polygon — the handler receives a hex string and must parse it. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: removes the listener on cleanup", async () => {
    const ui = await render(Submission);
    ui.unmount();

    expect(ui.called("window.ethereum.removeListener")).to.equal(
      true,
      "Return a cleanup that calls window.ethereum.removeListener, or listeners stack on every remount.",
    );
  });
});
