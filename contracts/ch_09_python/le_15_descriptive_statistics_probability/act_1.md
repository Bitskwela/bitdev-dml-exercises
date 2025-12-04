# Descriptive Statistics and Probability Activity

Now that you understand descriptive statistics, let's practice analyzing data distributions and calculating probabilities.

## Statistical Analysis Challenge

Descriptive statistics help us understand and communicate data patterns.

### Task 1: Central Tendency Measures

**Compute mean, median, and mode** of scholarship applicant ages.

**Your Code:**
```python
import statistics as stats

# Ages of 15 scholarship applicants
ages = [18, 21, 19, 18, 22, 20, 18, 21, 19, 20, 18, 23, 19, 21, 18]

# Your code here:
mean_age = 
median_age = 
mode_age = 

print(f"Mean age: {mean_age:.2f}")
print(f"Median age: {median_age}")
print(f"Mode age: {mode_age}")

# Which measure best represents "typical" age?
```

---

### Task 2: Spread Measures

**Calculate variance and standard deviation** of household incomes.

**Your Code:**
```python
import statistics as stats

# Monthly household incomes (in pesos)
incomes = [15000, 18000, 12000, 25000, 16000, 14000, 19000, 13000, 17000, 21000]

# Your code here:
variance = 
std_dev = 
mean_income = 

print(f"Mean income: ₱{mean_income:,.2f}")
print(f"Variance: {variance:,.2f}")
print(f"Standard deviation: ₱{std_dev:,.2f}")

# What does the std dev tell you about income spread?
```

---

### Task 3: Quartiles and IQR

**Find Q1, Q3, and IQR** (Interquartile Range) for GPAs.

**Your Code:**
```python
import numpy as np

# GPA scores
gpas = [3.2, 3.5, 2.8, 3.7, 3.1, 3.9, 3.3, 2.9, 3.6, 3.4, 3.8, 3.0, 3.5, 3.2, 3.7]

# Your code here:
q1 = 
q2 =  # This is the median
q3 = 
iqr = 

print(f"Q1 (25th percentile): {q1:.2f}")
print(f"Q2 (Median): {q2:.2f}")
print(f"Q3 (75th percentile): {q3:.2f}")
print(f"IQR: {iqr:.2f}")

# Use IQR to find outliers
lower_bound = q1 - 1.5 * iqr
upper_bound = q3 + 1.5 * iqr
outliers = [gpa for gpa in gpas if gpa < lower_bound or gpa > upper_bound]
print(f"Outliers: {outliers}")
```

---

### Task 4: Probability Calculation

**Compute approval probability** from historical counts.

**Your Code:**
```python
# Historical data
total_applicants = 287
approved_applicants = 194
rejected_applicants = 93

# Your code here:
prob_approved = 
prob_rejected = 

print(f"P(Approved) = {prob_approved:.2%}")
print(f"P(Rejected) = {prob_rejected:.2%}")

# Conditional probability
pwd_applicants = 45
pwd_approved = 38

prob_approved_given_pwd = 

print(f"\nP(Approved | PWD) = {prob_approved_given_pwd:.2%}")

# Is PWD status associated with higher approval rate?
```

---

## Reflection Questions

**When is median preferable to mean? Give two scenarios:**

1. _[Your answer: e.g., when data has outliers that skew the mean]_

2. _[Your answer: e.g., when dealing with skewed distributions like income]_

---

## What You've Learned

Through this activity, you've practiced:
- Calculating mean, median, and mode
- Computing variance and standard deviation
- Finding quartiles and identifying outliers
- Calculating probabilities from counts

---

<details>
<summary><strong>Answer Key (Click to reveal)</strong></summary>

### Task 1: Central Tendency
```python
import statistics as stats

ages = [18, 21, 19, 18, 22, 20, 18, 21, 19, 20, 18, 23, 19, 21, 18]

mean_age = stats.mean(ages)      # 19.6
median_age = stats.median(ages)  # 19
mode_age = stats.mode(ages)      # 18 (most frequent)

print(f"Mean age: {mean_age:.2f}")
print(f"Median age: {median_age}")
print(f"Mode age: {mode_age}")

# Median (19) best represents typical age since mode is skewed by many 18s
```

### Task 2: Spread Measures
```python
import statistics as stats

incomes = [15000, 18000, 12000, 25000, 16000, 14000, 19000, 13000, 17000, 21000]

variance = stats.variance(incomes)  # 14,444,444.44
std_dev = stats.stdev(incomes)      # 3,800.59
mean_income = stats.mean(incomes)   # 17,000

print(f"Mean income: ₱{mean_income:,.2f}")
print(f"Variance: {variance:,.2f}")
print(f"Standard deviation: ₱{std_dev:,.2f}")

# High std dev (₱3,800) means income varies significantly around mean
```

### Task 3: Quartiles and IQR
```python
import numpy as np

gpas = [3.2, 3.5, 2.8, 3.7, 3.1, 3.9, 3.3, 2.9, 3.6, 3.4, 3.8, 3.0, 3.5, 3.2, 3.7]

q1 = np.percentile(gpas, 25)   # 3.1
q2 = np.percentile(gpas, 50)   # 3.4 (median)
q3 = np.percentile(gpas, 75)   # 3.7
iqr = q3 - q1                  # 0.6

print(f"Q1: {q1:.2f}")
print(f"Q2 (Median): {q2:.2f}")
print(f"Q3: {q3:.2f}")
print(f"IQR: {iqr:.2f}")

lower_bound = q1 - 1.5 * iqr  # 2.2
upper_bound = q3 + 1.5 * iqr  # 4.6
outliers = [gpa for gpa in gpas if gpa < lower_bound or gpa > upper_bound]
print(f"Outliers: {outliers}")  # [] (no outliers in this dataset)
```

### Task 4: Probability
```python
total_applicants = 287
approved_applicants = 194
rejected_applicants = 93

prob_approved = approved_applicants / total_applicants  # 0.676 or 67.6%
prob_rejected = rejected_applicants / total_applicants  # 0.324 or 32.4%

print(f"P(Approved) = {prob_approved:.2%}")  # 67.60%
print(f"P(Rejected) = {prob_rejected:.2%}")  # 32.40%

pwd_applicants = 45
pwd_approved = 38

prob_approved_given_pwd = pwd_approved / pwd_applicants  # 0.844 or 84.4%

print(f"\nP(Approved | PWD) = {prob_approved_given_pwd:.2%}")  # 84.44%

# Yes! PWD applicants have 84.4% approval rate vs 67.6% overall
```

### Reflection Answers

**When is median preferable to mean?**

1. **Income data**: Income distributions are typically right-skewed with high earners pulling the mean up. Median better represents "typical" income.

2. **Housing prices**: Luxury homes skew the mean. Median gives better sense of typical home price.

3. **Test scores with outliers**: If a few students score 0 or 100, median is more representative of typical performance.

4. **Any skewed distribution**: Median is robust to extreme values unlike mean.

</details>
