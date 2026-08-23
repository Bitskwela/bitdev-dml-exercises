/**
 * Hidden test for le_07_dominate_the_web.
 *
 * DOM work is judged by driving the page: call the setup function, `fire` the
 * event a user would cause, then read what changed. Registering a listener is
 * not enough — a handler that never updates the element fails here, which is
 * the whole point of the lesson.
 */

describe("le_07_dominate_the_web", () => {
  it("writes the welcome message into the element", () => {
    Submission.updateWelcomeMessage("Neri");
    expect(el("#welcome").innerText, "#welcome").equal("Welcome, Neri!");
  });

  it("updates the status only after the button is actually clicked", () => {
    Submission.setupClickHandler();
    expect(el("#status").innerText, "#status before the click").equal(
      "",
      "the status must stay empty until the button is clicked",
    );

    fire("#alertBtn", "click");
    expect(el("#status").innerText, "#status after the click").equal(
      "Button was clicked!",
    );
  });

  it("toggles the content display back and forth", () => {
    const content = el("#content");
    content.style.display = "none";
    Submission.setupToggle();

    fire("#toggleBtn", "click");
    expect(content.style.display, "after first click").equal(
      "block",
      "a hidden element should become visible",
    );

    fire("#toggleBtn", "click");
    expect(content.style.display, "after second click").equal(
      "none",
      "clicking again should hide it — the toggle must go both ways",
    );
  });
});
