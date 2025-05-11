const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Calculator with MathLibrary", function () {
  let calculator;

  beforeEach(async function () {
    const Calculator = await ethers.getContractFactory("Calculator");
    calculator = await Calculator.deploy();
    await calculator.waitForDeployment();
  });

  it("should correctly calculate the sum using MathLibrary", async function () {
    const x = 7;
    const y = 5;
    const result = await calculator.calculateSum(x, y);
    expect(result).to.equal(x + y);
  });

  it("should correctly calculate the product using MathLibrary", async function () {
    const x = 6;
    const y = 4;
    const result = await calculator.calculateProduct(x, y);
    expect(result).to.equal(x * y);
  });
});
