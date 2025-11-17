## Lesson 20 Exercises: CSV & JSON Practice

---
### 1. Read CSV with DictReader (7 minutes)
Create sample.csv (name, age, barangay). Read and print each row dict.

---
### 2. Write CSV with DictWriter (8 minutes)
List of dicts: [{"name":"Ana","age":21},{"name":"Ben","age":19}]. Write to output.csv with header.

---
### 3. CSV to List Conversion (7 minutes)
Read CSV; convert to list of dicts; filter age > 20; print result.

---
### 4. JSON Load & Access (6 minutes)
Create resident.json: {"name":"Ana","details":{"age":21,"tags":["PWD"]}}. Load and access nested age.

---
### 5. JSON Dump with Indent (6 minutes)
Dict: {"residents":[{"name":"Ana"},{"name":"Ben"}]}. Write to file with indent=2.

---
### 6. JSON String Parse (6 minutes)
String: '{"status":"Approved","count":42}'. Use json.loads; print count.

---
### 7. Pandas CSV Round-Trip (8 minutes)
Create DataFrame (3 rows); write to CSV; read back; verify identical.

---
### 8. Stretch: CSV to JSON Converter (Optional)
Function convert(csv_path, json_path): read CSV via DictReader, write as JSON array.

---
### 9. Reflection (3 minutes)
Two scenarios preferring JSON; two preferring CSV.

---
**Next:** Lesson 21 (Python Modules & Imports).