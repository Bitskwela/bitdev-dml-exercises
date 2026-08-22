// Hidden grading test for le-12-defi-dashboard.

describe("Lesson 12: DeFi Dashboard", () => {
  it("Task 2: uses a read-only provider", async () => {
    const ui = await render(Submission);
    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "Pool stats are public — build an ethers.JsonRpcProvider, not a wallet provider.",
    );
  });

  it("Task 3: reads both reserves and the total supply", async () => {
    const ui = await render(Submission);
    expect(ui.called("contract.getReserves")).to.equal(true, "Call getReserves().");
    expect(ui.called("contract.getTotalSupply")).to.equal(true, "Call getTotalSupply().");
  });

  it("Task 3: unpacks the reserves tuple into both values", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("120000000000000000000", `Reserve0 missing. Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("45000000000", `Reserve1 missing — getReserves() returns a pair; destructure both. Rendered: "${ui.text()}"`);
  });

  it("Task 4: renders the total supply", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain("7350000000000000000", `Rendered: "${ui.text()}"`);
  });

  it("Task 4: clears the loading state once the data arrives", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.not.match(/loading/i, `Rendered: "${ui.text()}"`);
  });
});
