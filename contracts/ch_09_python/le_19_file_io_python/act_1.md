# File I/O Activity

Practice reading and writing files safely.

### Task 1: Read File to List
```python
def read_file_lines(filename):
    # Your code with 'with' statement
    
    
    return lines

lines = read_file_lines("data.txt")
print(f"Read {len(lines)} lines")
```

### Task 2: Write Names to File
```python
names = ["Ana Cruz", "Ben Reyes", "Carla Santos"]

with open("names.txt", "w", encoding="utf-8") as f:
    # Your code to write each name
    
    
```

### Task 3: Append to Log
```python
import datetime

def log_event(message):
    timestamp = datetime.datetime.now().isoformat()
    with open("activity.log", "a", encoding="utf-8") as f:
        # Your code
        

log_event("Application submitted")
```

### Task 4: Check File Exists
```python
import os

if os.path.exists("data.txt"):
    # Your code to read
    
else:
    print("File not found")
```

## Reflection
**Two reasons to use `with` statement:**
1. _[Automatic file closing even if error occurs]_
2. _[Cleaner, more readable code]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
# Task 1
def read_file_lines(filename):
    with open(filename, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f.readlines()]
    return lines

# Task 2
names = ["Ana Cruz", "Ben Reyes", "Carla Santos"]
with open("names.txt", "w", encoding="utf-8") as f:
    for name in names:
        f.write(name + "\n")

# Task 3
import datetime

def log_event(message):
    timestamp = datetime.datetime.now().isoformat()
    with open("activity.log", "a", encoding="utf-8") as f:
        f.write(f"[{timestamp}] {message}\n")

# Task 4
import os

if os.path.exists("data.txt"):
    with open("data.txt", "r", encoding="utf-8") as f:
        data = f.read()
else:
    print("File not found")
```

**Reflection:** Context managers (with) guarantee file closure, prevent resource leaks, handle exceptions gracefully, and make code more Pythonic

</details>
