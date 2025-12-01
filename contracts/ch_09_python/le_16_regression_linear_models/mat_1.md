## Background Story

The barangay council wanted to optimize scholarship amounts. "Is there a relationship between family income and academic performance?" the treasurer asked. "Should we give more support to lower-income students since they might have less resources?" These were critical questions affecting real students' futures, and Tian realized gut feelings wouldn't cut it—they needed evidence.

Rhea Joy plotted household income versus GPA on a scatter chart using Matplotlib. There was definitely a pattern—students from lower-income families tended to have slightly lower GPAs, though with significant variation. "We can see a trend, but how do we quantify it? How strong is the relationship? Can we predict expected GPA based on income?" She felt like they were so close to insights but missing a crucial tool.

Kuya Miguel introduced them to regression analysis. "Linear regression lets you model relationships between variables. You draw the 'best fit' line through your data points. The slope tells you how much GPA changes with income. The R-squared value tells you how well the model fits. It's like finding the mathematical rule hidden in the scatter plot." He showed them how to implement it with just a few lines of scikit-learn code.

They built a regression model predicting GPA from household income, controlling for other factors like hours worked and internet access. The model revealed that income alone explained only 23% of GPA variation—meaning other factors mattered more than economics. This insight led to policy changes: rather than just income-based aid, they added study support programs and internet subsidies. The scholarship system was becoming evidence-based, one regression line at a time.

---

## Theory & Lecture Content

### 1. What Is Regression?
Modeling relationship between dependent variable (y) and independent variable(s) (x).

### 2. Simple Linear Regression
y = mx + b (slope, intercept)
Fit line minimizing sum of squared errors.

### 3. Example Setup
```python
import numpy as np
from scipy import stats
x = np.array([10, 20, 30, 40, 50])  # applicant count
y = np.array([5000, 9500, 15000, 19000, 25000])  # cost
```

### 4. Fitting the Model
```python
slope, intercept, r_value, p_value, std_err = stats.linregress(x, y)
print(f"y = {slope:.2f}x + {intercept:.2f}")
```

### 5. Making Predictions
```python
def predict(applicants):
    return slope * applicants + intercept
print(predict(60))
```

### 6. R-Squared (Coefficient of Determination)
Measures fit quality (0 to 1); closer to 1 = better fit.
```python
r_squared = r_value ** 2
```

### 7. Residuals
Difference between actual y and predicted y.
Check residual plot for patterns (should be random).

### 8. Assumptions
- Linearity
- Independence of errors
- Homoscedasticity (constant variance)
- Normality of residuals

### 9. When Linear Regression Fails
- Non-linear relationships
- Outliers dominating
- Multicollinearity (multiple predictors)

### 10. Polynomial Regression (Teaser)
Fit curve: y = ax^2 + bx + c
Use np.polyfit for higher degrees.

### 11. Story Thread
Fit line predicting cost from count; R^2 = 0.98; forecast next quarter budget.

### 12. Practice Prompts
1. Fit simple linear model to sample data.
2. Compute R^2.
3. Predict y for new x value.
4. Plot data + fitted line.

### 13. Reflection
Two signs regression model is appropriate for your data.

---

## Closing Story

The barangay captain asked the million-peso question: "If applications keep growing like this, how many scholarships should we budget for next year?"

Tian pulled up the historical data: 6 quarters of scholarship applications. The numbers were trending upward.

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

# Historical data
quarters = np.array([1, 2, 3, 4, 5, 6]).reshape(-1, 1)
applications = np.array([45, 52, 58, 67, 73, 81])

# Fit linear model
model = LinearRegression()
model.fit(quarters, applications)

# Predict Q7
Q7_pred = model.predict([[7]])[0]

print(f"Slope: {model.coef_[0]:.2f} applications per quarter")
print(f"Intercept: {model.intercept_:.2f}")
print(f"Q7 Prediction: {Q7_pred:.0f} applications")
print(f"R²: {model.score(quarters, applications):.3f}")

# Visualize
plt.scatter(quarters, applications, label="Actual")
plt.plot(quarters, model.predict(quarters), 'r-', label="Trend Line")
plt.scatter([7], [Q7_pred], color='green', s=100, label="Q7 Forecast")
plt.xlabel("Quarter")
plt.ylabel("Applications")
plt.title("Scholarship Applications Trend")
plt.legend()
plt.grid(True)
plt.show()
```

The output:
```
Slope: 7.14 applications per quarter
Intercept: 39.71
Q7 Prediction: 90 applications
R²: 0.987
```

"R² of 0.987," Rhea Joy noted. "That means our linear model explains 98.7% of the variance. The trend is strong and consistent."

Kuya Miguel reviewed the chart. "The line fits well. But remember—this assumes the trend continues linearly. External factors could change that: economic downturn, policy changes, population shifts."

Tian added confidence intervals to the forecast. With 95% confidence, Q7 applications would be between 82 and 98.

"So budget for 90, but prepare for the upper bound of 98," the captain concluded. "This gives us a data-driven target instead of guessing."

Rhea Joy opened the budget spreadsheet. 90 applications × ₱5,000 per scholarship = ₱450,000 needed for Q7.

"From gut feeling to statistical forecast," Tian marveled. "Regression turns history into prediction."

_Next up: Simulation and Monte Carlo Methods!_ 🎲

**Next:** Quiz then exercises.