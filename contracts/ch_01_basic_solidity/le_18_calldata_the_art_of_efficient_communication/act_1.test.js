const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BarangayServiceFees", function () {
  let serviceFees;

  beforeEach(async function () {
    const BarangayServiceFees = await ethers.getContractFactory(
      "BarangayServiceFees"
    );
    serviceFees = await BarangayServiceFees.deploy();
  });

  it("should return the correct certification fee", async function () {
    const fee = await serviceFees.getCertificationFee();
    expect(fee).to.equal(100);
  });

  it("should calculate the correct total cost for multiple certifications", async function () {
    const totalCost = await serviceFees.calculateTotalCost(3);
    expect(totalCost).to.equal(300);
  });

  it("should return 0 for zero certifications", async function () {
    const totalCost = await serviceFees.calculateTotalCost(0);
    expect(totalCost).to.equal(0);
  });
});
