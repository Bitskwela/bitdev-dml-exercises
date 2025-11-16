# Lesson 12 Quiz: String Formatting & Manipulation

---
# Quiz 1
## Scenario: Report Formatting
Tian builds clean output strings.

**Question 1:** f-string correct syntax:
A. f"Value: {x}"
B. "Value: {x}".f()
C. f("Value: {x}")
D. format"Value: {x}"

**Question 2:** Align right width 10:
A. f"{x:<10}"
B. f"{x:>10}"
C. f"{x:^10}"
D. f"{x:10<}"

**Question 3:** Format float 2 decimals:
A. f"{val:.2f}"
B. f"{val:2f}"
C. f"{val:.2}"
D. f"{val:f2}"

**Question 4:** Zero-pad integer to 5 digits:
A. f"{n:5d}"
B. f"{n:05d}"
C. f"{n:5.0f}"
D. f"{n:d5}"

**Question 5:** title() effect on "ana cruz":
A. "ANA CRUZ"
B. "Ana cruz"
C. "Ana Cruz"
D. "ana Cruz"

---
# Quiz 2
## Scenario: Text Processing
Rhea Joy cleans input data.

**Question 6:** strip() removes:
A. Internal spaces
B. Leading/trailing whitespace
C. All spaces
D. Punctuation

**Question 7:** split(",") on "a,b,c":
A. ["a","b","c"]
B. "abc"
C. ["a,b,c"]
D. Error

**Question 8:** Reverse string s:
A. s.reverse()
B. s[::-1]
C. reverse(s)
D. s[-1]

**Question 9:** Check if string is digits:
A. s.isdigit()
B. s.isnumber()
C. s.numeric()
D. s.digits()

**Question 10:** Raw string r"C:\new" prevents:
A. Variable expansion
B. Escape sequence interpretation
C. String creation
D. Concatenation

---
## Answers
1: A  
2: B  
3: A  
4: B  
5: C  
6: B  
7: A  
8: B  
9: A  
10: B  

---
## Detailed Explanations
Q1 f-string prefix f before quotes.  
Q2 > aligns right.  
Q3 .2f means 2 decimal places float.  
Q4 05d pads with zeros.  
Q5 title() capitalizes each word.  
Q6 strip() removes outer whitespace.  
Q7 split() returns list.  
Q8 [::-1] reverses via slicing.  
Q9 isdigit() checks numeric chars.  
Q10 Raw strings ignore escapes.  

---
**Next:** Proceed to Lesson 12 exercises.