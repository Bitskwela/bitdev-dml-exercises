/**
 * Hidden test for le_20_drag_it_drop_it_own_it.
 *
 * A drag is three separate events, so the test performs the whole gesture:
 * `dragstart` on the card, then `drop` on the target column, carrying the same
 * `dataTransfer` between them exactly as a browser would. Asserting only that
 * listeners were registered would pass a handler that moves nothing.
 *
 * The three columns are declared in `spec.json` because `setupDragAndDrop`
 * finds them with `querySelectorAll(".column")`.
 */

/** A stand-in for the browser's DataTransfer, shared across one gesture. */
function makeDataTransfer() {
  const data = {};
  return {
    setData: (format, value) => {
      data[format] = String(value);
    },
    getData: (format) => data[format] || "",
  };
}

describe("le_20_drag_it_drop_it_own_it", () => {
  it("builds a draggable task card carrying its id and text", () => {
    const card = Submission.createTaskCard("task1", "Ayusin ang ilaw");
    expect(card.id, "card id").equal("task1");
    expect(card.textContent, "card text").equal("Ayusin ang ilaw");
    expect(card.className, "card class").contain("task-card");
    expect(card.draggable, "draggable").true(
      "a task card must be draggable for the gesture to start",
    );
    expect(card.listenerTypes(), "card listeners").contain("dragstart");
  });

  it("marks a card as dragging and records its id on the transfer", () => {
    const card = Submission.createTaskCard("task2", "Linisin ang kanal");
    const dataTransfer = makeDataTransfer();

    card.dispatchEvent({ type: "dragstart", dataTransfer });
    expect(dataTransfer.getData("text/plain"), "transferred id").equal(
      "task2",
      "dragstart should record which card is moving",
    );
    expect(card.classList.contains("dragging"), "dragging class").true();

    card.dispatchEvent({ type: "dragend", dataTransfer });
    expect(card.classList.contains("dragging"), "dragging after dragend").false(
      "the dragging class must come off when the gesture ends",
    );
  });

  it("allows a drop by preventing the default dragover action", () => {
    Submission.setupDragAndDrop();
    const allowed = fire("#todo", "dragover", {
      dataTransfer: makeDataTransfer(),
    });
    expect(allowed, "dragover default").false(
      "dragover must call preventDefault or the column will not accept a drop",
    );
  });

  it("moves the card into the column it was dropped on", () => {
    Submission.setupDragAndDrop();
    const card = Submission.createTaskCard("task3", "Bantayan ang basura");
    el("#todo").appendChild(card);
    expect(el("#todo").children, "card starts in todo").contain(card);

    const dataTransfer = makeDataTransfer();
    card.dispatchEvent({ type: "dragstart", dataTransfer });
    fire("#doing", "drop", { dataTransfer });

    expect(el("#doing").children, "card moved to doing").contain(
      card,
      "dropping on a column should append the dragged card to it",
    );
    expect(card.classList.contains("dragging"), "dragging cleared").false();
  });
});
