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

**Answer:** A  
**Explanation:** f-string prefix f before quotes.

---

**Question 2:** Align right width 10:
A. f"{x:<10}"
B. f"{x:>10}"
C. f"{x:^10}"
D. f"{x:10<}"

**Answer:** B  
**Explanation:** > aligns right.

---

**Question 3:** Format float 2 decimals:
A. f"{val:.2f}"
B. f"{val:2f}"
C. f"{val:.2}"
D. f"{val:f2}"

**Answer:** A  
**Explanation:** .2f means 2 decimal places float.

---

**Question 4:** Zero-pad integer to 5 digits:
A. f"{n:5d}"
B. f"{n:05d}"
C. f"{n:5.0f}"
D. f"{n:d5}"

**Answer:** B  
**Explanation:** 05d pads with zeros.

---

**Question 5:** title() effect on "ana cruz":
A. "ANA CRUZ"
B. "Ana cruz"
C. "Ana Cruz"
D. "ana Cruz"

**Answer:** C  
**Explanation:** title() capitalizes each word.

---

# Quiz 2
## Scenario: Text Processing
Rhea Joy cleans input data.

**Question 6:** strip() removes:
A. Internal spaces
B. Leading/trailing whitespace
C. All spaces
D. Punctuation

**Answer:** B  
**Explanation:** strip() removes outer whitespace.

---

**Question 7:** split(",") on "a,b,c":
A. ["a","b","c"]
B. "abc"
C. ["a,b,c"]
D. Error

**Answer:** A  
**Explanation:** split() returns list.

---

**Question 8:** Reverse string s:
A. s.reverse()
B. s[::-1]
C. reverse(s)
D. s[-1]

**Answer:** B  
**Explanation:** [::-1] reverses via slicing.

---

**Question 9:** Check if string is digits:
A. s.isdigit()
B. s.isnumber()
C. s.numeric()
D. s.digits()

**Answer:** A  
**Explanation:** isdigit() checks numeric chars.

---

**Question 10:** Raw string r"C:\new" prevents:
A. Variable expansion
B. Escape sequence interpretation
C. String creation
D. Concatenation

**Answer:** B  
**Explanation:** Raw strings ignore escapes.

---

**Next:** Proceed to Lesson 12 exercises.