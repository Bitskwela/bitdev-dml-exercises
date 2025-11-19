## Lesson 13: Introduction to Quantitative Methods

Story: Barangay wants to forecast next quarter scholarship budget. Tian asks: "Can we predict from past data?" Rhea Joy nods: "Welcome to quantitative modeling."

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

### 12. Practice Prompts
1. Calculate mean, median of sample list.
2. Identify categorical vs numeric fields in dataset.
3. Sketch workflow for predicting applicant approval rate.
4. List 3 Python libraries relevant to analysis.

### 13. Reflection
Two reasons automated quantitative analysis beats manual.

**Next:** Quiz then exercises.