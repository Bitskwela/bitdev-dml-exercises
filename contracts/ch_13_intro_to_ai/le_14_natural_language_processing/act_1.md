# Review Analyzer (NLP Lab)

Analyze 20 customer reviews of Tita Malou's carinderia using tokenization, word frequency, stop word removal, and sentiment classification.

---

## Task 1: Tokenize

Write a `tokenize(text)` function that:
- Lowercases the text
- Removes punctuation
- Splits into words

```python
import string
def tokenize(text):
    text = text.lower()
    text = text.translate(str.maketrans("", "", string.punctuation))
    return text.split()
```

---

## Task 2: Word Frequency

Use `collections.Counter` to find the most common words across all reviews.

```python
from collections import Counter
counter = Counter()
for review in reviews:
    counter.update(tokenize(review))
print(counter.most_common(10))
```

---

## Task 3: Stop Word Removal

Filter out filler words (English + Filipino stop words):

```python
STOP_WORDS = {"the", "is", "a", "and", "to", "of", "in",
              "ang", "ng", "sa", "na", "ay", "mga"}
```

Re-count frequency, this time only meaningful words.

---

## Task 4: Keyword-Based Sentiment

```python
POSITIVE = {"masarap", "sulit", "fresh", "delicious", "affordable", "sarap", "busog"}
NEGATIVE = {"matagal", "malamig", "konti", "mahal", "pangit", "hindi", "walang"}

def sentiment(text):
    words = set(tokenize(text))
    pos = len(words & POSITIVE)
    neg = len(words & NEGATIVE)
    if pos > neg: return "positive"
    if neg > pos: return "negative"
    return "neutral"
```

---

## Task 5: Full Report

For all 20 reviews:
- Classify each
- Count positive / negative / neutral
- Print top 5 positive keywords found
- Print top 5 negative keywords found
- Compute overall satisfaction %

### Sample Output

```
📊 REVIEW ANALYSIS — Tita Malou's Carinderia
  Total reviews:    20
  Positive:         14 (70%)
  Negative:          4 (20%)
  Neutral:           2 (10%)

Top positive keywords: masarap (8), sulit (5), fresh (4), sarap (3)
Top negative keywords: matagal (3), konti (2), mahal (2)
```

---

## Challenge: Intensifiers & Categorization

### Challenge A: Intensifiers

Words like "sobrang" or "super" amplify the next word. Detect them and weight sentiment accordingly:
- "sobrang masarap" → +2 positive
- "super pangit" → +2 negative

### Challenge B: Topic Categories

Classify each review into a topic:
- food_quality (keywords: sarap, lasa, lutong, fresh)
- service (keywords: mabilis, matagal, tindera, service)
- price (keywords: sulit, mahal, presyo, affordable)
- cleanliness (keywords: malinis, madumi, mabaho)
- portions (keywords: konti, malaki, dami)

---

## What You've Learned

- Tokenization and stop word removal
- Word frequency counting with `Counter`
- Keyword-based sentiment classification
- Why real NLP is harder (sarcasm, Taglish, context)

Next up: **Computer Vision** — Dan discovers how AI sees images.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the complete 20-review NLP lab with intensifiers and topic categorization.

</details>
