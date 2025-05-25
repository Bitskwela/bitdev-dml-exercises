const { expect } = require("chai");

describe("BarangayLending", function () {
  let barangayLending;
  let borrower, lender;

  beforeEach(async () => {
    [borrower, lender] = await ethers.getSigners();
    const BarangayLending = await ethers.getContractFactory("BarangayLending");
    barangayLending = await BarangayLending.deploy();
    await barangayLending.waitForDeployment();
  });

  it("Should allow a user to request a loan", async () => {
    const amount = ethers.parseEther("1");
    const reason = "Buy rice";

    const tx = await barangayLending
      .connect(borrower)
      .requestLoan(amount, reason);
    await tx.wait();

    const loan = await barangayLending.loans(1);
    expect(loan.borrower).to.equal(borrower.address);
    expect(loan.amount).to.equal(amount);
    expect(loan.reason).to.equal(reason);
    expect(loan.isFunded).to.be.false;
  });

  it("Should fund the loan and transfer funds to borrower", async () => {
    const amount = ethers.parseEther("1");
    const reason = "Emergency";

    // Borrower requests a loan
    await barangayLending.connect(borrower).requestLoan(amount, reason);

    // Lender funds the loan
    const tx = await barangayLending
      .connect(lender)
      .fundLoan(1, { value: amount });
    await tx.wait();

    const fundedLoan = await barangayLending.loans(1);
    expect(fundedLoan.isFunded).to.be.true;
    expect(fundedLoan.lender).to.equal(lender.address);
  });

  it("Should revert if loan is already funded", async () => {
    const amount = ethers.parseEther("1");
    await barangayLending.connect(borrower).requestLoan(amount, "Medical");

    await barangayLending.connect(lender).fundLoan(1, { value: amount });

    await expect(
      barangayLending.connect(lender).fundLoan(1, { value: amount })
    ).to.be.revertedWith("Loan already funded");
  });

  it("Should revert if incorrect amount is sent", async () => {
    const amount = ethers.parseEther("1");
    await barangayLending.connect(borrower).requestLoan(amount, "Bills");

    await expect(
      barangayLending
        .connect(lender)
        .fundLoan(1, { value: ethers.parseEther("0.5") })
    ).to.be.revertedWith("Incorrect amount");
  });
});
