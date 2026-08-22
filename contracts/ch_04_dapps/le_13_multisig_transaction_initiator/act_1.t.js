// Hidden grading test for le-13-multisig-transaction-initiator.

describe("Lesson 13: Multisig Transaction Initiator", () => {
  it("Task 2: reads the transaction count then each transaction", async () => {
    const ui = await render(Submission);

    expect(ui.called("contract.getTransactionCount")).to.equal(true, "Read getTransactionCount().");
    expect(ui.calls("contract.transactions").length).to.equal(
      2,
      `A count of 2 means two transactions(i) reads, got ${ui.calls("contract.transactions").length}.`,
    );
  });

  it("Task 4: renders each proposal's recipient", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain("0xAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAa", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("0xBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBb", `Rendered: "${ui.text()}"`);
  });

  it("Task 3: shows the value in ether, not wei", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain(
      "1.5",
      `1500000000000000000 wei is 1.5 ETH — use ethers.formatEther. Rendered: "${ui.text()}"`,
    );
    expect(ui.text()).to.not.contain(
      "1500000000000000000",
      "Raw wei should not reach the screen.",
    );
  });

  it("Task 3: shows each proposal's confirmation count", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain("Confirmations", `Label the confirmations. Rendered: "${ui.text()}"`);
  });

  it("Task 4: distinguishes an executed proposal from a pending one", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /executed/i,
      `Show whether each proposal has executed. Rendered: "${ui.text()}"`,
    );
  });
});
