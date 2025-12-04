### 12. Deliverable Checklist
- [ ] Data loaded
- [ ] Regression fitted
- [ ] Simulation run
- [ ] CI computed
- [ ] Visualization created
- [ ] Report written

# Mini Project: Model the Future Activity

Build a complete forecasting model with trend analysis and simulation.

### Project: Forecast Q7 Scholarship Applications

**Historical Data:**
```python
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

quarters = np.array([1, 2, 3, 4, 5, 6])
applications = np.array([90, 95, 100, 110, 105, 115])
```

**Your Tasks:**

1. **Fit regression model**
2. **Forecast Q7 (point estimate)**
3. **Run 1000 simulations adding realistic variability**
4. **Calculate 95% confidence interval**
5. **Visualize: historical + forecast + CI**
6. **Estimate budget range (₱600/applicant)**

**Deliverables:**
- Trend equation
- Q7 forecast with CI
- Budget recommendation
- Visualization
- 1-page report

## Reflection
**Two improvements for next iteration:**
1. _[Add seasonal adjustment]_
2. _[Include more predictor variables]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

# 1. Fit model
quarters = np.array([1, 2, 3, 4, 5, 6])
applications = np.array([90, 95, 100, 110, 105, 115])
slope, intercept, r, p, se = stats.linregress(quarters, applications)

# 2. Forecast Q7
q7_base = slope * 7 + intercept  # ≈ 119

# 3. Simulate with variability
std_dev = np.std(applications)  # ≈ 8.6
q7_samples = np.random.normal(q7_base, std_dev, 1000)

# 4. Confidence interval
lower = np.percentile(q7_samples, 2.5)   # ≈ 102
upper = np.percentile(q7_samples, 97.5)  # ≈ 136

# 5. Visualize
plt.figure(figsize=(10, 6))
plt.plot(quarters, applications, 'o-', label='Historical')
plt.plot(7, q7_base, 'r*', markersize=15, label='Forecast')
plt.fill_between([6.5, 7.5], lower, upper, alpha=0.3, label='95% CI')
plt.xlabel("Quarter")
plt.ylabel("Applications")
plt.title("Scholarship Application Forecast")
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

# 6. Budget
mean_budget = q7_base * 600
lower_budget = lower * 600
upper_budget = upper * 600

print(f"\nQ7 Forecast: {q7_base:.0f} applications (95% CI: {lower:.0f}-{upper:.0f})")
print(f"Budget: ₱{mean_budget:,.0f} (₱{lower_budget:,.0f} - ₱{upper_budget:,.0f})")
```

**Report Summary:**
- **Trend:** Applications growing ~4 per quarter
- **Q7 Forecast:** 119 applications (95% CI: 102-136)
- **Budget Needed:** ₱71,400 (₱61,200 - ₱81,600)
- **Recommendation:** Allocate ₱81,600 to be safe

</details>
