const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SanJuanCityToken", function () {
  let token;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("SanJuanCityToken");
    token = await Token.deploy();
  });

  it("should deploy with the correct name and symbol", async function () {
    expect(await token.name()).to.equal("SanJuanToken");
    expect(await token.symbol()).to.equal("SJC");
  });

  it("should mint 1000 tokens to the owner on deployment", async function () {
    const balance = await token.balanceOf(owner.address);
    const expected = ethers.parseUnits("1000", await token.decimals());
    expect(balance).to.equal(expected);
  });

  it("should allow the owner to transfer tokens", async function () {
    const amount = ethers.parseUnits("100", await token.decimals());
    await token.transfer(addr1.address, amount);

    const addr1Balance = await token.balanceOf(addr1.address);
    expect(addr1Balance).to.equal(amount);
  });
});
