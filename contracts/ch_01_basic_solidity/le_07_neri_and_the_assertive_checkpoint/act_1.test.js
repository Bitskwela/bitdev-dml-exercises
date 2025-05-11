const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HackanaDefense", function () {
  let defense, owner, outsider;

  beforeEach(async function () {
    [owner, outsider] = await ethers.getSigners();
    const HackanaDefense = await ethers.getContractFactory("HackanaDefense");
    defense = await HackanaDefense.connect(owner).deploy();
  });

  it("should update criticalData and assert it is non-negative", async function () {
    await defense.connect(owner).updateCriticalData(42);
    const value = await defense.criticalData();
    expect(value).to.equal(42);
  });

  it("should allow the owner to call restrictedUpdate", async function () {
    await defense.connect(owner).restrictedUpdate(100);
    const value = await defense.criticalData();
    expect(value).to.equal(100);
  });

  it("should revert if non-owner calls restrictedUpdate", async function () {
    await expect(
      defense.connect(outsider).restrictedUpdate(200)
    ).to.be.revertedWith(
      "Access denied: Only the owner can update critical data."
    );
  });
});
