const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 05: Sign-in with Wallet Experience", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should connect wallet and get address", function () {
    expect(code).to.contain("eth_requestAccounts");
    expect(code).to.contain("signer.getAddress()");
    expect(code).to.contain("setAccount(address)");
  });

  it("Task 2: Should implement signMessage with nonce", function () {
    expect(code).to.contain("signer.signMessage(msg)");
    expect(code).to.contain("Date.now().toString()");
    expect(code).to.contain("Signature:");
  });

  it("Task 3: Should verify signature using contract.verify", function () {
    expect(code).to.contain("ethers.utils.splitSignature(signature)");
    expect(code).to.contain("contract.verify(account, msgHash, v, r, s)");
    expect(code).to.contain("setIsAuthenticated(true)");
  });
});
