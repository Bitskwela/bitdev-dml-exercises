## Background Story

Tian's main scholarship script had grown to 847 lines of code in a single file. Scrolling through it had become painful. Finding specific functions took minutes. When Rhea Joy wanted to reuse the eligibility checker for a different project, she had to copy-paste 200 lines and manually fix all the dependencies. "This is unsustainable," she declared. "We need to organize this mess."

The problem became critical when they tried to collaborate with a volunteer developer from a neighboring barangay. "I want to help with the reporting module," he said, "but I can't work in the same file as you without constant conflicts. Can't you split this up?" Tian knew he was right, but he'd never organized code into multiple files before. Everything he'd learned came from single-script tutorials.

Kuya Miguel recognized this as a rite of passage. "Welcome to modular programming. Split your code into logical modules: one for data models, one for validation logic, one for calculations, one for reports. Use imports to bring functionality where you need it. Python's module system is designed for this—folders become packages, files become importable modules. It's not just organization; it's enabling team collaboration and code reuse."

They spent a weekend refactoring: created a `models` folder for data structures, a `validators` folder for checking rules, a `calculators` folder for scholarship math, a `utils` folder for common functions, and a `reports` folder for output generation. Each module had a clear responsibility and clean imports. The main script shrank to 80 lines that just orchestrated the modules. Multiple developers could now work simultaneously without conflicts. Reusing code across projects became trivial. The scholarship system was becoming maintainable, one module at a time.

---

## Theory & Lecture Content

### 1. What Is a Module?
Any .py file is a module. Contains functions, classes, variables.

### 2. Basic Import
```python
import math
print(math.sqrt(16))
```

### 3. Import Specific
```python
from math import sqrt, pi
print(sqrt(16), pi)
```

### 4. Alias
```python
import pandas as pd
import numpy as np
```

### 5. Import All (Discouraged)
```python
from math import *
# pollutes namespace
```

### 6. Creating Your Module
File: utils.py
```python
def greet(name):
    return f"Hello {name}"
```
Main script:
```python
import utils
print(utils.greet("Ana"))
```

### 7. Package (Directory with __init__.py)
```
my_package/
    __init__.py
    module_a.py
    module_b.py
```
Import:
```python
from my_package import module_a
```

### 8. Relative Imports (Within Package)
```python
from . import sibling_module
from .. import parent_module
```

### 9. Standard Library Highlights
- os, sys: system interaction
- datetime: date/time handling
- json, csv: data formats
- random: random numbers
- re: regular expressions
- pathlib: modern path handling

<details>
<summary><strong>Click here to view local installation guide (Optional)</strong></summary>

### 10. Installing Third-Party Packages Locally

If you want to install packages on your local machine, you can use pip:

```bash
pip install requests pandas flask
```

**Note:** This course uses in-browser coding environments with pre-installed packages, so local installation is optional for learning purposes.

</details>

### 10. if __name__ == "__main__":
```python
def main():
    print("Running as script")

if __name__ == "__main__":
    main()
```
Runs only when script executed directly.

### 12. Story Thread
Refactor: validation.py, data_loader.py, report.py; main.py imports and orchestrates.

### 13. Practice Prompts
1. Import datetime; print current date.
2. Create helper.py with utility function; import in main.
3. Use alias for long module name.
4. Demonstrate __name__ == "__main__" pattern.

### 14. Reflection
Two benefits of modular code organization.

---

## Closing Story

Tian's `scholarship.py` file had grown to 800 lines. Validation logic mixed with database code mixed with report generation. Finding bugs was a nightmare.

"Time to modularize," Kuya Miguel declared. "Break it into focused modules."

They refactored:

```
scholarship_system/
├── main.py
├── models.py          # Data structures
├── validation.py      # Eligibility checks
├── database.py        # DB operations
├── reports.py         # Report generation
└── utils.py           # Helper functions
```

**validation.py:**
```python
def check_age(age):
    return age >= 17 and age <= 25

def check_residency(resident):
    return resident.get("is_resident") == True

def check_income(income):
    return income < 50000
```

**main.py:**
```python
import validation
import database
import reports
from datetime import datetime

def process_applications():
    applicants = database.load_applicants()
    approved = []
    
    for applicant in applicants:
        if (validation.check_age(applicant["age"]) and
            validation.check_residency(applicant) and
            validation.check_income(applicant["income"])):
            approved.append(applicant)
    
    database.save_approved(approved)
    reports.generate_summary(approved)
    return len(approved)

if __name__ == "__main__":
    count = process_applications()
    print(f"✓ Processed {count} approvals")
```

"Now each module has one job," Rhea Joy noted. "Testing is easier—I can test `validation.py` without loading the database."

Tian used Python's standard library:

```python
import os
import datetime
import json
import csv
from pathlib import Path

# Modern path handling
data_dir = Path("data")
if not data_dir.exists():
    data_dir.mkdir()

# Timestamps
timestamp = datetime.datetime.now().isoformat()

# File operations
with open(data_dir / "log.txt", "a") as f:
    f.write(f"[{timestamp}] Processing started\n")
```

Kuya Miguel introduced third-party packages:

```bash
pip install requests pandas flask
```

```python
import requests
import pandas as pd
from flask import Flask

# Fetch data from API
response = requests.get("https://api.example.com/schools")
schools = response.json()

# Process with Pandas
df = pd.DataFrame(schools)
print(df.head())
```

The scholarship system transformed from a monolithic 800-line file into an organized package:
- Each module had clear responsibility
- Functions were reusable
- Testing became straightforward
- New features added without breaking existing code

Rhea Joy ran the test suite:

```python
# test_validation.py
from validation import check_age, check_income

def test_age_validation():
    assert check_age(18) == True
    assert check_age(16) == False
    assert check_age(26) == False

def test_income_validation():
    assert check_income(30000) == True
    assert check_income(60000) == False
```

All tests passed. The modular design made verification easy.

"This is how professional codebases work," Kuya Miguel said. "Not one giant file. An ecosystem of focused modules that work together."

Tian committed the refactor: "Refactor: Split monolith into modular package. Separation of concerns."

_Next up: Web Servers and Flask Basics!_ 🌐

**Next:** Quiz then exercises.