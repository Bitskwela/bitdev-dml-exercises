const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BarangayFund", function () {
  let fund;
  let user;

  beforeEach(async function () {
    [user] = await ethers.getSigners();
    const BarangayFund = await ethers.getContractFactory("BarangayFund");
    fund = await BarangayFund.deploy();
  });

  it("should deposit funds and emit FundUpdated event", async function () {
    const tx = await fund.connect(user).depositFunds(1000);

    await expect(tx).to.emit(fund, "FundUpdated").withArgs(1000, user.address);

    const updatedTotal = await fund.totalFunds();
    expect(updatedTotal).to.equal(1000);
  });

  it("should revert when deposit amount is zero", async function () {
    await expect(fund.depositFunds(0)).to.be.revertedWith(
      "Deposit amount must be greater than zero."
    );
  });
});
