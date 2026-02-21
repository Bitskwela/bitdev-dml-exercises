const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Lesson 09: On-Chain To-Do List", function () {
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
  });

  it("Task 1: Should load tasks from the contract", function () {
    expect(code).to.contain("contract.getTasksCount()");
    expect(code).to.contain("contract.tasks(i)");
    expect(code).to.contain("id.toNumber()");
  });

  it("Task 2: Should implement handleCreate for new tasks", function () {
    expect(code).to.contain("contract.createTask(newTask)");
    expect(code).to.contain("tx.wait()");
  });

  it("Task 3: Should implement handleToggle for task status", function () {
    expect(code).to.contain("contract.toggleDone(taskId)");
    expect(code).to.contain("setTasks((prev)");
  });
});
