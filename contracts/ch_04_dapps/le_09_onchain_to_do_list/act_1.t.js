// Hidden grading test for le-09-onchain-to-do-list.

describe("Lesson 09: On-Chain To-Do List", () => {
  it("Task 1: reads the task count and then each task", async () => {
    const ui = await render(Submission);

    expect(ui.called("contract.getTasksCount")).to.equal(
      true,
      "Read getTasksCount() to know how many tasks to fetch.",
    );
    expect(ui.calls("contract.tasks").length).to.equal(
      2,
      `A count of 2 means two tasks(i) reads, got ${ui.calls("contract.tasks").length}.`,
    );
  });

  it("Task 4: renders every task's content", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("Bumili ng bigas", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("Bayaran ang kuryente", `Rendered: "${ui.text()}"`);
  });

  it("Task 4: reflects each task's done state in its checkbox", async () => {
    const ui = await render(Submission);
    const boxes = ui.all("input").filter((n) => n.props?.type === "checkbox");

    expect(boxes.length).to.equal(2, `Expected one checkbox per task, got ${boxes.length}.`);
    expect(boxes[0].props.checked).to.equal(false, "The first task is not done.");
    expect(boxes[1].props.checked).to.equal(true, "The second task is done — its box should be checked.");
  });

  it("Task 2: creates a task from the form", async () => {
    const ui = await render(Submission);
    await ui.type("Ayusin ang bubong");
    await ui.submit();

    const created = ui.calls("contract.createTask");
    expect(created.length).to.not.equal(0, "Submitting the form should call createTask(content).");
    expect(created[0][0]).to.equal(
      "Ayusin ang bubong",
      `createTask() should receive what was typed, got ${JSON.stringify(created[0][0])}.`,
    );
  });

  it("Task 2: waits for the receipt before treating the task as created", async () => {
    const ui = await render(Submission);
    await ui.type("Ayusin ang bubong");
    await ui.submit();

    expect(ui.called("tx.wait")).to.equal(true, "Await tx.wait() — the task is not on-chain until it is mined.");
  });

  it("Task 2: ignores an empty submission", async () => {
    const ui = await render(Submission);
    await ui.submit();

    expect(ui.called("contract.createTask")).to.equal(
      false,
      "An empty task should not cost a transaction.",
    );
  });

  it("Task 3: toggles a task when its checkbox is changed", async () => {
    const ui = await render(Submission);
    const boxes = ui.all("input").filter((n) => n.props?.type === "checkbox");
    await boxes[0].props.onChange({ target: { checked: true } });
    await ui.settle();

    const toggled = ui.calls("contract.toggleDone");
    expect(toggled.length).to.not.equal(0, "Changing a checkbox should call toggleDone(taskId).");
    expect(Number(toggled[0][0])).to.equal(0, `toggleDone() should receive that task's id, got ${toggled[0][0]}.`);
  });
});
