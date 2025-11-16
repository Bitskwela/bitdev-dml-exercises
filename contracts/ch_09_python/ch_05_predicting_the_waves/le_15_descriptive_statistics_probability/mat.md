## Lesson 15: Descriptive Statistics and Probability Basics

Story: Scholarship committee asks: "What's typical applicant age? How spread out?" Tian computes mean; Rhea Joy adds median, variance, and probability of approval.

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

**Next:** Quiz then exercises.