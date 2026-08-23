/**
 * Hidden test for le_18_blueprints_with_classes.
 *
 * Classes are judged through instances: construct one, call its methods, and
 * check the state that results. `Counter` also carries class-level state, so it
 * is exercised across two instances — a per-instance counter would pass a
 * single-instance check and still be wrong.
 */

describe("le_18_blueprints_with_classes", () => {
  it("builds a product and discounts its price", () => {
    const product = new Submission.Product(1, "Bigas", 100);
    expect(product.id, "id").equal(1);
    expect(product.name, "name").equal("Bigas");
    expect(product.price, "price").equal(100);

    product.applyDiscount(25);
    expect(product.price, "price after 25% off").equal(
      75,
      "applyDiscount should reduce the price in place",
    );
    expect(product.toString(), "toString").contain("Bigas");
    expect(product.toString(), "toString").contain("75.00");
  });

  it("builds a user that can greet and change its email", () => {
    const user = new Submission.User("mara", "mara@old.ph");
    expect(user.greet(), "greeting").equal("Hello, mara!");

    user.updateEmail("mara@new.ph");
    expect(user.email, "updated email").equal("mara@new.ph");
    expect(user.username, "username unchanged").equal("mara");
  });

  it("tracks live instances on the class, not on each object", () => {
    const start = Submission.Counter.count;

    const first = new Submission.Counter("a");
    const second = new Submission.Counter("b");
    expect(Submission.Counter.count, "count after two").equal(
      start + 2,
      "the count is shared by the class, so two instances add two",
    );

    first.dispose();
    expect(Submission.Counter.count, "count after one dispose").equal(start + 1);

    second.dispose();
    expect(Submission.Counter.count, "count after both disposed").equal(start);
  });
});
