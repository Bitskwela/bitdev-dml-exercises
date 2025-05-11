const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CustomerRegistry", function () {
  let registry, user1, user2;

  beforeEach(async function () {
    [user1, user2] = await ethers.getSigners();
    const CustomerRegistry = await ethers.getContractFactory(
      "CustomerRegistry"
    );
    registry = await CustomerRegistry.deploy();
  });

  it("should add a new customer with correct details", async function () {
    await registry.connect(user1).addCustomer("Juan Dela Cruz", 5000);

    const customer = await registry.customers(user1.address);
    expect(customer.name).to.equal("Juan Dela Cruz");
    expect(customer.walletAddress).to.equal(user1.address);
    expect(customer.balance).to.equal(5000);
  });

  it("should return correct customer details from getCustomer", async function () {
    await registry.connect(user2).addCustomer("Maria Clara", 7500);

    const [name, wallet, balance] = await registry.getCustomer(user2.address);
    expect(name).to.equal("Maria Clara");
    expect(wallet).to.equal(user2.address);
    expect(balance).to.equal(7500);
  });
});
