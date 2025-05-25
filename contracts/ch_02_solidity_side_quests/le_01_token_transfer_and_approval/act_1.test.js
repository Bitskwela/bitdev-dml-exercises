const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SanJuanToken", function () {
  let token, owner, spender, recipient;
  let amount;

  beforeEach(async () => {
    [owner, spender, recipient] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("SanJuanToken");
    const initialSupply = ethers.parseUnits("1000", "ether");
    token = await Token.deploy(initialSupply);
    await token.waitForDeployment();

    amount = ethers.parseUnits("100", "ether");
  });

  it("should approve and transferFrom correctly", async () => {
    // Owner approves spender
    await token.connect(owner).approve(spender.address, amount);

    // Spender transfers from owner to recipient
    await token
      .connect(spender)
      .transferFrom(owner.address, recipient.address, amount);

    const recipientBalance = await token.balanceOf(recipient.address);
    const updatedAllowance = await token.allowance(
      owner.address,
      spender.address
    );
    const ownerBalance = await token.balanceOf(owner.address);

    expect(recipientBalance).to.equal(amount);
    expect(updatedAllowance).to.equal(0); // Allowance reduced to 0
    expect(ownerBalance).to.equal(ethers.parseUnits("900", "ether")); // 1000 - 100
  });
});
