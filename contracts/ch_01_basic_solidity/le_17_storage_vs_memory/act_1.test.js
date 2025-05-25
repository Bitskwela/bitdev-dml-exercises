const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DataOptimization", function () {
  let dataOptimization;

  beforeEach(async function () {
    const DataOptimization = await ethers.getContractFactory(
      "DataOptimization"
    );
    dataOptimization = await DataOptimization.deploy(); // Deploy the contract
  });

  it("should update the storedMessage when updateMessage is called", async function () {
    const newMessage = "New message stored";
    await dataOptimization.updateMessage(newMessage);

    // Get the stored message from the contract
    const storedMessage = await dataOptimization.storedMessage();
    expect(storedMessage).to.equal(newMessage);
  });

  it("should return the same message from storage and memory in compareStorageAndMemory", async function () {
    const message = await dataOptimization.compareStorageAndMemory();
    expect(message).to.equal("Stored permanently");
  });
});
