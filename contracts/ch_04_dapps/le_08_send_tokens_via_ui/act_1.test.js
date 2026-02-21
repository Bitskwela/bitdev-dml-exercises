const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 08: Send Tokens via UI", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should validate recipient address and amount", function () {
    expect(code).to.contain("ethers.utils.isAddress(recipient)");
    expect(code).to.match(/Number\(amount\)\s*>\s*0/);
  });

  it("Task 2: Should setup signer and contract for transfer", function () {
    expect(code).to.contain(
      "new ethers.Contract(contractAddress, ABI, signer)",
    );
    expect(code).to.contain("provider.getSigner()");
  });

  it("Task 3: Should parse units and execute transfer", function () {
    expect(code).to.contain("ethers.utils.parseUnits(amount, decimals)");
    expect(code).to.contain("contract.transfer(recipient, parsedAmount)");
    expect(code).to.contain("tx.wait()");
  });
});
