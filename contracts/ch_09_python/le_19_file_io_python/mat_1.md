## Background Story

The scholarship system had been running successfully for months, but Tian was starting to notice a problem: every time he closed the program, all the data disappeared. He had to manually re-enter scholarship information every single session because everything lived only in memory. "This is ridiculous," he complained to Rhea Joy. "We process hundreds of applications and then lose everything when the computer restarts."

Rhea Joy had encountered similar frustration. "We need persistence, Kuya. The data needs to survive between sessions. That means reading from and writing to files." She'd read about file I/O operations but had never implemented them in a real project. "How hard can it be? Files are just text, right?"

Kuya Miguel pulled up a terminal and demonstrated the basics. "Reading and writing files is fundamental to real applications. You need to open files safely, handle errors if files don't exist or are corrupted, read data efficiently without loading gigabytes into memory all at once, and write data reliably without corrupting existing information. Always use context managers—the `with` statement—so files close properly even if errors occur."

They implemented a proper file I/O system: scholarship data saved to text files with proper error handling, automatic backups before overwriting, reading large files in chunks to handle growing datasets, and even a simple logging system that tracked all data changes. No more lost data, no more manual re-entry. When the power went out during a thunderstorm and the computer shut down, they restarted with confidence—everything was safely persisted to disk. The scholarship system was becoming reliable, one file operation at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

The scholarship data lived in text files scattered across different folders. Some had applicant names. Others had approval statuses. Tian needed to combine them all.

```python
import os

# Read all applicant names
applicants = []
if os.path.exists("applicants.txt"):
    with open("applicants.txt", "r", encoding="utf-8") as f:
        applicants = [line.strip() for line in f.readlines()]

print(f"Loaded {len(applicants)} applicants")

# Process and write results
with open("processed.txt", "w", encoding="utf-8") as output:
    for applicant in applicants:
        # Process each one
        status = check_eligibility(applicant)
        output.write(f"{applicant}: {status}\n")

print("✓ Processing complete")
```

"File I/O is how programs persist data," Kuya Miguel explained. "Memory is temporary. When your script ends, variables disappear. Files survive."

Rhea Joy built a logging system:

```python
import datetime

def log_action(message):
    timestamp = datetime.datetime.now().isoformat()
    with open("activity.log", "a", encoding="utf-8") as log:
        log.write(f"[{timestamp}] {message}\n")

log_action("Application processing started")
# ... processing ...
log_action("Processed 150 applications")
log_action("Approved: 97, Rejected: 53")
```

The log file became an audit trail—every action timestamped and recorded.

Tian encountered his first encoding error:

```python
# Error: UnicodeDecodeError
with open("applicants.txt") as f:  # Default encoding might not handle Filipino characters
    data = f.read()

# Fixed: Specify UTF-8
with open("applicants.txt", encoding="utf-8") as f:
    data = f.read()
```

"Always specify encoding for text files," Kuya Miguel advised. "UTF-8 handles all languages—English, Tagalog, special characters."

Rhea Joy added error handling:

```python
try:
    with open("data.txt", "r", encoding="utf-8") as f:
        data = f.read()
except FileNotFoundError:
    print("Error: data.txt not found")
    data = None
except PermissionError:
    print("Error: Permission denied")
    data = None
```

The scholarship system now had persistent storage. Applicant data loaded from files. Processing results written to files. Audit logs maintained. Backups possible.

"From volatile memory to permanent storage," Tian marveled. "Files are how programs remember."

_Next up: Working with CSV and JSON!_ 📊

**Next:** Quiz then exercises.