// Hidden grading test for le-10-dao-voting-ui.

describe("Lesson 10: DAO Voting UI", () => {
  it("Task 1: reads the proposal count, each proposal, and each vote status", async () => {
    const ui = await render(Submission);

    expect(ui.called("contract.getProposalCount")).to.equal(true, "Read getProposalCount().");
    expect(ui.calls("contract.proposals").length).to.equal(
      2,
      `A count of 2 means two proposals(i) reads, got ${ui.calls("contract.proposals").length}.`,
    );
    expect(ui.calls("contract.hasVoted").length).to.equal(
      2,
      "Check hasVoted(i, account) per proposal so the UI knows which to lock.",
    );
  });

  it("Task 4: renders each proposal and its tally", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("Ayusin ang basketball court", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("Bagong ilaw sa kalye", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("5", `The yes-count for proposal 0 should show. Rendered: "${ui.text()}"`);
  });

  it("Task 4: hides the vote buttons on a proposal already voted on", async () => {
    const ui = await render(Submission);
    const voteButtons = ui.all("button").filter((b) => /vote/i.test(JSON.stringify(b)));

    // Proposal 0 is unvoted (Yes + No), proposal 1 is already voted.
    expect(voteButtons.length).to.equal(
      2,
      `Only the unvoted proposal should offer buttons, expected 2 and got ${voteButtons.length}.`,
    );
  });

  it("Task 2: sends the proposal id and the chosen side", async () => {
    const ui = await render(Submission);
    await ui.click("Vote Yes");

    const votes = ui.calls("contract.vote");
    expect(votes.length).to.not.equal(0, "Clicking Vote Yes should call vote(proposalId, support).");
    expect(Number(votes[0][0])).to.equal(0, `Expected proposal id 0, got ${votes[0][0]}.`);
    expect(votes[0][1]).to.equal(true, "Vote Yes should pass support = true.");
  });

  it("Task 2: waits for the receipt", async () => {
    const ui = await render(Submission);
    await ui.click("Vote Yes");

    expect(ui.called("tx.wait")).to.equal(true, "Await tx.wait() before updating the tally.");
  });

  it("Task 3: subscribes to the Voted event", async () => {
    const ui = await render(Submission);
    const events = ui.calls("contract.on").map(([e]) => e);

    expect(events).to.contain(
      "Voted",
      `Subscribe to "Voted" so other people's votes appear live. Subscribed to: ${JSON.stringify(events)}`,
    );
  });

  it("Task 3: unsubscribes on cleanup", async () => {
    const ui = await render(Submission);
    ui.unmount();

    expect(ui.calls("contract.off").map(([e]) => e)).to.contain(
      "Voted",
      "Return a cleanup that calls contract.off(...), or listeners stack on every remount.",
    );
  });
});
