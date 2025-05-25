const { expect } = require("chai");

describe("BarangayAidVault", function () {
  let vault, owner, donor, recipient, other;

  beforeEach(async () => {
    [owner, donor, recipient, other] = await ethers.getSigners();
    const BarangayAidVault = await ethers.getContractFactory(
      "BarangayAidVault"
    );
    vault = await BarangayAidVault.connect(owner).deploy();
    await vault.waitForDeployment();
  });

  it("Should set the owner on deployment", async () => {
    expect(await vault.owner()).to.equal(owner.address);
  });

  it("Should allow a donor to deposit aid", async () => {
    const amount = ethers.parseEther("1");

    await expect(
      vault.connect(donor).depositAid(recipient.address, { value: amount })
    )
      .to.emit(vault, "AidDeposited")
      .withArgs(donor.address, recipient.address, amount);

    const claimable = await vault.claimable(recipient.address);
    expect(claimable).to.equal(amount);
  });

  it("Should revert if deposit is zero", async () => {
    await expect(
      vault.connect(donor).depositAid(recipient.address, { value: 0 })
    ).to.be.revertedWith("Cannot send 0 ETH");
  });

  it("Should allow recipient to claim aid", async () => {
    const amount = ethers.parseEther("1");

    await vault.connect(donor).depositAid(recipient.address, { value: amount });

    await expect(vault.connect(recipient).claimAid())
      .to.emit(vault, "AidClaimed")
      .withArgs(recipient.address, amount);

    const updated = await vault.claimable(recipient.address);
    expect(updated).to.equal(0);
  });

  it("Should revert if no aid to claim", async () => {
    await expect(vault.connect(recipient).claimAid()).to.be.revertedWith(
      "Nothing to claim"
    );
  });

  it("Should allow owner to emergency withdraw", async () => {
    const amount = ethers.parseEther("2");

    await vault.connect(donor).depositAid(recipient.address, { value: amount });

    // recipient does not claim, funds still in contract
    await expect(vault.connect(owner).emergencyWithdraw())
      .to.emit(vault, "EmergencyWithdrawn")
      .withArgs(amount);
  });

  it("Should revert emergency withdraw if not owner", async () => {
    await expect(vault.connect(other).emergencyWithdraw()).to.be.revertedWith(
      "Not authorized"
    );
  });

  it("Should revert emergency withdraw if balance is 0", async () => {
    await expect(vault.connect(owner).emergencyWithdraw()).to.be.revertedWith(
      "No funds"
    );
  });
});
