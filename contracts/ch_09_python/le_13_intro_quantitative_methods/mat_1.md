## Background Story

The barangay council meeting was tense. Captain Cruz faced a difficult question from the treasurer: "How much budget should we allocate for scholarships next quarter? Last time we ran out of funds halfway through. The time before that, we overestimated and had surplus we couldn't use for anything else." The council members argued back and forth, throwing out guesses based on gut feelings and vague memories of past years.

Tian, sitting in the back row taking notes for the youth committee, had an idea. "Captain Cruz, what if we could predict the budget based on actual historical data? We have three years of scholarship records—number of applicants, approval rates, average amounts awarded." The room went quiet. The treasurer looked skeptical. "You can predict the future from past data?"

Rhea Joy, who'd been reading about data science, jumped in. "It's called quantitative methods, sir. Using mathematical models to analyze patterns and make informed predictions. It's not magic—it's statistics and probability." Captain Cruz was intrigued. "Can you actually do this?" Tian glanced at Rhea Joy nervously. They'd never done anything like this before.

That evening, Kuya Miguel gave them a crash course via video call. "Quantitative modeling sounds fancy, but it starts simple: collect numerical data, look for patterns, build a model, test your predictions. You're not fortune tellers—you're making educated estimates based on trends." They gathered their scholarship data: applications per quarter, approval percentages, seasonal variations, economic factors. By midnight, they had a basic forecast model that predicted next quarter's budget need with reasonable confidence intervals. The council was impressed. The scholarship system was becoming strategic, one data-driven decision at a time.

---

## Theory & Lecture Content

### 1. What Are Quantitative Methods?
Using numerical data + mathematical models to:
- Describe patterns (descriptive)
- Make predictions (predictive)
- Test hypotheses (inferential)

### 2. Common Applications
- Budget forecasting
- Demand prediction
- Risk assessment
- A/B testing results
- Time series trends

### 3. Data Types Recap
- Categorical: labels ("Approved", "Pending")
- Numerical: counts, measurements (age, income)
  - Discrete: integers (applicants)
  - Continuous: floats (average score)

### 4. Measurement Scales
- Nominal: unordered categories
- Ordinal: ordered categories
- Interval: numeric differences meaningful (no true zero)
- Ratio: true zero exists (income)

### 5. The Modeling Workflow
1. Define question
2. Collect data
3. Clean & explore
4. Choose model
5. Train/fit
6. Validate
7. Interpret & decide

### 6. Python Ecosystem for Quant
- NumPy: arrays, linear algebra
- Pandas: DataFrames, data manipulation
- Matplotlib/Seaborn: visualization
- SciPy: statistical functions
- Scikit-learn: machine learning

### 7. Example: Simple Average
```python
applicant_ages = [18, 21, 19, 22, 20]
average_age = sum(applicant_ages) / len(applicant_ages)
```

### 8. Why Not Just Spreadsheets?
- Reproducibility (scripts)
- Scalability (thousands of rows)
- Automation (batch processing)
- Advanced algorithms (ML, optimization)

### 9. Story Thread
Historical scholarship count per quarter plotted; trend line fitted; next quarter estimate derived.

### 10. Common Pitfalls
- Overfitting: model memorizes noise
- Underfitting: model too simple
- Ignoring data quality
- Confusing correlation with causation

### 11. Ethical Considerations
- Bias in training data
- Transparency in predictions
- Privacy of sensitive fields

---

## Closing Story

The barangay captain asked a simple question: "What's the average age of our scholarship applicants?"

Tian pulled out a calculator and started manually adding ages from the paper forms. After 10 minutes, he'd only processed 15 out of 150 applicants.

"This will take hours," Rhea Joy sighed.

Kuya Miguel opened a laptop. "Let me show you something."

```python
import pandas as pd

# Load data
df = pd.read_csv("applicants.csv")

# Calculate statistics
average_age = df["age"].mean()
median_age = df["age"].median()
total_applicants = len(df)
approved = len(df[df["status"] == "Approved"])
approval_rate = (approved / total_applicants) * 100

print(f"Total Applicants: {total_applicants}")
print(f"Average Age: {average_age:.1f} years")
print(f"Median Age: {median_age}")
print(f"Approval Rate: {approval_rate:.1f}%")
```

The output appeared in seconds:
```
Total Applicants: 150
Average Age: 18.3 years
Median Age: 18
Approval Rate: 67.3%
```

Tian stared at the screen. "That... took two seconds?"

"Quantitative methods," Kuya Miguel explained. "Instead of manually counting and calculating, we let computers process the numbers. Mean, median, mode, standard deviation, correlations—all automated."

Rhea Joy was already thinking ahead. "Can we predict which applicants are likely to be approved based on past data?"

"That's machine learning," Kuya Miguel smiled. "But it starts with understanding the basics: descriptive statistics, probability, data distributions. Once you can describe your data quantitatively, you can analyze it. Once you can analyze it, you can predict from it."

Tian looked at the 150 paper forms. Each one a data point. Each data point telling a story. And with Python, those stories could be read, understood, and acted upon at scale.

"From manual counting to automated analysis," Tian marveled. "This changes everything."

_Next up: NumPy, Pandas, and Matplotlib—the data science toolkit!_ 📊

**Next:** Quiz then exercises.