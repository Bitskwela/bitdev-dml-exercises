const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AntiHackanaLedger", function () {
  let AntiHackanaLedger, ledger, user1, user2;

  beforeEach(async function () {
    [user1, user2] = await ethers.getSigners();
    AntiHackanaLedger = await ethers.getContractFactory("AntiHackanaLedger");
    ledger = await AntiHackanaLedger.deploy();
  });

  it("should update user balance using updateBalance", async function () {
    await ledger.updateBalance(user1.address, 1000);
    const balance = await ledger.userBalances(user1.address);
    expect(balance).to.equal(1000);
  });

  it("should return correct balance using getBalance", async function () {
    await ledger.updateBalance(user2.address, 2500);
    const balance = await ledger.getBalance(user2.address);
    expect(balance).to.equal(2500);
  });
});
