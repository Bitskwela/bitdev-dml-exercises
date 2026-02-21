const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 11: Real-time Gas Fee Tracker", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1 & 2: Should setup provider and contract correctly", function () {
    expect(code).to.contain("new ethers.providers.JsonRpcProvider");
    expect(code).to.contain("process.env.REACT_APP_GAS_TRACKER_ADDRESS");
  });

  it("Task 3: Should fetch base fee and update state", function () {
    expect(code).to.contain("contract.getBaseFee()");
    expect(code).to.contain("setBase(fee)");
  });
});
