const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 02: Read Smart Contract Data", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should instantiate ethers.Contract correctly in useEffect", function () {
    expect(code).to.contain("new ethers.Contract");
    expect(code).to.contain("process.env.REACT_APP_CONTRACT_ADDRESS");
    expect(code).to.contain("abi");
  });

  it("Task 2: Should call name(), symbol(), and totalMinted()", function () {
    expect(code).to.contain("contract.name()");
    expect(code).to.contain("contract.symbol()");
    expect(code).to.contain("contract.totalMinted()");
  });

  it("Task 3: Should call tokenURIs(tokenId) in fetchTokenURI", function () {
    expect(code).to.contain("contract.tokenURIs(tokenId)");
    expect(code).to.contain("setUri(fetchedUri)");
  });
});
