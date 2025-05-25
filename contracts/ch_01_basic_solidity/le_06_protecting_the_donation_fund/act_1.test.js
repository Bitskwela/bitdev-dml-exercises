const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SecureFund", function () {
  let SecureFund, fund, owner, donor;

  beforeEach(async function () {
    [owner, donor] = await ethers.getSigners();
    SecureFund = await ethers.getContractFactory("SecureFund");
    fund = await SecureFund.connect(owner).deploy();
  });

  it("should accept donations and update totalDonations", async function () {
    const donation = ethers.parseEther("1");
    await fund.connect(donor).donate({ value: donation });
    const total = await fund.totalDonations();
    expect(total).to.equal(donation);
  });

  it("should allow only owner to withdraw", async function () {
    const donation = ethers.parseEther("1");
    await fund.connect(donor).donate({ value: donation });

    await expect(fund.connect(owner).withdraw()).to.not.be.reverted;
  });

  it("should reject withdrawals from non-owners", async function () {
    await expect(fund.connect(donor).withdraw()).to.be.revertedWith(
      "Not the owner"
    );
  });
});
