## Background Story

The scholarship program faced a new challenge: Should they allocate funds on a first-come-first-served basis, or hold all applications and distribute based on merit? Captain Cruz wanted data to support the decision, but they couldn't exactly run the program both ways and see what happens—real students were depending on this funding.

"What if we simulate it?" Rhea Joy suggested during a brainstorming session. "We have historical data on application timing and student qualifications. What if we create a computer model that runs both scenarios thousands of times with random variations and see which approach maximizes student outcomes?" Tian looked confused. "Create fake data? Isn't that... cheating?"

Kuya Miguel jumped on a video call to explain. "Simulation is a powerful tool when you can't experiment in reality. You're not making up data randomly—you're generating synthetic data that follows real patterns and distributions. Monte Carlo simulation can run thousands of 'what-if' scenarios in seconds. It's how engineers test bridges before building them, how epidemiologists model disease spread, how financial analysts assess risk."

They built a simulation model: generate synthetic applicants based on historical distributions, run the first-come-first-served algorithm, record outcomes, repeat 10,000 times. Then do the same with merit-based distribution. The results were clear—merit-based allocation consistently produced better outcomes with less variance. Captain Cruz was convinced by the evidence. They even used simulation to optimize the balance between merit and need-based criteria. The scholarship system was becoming sophisticated, one simulated scenario at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

The scholarship budget planning hit a snag. The forecast said 90 applications, but what if some applicants dropped out? What if more showed up? What if scholarship amounts varied?

"Single-point estimates are brittle," Kuya Miguel explained. "They don't capture uncertainty. Let's simulate 1,000 possible futures."

Tian built a Monte Carlo simulation:

```python
import numpy as np
import matplotlib.pyplot as plt

# Parameters (based on historical data)
avg_applications = 90
std_applications = 8
avg_scholarship = 5000
std_scholarship = 500

# Run 1000 simulations
np.random.seed(42)
num_simulations = 1000
total_costs = []

for _ in range(num_simulations):
    # Simulate applicants (normal distribution)
    applicants = int(np.random.normal(avg_applications, std_applications))
    applicants = max(0, applicants)  # Can't be negative
    
    # Simulate scholarship amounts
    scholarships = np.random.normal(avg_scholarship, std_scholarship, applicants)
    total_cost = scholarships.sum()
    total_costs.append(total_cost)

# Analyze results
mean_cost = np.mean(total_costs)
percentile_95 = np.percentile(total_costs, 95)

print(f"Expected Cost: ₱{mean_cost:,.0f}")
print(f"95th Percentile: ₱{percentile_95:,.0f}")
print(f"Range: ₱{min(total_costs):,.0f} - ₱{max(total_costs):,.0f}")

# Visualize
plt.hist(total_costs, bins=50, edgecolor='black', alpha=0.7)
plt.axvline(mean_cost, color='red', linestyle='--', label=f'Mean: ₱{mean_cost:,.0f}')
plt.axvline(percentile_95, color='orange', linestyle='--', label=f'95th: ₱{percentile_95:,.0f}')
plt.xlabel("Total Cost (₱)")
plt.ylabel("Frequency")
plt.title("Monte Carlo Simulation: Scholarship Budget (1000 runs)")
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()
```

The histogram showed a bell curve. Most scenarios clustered around ₱450,000, but some reached ₱520,000.

"See the distribution?" Rhea Joy pointed. "The 95th percentile is ₱487,000. If we budget that amount, we'll be covered in 95% of scenarios."

Kuya Miguel nodded approvingly. "Simulation captures variability. Instead of saying 'we need ₱450,000,' you can say 'we need ₱450,000 on average, but should reserve ₱487,000 to be 95% confident.'"

Tian ran variations:
- Pessimistic scenario: +20% applications → 95th percentile: ₱585,000
- Optimistic scenario: -10% applications → 95th percentile: ₱395,000

The captain reviewed the risk analysis. "Budget ₱490,000. If applications are lower, we save. If higher, we're still covered. This is contingency planning with math."

"Simulation doesn't predict the future," Kuya Miguel explained. "It explores possible futures and quantifies their likelihood. That's far more useful than a single guess."

Rhea Joy saved the simulation notebook. The scholarship committee now had not just a forecast, but a probability distribution of outcomes—and a budget that reflected real-world uncertainty.

_Next up: Mini Project—Model the Future!_ 🔮

**Next:** Quiz then exercises.