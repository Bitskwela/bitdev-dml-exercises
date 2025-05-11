const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BarangayServiceFees", function () {
  let contract;

  beforeEach(async () => {
    const BarangayServiceFees = await ethers.getContractFactory(
      "BarangayServiceFees"
    );
    contract = await BarangayServiceFees.deploy();
  });

  it("should return the certification fee", async function () {
    const fee = await contract.getCertificationFee();
    expect(fee).to.equal(100);
  });

  it("should correctly calculate the total cost for multiple certifications", async function () {
    const total = await contract.calculateTotalCost(3);
    expect(total).to.equal(300);
  });
});
