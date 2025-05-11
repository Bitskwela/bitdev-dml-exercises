const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DigitalArtToken", function () {
  let DigitalArtToken, digitalArtToken;
  let owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    DigitalArtToken = await ethers.getContractFactory("DigitalArtToken");
    digitalArtToken = await DigitalArtToken.deploy();
  });

  it("should have the correct name and symbol", async function () {
    expect(await digitalArtToken.name()).to.equal("DigitalArtToken");
    expect(await digitalArtToken.symbol()).to.equal("DAT");
  });

  it("should allow the owner to mint an NFT", async function () {
    const tx = await digitalArtToken.mintArt(
      addr1.address,
      "ipfs://metadataURI1"
    );
    await tx.wait();

    expect(await digitalArtToken.ownerOf(1)).to.equal(addr1.address);
    expect(await digitalArtToken.tokenURI(1)).to.equal("ipfs://metadataURI1");
  });

  it("should increment token IDs correctly", async function () {
    await digitalArtToken.mintArt(addr1.address, "ipfs://art1");
    await digitalArtToken.mintArt(addr1.address, "ipfs://art2");

    expect(await digitalArtToken.ownerOf(1)).to.equal(addr1.address);
    expect(await digitalArtToken.ownerOf(2)).to.equal(addr1.address);
  });
});
