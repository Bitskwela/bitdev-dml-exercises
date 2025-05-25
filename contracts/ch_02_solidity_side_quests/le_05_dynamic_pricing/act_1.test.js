const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DynamicPricing", function () {
  let pricing;

  beforeEach(async () => {
    const DynamicPricing = await ethers.getContractFactory("DynamicPricing");
    pricing = await DynamicPricing.deploy();
    await pricing.waitForDeployment();
  });

  it("Should calculate price with demand and time factors", async function () {
    const basePrice = 100; // Base price: 100 units
    const demandFactor = 20; // +20% increase
    const timeFactor = 10; // +10% increase after demand adjustment

    // Step 1: basePrice + 20% = 100 + 20 = 120
    // Step 2: 120 + 10% = 120 + 12 = 132

    const finalPrice = await pricing.calculatePrice(
      basePrice,
      demandFactor,
      timeFactor
    );
    expect(finalPrice).to.equal(132);
  });

  it("Should return base price when factors are 0", async function () {
    const finalPrice = await pricing.calculatePrice(100, 0, 0);
    expect(finalPrice).to.equal(100);
  });

  it("Should handle large percentages correctly", async function () {
    const basePrice = 100;
    const demandFactor = 100; // +100% → 100 + 100 = 200
    const timeFactor = 50; // +50% of 200 → 200 + 100 = 300

    const finalPrice = await pricing.calculatePrice(
      basePrice,
      demandFactor,
      timeFactor
    );
    expect(finalPrice).to.equal(300);
  });

  it("Should return 0 if basePrice is 0", async function () {
    const finalPrice = await pricing.calculatePrice(0, 50, 50);
    expect(finalPrice).to.equal(0);
  });
});
