const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("UserRegistry (Upgradeable)", function () {
  let registry;

  beforeEach(async function () {
    const Registry = await ethers.getContractFactory("UserRegistryV1");
    registry = await upgrades.deployProxy(Registry, [], {
      initializer: "initialize",
    });
  });

  it("should register a user with V1", async function () {
    const [owner] = await ethers.getSigners();

    await registry.registerUser("Alice");
    expect(await registry.getUser(owner.address)).to.equal("Alice");
  });
});
