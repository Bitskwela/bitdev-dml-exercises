## Lesson 16: Regression and Linear Models

Story: Can we predict scholarship cost from applicant count? Tian plots points; Rhea Joy fits a line: "Regression finds relationships."

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

**Next:** Quiz then exercises.