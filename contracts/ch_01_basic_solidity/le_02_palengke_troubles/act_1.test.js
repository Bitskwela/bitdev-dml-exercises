const { expect } = require("chai");
const { BigNumber } = require("ethers");

describe("PalengkeLedger", function () {
  let PalengkeLedger, ledger, owner, vendor;

  beforeEach(async function () {
    PalengkeLedger = await ethers.getContractFactory("PalengkeLedger");
    ledger = await PalengkeLedger.deploy();
    [owner, vendor] = await ethers.getSigners();
  });

  it(`Should validate the creation of the following variables:
        1. vendorName,
        2. totalSales,
        3. transactionStatus,
    `, async function () {
    const vendorName = await ledger.vendorName();
    expect(vendorName).to.be.a("string");

    const totalSales = await ledger.totalSales();
    expect(totalSales).to.equal(0);

    const transactionStatus = await ledger.transactionStatus();
    expect(transactionStatus).to.be.a("boolean");
  });

  it("Task #2: Should have a mapping for vendorSales", async function () {
    const initialSales = await ledger.vendorSales(vendor.address);
    expect(initialSales).to.equal(0);
  });
});
