const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTWithRoyalties", function () {
  let nftContract;
  let creator, buyer, seller;

  beforeEach(async () => {
    [creator, buyer, seller] = await ethers.getSigners();
    const NFTWithRoyalties = await ethers.getContractFactory(
      "NFTWithRoyalties"
    );
    nftContract = await NFTWithRoyalties.connect(creator).deploy(
      creator.address,
      10
    ); // 10% royalty
    await nftContract.waitForDeployment();

    // Give seller initial ownership for test
    await nftContract
      .connect(creator)
      .transferNFT(seller.address, ethers.parseEther("1.0"), {
        value: ethers.parseEther("1.0"),
      });
  });
  it("Should transfer ownership after payment", async () => {
    const salePrice = ethers.parseEther("2.0");

    // Transfer from seller to buyer
    await nftContract
      .connect(seller)
      .transferNFT(buyer.address, salePrice, { value: salePrice });

    // Check new owner
    const newOwner = await nftContract.currentOwner();
    expect(newOwner).to.equal(buyer.address);
  });
});
