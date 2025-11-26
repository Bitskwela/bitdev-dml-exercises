# Javascript Conditional Statements and Logical Operators

## Background Story
Odessa, an IT student in the Philippines is also a student council member 🏛️. One of her responsibilities is to manage the student council budget. As the year progresses, she begins to notice discrepancies in the entries, especially after events 🎉. There are entries that are either too high or too low to be standard expenditures. 

To simplify her work 👩‍💻 and make everything more efficient, Odessa decides to write a script to filter these entries. Her plan is to write code that checks each entry and determines if it's above or below the standard limit. This is her first encounter with conditional statements, and she's excited to learn how to use them to make smart decisions in her code. 

With your help, she will learn how to write 'if' and 'else' statements, how to use comparison operators (>, <, >=, <=, ==, !=), and logical operators (&&, ||, !) in JavaScript 💻.

## Theory & Lecture Content

JavaScript if...else statement: Control structures are used to control the flow of execution in a program. The *if* statement is the simplest form of control structure. It evaluates whether a statement is true or false, and then runs a set of statements based on the result. If the statement is true, it will execute the block of code within the if statement. If it's false, and there's an else statement, it will execute the code within the else statement.

Example:
```js
var budget = 5000;
if (budget > 4000) {
  console.log("Budget is within the limit");
} else {
  console.log("Budget is beyond the limit");
}
```

Comparison Operators: We use these operators to compare values. Here are some examples:
- `>`: Greater than
- `<`: Less than
- `>=`: Greater than or equal to
- `<=`: Less than or equal to
- `==`: Equal to
- `!=`: Not equal to 

Logical Operators: We use these operators to make more complex logical expressions:
- `&&` - AND
- `||` - OR
- `!` - NOT

You can learn more about comparison and logical operators [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators#comparison_operators)


## Closing Story

With a few lines of code, Odessa has made her work more efficient. Now, whenever there's a budget entry, the script is run and it returns a verdict - if the budget is within range or over limit. She's also managed to clean up the older entries to only include positive values and those less than 5000.

In the process, she's not only learned how to use if...else statements, comparison, and logical operators, but she also saved her time 🕰️ for more important tasks ahead 💡. This was another step on her journey to becoming a full-stack developer, proving to her that with coding, every problem - no matter how daunting - can indeed have a solution.