const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CustomErrorExample", function () {
  let contract;
  let owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const CustomErrorExample = await ethers.getContractFactory(
      "CustomErrorExample"
    );
    contract = await CustomErrorExample.deploy();
  });

  it("should initialize with correct owner and balance", async function () {
    expect(await contract.owner()).to.equal(owner.address);
    expect(await contract.checkBalance()).to.equal(1000);
  });

  it("should allow the owner to withdraw within balance", async function () {
    await contract.withdraw(500);
    expect(await contract.checkBalance()).to.equal(500);
  });

  it("should revert with UnauthorizedAccess if non-owner tries to withdraw", async function () {
    await expect(contract.connect(addr1).withdraw(100))
      .to.be.revertedWithCustomError(contract, "UnauthorizedAccess")
      .withArgs(addr1.address);
  });

  it("should revert with InsufficientFunds if amount exceeds balance", async function () {
    await expect(contract.withdraw(2000))
      .to.be.revertedWithCustomError(contract, "InsufficientFunds")
      .withArgs(2000, 1000);
  });
});
