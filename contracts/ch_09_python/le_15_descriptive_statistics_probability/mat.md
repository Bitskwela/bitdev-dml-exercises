## Background Story

The quarterly scholarship report was due, and the council wanted answers: What's the typical GPA of approved applicants? How spread out are the household incomes? What's the probability that a randomly selected applicant has a GPA above 3.5? Captain Cruz read Tian's initial report and frowned. "You just listed all the numbers. I need to understand what they mean. What's normal? What's unusual?"

Tian felt lost. He could calculate averages, but the treasurer was asking about "standard deviations" and "quartiles" and "probability distributions"—terms he'd heard in math class but never really understood. Rhea Joy was in the same boat. "Kuya, we have all this data but we don't know how to describe it properly. We're missing the vocabulary."

Kuya Miguel recognized the gap immediately. "You need descriptive statistics—the language for summarizing data. Mean tells you the center, median handles skewed data, standard deviation shows spread. Quartiles reveal where data clusters. These aren't just math exercises; they're tools for communication." He pulled up their scholarship dataset and started demonstrating: calculating measures of central tendency, showing how outliers affected different metrics, explaining variance and distribution shapes.

They rebuilt the report from scratch: instead of raw number dumps, they provided meaningful summaries—"median household income of 18,000 pesos with a standard deviation of 5,200, indicating moderate variability." They calculated probabilities: "68% of applicants fall within one standard deviation of mean GPA." They identified outliers and explained what made them unusual. Captain Cruz read the new report and immediately understood the scholarship program's patterns and trends. The scholarship system was becoming insightful, one statistic at a time. 📊🎯

---

## Theory & Lecture Content

### 1. Central Tendency
- Mean: arithmetic average
- Median: middle value (robust to outliers)
- Mode: most frequent value
```python
import statistics as stats
data = [18, 21, 19, 22, 20, 21]
print(stats.mean(data))
print(stats.median(data))
print(stats.mode(data))
```

### 2. Spread (Dispersion)
- Range: max - min
- Variance: average squared deviation from mean
- Standard Deviation: sqrt(variance)
```python
print(stats.variance(data))
print(stats.stdev(data))
```

### 3. Percentiles & Quartiles
- Q1 (25th), Q2 (median, 50th), Q3 (75th)
- IQR = Q3 - Q1
```python
import numpy as np
q1, q2, q3 = np.percentile(data, [25, 50, 75])
```

### 4. Outlier Detection (Simple)
Outlier if < Q1 - 1.5*IQR or > Q3 + 1.5*IQR.

### 5. Probability Basics
- P(event) = favorable outcomes / total outcomes
- P(A or B) = P(A) + P(B) - P(A and B)
- P(A and B) = P(A) * P(B) if independent

### 6. Conditional Probability
P(A|B) = P(A and B) / P(B)

### 7. Example: Approval Probability
Historical: 300 applicants, 180 approved.
P(approved) = 180/300 = 0.6

### 8. Distributions (Concept)
- Uniform: equal probability
- Normal (Gaussian): bell curve
- Binomial: fixed trials, binary outcome

### 9. Standard Normal (Z-score)
z = (x - mean) / std
Measures how many std devs from mean.

### 10. Random Sampling
```python
import random
sample = random.sample(population, 50)
```

### 11. Story Thread
Compute mean age, std dev; identify outliers; estimate approval probability from historical data.

### 12. Practice Prompts
1. Compute mean, median, mode of sample.
2. Calculate variance and std dev.
3. Find Q1, Q3, IQR.
4. Compute approval probability from counts.

### 13. Reflection
When is median preferable to mean? Give two scenarios.

---

## Closing Story

The barangay captain reviewed Tian's initial report and frowned. "Average household income: ₱45,000 per month? That seems high. Most families here are struggling."

Tian rechecked the calculation. The mean was correct. But then Kuya Miguel pointed out the issue:

```python
import numpy as np

incomes = [12000, 15000, 13000, 14000, 250000, 11000, 16000]

mean_income = np.mean(incomes)
median_income = np.median(incomes)

print(f"Mean: ₱{mean_income:,.0f}")
print(f"Median: ₱{median_income:,.0f}")
```

Output:
```
Mean: ₱47,286
Median: ₱14,000
```

"See the problem?" Kuya Miguel highlighted the data. "One family earning ₱250,000 skewed the entire average. The median—₱14,000—represents the typical family much better."

"Outliers," Rhea Joy realized. "They distort the mean but don't affect the median."

Tian recalculated the scholarship analysis using appropriate statistics:

```python
import pandas as pd
import scipy.stats as stats

df = pd.read_csv("applicants.csv")

# Descriptive statistics
print("Age Distribution:")
print(f"  Mean: {df['age'].mean():.1f}")
print(f"  Median: {df['age'].median()}")
print(f"  Mode: {df['age'].mode().values[0]}")
print(f"  Std Dev: {df['age'].std():.2f}")
print(f"  Range: {df['age'].min()} - {df['age'].max()}")

# Quartiles
Q1 = df['age'].quantile(0.25)
Q3 = df['age'].quantile(0.75)
IQR = Q3 - Q1

print(f"\nQuartiles:")
print(f"  Q1 (25th): {Q1}")
print(f"  Q2 (50th/Median): {df['age'].median()}")
print(f"  Q3 (75th): {Q3}")
print(f"  IQR: {IQR}")

# Probability
total = len(df)
approved = len(df[df['status'] == 'Approved'])
approval_prob = approved / total

print(f"\nApproval Probability: {approval_prob:.2%}")
```

The revised report painted a clearer picture. The median age was 18—most applicants were fresh high school graduates. The standard deviation showed low variance—ages clustered tightly. The IQR confirmed most fell between 17 and 19.

"Statistics aren't just numbers," Kuya Miguel explained. "They're summaries that reveal patterns. Mean for normal distributions. Median for skewed data. Mode for categorical data. Standard deviation for spread. Quartiles for outlier detection. Each metric tells part of the story."

Rhea Joy calculated probabilities:

```python
# Conditional probability
male_approved = len(df[(df['gender'] == 'Male') & (df['status'] == 'Approved')])
male_total = len(df[df['gender'] == 'Male'])

P_approval_given_male = male_approved / male_total
print(f"P(Approval|Male): {P_approval_given_male:.2%}")
```

The analysis revealed no gender bias in approvals—good to confirm for equity.

The barangay captain reviewed the corrected report. "Now this makes sense. The median income shows the typical family. The quartiles show the spread. The probabilities guide our outreach. This is data we can act on."

Tian saved the Jupyter notebook. From raw numbers to meaningful insights—that's the power of descriptive statistics.

_Next up: Regression and Linear Models!_ 📈

**Next:** Quiz then exercises.