const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EtherConverter", function () {
  let converter;

  beforeEach(async function () {
    const Factory = await ethers.getContractFactory("EtherConverter");
    converter = await Factory.deploy();
  });

  it("should convert Ether to Wei correctly", async function () {
    // Call with 2 Ether
    const result = await converter.etherToWei(2);

    // Expected Wei as bigint or BigNumber
    const expectedWei = ethers.parseEther("2"); // bigint in v6+, BigNumber in v5

    // Compare via string to cover both types
    expect(result.toString()).to.equal(expectedWei.toString());
  });

  it("should convert Wei to Ether correctly", async function () {
    // 2 Ether in Wei
    const weiAmount = ethers.parseEther("2");

    const result = await converter.weiToEther(weiAmount);

    // In Solidity it's uint256 => returned as BigNumber or bigint
    // Convert to JavaScript number safely
    const etherValue = typeof result === "bigint" ? result : result.toNumber();

    expect(etherValue).to.equal(2);
  });
});
