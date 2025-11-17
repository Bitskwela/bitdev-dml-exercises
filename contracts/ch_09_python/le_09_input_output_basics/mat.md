## Lesson 9: Input and Output Basics

Story: A volunteer wants a quick terminal tool: enter resident name, tag stored, summary printed. Tian and Rhea Joy wire simple input/output flows—foundation for scripts.

### 1. Standard Input with input()
```python
name = input("Enter resident name: ")
print("You entered", name)
```
Always returns string; convert types explicitly.

### 2. Input Validation
```python
raw = input("Age: ")
try:
	age = int(raw)
except ValueError:
	age = 0
```

### 3. Basic Printing
```python
print("Approved:", approved_count)
print(f"Total residents: {total}")
```
print adds newline; override with end="".

### 4. Multiple Arguments & sep
```python
print("Ana", "Ben", "Carla", sep=" | ")
```

### 5. Reading Text Files
```python
with open("residents.txt") as f:
	for line in f:
		line = line.strip()
		process(line)
```
with ensures closure.

### 6. Writing Files
```python
data = ["Ana", "Ben"]
with open("out.txt", "w") as f:
	for name in data:
		f.write(name + "\n")
```

### 7. Appending
```python
with open("log.txt", "a") as f:
	f.write("Started run\n")
```

### 8. Encoding Note
```python
open("names.txt", encoding="utf-8")
```
Ensures proper handling of Filipino characters.

### 9. Path Considerations
Use relative paths carefully; prefer explicit or os.path.join for portability.

### 10. Simple CSV Read (Manual)
```python
with open("scores.csv") as f:
	for line in f:
		student, score = line.strip().split(",")
```
Robust parsing → csv module.

### 11. Basic Output Formatting
```python
print("{:<10} {:>5}".format("Name", "Age"))
print("{:<10} {:>5}".format("Ana", 21))
```

### 12. Story Thread
Interactive prompt script deployed: volunteers record attendee names; file persists list; simple feedback loop encourages correct spelling.

### 13. Practice Prompts
1. Prompt for three tags; store in list.
2. Write validated ages to file.
3. Read file lines into list stripping whitespace.
4. Show formatted column output for 3 residents.

### 14. Reflection
Two reasons to use with for file operations.

**Next:** Quiz then exercises.
