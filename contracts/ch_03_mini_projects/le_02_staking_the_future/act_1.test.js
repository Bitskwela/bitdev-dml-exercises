const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SimpleStaker", function () {
  let token, staker, owner, user;
  const initialSupply = ethers.parseEther("1000");
  const stakeAmount = ethers.parseEther("100");

  beforeEach(async () => {
    [owner, user] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("SanJuanToken");
    token = await Token.deploy();
    await token.waitForDeployment();

    // Owner gets tokens and sends to user
    await token.transfer(user.address, ethers.parseEther("100"));

    const Staker = await ethers.getContractFactory("SimpleStaker");
    staker = await Staker.deploy(token.target);
    await staker.waitForDeployment();

    // ✅ Add reward buffer to the contract
    await token.transfer(staker.target, ethers.parseEther("10"));

    // User approves staking
    await token.connect(user).approve(staker.target, ethers.parseEther("100"));
  });

  it("Should allow user to stake tokens", async function () {
    await token.connect(user).approve(staker.target, stakeAmount);
    await staker.connect(user).stake(stakeAmount);

    const stakeInfo = await staker.stakes(user.address);
    expect(stakeInfo.amount).to.equal(stakeAmount);
    expect(stakeInfo.unlockTime).to.be.above(0);
  });

  it("Should not allow unstaking before lock ends", async function () {
    await token.connect(user).approve(staker.target, stakeAmount);
    await staker.connect(user).stake(stakeAmount);

    await expect(staker.connect(user).unstake()).to.be.revertedWith(
      "Still locked"
    );
  });

  it("Should allow unstake after lock time", async function () {
    await token.connect(user).approve(staker.target, stakeAmount);
    await staker.connect(user).stake(stakeAmount);

    // Travel 61 seconds forward
    await ethers.provider.send("evm_increaseTime", [61]);
    await ethers.provider.send("evm_mine");

    const balanceBefore = await token.balanceOf(user.address);

    await staker.connect(user).unstake();

    const balanceAfter = await token.balanceOf(user.address);
    const expectedReward = (stakeAmount * 110n) / 100n;

    expect(balanceAfter - balanceBefore).to.equal(expectedReward);
  });

  it("Should not unstake if nothing was staked", async function () {
    await expect(staker.connect(user).unstake()).to.be.revertedWith(
      "Nothing staked"
    );
  });
});
