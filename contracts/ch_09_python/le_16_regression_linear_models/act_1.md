# Regression and Linear Models Activity

Practice building predictive models with linear regression.

### Task 1: Fit Linear Model
```python
import numpy as np
from scipy import stats

# Applications per quarter
quarters = np.array([1, 2, 3, 4, 5, 6])
applications = np.array([45, 52, 58, 67, 73, 81])

# Your code:
slope, intercept, r_value, p_value, std_err = stats.linregress(quarters, applications) 

print(f"Equation: y = {slope:.2f}x + {intercept:.2f}")
print(f"R-squared: {r_value**2:.4f}")
```

### Task 2: Compute R²
```python
# Using result from Task 1
r_squared = r_value ** 2 
print(f"R²: {r_squared:.4f} ({r_squared*100:.2f}% variance explained)")
```

### Task 3: Make Prediction
```python
def predict(quarter):
    return slope * quarter + intercept

q7_prediction = predict(7)
print(f"Predicted applications for Q7: {q7_prediction:.0f}")
```

### Task 4: Plot with Fitted Line
```python
import matplotlib.pyplot as plt

plt.scatter(quarters, applications, label="Actual")
plt.plot(quarters, slope*quarters + intercept, 'r-', label="Fitted Line")
plt.xlabel("Quarter") 
plt.ylabel("Applications")
plt.legend()
plt.show()
```

## Reflection
**Two signs regression is appropriate:**
1. _[Linear relationship visible in scatter plot]_
2. _[R² > 0.7 indicates good fit]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
slope, intercept, r_value, p_value, std_err = stats.linregress(quarters, applications)
# slope ≈ 7.0, intercept ≈ 38.67, r_value ≈ 0.993

r_squared = r_value ** 2  # ≈ 0.986 (98.6% variance explained)

def predict(quarter):
    return slope * quarter + intercept

q7_prediction = predict(7)  # ≈ 87 applications
```

**Reflection:** Model is appropriate because: (1) Strong linear pattern (R²=0.986), (2) Residuals random, (3) Simple trend without seasonality

</details>
