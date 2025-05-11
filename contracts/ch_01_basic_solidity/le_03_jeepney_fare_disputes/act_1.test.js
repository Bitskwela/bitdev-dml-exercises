const { expect } = require("chai");
const { BigNumber } = require("ethers");

describe("JeepneyFareSysten", function () {
  let JeepneyFareSystem, jeepneyFareSystem, passenger;

  beforeEach(async function () {
    [passenger] = await ethers.getSigners();
    JeepneyFareSystem = await ethers.getContractFactory("JeepneyFareSystem");
    jeepneyFareSystem = await JeepneyFareSystem.deploy();
  });

  it("Should define a public function named calculateFare", async function () {
    const fare = await jeepneyFareSystem.calculateFare(5);
    expect(fare).to.equal(13 + 5 * 2); // baseFare + distance * 2
  });

  it("Should have a payable function payFare", async function () {
    const distance = 3;
    const fare = await jeepneyFareSystem.calculateFare(distance);

    await expect(
      jeepneyFareSystem.connect(passenger).payFare(distance, {
        value: fare,
      })
    ).to.changeEtherBalance(jeepneyFareSystem, fare);

    const status = await jeepneyFareSystem.hasPaid(passenger.address);
    expect(status).to.be.true;
  });

  it("Should have a view function checkPaymentStatus", async function () {
    // Before payment
    expect(await jeepneyFareSystem.checkPaymentStatus(passenger.address)).to.be
      .false;

    // After payment
    const distance = 2;
    const fare = await jeepneyFareSystem.calculateFare(distance);
    await jeepneyFareSystem.connect(passenger).payFare(distance, {
      value: fare,
    });

    expect(await jeepneyFareSystem.checkPaymentStatus(passenger.address)).to.be
      .true;
  });

  it("Should contain a private function verifyFare", async function () {
    // Private functions cannot be called externally. So we test it indirectly:
    // This means: if you pay an incorrect fare, it should fail (because verifyFare fails internally).
    const distance = 4;
    const incorrectFare = 20; // wrong fare

    await expect(
      jeepneyFareSystem.connect(passenger).payFare(distance, {
        value: incorrectFare,
      })
    ).to.be.revertedWith("Incorrect fare amount.");
  });
});
