const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 13: Multisig Transaction Initiator", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should setup provider and logic to fetch count", function () {
    expect(code).to.contain(
      "new ethers.providers.Web3Provider(window.ethereum)",
    );
    expect(code).to.contain("wallet.getTransactionCount()");
  });

  it("Task 2: Should iterate and fetch each transaction", function () {
    expect(code).to.contain("for (let i = 0; i < count; i++)");
    expect(code).to.contain("wallet.transactions(i)");
  });

  it("Task 3: Should format output and update proposals state", function () {
    expect(code).to.contain("ethers.utils.formatEther(value)");
    expect(code).to.contain("setProposals(items)");
  });
});
