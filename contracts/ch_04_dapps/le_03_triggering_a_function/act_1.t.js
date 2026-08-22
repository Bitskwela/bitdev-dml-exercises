// Hidden grading test for le-03-triggering-a-function.

describe("Lesson 03: Triggering a Function", () => {
  it("Task 4: renders a Vote control", async () => {
    const ui = await render(Submission, { props: { onVoted: spy() } });
    expect(ui.text()).to.match(/vote/i, `Expected a Vote control. Rendered: "${ui.text()}"`);
  });

  it("Task 1: asks the wallet for accounts before writing", async () => {
    const ui = await render(Submission, { props: { onVoted: spy() } });
    await ui.click("Vote");

    const methods = ui.calls("window.ethereum.request").map(([m]) => m);
    expect(methods).to.contain(
      "eth_requestAccounts",
      `A write needs an authorised account first. Methods requested: ${JSON.stringify(methods)}`,
    );
  });

  it("Task 2: signs the call — builds a BrowserProvider and awaits its signer", async () => {
    const ui = await render(Submission, { props: { onVoted: spy() } });
    await ui.click("Vote");

    expect(ui.called("new ethers.BrowserProvider")).to.equal(
      true,
      "A state-changing call needs the wallet's signer: build an ethers.BrowserProvider.",
    );
    expect(ui.called("provider.getSigner")).to.equal(
      true,
      "Get the signer from the provider — remember getSigner() is async in ethers v6.",
    );
  });

  it("Task 3: sends the selected proposal to vote()", async () => {
    const ui = await render(Submission, { props: { onVoted: spy() } });
    await ui.click("Vote");

    const votes = ui.calls("contract.vote");
    expect(votes.length).to.not.equal(0, "Clicking Vote should call contract.vote(...).");
    expect(votes[0][0]).to.equal(
      "Bagong Palengke",
      `vote() should receive the selected proposal. It received: ${JSON.stringify(votes[0][0])}`,
    );
  });

  it("Task 3: waits for the transaction receipt", async () => {
    const ui = await render(Submission, { props: { onVoted: spy() } });
    await ui.click("Vote");

    expect(ui.called("tx.wait")).to.equal(
      true,
      "Sending a transaction is not the same as it being mined — await tx.wait().",
    );
  });

  it("Task 3: notifies the parent once the vote is confirmed", async () => {
    const onVoted = spy();
    const ui = await render(Submission, { props: { onVoted } });
    await ui.click("Vote");

    expect(onVoted.called()).to.equal(
      true,
      "Call onVoted() after the transaction confirms, so the parent can refresh.",
    );
  });

  it("Task 3: reports the confirmed state to the user", async () => {
    const ui = await render(Submission, { props: { onVoted: spy() } });
    await ui.click("Vote");

    expect(ui.text()).to.match(
      /confirm/i,
      `The user should see that the vote confirmed. Rendered: "${ui.text()}"`,
    );
  });
});
