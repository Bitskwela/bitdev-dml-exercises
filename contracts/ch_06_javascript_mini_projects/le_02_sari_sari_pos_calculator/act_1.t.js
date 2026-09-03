/**
 * Hidden test for le_02_sari_sari_pos_calculator.
 *
 * Tasks 1 and 2 are pure classes, so they are exercised directly. Task 3 is the
 * wiring, which is exercised once — `setupPOS` registers listeners, and calling
 * it in more than one `it` would leave two handlers on the same form and record
 * every sale twice.
 *
 * Money is asserted through `toFixed(2)` output rather than raw floats: the
 * lesson's whole point is a receipt a tindera can read.
 */

describe("le_02_sari_sari_pos_calculator", () => {
  it("builds an item that knows its own price", () => {
    const item = new Submission.Item("Sardinas", 25.5);

    expect(item.name, "item name").equal("Sardinas");
    expect(item.price, "item price").equal(25.5);
  });

  it("renders an item as a peso-formatted list row", () => {
    const html = new Submission.Item("Sardinas", 25.5).toHTML();

    expect(html, "row markup").contain("<li>");
    expect(html, "row name").contain("Sardinas");
    expect(html, "row price").contain("25.50", "prices show two decimal places");
  });

  it("totals a cart and empties it on demand", () => {
    const cart = new Submission.Cart();
    expect(cart.getTotal(), "empty cart").equal(0, "an empty cart costs nothing");

    cart.addItem(new Submission.Item("Sardinas", 25.5));
    cart.addItem(new Submission.Item("Kape", 12.25));
    expect(cart.items.length, "items held").equal(2);
    expect(cart.getTotal(), "running total").equal(37.75);

    cart.clearCart();
    expect(cart.items.length, "items after clear").equal(0);
    expect(cart.getTotal(), "total after clear").equal(0);
  });

  it("renders the cart into the list and the total element", () => {
    const cart = new Submission.Cart();
    cart.addItem(new Submission.Item("Sardinas", 25.5));
    cart.addItem(new Submission.Item("Kape", 12.25));

    const list = el("#cart-list");
    const total = el("#cart-total");
    cart.render(list, total);

    expect(list.innerHTML, "cart list").contain("Sardinas");
    expect(list.innerHTML, "cart list").contain("Kape");
    expect(total.textContent, "cart total").equal("37.75");
  });

  it("carts are independent of one another", () => {
    const first = new Submission.Cart();
    const second = new Submission.Cart();
    first.addItem(new Submission.Item("Sardinas", 25.5));

    expect(second.items.length, "second cart").equal(
      0,
      "each Cart must own its own items array",
    );
  });

  it("wires the form so a sale is recorded and the form reset", () => {
    Submission.setupPOS();

    el("#item-name").value = "Sardinas";
    el("#item-price").value = "25.50";
    const prevented = fire("#pos-form", "submit");

    expect(prevented, "submit default").false(
      "the form must call preventDefault, or the page reloads and the cart is lost",
    );
    expect(el("#cart-list").innerHTML, "cart list").contain("Sardinas");
    expect(el("#cart-total").textContent, "cart total").equal("25.50");
    expect(el("#item-name").value, "name input").equal("", "the form should reset for the next item");
    expect(el("#item-price").value, "price input").equal("");

    el("#item-name").value = "Kape";
    el("#item-price").value = "12.25";
    fire("#pos-form", "submit");
    expect(el("#cart-total").textContent, "running total").equal("37.75");

    fire("#clear-cart", "click");
    expect(el("#cart-total").textContent, "total after clearing").equal("0.00");
    expect(el("#cart-list").innerHTML, "list after clearing").equal("");
  });
});
