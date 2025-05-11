const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DerivedContract", function () {
  let contract;

  beforeEach(async function () {
    const DerivedContract = await ethers.getContractFactory("DerivedContract");
    contract = await DerivedContract.deploy();
  });

  it("should set the organization name", async function () {
    await contract.setOrganizationName("Barangay Dev");
    const name = await contract.organizationName();
    expect(name).to.equal("Barangay Dev");
  });

  it("should revert if organization name is empty", async function () {
    await expect(contract.setOrganizationName("")).to.be.revertedWith(
      "Name cannot be empty"
    );
  });

  it("should deposit funds correctly", async function () {
    await contract.depositFunds(500);
    const balance = await contract.fundBalance();
    expect(balance).to.equal(500);
  });

  it("should revert if deposit amount is zero", async function () {
    await expect(contract.depositFunds(0)).to.be.revertedWith(
      "Amount must be greater than zero"
    );
  });
});
