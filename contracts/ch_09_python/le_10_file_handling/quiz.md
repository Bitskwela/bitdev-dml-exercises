# Quiz: File Handling

---

# Quiz 1

## Scenario

Tian needs to save student grades and inventory data permanently. Kuya Miguel tests his understanding of reading from and writing to files.

---

## Question 1

What's the correct way to open a file for reading?

**Choices:**
- A) `file = open("data.txt", "r")`
- B) `file = read("data.txt")`
- C) `file = open("data.txt")`
- D) Both A and C

**Correct Answer:** D

**Explanation:**
Both work because `"r"` (read mode) is the default:
- `open("data.txt", "r")` - explicit read mode
- `open("data.txt")` - implicit read mode (default)

However, being explicit with mode is better practice for clarity.

---

## Question 2

What's the advantage of using `with` statement?

```python
# Method 1
file = open("data.txt", "r")
content = file.read()
file.close()

# Method 2
with open("data.txt", "r") as file:
    content = file.read()
```

**Choices:**
- A) Method 1 is better
- B) Method 2 automatically closes the file
- C) Method 2 is faster
- D) No difference

**Correct Answer:** B

**Explanation:**
The `with` statement automatically closes the file when the block ends, even if an error occurs. This prevents resource leaks and is considered best practice. You don't need to manually call `close()`.

---

## Question 3

What happens with this code?

```python
with open("story.txt", "r") as file:
    content = file.read()
    print(content)
```

**The file doesn't exist.**

**Choices:**
- A) Prints empty string
- B) Creates the file
- C) FileNotFoundError
- D) Prints None

**Correct Answer:** C

**Explanation:**
Opening a file in read mode (`"r"`) when it doesn't exist raises a `FileNotFoundError`. To avoid this, check if the file exists first:
```python
import os
if os.path.exists("story.txt"):
    # read file
```

Or use try-except to handle the error.

---

## Question 4

What's the difference between these modes?

```python
# Mode "w"
with open("data.txt", "w") as file:
    file.write("Hello")

# Mode "a"
with open("data.txt", "a") as file:
    file.write("World")
```

**Choices:**
- A) No difference
- B) "w" overwrites file, "a" appends to end
- C) "w" appends, "a" overwrites
- D) "a" creates new file, "w" doesn't

**Correct Answer:** B

**Explanation:**
- `"w"` (write) - creates new file or **overwrites** existing content
- `"a"` (append) - adds to the **end** of existing file

If the file doesn't exist, both create it. Use "w" carefully as it deletes existing content!

---

## Question 5

What does `input()` always return?

```python
age = input("Age: ")
```

**User types: 16**

But Tian wants to save it to a file. What's the data type?

**Choices:**
- A) int
- B) str
- C) float
- D) Depends on input

**Correct Answer:** B

**Explanation:**
`input()` ALWAYS returns a string, even if the user types numbers. When writing to files, strings work fine. When reading back, remember to convert if needed: `int(age)`.

---

## Question 6

What's the output?

```python
with open("numbers.txt", "w") as file:
    file.write("10")
    file.write("20")
    file.write("30")
```

**What's in the file?**

**Choices:**
- A) 10 20 30 (on separate lines)
- B) 102030 (on one line)
- C) 10\n20\n30
- D) Error

**Correct Answer:** B

**Explanation:**
`write()` doesn't add newlines automatically! The file contains "102030" on one line. To write on separate lines, add `\n`:
```python
file.write("10\n")
file.write("20\n")
file.write("30\n")
```

---

## Question 7

Tian saves grades to a file. What's the correct code?

```python
grades = [85, 90, 78, 92]
```

**Choices:**
- A) 
```python
with open("grades.txt", "w") as file:
    file.write(grades)
```
- B)
```python
with open("grades.txt", "w") as file:
    for grade in grades:
        file.write(str(grade) + "\n")
```
- C)
```python
with open("grades.txt", "w") as file:
    file.write(str(grades))
```
- D) Both B and C

**Correct Answer:** D

**Explanation:**
Option A causes TypeError (can't write list directly). Both B and C work:
- Option B: writes each grade on separate line (better for reading back)
- Option C: writes the entire list as string "[85, 90, 78, 92]"

Option B is generally better for processing later.

---

## Question 8

What's the output?

```python
with open("data.txt", "r") as file:
    line1 = file.readline()
    line2 = file.readline()
    print(line1 + line2)
```

**File contains:**
```
Hello
World
```

**Choices:**
- A) Hello World
- B) Hello\nWorld\n
- C) HelloWorld
- D) Hello World (with newlines preserved)

**Correct Answer:** D

**Explanation:**
`readline()` reads one line INCLUDING the newline character `\n`. So:
- line1 = "Hello\n"
- line2 = "World\n"
- Output: "Hello\nWorld\n" (displays with line breaks)

Use `.strip()` to remove newlines: `line1.strip()`

---

# Quiz 2

## Scenario

Tian continues learning file handling with CSV, JSON, and error handling. Kuya Miguel tests his advanced understanding.

---

## Question 1

What's the best way to read all lines?

```python
# Method 1
with open("data.txt", "r") as file:
    for line in file:
        print(line.strip())

# Method 2
with open("data.txt", "r") as file:
    lines = file.readlines()
    for line in lines:
        print(line.strip())
```

**Choices:**
- A) Method 1 (more memory efficient)
- B) Method 2 (more memory efficient)
- C) Both are the same
- D) Neither works

**Correct Answer:** A

**Explanation:**
Method 1 reads one line at a time (memory efficient, good for large files). Method 2 loads all lines into memory at once (uses more memory). Both work, but Method 1 is preferred for large files.

---

## Question 10

Tian saves student data as CSV. What's correct?

```python
import csv

students = [
    ["Name", "Age", "Grade"],
    ["Tian", 16, 85],
    ["Juan", 17, 90]
]
```

**Choices:**
- A)
```python
with open("students.csv", "w") as file:
    writer = csv.writer(file)
    writer.writerows(students)
```
- B)
```python
with open("students.csv", "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerows(students)
```
- C) Both work, but B is better
- D) Neither works

**Correct Answer:** C

**Explanation:**
Both work, but Option B with `newline=""` prevents extra blank lines on Windows. This is the recommended way to write CSV files:
```python
with open("file.csv", "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerows(data)
```

---

## Question 11

What's the output?

```python
import os

if os.path.exists("data.txt"):
    print("Found")
else:
    print("Not found")
```

**The file doesn't exist.**

**Choices:**
- A) Found
- B) Not found
- C) Error
- D) None

**Correct Answer:** B

**Explanation:**
`os.path.exists()` returns `True` if the file/directory exists, `False` otherwise. Since the file doesn't exist, it prints "Not found". This is useful to check before trying to open files.

---

## Question 12

Tian reads CSV data. What's printed?

```python
import csv

with open("data.csv", "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        print(row["Name"])
```

**File contains:**
```csv
Name,Age
Tian,16
Juan,17
```

**Choices:**
- A) Name Tian Juan
- B) Tian Juan
- C) Name
- D) Error

**Correct Answer:** B

**Explanation:**
`DictReader` reads CSV with headers as dictionary keys. It skips the header row and treats each subsequent row as a dictionary:
- First iteration: `{"Name": "Tian", "Age": "16"}` → prints "Tian"
- Second iteration: `{"Name": "Juan", "Age": "17"}` → prints "Juan"

---

## Question 13

What happens?

```python
try:
    with open("data.txt", "r") as file:
        content = file.read()
        print(content)
except FileNotFoundError:
    print("File not found!")
```

**The file doesn't exist.**

**Choices:**
- A) Prints empty string
- B) Prints "File not found!"
- C) Program crashes
- D) Creates the file

**Correct Answer:** B

**Explanation:**
The try-except block catches the `FileNotFoundError` and executes the except block, printing "File not found!". This is good practice for handling file errors gracefully without crashing the program.

---

## Question 14

What's saved in the file?

```python
import json

student = {
    "name": "Tian",
    "age": 16,
    "grades": [85, 90, 78]
}

with open("student.json", "w") as file:
    json.dump(student, file, indent=4)
```

**Choices:**
- A) String representation of dictionary
- B) Formatted JSON with indentation
- C) Binary data
- D) Error: can't save dictionaries

**Correct Answer:** B

**Explanation:**
`json.dump()` saves Python data structures as formatted JSON. The `indent=4` parameter makes it human-readable with 4-space indentation:
```json
{
    "name": "Tian",
    "age": 16,
    "grades": [85, 90, 78]
}
```

JSON is great for saving complex data structures!

---

## Question 15

How to read the JSON file back?

```python
import json
```

**Choices:**
- A)
```python
with open("data.json", "r") as file:
    data = file.read()
```
- B)
```python
with open("data.json", "r") as file:
    data = json.load(file)
```
- C)
```python
with open("data.json", "r") as file:
    data = json.loads(file)
```
- D) Both A and B

**Correct Answer:** B

**Explanation:**
`json.load(file)` reads JSON from a file object and converts it back to Python data structures. Option A just reads it as a string (not converted). Option C is wrong - `loads()` is for JSON strings, not file objects.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- Opening files: `open(filename, mode)`
- File modes: `"r"` (read), `"w"` (write/overwrite), `"a"` (append)
- `with` statement automatically closes files (best practice)
- FileNotFoundError when reading non-existent files
- `write()` doesn't add newlines automatically - use `\n`
- `input()` returns strings
- `readline()` includes newline character
- Convert data types when needed (str, int, float)

**Quiz 2:**
- Reading lines efficiently with iteration vs `readlines()`
- CSV handling with `csv.writer()` and `csv.DictReader()`
- Use `newline=""` when writing CSV files
- `os.path.exists()` checks if file/directory exists
- Try-except for handling FileNotFoundError gracefully
- JSON handling:
  - `json.dump(data, file)` - write to file
  - `json.load(file)` - read from file
  - `indent=4` for formatted output
- JSON perfect for complex data structures (dicts, lists)

Excellent work! You've completed the Python course! File handling is crucial for data persistence and real-world applications. Congratulations on finishing all 10 lessons! 🎉