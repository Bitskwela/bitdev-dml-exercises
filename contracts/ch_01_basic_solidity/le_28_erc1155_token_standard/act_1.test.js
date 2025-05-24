const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MultiAsset", function () {
  let contract;
  let owner, addr1;

  const GOLD = 1;
  const ARTIFACT = 2;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const MultiAsset = await ethers.getContractFactory("MultiAsset");
    contract = await MultiAsset.deploy();
  });

  it("should have correct initial metadata URI", async function () {
    expect(await contract.uri(GOLD)).to.equal(
      "https://api.bitskwela.com/metadata/{id}.json"
    );
  });

  it("should mint initial Gold and Artifact to owner", async function () {
    const goldBalance = await contract.balanceOf(owner.address, GOLD);
    const artifactBalance = await contract.balanceOf(owner.address, ARTIFACT);

    expect(goldBalance).to.equal(1000);
    expect(artifactBalance).to.equal(1);
  });

  it("should allow the owner to mint more tokens", async function () {
    await contract.mint(addr1.address, GOLD, 500, "0x");
    const balance = await contract.balanceOf(addr1.address, GOLD);
    expect(balance).to.equal(500);
  });

  it("should allow token transfers (GOLD)", async function () {
    await contract.safeTransferFrom(
      owner.address,
      addr1.address,
      GOLD,
      100,
      "0x"
    );
    const senderBal = await contract.balanceOf(owner.address, GOLD);
    const receiverBal = await contract.balanceOf(addr1.address, GOLD);

    expect(senderBal).to.equal(900);
    expect(receiverBal).to.equal(100);
  });

  it("should allow token transfers (ARTIFACT)", async function () {
    await contract.safeTransferFrom(
      owner.address,
      addr1.address,
      ARTIFACT,
      1,
      "0x"
    );
    const ownerBal = await contract.balanceOf(owner.address, ARTIFACT);
    const addr1Bal = await contract.balanceOf(addr1.address, ARTIFACT);

    expect(ownerBal).to.equal(0);
    expect(addr1Bal).to.equal(1);
  });
});
