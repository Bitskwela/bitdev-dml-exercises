const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BarangayWallet", function () {
  let wallet;
  let user;

  beforeEach(async () => {
    [user] = await ethers.getSigners();
    const BarangayWallet = await ethers.getContractFactory("BarangayWallet");
    wallet = await BarangayWallet.deploy();
    await wallet.waitForDeployment(); // Required in latest Hardhat versions
  });

  it("should accept Ether via receive and update totalReceived", async () => {
    const tx = await user.sendTransaction({
      to: await wallet.getAddress(),
      value: ethers.parseEther("1"),
    });

    await tx.wait();

    const received = await wallet.totalReceived();
    expect(received).to.equal(ethers.parseEther("1"));
  });

  it("should correctly track totalReceived after multiple deposits", async () => {
    const deposit1 = ethers.parseEther("0.3");
    const deposit2 = ethers.parseEther("0.7");

    await user.sendTransaction({
      to: await wallet.getAddress(),
      value: deposit1,
    });
    await user.sendTransaction({
      to: await wallet.getAddress(),
      value: deposit2,
    });

    const total = await wallet.totalReceived();
    expect(total).to.equal(deposit1 + deposit2);
  });

  it("should emit InvalidCall event on fallback", async () => {
    const invalidData = ethers.encodeBytes32String("invalid-call");

    await expect(
      user.sendTransaction({
        to: await wallet.getAddress(),
        value: ethers.parseEther("0.1"),
        data: invalidData,
      })
    )
      .to.emit(wallet, "InvalidCall")
      .withArgs(user.address, ethers.parseEther("0.1"), invalidData);
  });
});
