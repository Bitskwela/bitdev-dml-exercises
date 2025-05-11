const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HackanaDefense with MathLibrary", function () {
  let hackanaDefense;

  beforeEach(async function () {
    const HackanaDefense = await ethers.getContractFactory("HackanaDefense");
    hackanaDefense = await HackanaDefense.deploy();
    await hackanaDefense.waitForDeployment();
  });

  it("should return the correct fee using calculateFee", async function () {
    const transactionAmount = 1000;
    const feePercent = 5;

    const expectedFee = (transactionAmount * feePercent) / 100;
    const fee = await hackanaDefense.calculateFee(
      transactionAmount,
      feePercent
    );

    expect(fee).to.equal(expectedFee);
  });

  it("should have the correct city set", async function () {
    const city = await hackanaDefense.city();
    expect(city).to.equal("San Juan City");
  });
});
