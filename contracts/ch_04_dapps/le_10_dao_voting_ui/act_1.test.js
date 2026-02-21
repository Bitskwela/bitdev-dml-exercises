const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 10: DAO Voting UI", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should load proposals and user voting status", function () {
    expect(code).to.contain("contract.getProposalCount()");
    expect(code).to.contain("contract.proposals(i)");
    expect(code).to.contain("contract.hasVoted(i, account)");
  });

  it("Task 2: Should update votes in real-time via event listeners", function () {
    expect(code).to.contain('contract.on("Voted", handleVote)');
    expect(code).to.contain('contract.off("Voted", handleVote)');
  });

  it("Task 3: Should implement castVote with wait and state update", function () {
    expect(code).to.contain("contract.vote(proposalId, support)");
    expect(code).to.contain("tx.wait()");
    expect(code).to.contain("hasVoted: true");
  });
});
