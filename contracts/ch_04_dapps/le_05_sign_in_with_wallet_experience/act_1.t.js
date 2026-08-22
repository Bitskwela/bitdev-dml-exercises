// Hidden grading test for le-05-sign-in-with-wallet-experience.

const ACCOUNT = "0x1234567890123456789012345678901234567890";

/** Drive the flow as far as the named step. */
async function advanceTo(step) {
  const ui = await render(Submission);
  if (step === "connect") return ui;
  await ui.click("Connect");
  if (step === "signed-in") return ui;
  await ui.click("Sign In");
  if (step === "signed") return ui;
  await ui.click("Verify");
  return ui;
}

describe("Lesson 05: Sign in with Wallet", () => {
  it("Task 4: opens on a Connect step", async () => {
    const ui = await advanceTo("connect");
    expect(ui.text()).to.match(/connect/i, `Rendered: "${ui.text()}"`);
  });

  it("Task 1: warns instead of crashing when MetaMask is missing", async () => {
    const ui = await render(Submission, { wallet: "absent" });
    await ui.click("Connect");

    expect(ui.text()).to.match(
      /metamask/i,
      `Without a wallet the user should be told to install MetaMask, not left with a dead button. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 1: resolves the signer's address on connect", async () => {
    const ui = await advanceTo("signed-in");

    expect(ui.called("signer.getAddress")).to.equal(
      true,
      "Read the address from the signer, not from the raw accounts array.",
    );
    expect(ui.text()).to.contain(ACCOUNT, `The connected address should show. Rendered: "${ui.text()}"`);
  });

  it("Task 2: asks the signer to sign a message", async () => {
    const ui = await advanceTo("signed");

    expect(ui.called("signer.signMessage")).to.equal(
      true,
      "Signing in off-chain means calling signer.signMessage(message).",
    );
  });

  it("Task 2: includes a nonce so a captured signature cannot be replayed", async () => {
    const ui = await advanceTo("signed");
    const [signed] = ui.calls("signer.signMessage")[0] || [];

    expect(String(signed)).to.match(
      /nonce/i,
      `The signed message should carry a nonce. It was: ${JSON.stringify(signed)}`,
    );
  });

  it("Task 3: verifies the signature against the contract", async () => {
    const ui = await advanceTo("verified");

    expect(ui.called("contract.verify")).to.equal(
      true,
      "Verification should call contract.verify(...) with the signature parts.",
    );
  });

  it("Task 3: unlocks the dashboard once verification succeeds", async () => {
    const ui = await advanceTo("verified");

    expect(ui.text()).to.match(
      /dashboard/i,
      `A valid signature should unlock the dashboard. Rendered: "${ui.text()}"`,
    );
  });
});
