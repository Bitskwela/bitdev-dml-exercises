const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 18: NFT Minting UI with Image Preview", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should handle missing file", function () {
    expect(code).to.contain("if (!file)");
  });

  it("Task 2: Should create object URL for preview", function () {
    expect(code).to.contain("URL.createObjectURL(file)");
  });

  it("Task 3: Should build metadata object with preview UI", function () {
    expect(code).to.contain("const metadata = {");
    expect(code).to.contain("JSON.stringify(metadata");
  });
});
