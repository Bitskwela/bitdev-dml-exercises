/**
 * Hidden test for le_04_online_jeep_fare_calculator.
 *
 * `calculateFare` returns a STRING — `toFixed(2)` — because a fare is money on a
 * screen, not a float. The assertions compare strings for that reason; a student
 * who returns a number fails here, which is the intended lesson.
 *
 * The discount is capped at zero rather than allowed to go negative, so the
 * clamp is tested with a route cheap enough for a senior discount to overshoot.
 */

describe("le_04_online_jeep_fare_calculator", () => {
  it("knows the base fare for each route", () => {
    expect(Submission.getBaseFare("cubao-pasig"), "cubao-pasig").equal(10);
    expect(Submission.getBaseFare("trinoma-qch"), "trinoma-qch").equal(12);
    expect(Submission.getBaseFare("edsa-ortigas"), "edsa-ortigas").equal(11);
  });

  it("falls back to zero for a route it does not serve", () => {
    expect(Submission.getBaseFare("cubao-baguio"), "unknown route").equal(
      0,
      "an unlisted route should fall back to 0, not undefined",
    );
  });

  it("charges the plain fare when there is no discount or luggage", () => {
    expect(Submission.calculateFare("cubao-pasig", "none", false), "plain fare").equal("10.00");
  });

  it("applies the student and senior discounts", () => {
    expect(Submission.calculateFare("trinoma-qch", "student", false), "student").equal("10.00");
    expect(Submission.calculateFare("trinoma-qch", "senior", false), "senior").equal("9.00");
  });

  it("adds the luggage surcharge", () => {
    expect(Submission.calculateFare("trinoma-qch", "none", true), "with luggage").equal("17.00");
  });

  it("applies the discount and the surcharge together", () => {
    expect(Submission.calculateFare("trinoma-qch", "senior", true), "senior + luggage").equal(
      "14.00",
    );
  });

  it("never charges a negative fare", () => {
    expect(Submission.calculateFare("cubao-baguio", "senior", false), "unknown + senior").equal(
      "0.00",
      "a discount larger than the fare must clamp at zero",
    );
  });

  it("returns the fare as a two-decimal string", () => {
    expect(typeof Submission.calculateFare("cubao-pasig", "none", false), "return type").equal(
      "string",
      "a displayed fare is formatted text, not a raw number",
    );
  });

  it("wires the calculator button to the result element", () => {
    Submission.setupFareCalculator();

    el("#route-select").value = "edsa-ortigas";
    el("#discount-select").value = "student";
    el("#luggage-addon").checked = true;

    fire("#calc-btn", "click");

    const shown = el("#fare-result").textContent;
    expect(shown, "displayed fare").contain("14.00", "11 - 2 + 5 = 14.00");
    expect(shown, "displayed fare").contain("Fare:");
  });
});
