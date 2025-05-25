const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("LiquidityLocker", function () {
  let locker, owner, user;

  beforeEach(async () => {
    [owner, user] = await ethers.getSigners();
    const Locker = await ethers.getContractFactory("LiquidityLocker");
    locker = await Locker.deploy();
    await locker.waitForDeployment();
  });

  it("Should accept deposits and store user amount", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    const deposit = await locker.deposits(user.address);
    expect(deposit).to.equal(ethers.parseEther("1"));
  });

  it("Should lock deposit for 60 seconds", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    const lockEnd = await locker.lockEnd();
    const now = Math.floor(Date.now() / 1000);

    // Lock end should be roughly current time + 60 seconds
    expect(lockEnd).to.be.greaterThan(now);
  });

  it("Should not allow withdrawal before 60 seconds", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    await expect(locker.connect(user).withdraw()).to.be.revertedWith(
      "Still locked"
    );
  });

  it("Should allow withdrawal after 60 seconds and reset deposit", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    await ethers.provider.send("evm_increaseTime", [61]);
    await ethers.provider.send("evm_mine");

    await locker.connect(user).withdraw();

    const remaining = await locker.deposits(user.address);
    expect(remaining).to.equal(0);
  });

  it("Should reject withdrawal if user never deposited", async function () {
    await expect(locker.connect(user).withdraw()).to.be.revertedWith(
      "No funds"
    );
  });
});
