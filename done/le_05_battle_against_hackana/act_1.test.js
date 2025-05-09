const { expect } = require("chai");
const { ethers } = require("hardhat");

// Imagine this contract is like a barangay community fund in the Philippines!
// People can donate (like for fiesta or calamity), and the barangay captain (owner) can withdraw for projects.

describe("CommunityFund", function () {
  let CommunityFund, fund, owner, donor, outsider;

  // Before each test, deploy a fresh contract and get 3 accounts
  beforeEach(async function () {
    [owner, donor, outsider] = await ethers.getSigners();
    CommunityFund = await ethers.getContractFactory("CommunityFund");
    fund = await CommunityFund.connect(owner).deploy();
  });

  describe("donate function", function () {
    it("should set the fund owner as contract deployer", async function () {
      expect(await fund.fundOwner()).to.equal(owner.address);
    });

    it("should allow valid donations and update totalDonations", async function () {
      // Donor gives 1 ETH (like donating to barangay fund)
      const donationAmount = ethers.parseEther("1.0");
      await fund
        .connect(donor)
        .donate(donationAmount, { value: donationAmount });

      // Check if totalDonations is updated
      const total = await fund.totalDonations();
      expect(total).to.equal(donationAmount);
    });

    it("should reject donation of 0", async function () {
      await expect(
        fund.connect(donor).donate(0, { value: 0 })
      ).to.be.revertedWith("Donation must be greater than zero");
    });
    it("should reject mismatched Ether value and donation amount", async function () {
      await expect(
        fund.connect(donor).donate(ethers.parseEther("1.0"), {
          value: ethers.parseEther("0.5"),
        })
      ).to.be.revertedWith("Insufficient Ether provided");
    });
  });

  describe("withdraw function", function () {
    it("should allow the owner to withdraw funds", async function () {
      const donationAmount = ethers.parseEther("1.0");
      const withdrawAmount = ethers.parseEther("0.5");

      // Donor donates 1 ETH
      await fund
        .connect(donor)
        .donate(donationAmount, { value: donationAmount });

      // Owner withdraws 0.5 ETH
      await expect(fund.connect(owner).withdraw(withdrawAmount)).to.not.be
        .reverted;

      // Check updated balance in the contract
      const updatedTotal = await fund.totalDonations();
      expect(updatedTotal).to.equal(donationAmount - withdrawAmount);
    });

    it("should reject withdrawals from non-owners", async function () {
      await expect(fund.connect(outsider).withdraw(1)).to.be.revertedWith(
        "Only the owner can withdraw funds"
      );
    });
  });
});
