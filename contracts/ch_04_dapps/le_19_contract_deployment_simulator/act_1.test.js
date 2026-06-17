const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 19: Contract Deployment Simulator", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should setup signer from BrowserProvider", function () {
    expect(code).to.contain("new ethers.BrowserProvider(window.ethereum)");
    expect(code).to.contain("await provider.getSigner()");
  });

  it("Task 2: Should use ContractFactory with artifact abi and bytecode", function () {
    expect(code).to.contain("new ethers.ContractFactory(");
    expect(code).to.contain("HelloWorldArtifact.abi");
    expect(code).to.contain("HelloWorldArtifact.bytecode");
  });

  it("Task 3: Should deploy contract and wait for confirmation", function () {
    expect(code).to.contain("factory.deploy(greet)");
    expect(code).to.contain("contract.waitForDeployment()");
    expect(code).to.contain("onDeployed(await contract.getAddress())");
  });
});
