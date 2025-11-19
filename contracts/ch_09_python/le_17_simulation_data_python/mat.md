## Lesson 17: Simulation and Data Generation in Python

Story: "What if applicant flow doubles?" Committee asks. Tian simulates 1000 scenarios using random data to model outcomes.

### 1. Why Simulate?
- Test "what-if" scenarios
- Understand variability
- Train models when real data scarce
- Monte Carlo risk assessment

### 2. Random Number Generation
```python
import random
random.random()          # 0.0 to 1.0
random.randint(1, 100)   # integer
random.choice(["A","B","C"])
```

### 3. NumPy Random
```python
import numpy as np
np.random.rand(5)           # uniform [0,1)
np.random.randint(1, 10, size=5)
np.random.normal(mu, sigma, size=100)
```

### 4. Setting Seed (Reproducibility)
```python
np.random.seed(42)
# now results repeatable
```

### 5. Simulating Applicant Flow
```python
base = 100
variability = 10
simulated = [base + np.random.randint(-variability, variability) for _ in range(12)]
```

### 6. Monte Carlo Example
Simulate 1000 budget scenarios:
```python
results = []
for _ in range(1000):
    applicants = np.random.normal(100, 15)
    cost = applicants * 500
    results.append(cost)
avg_cost = np.mean(results)
std_cost = np.std(results)
```

### 7. Confidence Intervals (Concept)
95% of simulations fall within mean ± 1.96*std (normal assumption).

### 8. Generating Synthetic Datasets
```python
data = pd.DataFrame({
    "age": np.random.randint(18, 65, 500),
    "income": np.random.normal(30000, 10000, 500)
})
```

### 9. Sampling Distributions
Repeat sampling; observe mean distribution (Central Limit Theorem).

### 10. Story Thread
Simulate next year: 1000 runs; histogram of total cost; identify 95th percentile for budget ceiling.

### 11. Practice Prompts
1. Generate 100 random integers 1-50.
2. Simulate normal distribution (mean 22, std 3).
3. Run Monte Carlo with 500 iterations.
4. Plot histogram of simulation results.

### 12. Reflection
Two benefits of simulation over single-point estimates.

**Next:** Quiz then exercises.