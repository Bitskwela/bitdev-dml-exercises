# Recommender Showdown: Heuristic vs Learning

Build TWO dish recommenders for Tita Malou's carinderia â€” one based on her rules (heuristic), one that learns patterns from sales data. Then race them on a held-out test set.

---

## Task 1: Generate the Dataset

The starter generates 200 days of simulated sales data with realistic patterns:
- Rainy + Friday â†’ Sinigang dominates (45%)
- Payday â†’ Kare-Kare or Bistek (55%)
- Weekend + Sunny â†’ Halo-Halo (40%)
- Monday â†’ Lugaw or Tortang Talong (43%)

---

## Task 2: Build the Heuristic Recommender

Hand-code Tita Malou's "20 years of experience":

```python
def heuristic_recommender(weather, day, is_payday):
    if is_payday:            return "Kare-Kare"
    elif weather == "Rainy": return "Sinigang"
    elif weather == "Sunny": return "Halo-Halo"
    elif day == "Monday":    return "Lugaw"
    else:                    return "Adobo"
```

---

## Task 3: Build the Learning Recommender

Count how often each dish was best-seller for each (weather, day, is_payday) combo. Store in a frequency model dict. Recommend the most common best-seller for that context.

---

## Task 4: Head-to-Head Comparison

Split data 75/25 into training and test. Build the frequency model from training data only. Run both recommenders on the test set. Compare accuracy.

### Sample Output

```
Heuristic accuracy:      62/100 = 62.0%
Data-driven accuracy:    78/100 = 78.0%
Learning edge:           +16.0%

Hidden patterns discovered:
- Rainy Fridays are sinigang-dominant
- Payday weekends = Kare-Kare rules
```

---

## Challenge: Add Time-of-Day

Add a `time_of_day` variable ("morning", "lunch", "afternoon", "evening") to both systems. Expand the dataset and rebuild. Does the learning system improve more than the heuristic?

### Bonus: 10-Scenario Accuracy Test

Define 10 specific scenarios with a "ground truth" expected dish. Test both recommenders. Which gets more right?

---

## What You've Learned

- Heuristics (hand-coded rules) vs learning (data-discovered rules)
- Frequency-based learning: count and return the mode
- Train/test splits to measure accuracy fairly
- Why data-driven systems can find patterns humans miss

Next up: **Intro to Neural Networks** â€” Dan builds his first perceptron.
