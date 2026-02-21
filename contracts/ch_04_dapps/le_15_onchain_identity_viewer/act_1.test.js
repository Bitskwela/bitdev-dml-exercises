const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 15: On-chain Identity Viewer", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should fetch basic profile data", function () {
    expect(code).to.contain("identity.getProfile(userAddress)");
    expect(code).to.contain("setName(n)");
  });

  it("Task 2: Should iterate and fetch credentials", function () {
    expect(code).to.contain("for (let i = 0; i < credCount; i++)");
    expect(code).to.contain("identity.getCredential(userAddress, i)");
  });

  it("Task 3: Should setup and cleanup ProfileUpdated event listener", function () {
    expect(code).to.contain('identity.on("ProfileUpdated"');
    expect(code).to.contain('identity.removeAllListeners("ProfileUpdated")');
  });
});
