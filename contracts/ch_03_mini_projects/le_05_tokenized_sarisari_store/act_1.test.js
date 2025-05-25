const { expect } = require("chai");

describe("SariSariToken", function () {
  let token, owner, user;

  beforeEach(async () => {
    [owner, user] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("SariSariToken");
    token = await Token.connect(owner).deploy();
    await token.waitForDeployment();
  });

  it("Should set the owner and mint 10,000 SST on deployment", async () => {
    const balance = await token.balanceOf(owner.address);
    expect(await token.owner()).to.equal(owner.address);
    expect(balance).to.equal(ethers.parseEther("10000"));
  });

  it("Should allow only owner to mint within max supply", async () => {
    const mintAmount = ethers.parseEther("5000");
    await token.connect(owner).mint(user.address, mintAmount);

    const userBalance = await token.balanceOf(user.address);
    expect(userBalance).to.equal(mintAmount);
  });

  it("Should not allow non-owner to mint", async () => {
    const amount = ethers.parseEther("1000");
    await expect(
      token.connect(user).mint(user.address, amount)
    ).to.be.revertedWith("Not authorized");
  });

  it("Should not mint if it exceeds MAX_SUPPLY", async () => {
    const amount = ethers.parseEther("50001"); // Exceeds 50,000 max
    await expect(
      token.connect(owner).mint(user.address, amount)
    ).to.be.revertedWith("Exceeds cap");
  });
});
