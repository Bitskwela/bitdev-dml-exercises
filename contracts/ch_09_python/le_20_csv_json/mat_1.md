## Background Story

The municipal education office called with a request: "Send us your scholarship data so we can include it in the regional report. We need it in Excel format." Tian looked at his custom text file format—a messy mix of tab-separated values with no clear structure. "Uh... I can copy and paste it?" The officer sighed. "Just export it as CSV. That's the standard."

Meanwhile, a local tech startup wanted to integrate scholarship data into their youth services app. "We need your API to return JSON," their developer explained. "It's the standard format for web APIs." Tian and Rhea Joy looked at each other blankly. They'd heard these terms—CSV and JSON—but had been avoiding learning them, thinking their custom format was good enough.

Kuya Miguel shook his head when he heard about their struggles. "CSV and JSON aren't arbitrary standards—they're universal languages for data exchange. CSV is tabular data that works with Excel, databases, and data analysis tools. JSON is structured data perfect for web APIs and configuration files. Fighting standards is fighting the entire industry. Learn them, use them, benefit from all the tools built around them."

They spent an afternoon refactoring their data layer: Python's built-in `csv` module made reading and writing spreadsheet-compatible files trivial. The `json` module handled serialization and deserialization of complex nested data structures. They could now exchange data seamlessly with Excel, databases, web applications, and other systems. The municipal office got their properly formatted CSV. The startup integrated their scholarship data via clean JSON responses. The scholarship system was becoming interoperable, one standard format at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

The municipal office sent the scholarship data in Excel format. Tian exported it as CSV. Rhea Joy needed to share it with the web developer. She exported it as JSON.

```python
import csv
import json
import pandas as pd

# Read CSV
applicants = []
with open("applicants.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        applicants.append(row)

print(f"Loaded {len(applicants)} from CSV")

# Convert to JSON for API
with open("applicants.json", "w", encoding="utf-8") as f:
    json.dump(applicants, f, indent=2, ensure_ascii=False)

print("✓ Exported to JSON")
```

"CSV is universal," Kuya Miguel explained. "Every spreadsheet program reads it. But it's flat—only rows and columns. JSON handles nested structures: lists, dictionaries, objects."

Rhea Joy encountered nested data:

```json
{
  "applicant": {
    "name": "Rhea Joy Santos",
    "age": 17,
    "contact": {
      "email": "rhea@example.com",
      "phone": "09171234567"
    },
    "requirements": [
      "Birth Certificate",
      "Grades",
      "Interview"
    ]
  }
}
```

"Try that in CSV," she said. "You'd need multiple files or awkward column naming."

Tian used Pandas for heavy lifting:

```python
# Load CSV
df = pd.read_csv("applicants.csv")

# Filter
approved = df[df["status"] == "Approved"]

# Save both formats
approved.to_csv("approved.csv", index=False)
approved.to_json("approved.json", orient="records", indent=2)

print(f"✓ Saved {len(approved)} approved applications")
```

The web developer loved the JSON:

```python
# Easy to consume in web apps
import requests

response = requests.get("http://api.example.com/applicants.json")
applicants = response.json()  # Automatically parsed!

for applicant in applicants:
    print(applicant["name"], applicant["status"])
```

Tian built a data pipeline:

1. Excel → CSV export
2. Python reads CSV with Pandas
3. Process and filter
4. Export JSON for web API
5. Export CSV for reports

"CSV for spreadsheets and reports. JSON for APIs and applications," Kuya Miguel summarized. "Both have their place. Master both formats, and you can move data anywhere."

The scholarship system now integrated with the barangay website. Real-time application status. Approved applicants displayed online. All powered by JSON APIs fed from CSV data sources.

_Next up: Python Modules and Imports!_ 📦

**Next:** Quiz then exercises.