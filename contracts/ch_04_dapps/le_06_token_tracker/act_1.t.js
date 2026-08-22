// Hidden grading test for le-06-token-tracker.

describe("Lesson 06: Token Tracker", () => {
  it("Task 2: reads name, symbol and decimals on mount", async () => {
    const ui = await render(Submission);
    const targets = ui.callTargets();

    for (const m of ["contract.name", "contract.symbol", "contract.decimals"]) {
      expect(targets).to.contain(
        m,
        `Expected ${m}() to be read on mount. Calls made: ${JSON.stringify(targets)}`,
      );
    }
  });

  it("Task 4: renders the token metadata it read", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain("Barangay Peso", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("BPSO", `Rendered: "${ui.text()}"`);
  });

  it("Task 1: skips the reads entirely when the address is invalid", async () => {
    const ui = await render(Submission, { props: { tokenAddress: "not-an-address" } });

    expect(ui.called("contract.name")).to.equal(
      false,
      "Guard with ethers.isAddress(tokenAddress) — reading from a malformed address only reverts.",
    );
  });

  it("Task 3: connects the wallet and reads the caller's balance", async () => {
    const ui = await render(Submission);
    await ui.click("Fetch");

    const methods = ui.calls("window.ethereum.request").map(([m]) => m);
    expect(methods).to.contain("eth_requestAccounts", "Ask for the account before reading its balance.");
    expect(ui.called("contract.balanceOf")).to.equal(true, "Read balanceOf(user).");
  });

  it("Task 3: formats the raw balance with the token's decimals", async () => {
    const ui = await render(Submission);
    await ui.click("Fetch");

    expect(ui.text()).to.contain(
      "2.5",
      `A raw balance of 2500000000000000000 with 18 decimals is 2.5 — use ethers.formatUnits. Rendered: "${ui.text()}"`,
    );
    expect(ui.text()).to.not.contain(
      "2500000000000000000",
      "The raw integer should never reach the screen; format it first.",
    );
  });
});
