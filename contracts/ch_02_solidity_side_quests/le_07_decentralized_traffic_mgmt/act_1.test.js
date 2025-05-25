const { expect } = require("chai");

describe("TrafficLightManager", function () {
  let trafficLight;

  beforeEach(async () => {
    const TrafficLightManager = await ethers.getContractFactory(
      "TrafficLightManager"
    );
    trafficLight = await TrafficLightManager.deploy();
    await trafficLight.waitForDeployment();
  });

  it("Should set default lights to red", async () => {
    expect(await trafficLight.lightState("intersection1")).to.equal("red");
    expect(await trafficLight.lightState("intersection2")).to.equal("red");
  });

  it("Should change light to green", async () => {
    await trafficLight.changeLight("intersection1", "green");
    expect(await trafficLight.lightState("intersection1")).to.equal("green");
  });

  it("Should revert on invalid light state", async () => {
    await expect(
      trafficLight.changeLight("intersection1", "blue")
    ).to.be.revertedWith("Invalid state");
  });
});
