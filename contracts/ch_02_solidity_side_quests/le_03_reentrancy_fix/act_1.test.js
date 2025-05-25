const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PalengkeWallet", function () {
  let wallet, owner, user;

  beforeEach(async () => {
    [owner, user] = await ethers.getSigners();
    const Wallet = await ethers.getContractFactory("PalengkeWallet");
    wallet = await Wallet.deploy();
    await wallet.waitForDeployment();
  });

  it("Should accept deposits", async function () {
    const depositAmount = ethers.parseEther("1");

    await user.sendTransaction({
      to: wallet.target,
      value: depositAmount,
    });

    const balance = await wallet.balances(user.address);
    expect(balance).to.equal(depositAmount);
  });

  it("Should allow withdrawal after deposit", async function () {
    const depositAmount = ethers.parseEther("1");

    await user.sendTransaction({
      to: wallet.target,
      value: depositAmount,
    });

    const tx = await wallet.connect(user).withdraw(depositAmount);
    await tx.wait();

    const balance = await wallet.balances(user.address);
    expect(balance).to.equal(0);
  });

  it("Should not allow withdrawal if balance is too low", async function () {
    await expect(
      wallet.connect(user).withdraw(ethers.parseEther("1"))
    ).to.be.revertedWith("Insufficient balance");
  });
});
