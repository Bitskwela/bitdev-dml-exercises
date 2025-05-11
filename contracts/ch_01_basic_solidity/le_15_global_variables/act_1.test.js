const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TransactionTracker", function () {
  let tracker;
  let user;

  beforeEach(async function () {
    [user] = await ethers.getSigners(); // Get the test account
    const Tracker = await ethers.getContractFactory("TransactionTracker");
    tracker = await Tracker.deploy(); // Deploy the contract and wait for it to be deployed
    // No need to use .deployed() anymore; it's handled automatically
  });

  it("should log the caller's address and the timestamp when updateTransaction is called", async function () {
    // Call the updateTransaction function
    const tx = await tracker.connect(user).updateTransaction();
    const receipt = await tx.wait(); // Wait for the transaction to be mined

    // Fetch the logged data
    const callerAddress = await tracker.caller();
    const transactionTime = await tracker.transactionTime();

    // Assert that the caller's address is correct
    expect(callerAddress).to.equal(user.address);

    // Assert that the transactionTime is greater than 0 (indicating it was set)
    expect(transactionTime).to.be.gt(0);

    // Optionally check that the timestamp matches the block timestamp
    const block = await ethers.provider.getBlock(receipt.blockNumber);
    expect(transactionTime).to.equal(block.timestamp);
  });

  it("should update caller and transaction time multiple times", async function () {
    // Log the first transaction
    await tracker.connect(user).updateTransaction();
    const firstTransactionTime = await tracker.transactionTime();
    const firstCaller = await tracker.caller();
    expect(firstCaller).to.equal(user.address);
    expect(firstTransactionTime).to.be.gt(0);

    // Call again with a different user
    const [user2] = await ethers.getSigners();
    await tracker.connect(user2).updateTransaction();
    const secondTransactionTime = await tracker.transactionTime();
    const secondCaller = await tracker.caller();
    expect(secondCaller).to.equal(user2.address);
    expect(secondTransactionTime).to.be.gt(firstTransactionTime); // Ensure time updated
  });
});
