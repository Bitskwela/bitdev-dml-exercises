## Lesson 12: String Formatting and Manipulation

Story: Report generation: resident names need title case, IDs zero-padded, messages interpolated. Tian learns Python's string toolkit.

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

### 14. Practice Prompts
1. Format float to 3 decimals.
2. Pad resident ID to 6 digits.
3. Title-case mixed-case name.
4. Split CSV line and strip spaces.

### 15. Reflection
Two advantages of f-strings over concatenation.

**Next:** Quiz then exercises.