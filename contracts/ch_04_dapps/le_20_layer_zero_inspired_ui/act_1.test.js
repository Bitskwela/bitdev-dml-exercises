const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 20: LayerZero Inspired UI", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should setup contract for bridging tokens", function () {
    expect(code).to.contain("new ethers.Contract(");
    expect(code).to.contain("process.env.REACT_APP_BRIDGE_ADDR");
  });

  it("Task 2: Should call lockTokens with ETH value", function () {
    expect(code).to.contain("bridge.lockTokens({");
    expect(code).to.contain("value: ethers.utils.parseEther(amt)");
  });

  it("Task 3: Should parse Locked event and return ID", function () {
    expect(code).to.contain("receipt.events.find(");
    expect(code).to.contain('e.event === "Locked"');
    expect(code).to.contain("evt.args.id.toNumber()");
  });
});
