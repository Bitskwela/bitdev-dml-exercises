# Timers Activity

## Initial Code

```js
// Task 1: Delayed Execution
function delayedGreeting(name, ms) {
  // Add your code here
}

// Task 2: Simple Countdown
function startCountdown(seconds, onTick, onFinish) {
  // Add your code here
}

// Task 3: Stoppable Interval
function createRepeater(callback, ms) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `setTimeout`, `setInterval`, `clearTimeout`, `clearInterval`, Timer IDs, Callback Functions

---

### Task 1: Delayed Execution

Create a function that displays a greeting after a specified delay. Use `setTimeout` to schedule the greeting. The function should return the timeout ID so it can be cancelled if needed.

```js
function delayedGreeting(name, ms) {
  const timeoutId = setTimeout(function () {
    console.log(`Hello, ${name}!`);
  }, ms);

  return timeoutId;
}
```

---

### Task 2: Simple Countdown

Create a function that counts down from a given number of seconds. Call `onTick(remaining)` every second with the remaining time, and call `onFinish()` when the countdown reaches zero. Return the interval ID.

```js
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
```

---

### Task 3: Stoppable Interval

Create a function that returns an object with `start()` and `stop()` methods. The `start()` method should begin calling the callback at the specified interval, and `stop()` should clear the interval.

```js
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
```

---

## Breakdown of the Activity

**Variables Defined:**

- `name`: A string parameter representing the name to include in the greeting message.

- `ms`: A numeric parameter representing the delay time in milliseconds (1000ms = 1 second).

- `timeoutId`: The ID returned by `setTimeout`. Used to cancel the timeout with `clearTimeout`.

- `seconds`: The initial countdown value in seconds.

- `remaining`: A counter variable that tracks how many seconds are left in the countdown.

- `intervalId`: The ID returned by `setInterval`. Used to stop the interval with `clearInterval`.

- `onTick`: A callback function called every second with the remaining time.

- `onFinish`: A callback function called when the countdown completes.

- `callback`: A function to be executed repeatedly at each interval.

**Key Concepts:**

- `setTimeout(callback, ms)`:
  Schedules a function to run once after a specified delay in milliseconds. Returns a timeout ID that can be used to cancel it.

- `clearTimeout(id)`:
  Cancels a timeout that was set with `setTimeout`. The callback will not be executed if cancelled before the delay.

- `setInterval(callback, ms)`:
  Schedules a function to run repeatedly at fixed intervals. Returns an interval ID. Continues until cleared.

- `clearInterval(id)`:
  Stops a repeating interval. The callback will no longer be called after clearing.

- Timer IDs:
  Both `setTimeout` and `setInterval` return numeric IDs. Store these IDs if you need to cancel the timer later.

- Callback Functions:
  Functions passed as arguments to be executed later. Timers use callbacks to specify what code should run when the timer fires.

- Closure:
  Inner functions retain access to variables from their outer scope. This allows `remaining` to be accessed and modified inside the interval callback.

**Key Functions:**

- `delayedGreeting(name, ms)`:
  Demonstrates basic `setTimeout` usage for one-time delayed execution. Returns the ID for potential cancellation.

- `startCountdown(seconds, onTick, onFinish)`:
  Shows how to use `setInterval` with a decrementing counter. Demonstrates clearing the interval when a condition is met.

- `createRepeater(callback, ms)`:
  Demonstrates the pattern of encapsulating timer control in an object with start/stop methods. Shows how to prevent multiple intervals from being created.
