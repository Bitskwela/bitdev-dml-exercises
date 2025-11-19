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

**Question 2:** Mode "w" does:
A. Appends
B. Truncates & writes
C. Reads only
D. Binary mode

**Question 3:** Mode "a" purpose:
A. Read from start
B. Append to end
C. Delete file
D. Binary read

**Question 4:** f.readlines() returns:
A. Single string
B. List of lines
C. Dictionary
D. Integer count

**Question 5:** Encoding="utf-8" ensures:
A. Faster speed
B. Proper character decoding
C. Binary mode
D. Auto-close

---
# Quiz 2
## Scenario: Safe File Ops
Rhea Joy enforces best practices.

**Question 6:** Context manager benefit:
A. Slower execution
B. Auto-closes file
C. Manual tracking required
D. No advantage

**Question 7:** Iterate file lines:
A. for line in f:
B. while f:
C. f.loop()
D. f.iterate()

**Question 8:** Check file existence:
A. file.exists()
B. os.path.exists("file")
C. open("file").check()
D. path.valid("file")

**Question 9:** Binary file mode:
A. "r"
B. "rb"
C. "b"
D. "bin"

**Question 10:** Overwrite risk with:
A. Mode "r"
B. Mode "w"
C. Mode "a"
D. Mode "r+"

---
## Answers
1: B  
2: B  
3: B  
4: B  
5: B  
6: B  
7: A  
8: B  
9: B  
10: B  

---
## Detailed Explanations
Q1 with open("file") as f: context manager.  
Q2 "w" truncates existing file.  
Q3 "a" appends without erasing.  
Q4 readlines() returns list.  
Q5 UTF-8 handles diverse characters.  
Q6 Context manager auto-closes.  
Q7 Direct iteration over file object.  
Q8 os.path.exists checks presence.  
Q9 "rb" binary read mode.  
Q10 "w" overwrites file.  

---
**Next:** Proceed to Lesson 19 exercises.