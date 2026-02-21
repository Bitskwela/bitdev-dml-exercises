const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 03: Triggering a Function", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should handle wallet request and signer correctly", function () {
    expect(code).to.contain("eth_requestAccounts");
    expect(code).to.contain(
      "new ethers.providers.Web3Provider(window.ethereum)",
    );
    expect(code).to.contain("web3Provider.getSigner()");
  });

  it("Task 2: Should call contract.vote with selected proposal and gas limit", function () {
    expect(code).to.contain("contract.vote(selected");
    expect(code).to.contain("gasLimit: 100_000");
  });

  it("Task 3: Should handle transaction wait and status updates", function () {
    expect(code).to.contain("tx.wait()");
    expect(code).to.contain('setStatus("confirmed ✅")');
  });
});
