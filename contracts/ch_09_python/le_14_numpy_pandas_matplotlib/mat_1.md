## Background Story

Tian's homemade data analysis script was falling apart. Processing 287 scholarship applications with pure Python lists and loops was painfully slow—calculations that should take seconds were taking minutes. Worse, he was manually computing averages, finding medians, and generating summary statistics with nested loops that made his laptop fan scream in protest.

Rhea Joy had been researching Python data science tools and came across three names that kept appearing together: NumPy, Pandas, and Matplotlib. "Kuya, I think we're reinventing the wheel. Professional data scientists use these libraries—NumPy for numerical operations, Pandas for data manipulation, Matplotlib for visualization. Why are we doing everything manually?"

Kuya Miguel couldn't help but laugh when he heard about their struggles. "You're building a calculator with rocks and sticks when there's a supercomputer available. NumPy handles arrays and math operations at C-level speed. Pandas gives you DataFrame structures that work like supercharged Excel spreadsheets in code. Matplotlib creates charts and graphs. These are industry-standard tools, not cheating."

They spent the weekend learning the trinity of Python data science. Tian's 50-line calculation function became 3 lines with NumPy arrays. Rhea Joy's complex data filtering logic transformed into elegant Pandas queries. And when Captain Cruz asked for visual reports, they generated professional bar charts, line graphs, and scatter plots with Matplotlib in minutes. The scholarship analysis that previously took an afternoon now completed in seconds, with beautiful visualizations to boot. The scholarship system was becoming powerful, one imported library at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Tian opened the CSV file with 150 scholarship applicants. Before, this would mean writing loops, parsing strings, calculating manually. But now, with Pandas:

```python
import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv("scholarship_applicants.csv")

# Explore
print(df.head())
print(df.info())
print(df.describe())

# Filter: Approved applicants only
approved = df[df["status"] == "Approved"]

# Group by barangay
barangay_counts = approved.groupby("barangay").size()

# Visualize
plt.figure(figsize=(10, 6))
barangay_counts.plot(kind="bar")
plt.title("Approved Applicants by Barangay")
plt.xlabel("Barangay")
plt.ylabel("Count")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("approval_by_barangay.png")
plt.show()
```

The bar chart appeared: clear, colorful, professional. Each barangay's approval count visible at a glance.

"This is what the captain needs," Rhea Joy said, admiring the visualization. "Not spreadsheets. Not raw numbers. A chart that tells the story instantly."

Kuya Miguel showed them NumPy operations:

```python
import numpy as np

ages = df["age"].values  # Convert to NumPy array
mean_age = np.mean(ages)
std_age = np.std(ages)

print(f"Mean: {mean_age:.2f}, Std Dev: {std_age:.2f}")

# Find outliers (ages beyond 2 standard deviations)
outliers = ages[(ages < mean_age - 2*std_age) | (ages > mean_age + 2*std_age)]
print(f"Outliers: {outliers}")
```

"NumPy for numerical operations. Pandas for data manipulation. Matplotlib for visualization," Kuya Miguel summarized. "These three libraries form the backbone of data science in Python."

Tian created a trend analysis:

```python
# Group by month
df["month"] = pd.to_datetime(df["date"]).dt.month
monthly_apps = df.groupby("month").size()

plt.plot(monthly_apps.index, monthly_apps.values, marker="o")
plt.title("Application Trends by Month")
plt.xlabel("Month")
plt.ylabel("Applications")
plt.grid(True)
plt.show()
```

The line chart showed a spike in June—summer break, when students apply most.

"Data tells stories," Rhea Joy realized. "But only if you have the tools to listen."

The barangay captain reviewed their report: statistics, charts, trends, insights. What would have taken weeks of manual work was completed in an afternoon.

"From raw CSV to actionable insights," Tian said with satisfaction. "This is the power of data science."

_Next up: Descriptive Statistics and Probability!_ 🎲

**Next:** Quiz then exercises.