# Simulation and Monte Carlo Activity

Practice generating synthetic data and running simulations.

### Task 1: Random Integers
```python
import random

# Generate 100 random integers between 1-50
random_numbers = [random.randint(1, 50) for _ in range(100)] 

print(f"First 10: {random_numbers[:10]}")
print(f"Mean: {sum(random_numbers)/len(random_numbers):.2f}")
```

### Task 2: Normal Distribution
```python
import numpy as np

# Simulate ages: mean=22, std=3, n=100
ages = np.random.normal(22, 3, 100) 

print(f"Mean: {np.mean(ages):.2f}")
print(f"Std: {np.std(ages):.2f}")
```

### Task 3: Monte Carlo Simulation
```python
results = []
for _ in range(500):
    applicants = np.random.normal(100, 15)  # mean=100, std=15
    cost = applicants * 600  # ₱600 per applicant
    results.append(cost)

mean_cost = np.mean(results)
std_cost = np.std(results)
print(f"Expected cost: ₱{mean_cost:,.0f} ± {std_cost:,.0f}")
```

### Task 4: Histogram
```python
import matplotlib.pyplot as plt

plt.hist(results, bins=30, edgecolor='black')
plt.axvline(mean_cost, color='r', linestyle='--', label='Mean')
plt.xlabel("Total Cost")
plt.ylabel("Frequency")
plt.legend()
plt.show()
```

## Reflection
**Two benefits of simulation:**
1. _[Captures uncertainty/variability]_
2. _[Tests multiple scenarios without real-world risk]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
# Task 1
random_numbers = [random.randint(1, 50) for _ in range(100)]

# Task 2  
ages = np.random.normal(22, 3, 100)

# Task 3 - complete code above is correct

# Task 4 - complete code above is correct
```

**Reflection:** Simulations (1) Quantify uncertainty with confidence intervals, (2) Test scenarios before implementation, (3) Handle complex systems analytically intractable

</details>
