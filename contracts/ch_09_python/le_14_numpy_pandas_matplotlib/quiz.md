# Lesson 14 Quiz: NumPy, Pandas, Matplotlib

---
# Quiz 1
## Scenario: Data Analysis Toolkit
Tian loads and visualizes applicant data.

**Question 1:** NumPy array advantage:
A. Slower than lists
B. Fast element-wise operations
C. Only stores strings
D. No math support

**Question 2:** Create 5-element zero array:
A. np.zeros(5)
B. np.empty(5)
C. np.array([0])
D. np.zero(5)

**Question 3:** Pandas DataFrame resembles:
A. Single list
B. Table with rows/columns
C. Unstructured text
D. Binary file

**Question 4:** Read CSV into DataFrame:
A. pd.load("file.csv")
B. pd.read_csv("file.csv")
C. pd.open("file.csv")
D. pd.import_csv("file.csv")

**Question 5:** Filter DataFrame rows where age > 25:
A. df[age > 25]
B. df[df["age"] > 25]
C. df.filter(age > 25)
D. df.where(age > 25)

---
# Quiz 2
## Scenario: Visualization Tasks
Rhea Joy generates charts.

**Question 6:** Matplotlib plot line chart:
A. plt.plot(x, y)
B. plt.line(x, y)
C. plt.chart(x, y)
D. plt.draw(x, y)

**Question 7:** Bar chart function:
A. plt.bar(categories, values)
B. plt.column(categories, values)
C. plt.bars(categories, values)
D. plt.hist(categories, values)

**Question 8:** Histogram shows:
A. Time series
B. Distribution of single variable
C. Correlation matrix
D. Scatter comparison

**Question 9:** df.groupby("barangay")["age"].mean() calculates:
A. Total sum per barangay
B. Average age per barangay
C. Count of residents
D. Maximum age globally

**Question 10:** df.describe() provides:
A. Only column names
B. Summary statistics (mean, std, etc.)
C. Raw data dump
D. Error log

---
## Answers
1: B  
2: A  
3: B  
4: B  
5: B  
6: A  
7: A  
8: B  
9: B  
10: B  

---
## Detailed Explanations
Q1 NumPy optimized for numeric ops.  
Q2 np.zeros(n) creates array of zeros.  
Q3 DataFrame is tabular structure.  
Q4 pd.read_csv standard import.  
Q5 Boolean indexing: df[condition].  
Q6 plt.plot draws line chart.  
Q7 plt.bar creates bar chart.  
Q8 Histogram bins frequency distribution.  
Q9 groupby + aggregation computes per-group stats.  
Q10 describe() shows count, mean, std, min, max, quartiles.  

---
**Next:** Proceed to Lesson 14 exercises.