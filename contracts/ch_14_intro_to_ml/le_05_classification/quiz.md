# Lesson 5 Quiz: Classification

---
# Quiz 1
## Scenario: The Sunday Labels

Tita Malou hands Dan a stack of notebook pages and a sharpie. He labels each day busy / normal / slow.

**Question 1:** Which problem is classification (not regression)?
A. "Predict tomorrow's revenue in pesos"
B. "Classify each day as busy, normal, or slow"
C. "Forecast next month's flour expense"
D. "Estimate the delivery ETA in minutes"

**Answer:** B
**Explanation:** Categorical label (busy/normal/slow) → classification. The others are continuous numbers.

---

**Question 2:** How many CLASSES does Dan's busy/normal/slow problem have?
A. 1
B. 2 (binary)
C. 3 (multi-class)
D. As many as there are rows

**Answer:** C
**Explanation:** Three possible categories → 3-class classification.

---

**Question 3:** A confusion matrix shows:
A. How confused Dan is
B. Counts of (true label × predicted label) pairs — diagonal = correct, off-diagonal = errors
C. Only the accuracy number
D. The model's source code

**Answer:** B
**Explanation:** A 2D grid where rows are true labels and columns are predictions. Reading it shows where the model is wrong, not just how often.

---

**Question 4:** Accuracy = correct / total. If 95% of days are normal and a model always predicts normal, what is its accuracy?
A. ~50%
B. ~95% (without learning anything)
C. 100%
D. 0%

**Answer:** B
**Explanation:** That's the classic imbalanced-data trap. Always-predict-majority is a strong dummy baseline — and exposes why accuracy alone is misleading.

---

# Quiz 2
## Scenario: Threshold Design

Dan picks ₱5000 as his "busy" threshold and ₱2000 as his "normal" threshold.

**Question 5:** What happens if Dan changes the busy threshold from ₱5000 to ₱4000?
A. Nothing changes
B. More days get labeled "busy" — the class distribution shifts toward "busy"
C. Fewer days get labeled "busy"
D. The model becomes more accurate automatically

**Answer:** B
**Explanation:** Lower threshold → more rows above it → more "busy" labels. Threshold is a design choice that shapes the problem.

---

**Question 6:** Why is a CONFUSION MATRIX more informative than a single accuracy number?
A. It is not
B. It shows which classes get confused with which — diagnostic info you can't get from one number
C. It's just prettier
D. It's faster to compute

**Answer:** B
**Explanation:** A 79% accuracy could come from many shapes — confused busy/normal vs. confused slow/normal. The matrix reveals the structure of errors.

---

**Question 7:** What's the difference between BINARY and MULTI-CLASS classification?
A. Binary uses Python booleans; multi-class uses strings
B. Binary has exactly 2 possible labels; multi-class has 3 or more
C. There's no difference
D. Multi-class is always harder

**Answer:** B
**Explanation:** Binary = 2 outcomes (spam/not). Multi-class = 3+ outcomes (Sinigang/Adobo/Kare-Kare/Bistek/...).

---
**Next:** Proceed to Lesson 5 exercises.
