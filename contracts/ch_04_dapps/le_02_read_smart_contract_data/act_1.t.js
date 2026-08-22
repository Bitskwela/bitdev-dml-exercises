// Hidden grading test for le-02-read-smart-contract-data.

describe("Lesson 02: Read Smart Contract Data", () => {
  it("Task 1: reads name, symbol and totalMinted on mount", async () => {
    const ui = await render(Submission);
    const targets = ui.callTargets();

    for (const method of ["contract.name", "contract.symbol", "contract.totalMinted"]) {
      expect(targets).to.contain(
        method,
        `Expected the component to call ${method}() when it mounts. Calls made: ${JSON.stringify(targets)}`,
      );
    }
  });

  it("Task 1: uses a read-only provider rather than demanding a wallet", async () => {
    const ui = await render(Submission);
    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "Reading public data needs no wallet — build an ethers.JsonRpcProvider.",
    );
  });

  it("Task 3: renders the values it read", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.contain("Sining Chain", `Name missing. Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("SNG", `Symbol missing. Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("3", `Total minted missing. Rendered: "${ui.text()}"`);
  });

  it("Task 1: converts the uint256 total instead of rendering a bigint", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.not.contain(
      "3n",
      "totalMinted() returns a bigint in ethers v6 — convert it with Number() before storing it.",
    );
  });

  it("Task 2: reads tokenURIs(tokenId) when the button is clicked", async () => {
    const ui = await render(Submission);
    await ui.click("Get Token URI");

    expect(ui.callTargets()).to.contain(
      "contract.tokenURIs",
      "Clicking the button should call contract.tokenURIs(tokenId).",
    );
  });

  it("Task 2: displays the URI it fetched", async () => {
    const ui = await render(Submission);
    await ui.click("Get Token URI");

    expect(ui.text()).to.contain(
      "ipfs://QmSiningTokenTwo",
      `The fetched URI should be rendered. Rendered: "${ui.text()}"`,
    );
  });
});
