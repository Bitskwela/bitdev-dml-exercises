# Introduction to Quantitative Methods Activity

Now that you understand quantitative methods, let's practice basic statistical analysis and model thinking.

## Data Analysis Challenge

Quantitative methods help us find patterns and make data-driven decisions.

### Task 1: Calculate Descriptive Statistics

Calculate **mean and median** of a sample list.

**Your Code:**
```python
import statistics

# Sample scholarship amounts
amounts = [5000, 3000, 4500, 5500, 3500, 6000, 4000, 3000, 5000, 4500]

# Your code here:
mean_amount = 
median_amount = 

print(f"Mean scholarship amount: ₱{mean_amount:,.2f}")
print(f"Median scholarship amount: ₱{median_amount:,.2f}")

# Which is more representative? Why?
```

**Questions:**
1. What's the difference between mean and median?
2. When would median be more useful than mean?

---

### Task 2: Categorize Data Fields

**Identify categorical vs numeric fields** in a scholarship dataset.

**Dataset:**
```python
applicant = {
    "id": 101,
    "name": "Ana Cruz",
    "age": 18,
    "barangay": "San Roque",
    "gpa": 3.5,
    "status": "Approved",
    "amount": 5000,
    "tags": ["PWD", "Scholar"],
    "application_date": "2025-01-15"
}
```

**Categorize Each Field:**

| Field | Categorical or Numeric | Type Details |
|-------|------------------------|-------------|
| id | _[Your answer]_ | _[integer, identifier]_ |
| name | _[Your answer]_ | _[nominal categorical]_ |
| age | _[Your answer]_ | _[continuous/discrete?]_ |
| barangay | _[Your answer]_ | _[what type?]_ |
| gpa | _[Your answer]_ | _[what type?]_ |
| status | _[Your answer]_ | _[what type?]_ |
| amount | _[Your answer]_ | _[what type?]_ |
| tags | _[Your answer]_ | _[what type?]_ |
| application_date | _[Your answer]_ | _[what type?]_ |

---

### Task 3: Predictive Model Workflow

**Sketch workflow** for predicting applicant approval rate.

**Fill in the steps:**

1. **Define Question:** _[What are we trying to predict?]_

2. **Collect Data:** _[What historical data do we need?]_

3. **Clean & Explore:** _[What cleaning steps?]_

4. **Choose Model:** _[What type of model? Regression? Classification?]_

5. **Train/Fit:** _[How do we train the model?]_

6. **Validate:** _[How do we test accuracy?]_

7. **Interpret & Decide:** _[How do we use the results?]_

**Example Scenario:**
Predict whether an applicant will be approved based on age, GPA, and income.

---

### Task 4: Python Libraries for Analysis

**List 3 Python libraries** relevant to quantitative analysis.

**Library 1:** _[Name]_
- **Purpose:** _[What it does]_
- **Example Use:** _[When you'd use it]_

**Library 2:** _[Name]_
- **Purpose:** _[What it does]_
- **Example Use:** _[When you'd use it]_

**Library 3:** _[Name]_
- **Purpose:** _[What it does]_
- **Example Use:** _[When you'd use it]_

---

## Reflection Questions

**Two reasons automated quantitative analysis beats manual:**

1. _[Reason 1: e.g., processes thousands of records in seconds]_

2. _[Reason 2: e.g., eliminates human calculation errors]_

**Additional reflections:**

3. **When might you trust human judgment over a statistical model?**
   _[Your answer]_

4. **What's the difference between descriptive and predictive analytics?**
   _[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Calculating basic statistics (mean, median)
- Distinguishing categorical from numerical data
- Understanding the quantitative modeling workflow
- Identifying key Python data science libraries

Next, you'll learn NumPy, Pandas, and Matplotlib!

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Calculate Mean and Median
```python
def calculate_mean(numbers):
    return sum(numbers) / len(numbers)

def calculate_median(numbers):
    sorted_nums = sorted(numbers)
    n = len(sorted_nums)
    mid = n // 2
    
    if n % 2 == 0:  # Even length
        return (sorted_nums[mid - 1] + sorted_nums[mid]) / 2
    else:  # Odd length
        return sorted_nums[mid]

ages = [18, 21, 19, 22, 20, 23, 19, 21, 20]

mean_age = calculate_mean(ages)
median_age = calculate_median(ages)

print(f"Mean age: {mean_age:.2f}")
print(f"Median age: {median_age}")
print(f"Count: {len(ages)}")
```

### Task 2: Categorical vs Numerical
```python
applicant_data = {
    "name": "Ana Cruz",              # Categorical (nominal)
    "age": 20,                       # Numerical (discrete)
    "barangay": "San Roque",         # Categorical (nominal)
    "gpa": 3.75,                     # Numerical (continuous)
    "scholarship_type": "Academic",  # Categorical (nominal)
    "income_bracket": "Low"          # Categorical (ordinal)
}

categorical = ["name", "barangay", "scholarship_type", "income_bracket"]
numerical = ["age", "gpa"]

print("Categorical:", categorical)
print("Numerical:", numerical)
```

### Task 3: Modeling Workflow
**Example:** Predict approval based on age, GPA, income

```python
# 1. Define Problem
#    Goal: Predict scholarship approval (yes/no)
#    Input: age, gpa, income_bracket

# 2. Collect Data
applicants = [
    {"age": 20, "gpa": 3.5, "income": "Low", "approved": True},
    {"age": 19, "gpa": 3.2, "income": "Medium", "approved": True},
    {"age": 22, "gpa": 2.8, "income": "High", "approved": False},
    # ... more data
]

# 3. Clean Data
#    - Remove missing values
#    - Encode categorical (Low=1, Medium=2, High=3)
#    - Normalize numerical features

# 4. Explore Data
#    - Calculate mean GPA by approval status
#    - Check age distribution
#    - Identify correlations

# 5. Build Model
#    - Choose algorithm (logistic regression)
#    - Train on 80% of data
#    - Validate on 20%

# 6. Evaluate
#    - Accuracy: 85% correct predictions
#    - Confusion matrix
#    - Identify bias

# 7. Deploy
#    - Integrate into application form
#    - Monitor predictions
```

### Task 4: Python Libraries

**Library 1: NumPy**
- **Purpose:** Fast numerical array operations
- **Example:** Calculate mean of 1 million numbers in milliseconds

**Library 2: Pandas**
- **Purpose:** Data manipulation and analysis (DataFrames)
- **Example:** Load CSV, filter rows, aggregate by group

**Library 3: Matplotlib**
- **Purpose:** Data visualization (charts, plots)
- **Example:** Create histogram of age distribution

**Bonus Libraries:**
- **scikit-learn:** Machine learning models
- **SciPy:** Statistical tests
- **Seaborn:** Statistical visualization

### Reflection
1. **Automated analysis beats manual:** Speed (thousands of records), no human error
2. **Automated analysis beats manual:** Consistent application of rules
3. **Trust human judgment:** Qualitative factors (essays), ethical considerations, edge cases
4. **Descriptive vs predictive:** Describe what happened vs predict what will happen

</details>
