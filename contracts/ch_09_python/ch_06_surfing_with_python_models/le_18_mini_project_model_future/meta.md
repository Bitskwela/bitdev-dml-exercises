## Lesson 18 Exercises: Mini Project Implementation

---
### Project: Quarterly Applicant & Budget Forecast

**Data:** Historical quarterly applicants = [90, 95, 100, 110, 105, 115]

---
### Step 1: Load & Explore (5 minutes)
Create arrays quarters (1-6), applicants. Compute mean, std.

---
### Step 2: Fit Regression (8 minutes)
Use stats.linregress; print slope, intercept, R^2.

---
### Step 3: Forecast Q7 Base (5 minutes)
Compute q7_base = slope * 7 + intercept.

---
### Step 4: Simulate Variability (10 minutes)
Generate 1000 samples: normal(q7_base, historical_std).

---
### Step 5: Confidence Interval (7 minutes)
Compute 2.5th, 97.5th percentiles; report CI.

---
### Step 6: Budget Estimate (6 minutes)
Cost per applicant = 600. Compute budget_samples = q7_samples * 600; mean budget.

---
### Step 7: Visualization (10 minutes)
Plot: historical line, Q7 forecast point, shaded CI region.

---
### Step 8: Written Report (10 minutes)
Summarize:
- Trend equation
- Q7 forecast ± CI
- Budget mean ± range
- Assumptions & limitations (2-3 sentences)

---
### Step 9: Validation Idea (5 minutes)
Propose how to test model accuracy (e.g., holdout last quarter).

---
### Step 10: Extension Brainstorm (5 minutes)
List 2 model improvements (seasonal adjust, multi-variate, polynomial).

---
### Reflection (3 minutes)
Two lessons learned integrating regression + simulation.

---
**Next:** Chapter 6 complete; move to Chapter 7 (File I/O, CSV, Modules).