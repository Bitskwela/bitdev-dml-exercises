/**
 * Hidden test for le_19_the_timer_that_launched_a_startup.
 *
 * Intervals in the harness do not fire on their own — `tick()` advances them —
 * so "three seconds passed" is asserted rather than waited for, and the result
 * never depends on real timing.
 *
 * `setTimeout` still resolves on the microtask queue, which is why the delayed
 * greeting is awaited rather than ticked.
 */

describe("le_19_the_timer_that_launched_a_startup", () => {
  it("logs the greeting after the delay, not immediately", async () => {
    const before = logs().length;
    Submission.delayedGreeting("Det", 500);

    await Promise.resolve();
    await Promise.resolve();

    const printed = logs().slice(before);
    expect(printed.length, "printed lines").equal(
      1,
      "the greeting should be logged once the timer fires",
    );
    expect(printed[0], "greeting").equal("Hello, Det!");
  });

  it("ticks a countdown down to zero and then finishes exactly once", () => {
    const ticks = [];
    let finished = 0;

    Submission.startCountdown(3, (n) => ticks.push(n), () => finished++);
    expect(ticks, "first tick before any time passes").eql(
      [3],
      "the countdown should report its starting value immediately",
    );

    tick(3);
    expect(ticks, "ticks after three rounds").eql([3, 2, 1, 0]);
    expect(finished, "finish count").equal(1);

    // The interval must have cleared itself, or the countdown runs past zero.
    tick(2);
    expect(ticks, "ticks after the countdown ended").eql(
      [3, 2, 1, 0],
      "the interval must be cleared at zero so it cannot keep counting",
    );
    expect(finished, "finish count after extra ticks").equal(1);
  });

  it("starts and stops a repeater, and ignores a double start", () => {
    let runs = 0;
    const repeater = Submission.createRepeater(() => runs++, 100);

    tick(2);
    expect(runs, "runs before start").equal(
      0,
      "a repeater should not run until it is started",
    );

    repeater.start();
    tick(3);
    expect(runs, "runs after starting").equal(3);

    // Starting twice must not register a second interval.
    repeater.start();
    tick(1);
    expect(runs, "runs after a redundant start").equal(
      4,
      "starting an already-running repeater must not double its rate",
    );

    repeater.stop();
    tick(5);
    expect(runs, "runs after stopping").equal(4);

    // Stopping twice must not throw.
    repeater.stop();
    expect(runs, "runs after a redundant stop").equal(4);
  });
});
