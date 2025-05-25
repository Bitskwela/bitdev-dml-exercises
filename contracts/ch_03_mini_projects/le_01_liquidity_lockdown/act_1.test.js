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

  it("Should accept ETH deposits and lock it", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    const userDeposit = await locker.deposits(user.address);
    expect(userDeposit).to.equal(ethers.parseEther("1"));

    const lockEnd = await locker.lockEnd();
    expect(lockEnd).to.be.above(0);
  });

  it("Should not allow withdrawal before lock ends", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    await expect(locker.connect(user).withdraw()).to.be.revertedWith(
      "Still locked"
    );
  });

  it("Should allow withdrawal after lock ends", async function () {
    await locker.connect(user).deposit({ value: ethers.parseEther("1") });

    // Increase time by 61 seconds
    await ethers.provider.send("evm_increaseTime", [61]);
    await ethers.provider.send("evm_mine");

    const balanceBefore = await ethers.provider.getBalance(user.address);

    const tx = await locker.connect(user).withdraw();
    const receipt = await tx.wait();
    const gasUsed = receipt.gasUsed * receipt.effectiveGasPrice;

    const balanceAfter = await ethers.provider.getBalance(user.address);
    const depositAmount = ethers.parseEther("1");

    expect(balanceAfter).to.be.closeTo(
      balanceBefore.add(depositAmount).sub(gasUsed),
      ethers.utils.parseEther("0.001")
    );
  });

  it("Should fail to withdraw if user has no funds", async function () {
    await expect(locker.connect(user).withdraw()).to.be.revertedWith(
      "No funds"
    );
  });
});
