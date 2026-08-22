// Hidden grading test for le-04-event-listeners-in-the-frontend.

const ALICE = "0xAliceAliceAliceAliceAliceAliceAliceAlice";
const BOB = "0xBobBobBobBobBobBobBobBobBobBobBobBobBob0";

describe("Lesson 04: Event Listeners in the Frontend", () => {
  it("Task 4: shows a waiting state before any winner arrives", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /waiting/i,
      `Before any event, tell the user you are waiting. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 2: subscribes to the WinnerPicked event on mount", async () => {
    const ui = await render(Submission);
    const events = ui.calls("contract.on").map(([event]) => event);

    expect(events).to.contain(
      "WinnerPicked",
      `Subscribe with contract.on("WinnerPicked", handler) inside useEffect. Subscribed to: ${JSON.stringify(events)}`,
    );
  });

  it("Task 2: renders a winner delivered by the event", async () => {
    const ui = await render(Submission);
    const delivered = await ui.emitContract("WinnerPicked", ALICE);

    expect(delivered).to.not.equal(0, "The component never subscribed to any contract event.");
    expect(ui.text()).to.contain(
      ALICE,
      `The winner from the event should appear. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 2: keeps a history, newest first", async () => {
    const ui = await render(Submission);
    await ui.emitContract("WinnerPicked", ALICE);
    await ui.emitContract("WinnerPicked", BOB);

    const items = ui.all("li").map((li) => JSON.stringify(li));
    expect(items.length).to.equal(
      2,
      `Two events should leave two history entries, got ${items.length}.`,
    );
    expect(items[0]).to.contain(BOB, "The newest winner should be first in the history.");
  });

  it("Task 2: caps the history at five entries", async () => {
    const ui = await render(Submission);
    for (let i = 0; i < 7; i += 1) {
      await ui.emitContract("WinnerPicked", `0xWinner${i}`);
    }

    expect(ui.all("li").length).to.equal(
      5,
      `The history should hold at most 5 entries, got ${ui.all("li").length}.`,
    );
  });

  it("Task 3: unsubscribes on cleanup so listeners cannot stack", async () => {
    const ui = await render(Submission);
    ui.unmount();

    const events = ui.calls("contract.off").map(([event]) => event);
    expect(events).to.contain(
      "WinnerPicked",
      "Return a cleanup from useEffect that calls contract.off(...), or every remount adds another listener.",
    );
  });
});
