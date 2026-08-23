/**
 * Hidden test for le_15_building_from_scratch.
 *
 * Built elements are inspected structurally — tag, text, nesting — rather than
 * by serialising them, so a card assembled with the right shape passes however
 * it was put together.
 */

describe("le_15_building_from_scratch", () => {
  it("builds a card with its title and content nested inside", () => {
    const card = Submission.createCard("Palengke", "Bili na!");
    expect(card.tagName, "card tag").equal("DIV");
    expect(card.className, "card class").contain("card");
    expect(card.children.length, "card children").equal(
      2,
      "a card holds a title and a content element",
    );

    const [title, content] = card.children;
    expect(title.tagName, "title tag").equal("H3");
    expect(title.textContent, "title text").equal("Palengke");
    expect(content.tagName, "content tag").equal("P");
    expect(content.textContent, "content text").equal("Bili na!");
  });

  it("builds one list item per entry, in order", () => {
    const list = Submission.createList(["bigas", "asin", "suka"]);
    expect(list.tagName, "list tag").equal("UL");
    expect(list.children.length, "item count").equal(3);
    expect(
      list.children.map((li) => li.textContent).join(","),
      "item text",
    ).equal("bigas,asin,suka");
    expect(list.children[0].tagName, "item tag").equal("LI");

    expect(Submission.createList([]).children.length, "empty list").equal(0);
  });

  it("removes only the card whose id matches, and reports whether it did", () => {
    const container = document.createElement("div");
    const keep = document.createElement("div");
    const drop = document.createElement("div");
    keep.setAttribute("data-id", "keep");
    drop.setAttribute("data-id", "drop");
    container.appendChild(keep);
    container.appendChild(drop);

    expect(Submission.removeCardById("drop", container), "removed").true();
    expect(container.children.length, "remaining children").equal(1);
    expect(container.children[0], "surviving card").equal(keep);

    expect(Submission.removeCardById("missing", container), "no match").false(
      "removing an id that is not there should report false, not throw",
    );
    expect(container.children.length, "children after no-op").equal(1);
  });
});
