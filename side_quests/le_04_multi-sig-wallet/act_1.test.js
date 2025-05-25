const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MultiSigWallet", function () {
  let wallet, owner, signer1, signer2, nonSigner;

  beforeEach(async () => {
    [owner, signer1, signer2, nonSigner] = await ethers.getSigners();
    const MultiSigWallet = await ethers.getContractFactory("MultiSigWallet");
    wallet = await MultiSigWallet.deploy(
      [owner.address, signer1.address, signer2.address],
      2 // Approval threshold
    );
    await wallet.waitForDeployment();
  });

  it("Should allow signers to propose a transaction", async function () {
    await wallet
      .connect(owner)
      .proposeTransaction(nonSigner.address, ethers.parseEther("1"));
    const txn = await wallet.transactions(0);
    expect(txn.to).to.equal(nonSigner.address);
    expect(txn.value).to.equal(ethers.parseEther("1"));
    expect(txn.executed).to.be.false;
  });

  it("Should allow signers to approve and execute a transaction", async function () {
    await owner.sendTransaction({
      to: wallet.target,
      value: ethers.parseEther("2"),
    });

    await wallet
      .connect(owner)
      .proposeTransaction(nonSigner.address, ethers.parseEther("1"));
    await wallet.connect(owner).approveTransaction(0);
    await wallet.connect(signer1).approveTransaction(0);

    const balanceBefore = await ethers.provider.getBalance(nonSigner.address);
    const tx = await wallet.connect(owner).executeTransaction(0);
    await tx.wait();
    const balanceAfter = await ethers.provider.getBalance(nonSigner.address);

    expect(balanceAfter).to.be.gt(balanceBefore);
  });

  it("Should not allow duplicate approvals", async function () {
    await wallet
      .connect(owner)
      .proposeTransaction(nonSigner.address, ethers.parseEther("1"));
    await wallet.connect(owner).approveTransaction(0);

    await expect(
      wallet.connect(owner).approveTransaction(0)
    ).to.be.revertedWith("Already approved");
  });

  it("Should not allow execution without enough approvals", async function () {
    await wallet
      .connect(owner)
      .proposeTransaction(nonSigner.address, ethers.parseEther("1"));
    await wallet.connect(owner).approveTransaction(0);

    await expect(
      wallet.connect(owner).executeTransaction(0)
    ).to.be.revertedWith("Not enough approvals");
  });

  it("Should not allow non-signers to propose or approve", async function () {
    await expect(
      wallet
        .connect(nonSigner)
        .proposeTransaction(owner.address, ethers.parseEther("1"))
    ).to.be.revertedWith("Not authorized");

    await wallet
      .connect(owner)
      .proposeTransaction(owner.address, ethers.parseEther("1"));

    await expect(
      wallet.connect(nonSigner).approveTransaction(0)
    ).to.be.revertedWith("Not authorized");
  });
});
