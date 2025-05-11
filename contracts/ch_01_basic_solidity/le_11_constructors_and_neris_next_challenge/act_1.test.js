const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BarangayProgram", function () {
  let program;

  beforeEach(async function () {
    const BarangayProgram = await ethers.getContractFactory("BarangayProgram");
    program = await BarangayProgram.deploy("Clean & Green", 1000);
  });

  it("should set program name and starting balance via constructor", async function () {
    expect(await program.programName()).to.equal("Clean & Green");
    expect(await program.startingBalance()).to.equal(1000);
  });

  it("should return program details correctly", async function () {
    const [name, balance] = await program.getProgramDetails();
    expect(name).to.equal("Clean & Green");
    expect(balance).to.equal(1000);
  });
});
