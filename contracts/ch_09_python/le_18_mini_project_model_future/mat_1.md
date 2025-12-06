## Background Story

After weeks of learning data analysis, statistics, and simulation, Tian and Rhea Joy felt ready for a real challenge. Captain Cruz approached them with a critical question: "The barangay is planning to expand the scholarship program next year. We want to serve more students, but we need to convince the municipal council to increase our budget. Can you build a model that shows what different funding levels would achieve?"

This wasn't just a practice exercise—it was a real presentation to government officials who would decide the futures of dozens of students. Rhea Joy felt the weight of responsibility. "Kuya, this is different from our homework exercises. Real people will make real decisions based on our analysis. We can't mess this up." Tian nodded, feeling both excited and nervous. This was what all their learning had been building toward.

Kuya Miguel, sensing the importance of the moment, cleared his schedule to guide them through the project. "This is your capstone for data analysis. You'll need everything: data collection and cleaning, exploratory analysis, statistical modeling, simulation of different scenarios, visualization of results, and clear communication of findings. Think of it as your first professional portfolio piece."

They worked intensely for three days: gathering three years of historical data, identifying trends and patterns, building predictive models, running simulations with different budget scenarios, creating compelling visualizations, and preparing a presentation. Their model showed that a 40% budget increase could serve 60% more students by optimizing award distribution. The municipal council was impressed by the data-driven approach and approved the funding increase. The scholarship system was becoming impactful, one evidence-based decision at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Presentation day. The barangay scholarship committee gathered: Captain Cruz, three kagawads, the treasurer, and representatives from local schools.

Tian connected the laptop to the projector. Rhea Joy loaded the Jupyter notebook.

"Good afternoon," Tian began. "We've been asked to forecast scholarship needs for Q7. Here's what the data shows."

The first slide: a line chart showing 6 quarters of growth.

"Applications have been increasing steadily. Our linear regression model fits with R² of 0.987—very strong trend."

Next slide: the regression equation and Q7 forecast.

"Based on this trend, we predict 118 applications in Q7, with 95% confidence interval of 102 to 134."

Kagawad Santos raised a hand. "But what about uncertainty? What if more students apply than expected?"

"Great question," Rhea Joy clicked to the Monte Carlo results. "We simulated 1,000 possible scenarios accounting for variability in both applicant numbers and scholarship amounts."

The histogram filled the screen—a beautiful bell curve of possible futures.

"The expected budget is ₱590,000, but we recommend reserving ₱660,000 to cover 95% of scenarios. That's our risk buffer."

The treasurer nodded, taking notes.

Tian showed the final deliverables:
- Regression model with coefficients and R²
- Q7 forecast: 118 ± 16 applications
- Budget forecast: ₱590,000 (mean), ₱660,000 (95th percentile)
- Sensitivity analysis for different growth scenarios
- All code documented in reproducible notebook

"One important caveat," Kuya Miguel added from the back. "This model assumes linear growth continues. Major policy changes, economic shifts, or demographic changes could alter the trend. We recommend updating the model quarterly with new data."

Captain Cruz stood. "This is exactly what we needed. Not just a number pulled from thin air, but a data-driven forecast with confidence intervals and risk analysis. Motion to approve ₱660,000 for Q7 scholarship budget."

"Seconded."

"All in favor?"

Unanimous.

After the meeting, the treasurer approached Tian and Rhea Joy. "Can you teach me how to do this? We have other programs that need forecasting—health services, infrastructure, emergency fund."

"These same methods apply to any time-series data," Kuya Miguel said. "Regression for trends. Simulation for uncertainty. Quantitative methods turn guesses into informed decisions."

That evening, Tian committed the final notebook to GitHub: "Scholarship Forecasting Model - Q7 Projection". The README included:
- Data sources and assumptions
- Model methodology
- How to update with new data
- Limitations and caveats
- Contact for questions

From raw application counts to board-approved budget—all powered by Python, statistics, and data science principles.

"We didn't just build a model," Rhea Joy reflected. "We built a decision-making tool the barangay can use for years."

Tian looked at the approved budget: ₱660,000 allocated based on evidence, not intuition. Students would get scholarships. The budget wouldn't run short. Planning would be proactive, not reactive.

**That's the power of modeling the future.**

_Next up: File I/O in Python!_ 📂

**Next:** Quiz then project implementation.