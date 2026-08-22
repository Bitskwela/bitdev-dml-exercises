// Hidden grading test for le-16-escrow-dapp.

describe("Lesson 16: Escrow dApp", () => {
  it("Task 2: reads every field of the escrow", async () => {
    const ui = await render(Submission);
    const targets = ui.callTargets();

    for (const m of ["buyer", "seller", "amount", "deposited", "released"]) {
      expect(targets).to.contain(
        `contract.${m}`,
        `Expected ${m}() to be read. Calls made: ${JSON.stringify(targets)}`,
      );
    }
  });

  it("Task 1: uses a read-only provider — escrow state is public", async () => {
    const ui = await render(Submission);
    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "No wallet is needed to read escrow state: use ethers.JsonRpcProvider.",
    );
  });

  it("Task 4: renders both parties", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain(
      "0xAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAa",
      `The buyer should render. Rendered: "${ui.text()}"`,
    );
    expect(ui.text()).to.contain(
      "0xBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBbBb",
      `The seller should render. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: shows the amount in ether, not wei", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain(
      "0.75",
      `750000000000000000 wei is 0.75 ETH — use ethers.formatEther. Rendered: "${ui.text()}"`,
    );
    expect(ui.text()).to.not.contain(
      "750000000000000000",
      "Raw wei should not reach the screen.",
    );
  });

  it("Task 4: reports Pending — deposited but not yet released", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /pending/i,
      `deposited is true and released is false, so the status is Pending. Rendered: "${ui.text()}"`,
    );
  });
});
