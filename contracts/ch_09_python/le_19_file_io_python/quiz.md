# Lesson 19 Quiz: File I/O in Python

---
# Quiz 1
## Scenario: Data Persistence
Tian reads/writes applicant records.

**Question 1:** Context manager syntax:
A. open("file")
B. with open("file") as f:
C. file.open("name")
D. read("file")

**Answer:** B  
**Explanation:** with open("file") as f: context manager.

**Question 2:** Mode "w" does:
A. Appends
B. Truncates & writes
C. Reads only
D. Binary mode

**Answer:** B  
**Explanation:** "w" truncates existing file.

**Question 3:** Mode "a" purpose:
A. Read from start
B. Append to end
C. Delete file
D. Binary read

**Answer:** B  
**Explanation:** "a" appends without erasing.

**Question 4:** f.readlines() returns:
A. Single string
B. List of lines
C. Dictionary
D. Integer count

**Answer:** B  
**Explanation:** readlines() returns list.

**Question 5:** Encoding="utf-8" ensures:
A. Faster speed
B. Proper character decoding
C. Binary mode
D. Auto-close

**Answer:** B  
**Explanation:** UTF-8 handles diverse characters.

---
# Quiz 2
## Scenario: Safe File Ops
Rhea Joy enforces best practices.

**Question 6:** Context manager benefit:
A. Slower execution
B. Auto-closes file
C. Manual tracking required
D. No advantage

**Answer:** B  
**Explanation:** Context manager auto-closes.

**Question 7:** Iterate file lines:
A. for line in f:
B. while f:
C. f.loop()
D. f.iterate()

**Answer:** A  
**Explanation:** Direct iteration over file object.

**Question 8:** Check file existence:
A. file.exists()
B. os.path.exists("file")
C. open("file").check()
D. path.valid("file")

**Answer:** B  
**Explanation:** os.path.exists checks presence.

**Question 9:** Binary file mode:
A. "r"
B. "rb"
C. "b"
D. "bin"

**Answer:** B  
**Explanation:** "rb" binary read mode.

**Question 10:** Overwrite risk with:
A. Mode "r"
B. Mode "w"
C. Mode "a"
D. Mode "r+"

**Answer:** B  
**Explanation:** "w" overwrites file.

---
**Next:** Proceed to Lesson 19 exercises.