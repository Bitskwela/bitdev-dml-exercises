/**
 * Hidden test for le_10_map_filter_rise.
 *
 * `map`/`filter`/`reduce` all return new values, so the input array is checked
 * for mutation too — reaching the right answer by mutating in place is the
 * habit this lesson replaces.
 */

const PRODUCTS = () => [
  { name: "rice", price: 50, stock: 10 },
  { name: "sugar", price: 20, stock: 2 },
  { name: "salt", price: 15, stock: 7 },
];

describe("le_10_map_filter_rise", () => {
  it("maps product names to upper case without touching the input", () => {
    const input = PRODUCTS();
    expect(Submission.getProductNames(input), "names").eql([
      "RICE",
      "SUGAR",
      "SALT",
    ]);
    expect(input[0].name, "original name").equal(
      "rice",
      "the original products must not be modified",
    );
    expect(Submission.getProductNames([]), "empty list").eql([]);
  });

  it("filters to the products below the stock threshold", () => {
    const low = Submission.filterLowStock(PRODUCTS(), 8);
    expect(low.map((p) => p.name).join(","), "low stock").equal("sugar,salt");

    expect(Submission.filterLowStock(PRODUCTS(), 2), "threshold excludes equal")
      .eql([], "stock 2 is not below a threshold of 2");
    expect(
      Submission.filterLowStock(PRODUCTS(), 99).length,
      "everything below",
    ).equal(3);
  });

  it("reduces price x stock into a total inventory value", () => {
    // 50*10 + 20*2 + 15*7 = 500 + 40 + 105
    expect(Submission.calculateTotalValue(PRODUCTS()), "total value").equal(645);
    expect(Submission.calculateTotalValue([]), "empty inventory").equal(
      0,
      "an empty inventory is worth 0, not undefined",
    );
  });
});
