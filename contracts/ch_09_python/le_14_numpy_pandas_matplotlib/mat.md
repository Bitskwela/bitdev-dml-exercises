## Lesson 14: NumPy, Pandas, and Matplotlib

Story: Tian imports CSV of 500 applicants. Lists too clumsy. Rhea Joy introduces trio: NumPy (arrays), Pandas (tables), Matplotlib (charts).

### 1. NumPy Basics
```python
import numpy as np
arr = np.array([10, 20, 30])
print(arr.mean(), arr.std())
```
Fast operations on homogeneous numeric data.

### 2. Creating Arrays
```python
np.zeros(5)
np.ones((3, 3))
np.arange(0, 10, 2)
np.linspace(0, 1, 5)
```

### 3. Array Operations
```python
arr + 5        # element-wise
arr * 2
arr ** 2
arr.sum(), arr.max(), arr.min()
```

### 4. Pandas DataFrame
```python
import pandas as pd
data = {"name": ["Ana", "Ben"], "age": [21, 19]}
df = pd.DataFrame(data)
print(df.head())
```

### 5. Reading CSV
```python
df = pd.read_csv("applicants.csv")
df.info()
df.describe()
```

### 6. Selecting Columns & Rows
```python
df["age"]
df[["name", "age"]]
df.loc[0]        # by label
df.iloc[0]       # by position
```

### 7. Filtering
```python
approved = df[df["status"] == "Approved"]
seniors = df[df["age"] >= 60]
```

### 8. Aggregation
```python
df.groupby("barangay")["age"].mean()
df["age"].value_counts()
```

### 9. Matplotlib Basics
```python
import matplotlib.pyplot as plt
plt.plot([1, 2, 3], [10, 20, 15])
plt.xlabel("Quarter")
plt.ylabel("Applicants")
plt.title("Trend")
plt.show()
```

### 10. Bar Chart
```python
categories = ["A", "B", "C"]
counts = [10, 15, 7]
plt.bar(categories, counts)
plt.show()
```

### 11. Histogram
```python
plt.hist(df["age"], bins=10)
plt.show()
```

### 12. Story Thread
Load CSV → filter approved applicants → group by barangay → bar chart of counts.

### 13. Practice Prompts
1. Create NumPy array; calculate mean.
2. Load CSV into DataFrame; print first 5 rows.
3. Filter DataFrame for age > 25.
4. Plot line chart of quarterly totals.

### 14. Reflection
Two advantages of DataFrame over list of dicts.

**Next:** Quiz then exercises.