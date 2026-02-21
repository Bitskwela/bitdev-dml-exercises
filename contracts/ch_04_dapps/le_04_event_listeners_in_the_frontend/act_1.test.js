const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 04: Event Listeners in the Frontend", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should setup event listener on 'WinnerPicked'", function () {
    expect(code).to.contain('contract.on("WinnerPicked"');
    expect(code).to.contain("handleWinnerPicked");
  });

  it("Task 2: Should update history and slice last 5", function () {
    expect(code).to.contain("setHistory");
    expect(code).to.contain("slice(0, 5)");
  });

  it("Task 3: Should cleanup listener in useEffect return", function () {
    expect(code).to.contain("return () => {");
    expect(code).to.contain('contract.off("WinnerPicked"');
  });
});
