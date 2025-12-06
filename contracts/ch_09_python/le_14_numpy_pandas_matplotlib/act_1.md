# NumPy, Pandas, and Matplotlib Activity

Now that you understand the data science toolkit, let's practice working with arrays, DataFrames, and visualizations.

## Data Science Challenge

Real data analysis uses professional libraries - let's master the essentials.

### Task 1: NumPy Array Statistics

Create a **NumPy array** and calculate the mean.

**Your Code:**
```python
import numpy as np

# Scholarship amounts for 10 applicants
amounts = np.array([5000, 3500, 4000, 5500, 3000, 6000, 4500, 3500, 5000, 4000])

# Your code here:
mean_amount = amounts.mean()
std_amount = amounts.std()
max_amount = amounts.max()
min_amount = amounts.min() 

print(f"Mean: ₱{mean_amount:,.2f}")
print(f"Std Dev: ₱{std_amount:,.2f}")
print(f"Max: ₱{max_amount:,.2f}")
print(f"Min: ₱{min_amount:,.2f}")
```

---

### Task 2: Load and Explore DataFrame

**Load CSV into DataFrame** and print first 5 rows.

**Your Code:**
```python
import pandas as pd

# First, create a sample CSV file
sample_data = {
    "name": ["Ana Cruz", "Ben Reyes", "Carla Santos", "Dan Lim", "Eva Garcia", "Frank Tan"],
    "age": [18, 21, 19, 22, 20, 18],
    "barangay": ["San Roque", "Sto. Niño", "San Jose", "San Roque", "Sto. Niño", "San Jose"],
    "gpa": [3.5, 3.2, 3.8, 3.1, 3.6, 3.4],
    "status": ["Approved", "Pending", "Approved", "Pending", "Approved", "Approved"]
}

df = pd.DataFrame(sample_data)
df.to_csv("applicants.csv", index=False)

# Now your code to load and explore:
df = pd.read_csv("applicants.csv")

# Display first 5 rows
print(df.head())

# Display info about the DataFrame
print(df.info())

# Display basic statistics
print(df.describe())
```

---

### Task 3: Filter DataFrame

**Filter DataFrame** for applicants with age > 25.

**Your Code:**
```python
# Using the same DataFrame from Task 2

# Filter for age > 19
filtered_df = df[df["age"] > 19]

print("Applicants older than 19:")
print(filtered_df)

# Bonus: Filter for Approved AND age > 19
approved_older = df[(df["status"] == "Approved") & (df["age"] > 19)] 

print("\nApproved applicants older than 19:")
print(approved_older)
```

---

### Task 4: Plot Line Chart

Create a **line chart** showing quarterly application totals.

**Your Code:**
```python
import matplotlib.pyplot as plt

# Quarterly data
quarters = ["Q1", "Q2", "Q3", "Q4"]
applications = [45, 52, 58, 67]

# Your plotting code:
plt.figure(figsize=(10, 6))
# Add your plot code here
plt.plot(quarters, applications, marker='o', linewidth=2, markersize=8)
plt.xlabel("Quarter")
plt.ylabel("Number of Applications")
plt.title("Scholarship Applications by Quarter")
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.show()
```

---

## Reflection Questions

**Two advantages of DataFrame over list of dicts:**

1. _[Your answer: e.g., built-in filtering, grouping, and aggregation methods]_

2. _[Your answer: e.g., vectorized operations are much faster]_

---

## What You've Learned

Through this activity, you've practiced:
- NumPy array operations and statistics
- Loading and exploring Pandas DataFrames
- Filtering data with boolean indexing
- Creating visualizations with Matplotlib

---

<details>
<summary><strong>Answer Key (Click to reveal)</strong></summary>

### Task 1: NumPy Array Statistics
```python
import numpy as np

amounts = np.array([5000, 3500, 4000, 5500, 3000, 6000, 4500, 3500, 5000, 4000])

mean_amount = amounts.mean()  # or np.mean(amounts)
std_amount = amounts.std()     # or np.std(amounts)
max_amount = amounts.max()     # or np.max(amounts)
min_amount = amounts.min()     # or np.min(amounts)

print(f"Mean: ₱{mean_amount:,.2f}")      # ₱4,400.00
print(f"Std Dev: ₱{std_amount:,.2f}")   # ₱915.00
print(f"Max: ₱{max_amount:,.2f}")       # ₱6,000.00
print(f"Min: ₱{min_amount:,.2f}")       # ₱3,000.00
```

### Task 2: Load and Explore DataFrame
```python
import pandas as pd

df = pd.read_csv("applicants.csv")

# Display first 5 rows
print(df.head())

# Display info
print(df.info())

# Display statistics
print(df.describe())
```

### Task 3: Filter DataFrame
```python
# Filter for age > 19
filtered_df = df[df["age"] > 19]
print("Applicants older than 19:")
print(filtered_df)

# Bonus: Multiple conditions
approved_older = df[(df["status"] == "Approved") & (df["age"] > 19)]
print("\nApproved applicants older than 19:")
print(approved_older)
```

### Task 4: Plot Line Chart
```python
import matplotlib.pyplot as plt

quarters = ["Q1", "Q2", "Q3", "Q4"]
applications = [45, 52, 58, 67]

plt.figure(figsize=(10, 6))
plt.plot(quarters, applications, marker='o', linewidth=2, markersize=8)
plt.xlabel("Quarter")
plt.ylabel("Number of Applications")
plt.title("Scholarship Applications by Quarter")
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.show()
```

### Reflection Answers

**Two advantages of DataFrame over list of dicts:**

1. **Built-in operations**: DataFrames have methods like `.groupby()`, `.filter()`, `.merge()` that would require complex code with lists

2. **Performance**: Vectorized operations in Pandas are implemented in C, making them orders of magnitude faster than Python loops

3. **Data alignment**: Automatic alignment by index makes operations safer and cleaner

4. **Rich functionality**: Easy CSV/Excel I/O, missing data handling, time series support, etc.

</details>
