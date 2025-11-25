// Task 1: Print Numbers with For Loop
function printNumbers(start, end) {
  for (let i = start; i <= end; i++) {
    console.log(i);
  }
}

// Task 2: Sum Array Elements with While Loop
function sumArray(numbers) {
  let sum = 0;
  let i = 0;

  while (i < numbers.length) {
    sum = sum + numbers[i];
    i++;
  }

  return sum;
}

// Task 3: Generate Multiplication Table with Nested Loops
function multiplicationTable(size) {
  let table = [];

  for (let i = 0; i < size; i++) {
    let row = [];
    for (let j = 0; j < size; j++) {
      row.push((i + 1) * (j + 1));
    }
    table.push(row);
  }

  return table;
}
