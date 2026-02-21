const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 14: Simulated Chain Oracle DApp", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should fetch wind speed and released status", function () {
    expect(code).to.contain("relief.windSpeed()");
    expect(code).to.contain("relief.released()");
    expect(code).to.contain("Promise.all");
  });

  it("Task 2: Should fetch bridge contract balance in ETH", function () {
    expect(code).to.contain("provider.getBalance(CONTRACT)");
    expect(code).to.contain("ethers.utils.formatEther(bal)");
  });

  it("Task 3: Should update all status states", function () {
    expect(code).to.contain("setWind(ws.toNumber())");
    expect(code).to.contain("setReleased(rel)");
    expect(code).to.contain("setBalance(");
  });
});
