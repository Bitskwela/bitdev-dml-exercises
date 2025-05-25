const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EtherReceiver", function () {
  let etherReceiver;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    const EtherReceiver = await ethers.getContractFactory("EtherReceiver");
    etherReceiver = await EtherReceiver.deploy();
    await etherReceiver.waitForDeployment(); // Use this if ethers v6
  });

  it("should receive Ether and emit PaymentReceived event", async function () {
    const amount = ethers.parseEther("1");

    await expect(etherReceiver.connect(addr1).receivePayment({ value: amount }))
      .to.emit(etherReceiver, "PaymentReceived")
      .withArgs(addr1.address, amount);

    const balance = await etherReceiver.getBalance();
    expect(balance).to.equal(amount);
  });

  it("should return 0 balance initially", async function () {
    const balance = await etherReceiver.getBalance();
    expect(balance).to.equal(0);
  });
});
