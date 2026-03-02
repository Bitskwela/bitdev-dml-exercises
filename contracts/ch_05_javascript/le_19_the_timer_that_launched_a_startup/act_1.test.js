const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 19: The Timer that Launched a Startup", () => {
  beforeAll(() => {
    jest.useFakeTimers();
  });

  afterAll(() => {
    jest.useRealTimers();
  });

  test("delayedGreeting should call console.log after specified delay", () => {
    validateSolution(codePath, (context) => {
      const { delayedGreeting, console } = context;
      delayedGreeting("Juan", 3000);

      jest.advanceTimersByTime(3000);
      expect(console.log).toHaveBeenCalledWith("Hello, Juan!");
    });
  });

  test("startCountdown should execute tick and finish callbacks", () => {
    validateSolution(codePath, (context) => {
      const { startCountdown } = context;
      const onTick = jest.fn();
      const onFinish = jest.fn();

      startCountdown(3, onTick, onFinish);
      expect(onTick).toHaveBeenCalledWith(3);

      jest.advanceTimersByTime(1000);
      expect(onTick).toHaveBeenCalledWith(2);

      jest.advanceTimersByTime(2000);
      expect(onTick).toHaveBeenCalledWith(0);
      expect(onFinish).toHaveBeenCalled();
    });
  });

  test("createRepeater should start and stop an interval", () => {
    validateSolution(codePath, (context) => {
      const { createRepeater } = context;
      const callback = jest.fn();
      const repeater = createRepeater(callback, 1000);

      repeater.start();
      jest.advanceTimersByTime(3000);
      expect(callback).toHaveBeenCalledTimes(3);

      repeater.stop();
      jest.advanceTimersByTime(1000);
      expect(callback).toHaveBeenCalledTimes(3);
    });
  });
});
