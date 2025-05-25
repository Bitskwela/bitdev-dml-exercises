const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SecureNFT", function () {
  let nftContract;
  let owner, otherUser;

  beforeEach(async () => {
    [owner, otherUser] = await ethers.getSigners();

    const NFT = await ethers.getContractFactory("SecureNFT");
    nftContract = await NFT.deploy();
    await nftContract.waitForDeployment();
  });

  it("should mint NFT when called by the owner", async () => {
    const tokenURI = "https://example.com/nft/1.json";

    await nftContract.connect(owner).mintNFT(owner.address, tokenURI);

    const ownerOfToken = await nftContract.ownerOf(1);
    const fetchedTokenURI = await nftContract.tokenURI(1);
    const total = await nftContract.totalSupply();

    expect(ownerOfToken).to.equal(owner.address);
    expect(fetchedTokenURI).to.equal(tokenURI);
    expect(total).to.equal(1);
  });

  it("should not allow non-owners to mint", async () => {
    const tokenURI = "https://example.com/nft/unauthorized.json";

    await expect(
      nftContract.connect(otherUser).mintNFT(otherUser.address, tokenURI)
    )
      .to.be.revertedWithCustomError(nftContract, "OwnableUnauthorizedAccount")
      .withArgs(otherUser.address);
  });

  it("should revert when max supply is reached", async () => {
    const tokenURI = "https://example.com/nft/";

    // Mint up to max supply
    for (let i = 1; i <= 100; i++) {
      await nftContract
        .connect(owner)
        .mintNFT(owner.address, `${tokenURI}${i}.json`);
    }

    // Attempt to mint beyond max supply
    await expect(
      nftContract.connect(owner).mintNFT(owner.address, `${tokenURI}101.json`)
    ).to.be.revertedWith("Max NFT supply reached");
  });
});
