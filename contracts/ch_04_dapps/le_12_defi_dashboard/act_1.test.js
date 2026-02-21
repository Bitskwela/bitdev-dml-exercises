const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 12: DeFi Dashboard", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should validate LP address and setup contract", function () {
    expect(code).to.contain("ethers.utils.isAddress(LP_ADDRESS)");
    expect(code).to.contain("new ethers.Contract(LP_ADDRESS, ABI, provider)");
  });

  it("Task 2: Should fetch reserves and total supply", function () {
    expect(code).to.contain("lp.getReserves()");
    expect(code).to.contain("lp.getTotalSupply()");
  });

  it("Task 3: Should update reserves and supply states", function () {
    expect(code).to.contain("setReserves({ r0, r1 })");
    expect(code).to.contain("setSupply(ts)");
  });
});
