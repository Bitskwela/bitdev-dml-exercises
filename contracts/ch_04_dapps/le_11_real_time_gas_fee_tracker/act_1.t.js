// Hidden grading test for le-11-real-time-gas-fee-tracker.

describe("Lesson 11: Real-Time Gas Fee Tracker", () => {
  it("Task 1: uses a read-only provider — no wallet needed for public data", async () => {
    const ui = await render(Submission);
    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "Reading a public value needs no wallet: build an ethers.JsonRpcProvider.",
    );
  });

  it("Task 3: reads the base fee from the contract", async () => {
    const ui = await render(Submission);
    expect(ui.called("contract.getBaseFee")).to.equal(true, "Call getBaseFee() on mount.");
  });

  it("Task 4: renders the fee it read", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain(
      "24000000000",
      `The base fee should render. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: does not leave the user staring at a loading state", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.not.match(
      /loading/i,
      `Once the fee has arrived the loading state should be gone. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: labels the value so the number means something", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /wei|gwei|fee/i,
      `A bare integer tells the user nothing — label the unit. Rendered: "${ui.text()}"`,
    );
  });
});
