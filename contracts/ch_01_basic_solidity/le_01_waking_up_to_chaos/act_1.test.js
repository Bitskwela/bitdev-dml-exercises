const { expect } = require("chai");

describe("PalengkePay", function () {
  it("Should update validate the payerName string variable", async function () {
    const PalengkePay = await ethers.getContractFactory("PalengkePay");
    const palengke = await PalengkePay.deploy();

    await palengke.recordPayment("Tindera Maria", 500, "Juan Dela Cruz");

    expect(await palengke.vendorName()).to.equal("Tindera Maria");
    expect(await palengke.totalPayments()).to.equal(500);
    expect(await palengke.payerName()).to.equal("Juan Dela Cruz");
  });
  it("Should validate the recordPayment function", async function () {
    const PalengkePay = await ethers.getContractFactory("PalengkePay");
    const palengke = await PalengkePay.deploy();

    await palengke.recordPayment("Mabangus", 777, "Neri");

    expect(await palengke.vendorName()).to.equal("Mabangus");
    expect(await palengke.totalPayments()).to.equal(777);
    expect(await palengke.payerName()).to.equal("Neri");
  });
});
