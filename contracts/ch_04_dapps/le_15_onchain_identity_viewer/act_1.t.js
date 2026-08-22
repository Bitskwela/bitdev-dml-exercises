// Hidden grading test for le-15-onchain-identity-viewer.

describe("Lesson 15: On-Chain Identity Viewer", () => {
  it("Task 1: connects the wallet to learn whose profile to show", async () => {
    const ui = await render(Submission);
    const methods = ui.calls("window.ethereum.request").map(([m]) => m);

    expect(methods).to.contain(
      "eth_requestAccounts",
      `Ask for the account first. Methods requested: ${JSON.stringify(methods)}`,
    );
  });

  it("Task 2: reads the profile for the connected address", async () => {
    const ui = await render(Submission);
    const calls = ui.calls("contract.getProfile");

    expect(calls.length).to.not.equal(0, "Call getProfile(address).");
    expect(calls[0][0]).to.equal(
      "0x1234567890123456789012345678901234567890",
      `getProfile() should receive the connected address, got ${JSON.stringify(calls[0][0])}.`,
    );
  });

  it("Task 2: renders the name and status from the tuple", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("Neri Gomez", `The name should render. Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain(
      "Barangay Kagawad",
      `The status should render — getProfile returns three values; destructure all of them. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: reads one credential per the count the profile reported", async () => {
    const ui = await render(Submission);

    expect(ui.calls("contract.getCredential").length).to.equal(
      2,
      `The profile reports 2 credentials, so expect 2 getCredential reads, got ${ui.calls("contract.getCredential").length}.`,
    );
  });

  it("Task 3: renders every credential", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("BS Computer Science", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("Certified Solidity Developer", `Rendered: "${ui.text()}"`);
  });

  it("Task 4: subscribes to ProfileUpdated so edits appear without a refresh", async () => {
    const ui = await render(Submission);
    const events = ui.calls("contract.on").map(([e]) => e);

    expect(events).to.contain(
      "ProfileUpdated",
      `Subscribe to "ProfileUpdated". Subscribed to: ${JSON.stringify(events)}`,
    );
  });

  it("Task 4: removes the listener on cleanup", async () => {
    const ui = await render(Submission);
    ui.unmount();

    expect(ui.called("contract.off")).to.equal(
      true,
      "Return a cleanup that removes the ProfileUpdated listener, or they stack on every remount.",
    );
  });

  it("Task 5: clears the loading state once the profile has arrived", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.not.match(/loading/i, `Rendered: "${ui.text()}"`);
  });
});
