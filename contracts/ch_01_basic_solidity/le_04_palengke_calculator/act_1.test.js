const { expect } = require("chai");

describe("PalengkeCalculator", function () {
  let calculator;

  beforeEach(async function () {
    const PalengkeCalculator = await ethers.getContractFactory(
      "PalengkeCalculator"
    );
    calculator = await PalengkeCalculator.deploy();
  });

  it("Should calculate total cost using multiplication", async function () {
    const price = 50;
    const quantity = 4;
    const total = await calculator.calculateTotal(price, quantity);
    expect(total).to.equal(price * quantity); // 200
  });

  it("Should calculate change using subtraction", async function () {
    const totalCost = 150;
    const payment = 200;
    const change = await calculator.calculateChange(totalCost, payment);
    expect(change).to.equal(payment - totalCost); // 50
  });

  it("Should revert if payment is less than total cost", async function () {
    const totalCost = 300;
    const payment = 250;
    await expect(
      calculator.calculateChange(totalCost, payment)
    ).to.be.revertedWith("Insufficient payment.");
  });

  it("Should calculate discount using multiplication", async function () {
    const totalCost = 500;
    const discountPercent = 20; // 20%
    const discountedTotal = await calculator.applyDiscount(
      totalCost,
      discountPercent
    );
    expect(discountedTotal).to.equal(500 - (500 * 20) / 100); // 400
  });

  it("Should revert if discount percentage is more than 100", async function () {
    await expect(calculator.applyDiscount(100, 150)).to.be.revertedWith(
      "Invalid discount percentage."
    );
  });

  it("Should split bill using division", async function () {
    const totalCost = 900;
    const groupSize = 3;
    const perPerson = await calculator.splitBill(totalCost, groupSize);
    expect(perPerson).to.equal(totalCost / groupSize); // 300
  });

  it("Should revert if group size is zero", async function () {
    await expect(calculator.splitBill(100, 0)).to.be.revertedWith(
      "Group size must be greater than zero."
    );
  });
});
