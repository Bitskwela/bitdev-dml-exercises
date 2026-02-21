const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 17: Multi-Network Switch UI", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should handle both wallet and RPC providers", function () {
    expect(code).to.contain("if (window.ethereum)");
    expect(code).to.contain(
      "new ethers.providers.Web3Provider(window.ethereum)",
    );
    expect(code).to.contain("new ethers.providers.JsonRpcProvider(RPC)");
  });

  it("Task 2: Should match chain ID to friendly name", function () {
    expect(code).to.contain("NAMES[id]");
    expect(code).to.contain("idBN.toNumber()");
  });

  it("Task 3: Should setup and cleanup chainChanged listener", function () {
    expect(code).to.contain('window.ethereum.on("chainChanged"');
    expect(code).to.contain('window.ethereum.removeListener("chainChanged"');
    expect(code).to.contain("parseInt(chainHex, 16)");
  });
});
