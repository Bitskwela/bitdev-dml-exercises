const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 16: Escrow DApp", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should setup JsonRpcProvider and contract", function () {
    expect(code).to.contain("new ethers.providers.JsonRpcProvider(RPC)");
    expect(code).to.contain("new ethers.Contract(ADDR, ABI, provider)");
  });

  it("Task 2: Should fetch all stats using Promise.all", function () {
    expect(code).to.contain("Promise.all([");
    expect(code).to.contain("escrow.buyer()");
    expect(code).to.contain("escrow.seller()");
    expect(code).to.contain("escrow.amount()");
  });

  it("Task 3: Should format amount and update states", function () {
    expect(code).to.contain("ethers.utils.formatEther(amt)");
    expect(code).to.contain("setBuyer(b)");
    expect(code).to.contain("setAmt(a)");
  });
});
