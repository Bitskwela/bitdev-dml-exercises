const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Marketplace", function () {
  let marketplace;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    const Marketplace = await ethers.getContractFactory("Marketplace");
    marketplace = await Marketplace.deploy();
    await marketplace.waitForDeployment(); // for Ethers v6+
  });

  it("should allow deposit with correct Ether amount", async function () {
    const depositAmount = ethers.parseEther("1");

    await marketplace
      .connect(addr1)
      .deposit(depositAmount, { value: depositAmount });

    const balance = await marketplace.connect(addr1).checkBalance();
    expect(balance).to.equal(depositAmount);
  });

  it("should revert if deposit amount does not match msg.value", async function () {
    const valueSent = ethers.parseEther("1");
    const declaredAmount = ethers.parseEther("2");

    await expect(
      marketplace.connect(addr1).deposit(declaredAmount, { value: valueSent })
    ).to.be.revertedWith("Amount does not match sent Ether");
  });

  it("should allow withdrawal up to balance", async function () {
    const amount = ethers.parseEther("1");

    await marketplace.connect(addr1).deposit(amount, { value: amount });

    await expect(() =>
      marketplace.connect(addr1).withdraw(amount)
    ).to.changeEtherBalance(addr1, amount);

    const balanceAfter = await marketplace.connect(addr1).checkBalance();
    expect(balanceAfter).to.equal(0);
  });

  it("should revert withdrawal if balance is insufficient", async function () {
    const amount = ethers.parseEther("1");

    await expect(
      marketplace.connect(addr1).withdraw(amount)
    ).to.be.revertedWith("Insufficient balance");
  });

  it("should return correct balance using checkBalance", async function () {
    const amount = ethers.parseEther("0.5");

    await marketplace.connect(addr1).deposit(amount, { value: amount });

    const balance = await marketplace.connect(addr1).checkBalance();
    expect(balance).to.equal(amount);
  });
});
