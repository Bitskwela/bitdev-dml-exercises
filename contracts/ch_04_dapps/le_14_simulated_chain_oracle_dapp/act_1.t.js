// Hidden grading test for le-14-simulated-chain-oracle-dapp.

describe("Lesson 14: Simulated Chain Oracle dApp", () => {
  it("Task 2: reads the oracle's wind speed and release flag", async () => {
    const ui = await render(Submission);
    expect(ui.called("contract.windSpeed")).to.equal(true, "Read windSpeed().");
    expect(ui.called("contract.released")).to.equal(true, "Read released().");
  });

  it("Task 3: reads the pool balance from the provider, not the contract", async () => {
    const ui = await render(Submission);
    expect(ui.called("provider.getBalance")).to.equal(
      true,
      "The pool's ETH balance is chain state — read it with provider.getBalance(address).",
    );
  });

  it("Task 4: renders the wind speed", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain("185", `Rendered: "${ui.text()}"`);
  });

  it("Task 3: renders the balance in ether, not wei", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain(
      "3.25",
      `3250000000000000000 wei is 3.25 ETH — use ethers.formatEther. Rendered: "${ui.text()}"`,
    );
    expect(ui.text()).to.not.contain(
      "3250000000000000000",
      "Raw wei should not reach the screen.",
    );
  });

  it("Task 4: reports that the funds were dispatched", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /dispatch|released/i,
      `released() is true, so say so. Rendered: "${ui.text()}"`,
    );
  });
});
