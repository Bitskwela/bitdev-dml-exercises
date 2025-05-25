const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SecureDonation", function () {
  let SecureDonation, secureDonation;
  let owner, addr1, addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    const Contract = await ethers.getContractFactory("SecureDonation");
    secureDonation = await Contract.deploy();
  });

  it("should accept donations and track them correctly", async function () {
    await secureDonation
      .connect(addr1)
      .donate({ value: ethers.parseEther("1") });
    await secureDonation
      .connect(addr2)
      .donate({ value: ethers.parseEther("0.5") });

    expect(await secureDonation.donations(addr1.address)).to.equal(
      ethers.parseEther("1")
    );
    expect(await secureDonation.donations(addr2.address)).to.equal(
      ethers.parseEther("0.5")
    );
    expect(await secureDonation.totalDonations()).to.equal(
      ethers.parseEther("1.5")
    );
  });

  it("should reject zero donations", async function () {
    await expect(
      secureDonation.connect(addr1).donate({ value: 0 })
    ).to.be.revertedWith("Donation must be greater than zero.");
  });

  it("should fail to withdraw if no funds are available", async function () {
    await expect(secureDonation.connect(owner).withdraw()).to.be.revertedWith(
      "No funds to withdraw."
    );
  });
});
