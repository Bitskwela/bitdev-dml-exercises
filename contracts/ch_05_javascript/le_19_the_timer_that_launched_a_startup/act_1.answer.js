// Task 1: Delayed Execution
function delayedGreeting(name, ms) {
  const timeoutId = setTimeout(function () {
    console.log(`Hello, ${name}!`);
  }, ms);

  return timeoutId;
}

// Task 2: Simple Countdown
function startCountdown(seconds, onTick, onFinish) {
  let remaining = seconds;

  // Call onTick immediately with initial value
  onTick(remaining);

  const intervalId = setInterval(function () {
    remaining--;
    onTick(remaining);

    if (remaining <= 0) {
      clearInterval(intervalId);
      onFinish();
    }
  }, 1000);

  return intervalId;
}

// Task 3: Stoppable Interval
function createRepeater(callback, ms) {
  let intervalId = null;

  return {
    start: function () {
      if (intervalId === null) {
        intervalId = setInterval(callback, ms);
      }
    },
    stop: function () {
      if (intervalId !== null) {
        clearInterval(intervalId);
        intervalId = null;
      }
    },
  };
}
