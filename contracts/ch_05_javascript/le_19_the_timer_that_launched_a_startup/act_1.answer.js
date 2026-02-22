// Task 1: Delayed Execution
// setTimeout(): Execute code ONCE after a delay

function delayedGreeting(name, ms) {
  // setTimeout(callback, delay)
  // - callback: function to run
  // - delay: milliseconds to wait (1000ms = 1 second)

  const timeoutId = setTimeout(function () {
    console.log(`Hello, ${name}!`);
  }, ms);

  // setTimeout returns an ID that can be used to cancel it
  // clearTimeout(timeoutId) would cancel the scheduled function
  return timeoutId;
}

// USAGE:
// delayedGreeting("Odessa", 2000);  // Prints "Hello, Odessa!" after 2 seconds

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
