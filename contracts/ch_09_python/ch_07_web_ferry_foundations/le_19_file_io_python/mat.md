## Lesson 19: File I/O in Python

Story: Data lives in files. Tian needs persistent storage for applicant records. Rhea Joy shows reading, writing, and safe handling.

### 1. Opening Files
```python
f = open("data.txt", "r")  # read
content = f.read()
f.close()
```

### 2. Context Manager (Recommended)
```python
with open("data.txt", "r") as f:
    content = f.read()
# auto-closes
```

### 3. File Modes
- "r": read (default)
- "w": write (truncates)
- "a": append
- "r+": read + write
- "rb": binary read

### 4. Reading Methods
```python
f.read()         # entire file
f.readline()     # single line
f.readlines()    # list of lines
for line in f:   # iterate
    process(line.strip())
```

### 5. Writing Files
```python
with open("output.txt", "w") as f:
    f.write("Hello\n")
    f.writelines(["Line1\n", "Line2\n"])
```

### 6. Appending
```python
with open("log.txt", "a") as f:
    f.write("New entry\n")
```

### 7. Binary Files
```python
with open("image.png", "rb") as f:
    data = f.read()
```

### 8. Encoding
```python
open("file.txt", encoding="utf-8")
```
Ensures proper character handling (Filipino text).

### 9. Path Handling
```python
import os
if os.path.exists("data.txt"):
    with open("data.txt") as f:
        ...
```

### 10. Common Pitfalls
- Forgetting to close (use `with`)
- Wrong mode (w overwrites)
- Encoding mismatch
- Path errors (relative vs absolute)

### 11. Story Thread
Load applicant names from file; process each; append approval status to output file.

### 12. Practice Prompts
1. Read file into list of lines.
2. Write list of names to file.
3. Append timestamp to log.
4. Check if file exists before reading.

### 13. Reflection
Two reasons to use context manager over manual close.

**Next:** Quiz then exercises.