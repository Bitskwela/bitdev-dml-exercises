const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 06: Token Tracker", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should validate token address", function () {
    expect(code).to.contain("ethers.utils.isAddress(tokenAddress)");
  });

  it("Task 2: Should fetch token metadata (name, symbol, decimals)", function () {
    expect(code).to.contain("contract.name()");
    expect(code).to.contain("contract.symbol()");
    expect(code).to.contain("contract.decimals()");
    expect(code).to.contain("Promise.all");
  });

  it("Task 3: Should fetch and format user balance", function () {
    expect(code).to.contain("contract.balanceOf(user)");
    expect(code).to.contain(
      "ethers.utils.formatUnits(rawBalance, info.decimals)",
    );
    expect(code).to.contain("setBalance(");
  });
});
