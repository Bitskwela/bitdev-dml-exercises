## Background Story

The scholarship approval letters looked terrible. Tian's auto-generated messages came out as awkward text blocks: "Applicant MARIA SANTOS ID 1234 APPROVED amount5000barangaySanRoque". No spacing, inconsistent capitalization, no professional formatting whatsoever. Captain Cruz took one look and said, "We can't send these to students. It looks like a spam email or a scam."

Rhea Joy examined the code and found the problem: Tian was just concatenating strings together with plus signs, with no attention to formatting, spacing, or presentation. "Kuya, Python has much better ways to build strings. F-strings, formatting methods, text manipulation functions. We can make these messages look professional."

"Show me," Tian said, embarrassed but eager to learn. Kuya Miguel joined their session and demonstrated string formatting techniques: f-strings for interpolation, `.title()` for proper name capitalization, `.strip()` to clean up whitespace, padding and alignment for tabular data, and even multi-line strings for letter templates. "Think of strings as malleable clay," Miguel said. "You can shape them, clean them, format them exactly how you need."

They redesigned the notification system from scratch: proper greeting lines, capitalized names, formatted currency amounts, aligned columns in summary reports, and even personalized messages based on scholarship tier. The approval letters now looked official and professional, with proper spacing, alignment, and formatting. Captain Cruz reviewed the new output and nodded approvingly. "Now this is something we can send to our students." The scholarship system was becoming polished, one formatted string at a time.

---

## Theory & Lecture Content

### 1. String Concatenation
```python
full = first + " " + last
```

### 2. f-Strings (Formatted String Literals)
```python
name = "Ana"
age = 21
msg = f"Resident {name} is {age} years old."
```

### 3. format() Method
```python
"Score: {}".format(85)
"{name} - {score}".format(name="Ana", score=90)
```

### 4. Alignment & Width
```python
f"{name:<10}"   # left-align, width 10
f"{score:>5}"   # right-align
f"{value:^8}"   # center
```

### 5. Number Formatting
```python
f"{pi:.2f}"       # 3.14 (2 decimals)
f"{count:05d}"    # 00042 (zero-pad)
f"{percent:.1%}"  # 45.0%
```

### 6. Common Methods
```python
s.upper(), s.lower(), s.title(), s.capitalize()
s.strip(), s.lstrip(), s.rstrip()
s.startswith("Bara"), s.endswith(".txt")
s.replace("old", "new")
s.split(","), " ".join(parts)
```

### 7. Slicing
```python
s = "Barangay"
s[0:4]      # "Bara"
s[4:]       # "ngay"
s[::-1]     # reverse
```

### 8. find() and index()
```python
pos = s.find("nga")    # returns index or -1
pos = s.index("nga")   # raises ValueError if not found
```

### 9. Checking Content
```python
s.isdigit(), s.isalpha(), s.isalnum()
s.islower(), s.isupper()
```

### 10. Multi-line Strings
```python
msg = """Line 1
Line 2
Line 3"""
```

### 11. Escape Sequences
```python
"\n" (newline), "\t" (tab), "\\" (backslash), "\"" (quote)
```

### 12. Raw Strings
```python
path = r"C:\Users\Tian\Documents"
```

### 13. Story Thread
Report template: f-strings embed calculations; title() normalizes names; zero-padding formats IDs consistently.

---

## Closing Story

The scholarship approval letters looked unprofessional. Names were in all caps. Resident IDs weren't padded. Amounts had too many decimal places. Tian needed to clean up the text formatting.

```python
# Before: Messy output
name = "RHEA JOY SANTOS"
id_num = "42"
amount = 5000.0
print("Applicant: " + name + " ID: " + id_num + " Amount: " + str(amount))
# Output: "Applicant: RHEA JOY SANTOS ID: 42 Amount: 5000.0"
```

"Let's make this professional," Kuya Miguel said, introducing f-strings and string methods.

```python
# After: Clean formatting
name = "RHEA JOY SANTOS".title()  # "Rhea Joy Santos"
id_num = str(42).zfill(6)  # "000042"
amount = 5000.0

letter = f"""
Dear {name},

Congratulations! Your scholarship application (ID: {id_num}) has been approved.
Award Amount: ₱{amount:,.2f}

Sincerely,
Barangay Scholarship Committee
"""

print(letter)
```

Output:
```
Dear Rhea Joy Santos,

Congratulations! Your scholarship application (ID: 000042) has been approved.
Award Amount: ₱5,000.00

Sincerely,
Barangay Scholarship Committee
```

Rhea Joy was parsing CSV data:

```python
line = "Ana Cruz  ,  17  ,  Iloilo  "
parts = [p.strip() for p in line.split(",")]
name, age, location = parts
print(f"Processed: {name.title()} (age {age})")
```

"String manipulation is everywhere," Kuya Miguel explained. "User input needs cleaning. File data needs parsing. Reports need formatting. Master these methods, and 80% of data munging becomes trivial."

Tian built a resident ID formatter:

```python
def format_resident_id(raw_id):
    # Remove spaces and dashes
    clean = raw_id.replace(" ", "").replace("-", "")
    # Uppercase
    clean = clean.upper()
    # Pad to 8 characters
    return clean.zfill(8)

print(format_resident_id("brgy-42"))  # "BRGY0042"
```

The scholarship system now generated professional documents. Names properly capitalized. IDs consistently formatted. Monetary amounts with commas and two decimals. Template strings embedded with live data.

"Text is the universal interface," Kuya Miguel said. "Files, databases, APIs, user input—it all flows as strings. Format them well, parse them carefully, and your systems communicate clearly."

Rhea Joy generated the final report—150 applicants, each with a perfectly formatted approval letter, ready to print and distribute.

_Next up: Introduction to Quantitative Methods!_ 📊

**Next:** Quiz then exercises.