## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+3.0+-+COVER.png)

📚 One afternoon, after dismissals, Odessa found herself sitting in the school's computer lab with a tedious task at hand. She needed to create lists of section names to be inputted into the school's database system. Normally, this wouldn’t be such a problem, but her school, based on the outskirts of Manila, had been abruptly split into multiple sections due to an increase in enrollment. She was dealing with hundreds of section names!

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+3.1.png)

With her fingers getting tired from the monotony, and her mind numb from the sheer repetition, 💡an idea sparked in Odessa's mind. She remembered her ongoing JavaScript lectures and thought, "Why not use what I've learned so far to make this task more manageable?" She decided to create a name-list generator using JavaScript 'loops'.

As she began to automate these repetitive tasks, she soon realized that the code she wrote was saving her an immense amount of time and energy. She was amazed at the power she held in her hands. Before long, her classmates started noticing her efficiency and began to approach her for help. Through this experience, Odessa gained confidence in her coding skills and started to believe that she might actually have a talent for programming. 💻✨

## Theory & Lecture Content

### What Are Loops?

**Think of loops like doing laps around a track** 🏃‍♀️. Instead of writing "run one lap" 100 times, you say "run laps until you've completed 100." That's exactly what loops do in code—they repeat actions automatically until a condition is met.

🔍 **Loops** in JavaScript are powerful programming structures that allow us to execute a block of code multiple times until a certain condition is met. They save you from writing repetitive code and make automation possible.

### Why Loops Matter

Without loops, this is what you'd have to write:

```js
console.log("Section A-1");
console.log("Section A-2");
console.log("Section A-3");
// ...imagine writing this 100 times!
```

With loops, you can do:

```js
for (let i = 1; i <= 100; i++) {
  console.log(`Section A-${i}`);
}
```

**That's the power of loops!** Write once, run many times.

### 1. For Loop (When You Know How Many Times)

Use a `for` loop when **you know in advance how many times** you need to repeat something.

**Syntax:**

```js
for (initialization; condition; increment / decrement) {
  // code to be executed
}
```

**Breaking it down:**

1. **Initialization**: Set up a counter variable (usually `let i = 0`)
2. **Condition**: Keep looping while this is true (e.g., `i < 5`)
3. **Increment**: Update the counter after each loop (e.g., `i++`)

**Example: Print numbers 0 to 4**

```js
for (let i = 0; i < 5; i++) {
  console.log(i); // 0, 1, 2, 3, 4
}
```

**What happens step by step:**

1. `let i = 0` – Start with i = 0
2. Check `i < 5` – Is 0 < 5? Yes, run the code
3. Print `0`
4. `i++` – Increment i to 1
5. Check `i < 5` – Is 1 < 5? Yes, run again
6. ...repeat until i = 5
7. Check `i < 5` – Is 5 < 5? No, stop looping

**Counting backwards:**

```js
for (let i = 5; i > 0; i--) {
  console.log(i); // 5, 4, 3, 2, 1
}
console.log("Happy New Year!"); // After loop ends
```

**Looping through an array:**

```js
const fruits = ["Mango", "Banana", "Papaya"];

for (let i = 0; i < fruits.length; i++) {
  console.log(fruits[i]);
}
// Mango
// Banana
// Papaya
```

### 2. While Loop (When You Don't Know How Many Times)

Use a `while` loop when **you don't know in advance** how many times to loop. It keeps going **as long as the condition is true**.

**Syntax:**

```js
while (condition) {
  // code to be executed
}
```

**Example:**

```js
let i = 0;
while (i < 5) {
  console.log(i); // 0, 1, 2, 3, 4
  i++; // IMPORTANT: Don't forget to increment!
}
```

**Real-world example: Withdrawing money**

```js
let balance = 1000;
let withdrawal = 100;

while (balance >= withdrawal) {
  balance = balance - withdrawal;
  console.log(`Withdrew ${withdrawal}. Balance: ${balance}`);
}
// Withdrew 100. Balance: 900
// Withdrew 100. Balance: 800
// ...continues until balance < 100
```

### 3. Do...While Loop (Run At Least Once)

The `do...while` loop is like `while`, but it **always runs at least once** because the condition is checked AFTER the code runs.

**Syntax:**

```js
do {
  // code to be executed
} while (condition);
```

**Example:**

```js
let i = 0;
do {
  console.log(i); // 0, 1, 2, 3, 4
  i++;
} while (i < 5);
```

**When is this useful?**

```js
let userInput;

do {
  userInput = prompt("Enter 'yes' to continue:");
} while (userInput !== "yes");
// Keeps asking until user types "yes"
```

Even if `userInput` started as "yes", the prompt would still show once.

### 4. Nested Loops (Loops Inside Loops)

**Nested loops** put one loop inside another. Think of it like **rows and columns in a table**—the outer loop handles rows, the inner loop handles columns.

**Example: Multiplication table**

```js
for (let row = 1; row <= 3; row++) {
  for (let col = 1; col <= 3; col++) {
    console.log(`${row} × ${col} = ${row * col}`);
  }
}
// 1 × 1 = 1
// 1 × 2 = 2
// 1 × 3 = 3
// 2 × 1 = 2
// 2 × 2 = 4
// 2 × 3 = 6
// 3 × 1 = 3
// 3 × 2 = 6
// 3 × 3 = 9
```

### Choosing the Right Loop

| Loop Type    | Use When...                        | Example Use Case                                |
| ------------ | ---------------------------------- | ----------------------------------------------- |
| `for`        | You know how many times to loop    | Print numbers 1-100, loop through array indices |
| `while`      | You loop until a condition changes | Keep reading input until valid, game loops      |
| `do...while` | You need to run at least once      | Show menu at least once, validate input         |

### Real-World Applications in the Philippines

- **Jeepney routes**: Loop through all stops and print each one
- **Class attendance**: Loop through student list and mark present/absent
- **Sari-sari store inventory**: Loop through products and calculate total stock
- **Barangay registration**: Loop through residents and assign ID numbers
- **Festival schedules**: Print all event times for the entire week

### Common Beginner Mistakes

**1. Infinite Loops (The Loop Never Stops!)**

```js
// ❌ WRONG: i never changes!
let i = 0;
while (i < 5) {
  console.log(i); // Prints 0 forever!
  // Missing i++ here!
}

// ✅ CORRECT: Increment inside the loop
let i = 0;
while (i < 5) {
  console.log(i);
  i++; // Now i increases each time
}
```

**2. Off-By-One Errors**

```js
// ❌ WRONG: Misses the last element!
const items = ["A", "B", "C"];
for (let i = 0; i < items.length - 1; i++) {
  console.log(items[i]); // Only prints A, B (misses C!)
}

// ✅ CORRECT: Include all elements
for (let i = 0; i < items.length; i++) {
  console.log(items[i]); // Prints A, B, C
}
```

**3. Using `var` Instead of `let` in Loops**

```js
// ❌ AVOID: var has function scope, causes bugs
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 100);
}
// Prints: 3, 3, 3 (Huh?!)

// ✅ CORRECT: let has block scope
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 100);
}
// Prints: 0, 1, 2 (As expected!)
```

**4. Forgetting to Initialize the Counter**

```js
// ❌ WRONG: i is undefined!
for (i = 0; i < 5; i++) {
  // Missing 'let'!
  console.log(i);
}

// ✅ CORRECT: Always declare with let
for (let i = 0; i < 5; i++) {
  console.log(i);
}
```

**5. Modifying the Array While Looping**

```js
// ❌ RISKY: Removing items while looping can skip elements
const numbers = [1, 2, 3, 4, 5];
for (let i = 0; i < numbers.length; i++) {
  numbers.pop(); // Don't modify array size in the loop!
}

// ✅ BETTER: Loop backwards or use filter
const numbers = [1, 2, 3, 4, 5];
const filtered = numbers.filter((num) => num > 2);
```

### Loop Control: break and continue

**break** – Exit the loop immediately:

```js
for (let i = 0; i < 10; i++) {
  if (i === 5) {
    break; // Stop at 5
  }
  console.log(i); // 0, 1, 2, 3, 4
}
```

**continue** – Skip to the next iteration:

```js
for (let i = 0; i < 5; i++) {
  if (i === 2) {
    continue; // Skip when i is 2
  }
  console.log(i); // 0, 1, 3, 4 (skips 2)
}
```

For additional details, please check the [Mozilla Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Loops_and_iteration).

## Closing Story

After using loops to automate her work, Odessa was recognized for her efficiency, which boosted her confidence and motivated her to dive deeper into programming. She realized that coding wasn't just about working on abstract stuff, but also about solving real-world problems effectively, which made it exciting. 🎉🚀 What's more, she discovered a new purpose – to help her classmates with their tasks using her newfound knowledge.

Having mastered loops, Odessa is now ready to learn about a new topic which is more fun and equally important – `Objects in JavaScript`.
