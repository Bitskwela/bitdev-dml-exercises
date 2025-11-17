## Lesson 18: Mini Project – Model the Future

Story: Synthesis time. Committee needs Q1 forecast. Tian + Rhea Joy combine regression (trend) + simulation (variability) into a mini predictive tool.

### 1. Project Goal
Predict next quarter applicant count and budget with confidence interval.

### 2. Data Preparation
Historical quarterly applicants: [90, 95, 100, 110, 105, 115]

### 3. Trend Analysis (Regression)
Fit linear model: quarter (1-6) vs applicants.
```python
import numpy as np
from scipy import stats
quarters = np.array([1,2,3,4,5,6])
applicants = np.array([90,95,100,110,105,115])
slope, intercept, r, p, se = stats.linregress(quarters, applicants)
print(f"Trend: y = {slope:.2f}x + {intercept:.2f}")
```

### 4. Forecast Base (Q7)
```python
q7_base = slope * 7 + intercept
```

### 5. Add Variability (Simulation)
Historical std ~ 8; simulate 1000 Q7 scenarios:
```python
std_dev = np.std(applicants)
q7_samples = np.random.normal(q7_base, std_dev, 1000)
```

### 6. Confidence Interval
```python
lower = np.percentile(q7_samples, 2.5)
upper = np.percentile(q7_samples, 97.5)
print(f"95% CI: [{lower:.0f}, {upper:.0f}]")
```

### 7. Budget Estimate
```python
cost_per = 600
budget_samples = q7_samples * cost_per
mean_budget = np.mean(budget_samples)
```

### 8. Visualization
Plot historical + forecast + CI:
```python
import matplotlib.pyplot as plt
plt.plot(quarters, applicants, 'o-', label='Historical')
plt.plot(7, q7_base, 'r*', label='Forecast')
plt.fill_between([6.5, 7.5], lower, upper, alpha=0.3, label='95% CI')
plt.legend()
plt.show()
```

### 9. Report Summary
- Trend equation
- Q7 forecast: mean ± CI
- Budget range
- Model limitations (linear assumption, short history)

### 10. Extensions
- Add seasonal adjustment
- Multi-variate model (barangay, income)
- Validate on holdout data

### 11. Story Thread
Committee receives report: "Q7 forecast 118 applicants (95% CI: 102-134); budget ₱70,800 ± ₱9,600."

### 12. Deliverable Checklist
- [ ] Data loaded
- [ ] Regression fitted
- [ ] Simulation run
- [ ] CI computed
- [ ] Visualization created
- [ ] Report written

### 13. Reflection
Two improvements for next iteration.

**Next:** Quiz then project implementation.