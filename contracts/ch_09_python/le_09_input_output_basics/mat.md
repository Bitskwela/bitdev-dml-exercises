## Background Story

Captain Cruz stood in the doorway of the tech room, arms crossed, looking unimpressed. "Tian, your program is great, but how do I actually use it? I'm not going to edit your code files every time I want to check an applicant's status." Tian's face reddened. In his excitement about algorithms and data structures, he'd forgotten the most basic requirement: the program needed to actually communicate with its users.

Rhea Joy was already thinking ahead. "We need input from users—names, IDs, grades—and we need to display results in a way that makes sense. Right now, everything is just printed as raw data dumps. Parang computer lang ang makakaintindi." Tian realized she was right. His beautiful scholarship system was essentially unusable by normal humans.

Kuya Miguel arrived that afternoon with specific advice. "Start simple. Use `input()` to ask questions and capture answers. Use `print()` to show results, but format them nicely. Add prompts so users know what to enter. Show friendly messages, not cryptic error codes." He demonstrated: instead of printing raw dictionaries, they formatted output into readable sentences like "Maria Santos from Barangay San Roque qualifies for 5,000 pesos scholarship."

They rewrote the user interface, adding clear prompts: "Enter applicant ID:", "Enter GPA (0.0-4.0):", displaying results with proper formatting and helpful messages. They even added a simple menu system letting users choose between different operations. By sunset, Captain Cruz could actually navigate the system himself, entering data and viewing reports without touching any code. The scholarship system was becoming accessible, one user-friendly interaction at a time.

---

## Theory & Lecture Content

### 1. Standard Input with input()
```python
name = input("Enter resident name: ")
print("You entered", name)
```
Always returns string; convert types explicitly.

### 2. Input Validation
```python
raw = input("Age: ")
try:
	age = int(raw)
except ValueError:
	age = 0
```

### 3. Basic Printing
```python
print("Approved:", approved_count)
print(f"Total residents: {total}")
```
print adds newline; override with end="".

### 4. Multiple Arguments & sep
```python
print("Ana", "Ben", "Carla", sep=" | ")
```

### 5. Reading Text Files
```python
with open("residents.txt") as f:
	for line in f:
		line = line.strip()
		process(line)
```
with ensures closure.

### 6. Writing Files
```python
data = ["Ana", "Ben"]
with open("out.txt", "w") as f:
	for name in data:
		f.write(name + "\n")
```

### 7. Appending
```python
with open("log.txt", "a") as f:
	f.write("Started run\n")
```

### 8. Encoding Note
```python
open("names.txt", encoding="utf-8")
```
Ensures proper handling of Filipino characters.

### 9. Path Considerations
Use relative paths carefully; prefer explicit or os.path.join for portability.

### 10. Simple CSV Read (Manual)
```python
with open("scores.csv") as f:
	for line in f:
		student, score = line.strip().split(",")
```
Robust parsing → csv module.

### 11. Basic Output Formatting
```python
print("{:<10} {:>5}".format("Name", "Age"))
print("{:<10} {:>5}".format("Ana", 21))
```

### 12. Story Thread
Interactive prompt script deployed: volunteers record attendee names; file persists list; simple feedback loop encourages correct spelling.

### 13. Practice Prompts
1. Prompt for three tags; store in list.
2. Write validated ages to file.
3. Read file lines into list stripping whitespace.
4. Show formatted column output for 3 residents.

### 14. Reflection
Two reasons to use with for file operations.

---

## Closing Story

The barangay volunteers needed a simple way to record resident attendance at the health seminar. Tian built a command-line script that morning:

```python
print("=== Barangay Health Seminar Attendance ===")
print()

attendees = []
while True:
    name = input("Enter resident name (or 'done' to finish): ").strip()
    if name.lower() == "done":
        break
    if name:
        attendees.append(name)
        print(f"✓ Added: {name}")

# Save to file
with open("attendance.txt", "w") as f:
    for attendee in attendees:
        f.write(f"{attendee}\n")

print(f"\n✓ Saved {len(attendees)} attendees to attendance.txt")
```

Rhea Joy tested it at the hall's computer. Type a name, press Enter. Type another. Type 'done' when finished. The file appeared instantly—one name per line, ready to print or email.

"This is so much better than pen and paper," she said, opening the text file. "No more illegible handwriting. No more lost lists."

Kuya Miguel showed them how to read it back:

```python
with open("attendance.txt", "r") as f:
    attendees = [line.strip() for line in f.readlines()]

print("=== Attendees ===")
for i, name in enumerate(attendees, start=1):
    print(f"{i:2d}. {name}")
```

"Input from users. Output to console. Read from files. Write to files," Kuya Miguel summarized. "These are the four fundamental I/O operations. Master them, and you can build interactive systems."

Tian added formatting:

```python
print(f"{'Name':<20} {'Status':<10}")
print("-" * 30)
for attendee in attendees:
    print(f"{attendee:<20} {'Present':<10}")
```

The output was now tabular, professional. The kind of report the barangay captain could hand to the municipal health officer.

That evening, 47 residents attended the seminar. All 47 names were captured accurately, saved to file, and formatted for the report—all thanks to a 30-line Python script.

"From user interaction to persistent storage," Rhea Joy marveled. "This is how real applications work."

_Next up: Conditionals and Control Flow—making decisions in code!_ 🔀

**Next:** Quiz then exercises.
