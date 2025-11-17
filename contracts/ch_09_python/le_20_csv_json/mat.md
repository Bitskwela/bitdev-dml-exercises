## Lesson 20: Working with CSV and JSON

Story: Applicant data arrives as CSV spreadsheet export. API returns JSON. Tian learns structured data interchange formats.

### 1. CSV (Comma-Separated Values)
Plain text table format:
```
name,age,barangay
Ana,21,Sto. Niño
Ben,19,San Jose
```

### 2. Reading CSV (csv module)
```python
import csv
with open("applicants.csv") as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)  # list
```

### 3. DictReader
```python
with open("applicants.csv") as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(row["name"], row["age"])
```

### 4. Writing CSV
```python
data = [["Ana",21],["Ben",19]]
with open("out.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["name","age"])
    writer.writerows(data)
```

### 5. DictWriter
```python
rows = [{"name":"Ana","age":21},{"name":"Ben","age":19}]
with open("out.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["name","age"])
    writer.writeheader()
    writer.writerows(rows)
```

### 6. JSON (JavaScript Object Notation)
```json
{"name": "Ana", "age": 21, "tags": ["PWD","Scholar"]}
```

### 7. Reading JSON
```python
import json
with open("data.json") as f:
    data = json.load(f)
print(data["name"])
```

### 8. Writing JSON
```python
resident = {"name":"Ana","age":21,"tags":["PWD"]}
with open("out.json", "w") as f:
    json.dump(resident, f, indent=2)
```

### 9. JSON String Parsing
```python
json_str = '{"name":"Ana"}'
data = json.loads(json_str)
```

### 10. Pandas Integration
```python
import pandas as pd
df = pd.read_csv("applicants.csv")
df.to_csv("output.csv", index=False)
df.to_json("output.json", orient="records")
```

### 11. Story Thread
Import CSV applicants; process; export filtered subset as JSON for API.

### 12. Practice Prompts
1. Read CSV using DictReader; print each row.
2. Write list of dicts to CSV using DictWriter.
3. Load JSON file; access nested key.
4. Convert DataFrame to JSON.

### 13. Reflection
Two advantages of JSON over CSV for nested data.

**Next:** Quiz then exercises.