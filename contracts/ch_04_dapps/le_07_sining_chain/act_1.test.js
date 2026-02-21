const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 07: Sining Chain", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should convert IPFS URIs to HTTP", function () {
    expect(code).to.contain("convertToHttpUrl");
    expect(code).to.contain("ipfs.io/ipfs/");
  });

  it("Task 2: Should fetch a single NFT's metadata", function () {
    expect(code).to.contain("contract.tokenURI(tokenId)");
    expect(code).to.contain("fetch(httpUri)");
    expect(code).to.contain("setNft({");
  });

  it("Task 3: Should fetch all NFTs owned by the user", function () {
    expect(code).to.contain("contract.balanceOf(account)");
    expect(code).to.contain("contract.tokenOfOwnerByIndex(account, i)");
    expect(code).to.contain("setOwnedNFTs(items)");
  });
});
