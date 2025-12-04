# CSV and JSON Activity

Practice working with common data interchange formats.

### Task 1: Read CSV with DictReader
```python
import csv

with open("applicants.csv", "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        # Your code to print name and age
        
```

### Task 2: Write CSV with DictWriter
```python
import csv

applicants = [
    {"name": "Ana", "age": 18, "gpa": 3.5},
    {"name": "Ben", "age": 21, "gpa": 3.2}
]

with open("output.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["name", "age", "gpa"])
    # Your code
    
    
```

### Task 3: Load and Access JSON
```python
import json

with open("data.json", "r") as f:
    data = json.load(f)
    # Access nested: data["applicant"]["contact"]["email"]
    
```

### Task 4: DataFrame to JSON
```python
import pandas as pd

df = pd.DataFrame(applicants)
df.to_json("applicants.json", orient="records", indent=2)
```

## Reflection
**Two advantages of JSON over CSV:**
1. _[Supports nested structures]_
2. _[Preserves data types]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
# Task 1
import csv

with open("applicants.csv", "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(f"{row['name']}: {row['age']} years old")

# Task 2
import csv

applicants = [
    {"name": "Ana", "age": 18, "gpa": 3.5},
    {"name": "Ben", "age": 21, "gpa": 3.2}
]

with open("output.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["name", "age", "gpa"])
    writer.writeheader()
    writer.writerows(applicants)

# Task 3
import json

with open("data.json", "r") as f:
    data = json.load(f)
    email = data["applicant"]["contact"]["email"]
    print(email)

# Task 4 - code above is correct
```

**Reflection:** JSON advantages: (1) Hierarchical structures (lists, dicts), (2) Type preservation (bool, null), (3) Standard for web APIs, (4) Human-readable with indentation

</details>
