const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PalengkeTransactions", function () {
  let palengke;

  beforeEach(async function () {
    const PalengkeTransactions = await ethers.getContractFactory(
      "PalengkeTransactions"
    );
    palengke = await PalengkeTransactions.deploy();
  });

  it("should record a payment and store it in the array", async function () {
    await palengke.recordPayment(100);
    const payment = await palengke.getPayment(0);
    expect(payment).to.equal(100);
  });

  it("should return the total number of payments", async function () {
    await palengke.recordPayment(200);
    await palengke.recordPayment(300);
    const total = await palengke.getTotalPayments();
    expect(total).to.equal(2);
  });

  it("should return the correct payment by index", async function () {
    await palengke.recordPayment(500);
    await palengke.recordPayment(1000);
    const secondPayment = await palengke.getPayment(1);
    expect(secondPayment).to.equal(1000);
  });

  it("should revert if index is out of bounds", async function () {
    await expect(palengke.getPayment(0)).to.be.revertedWith("Invalid index.");
  });
});
