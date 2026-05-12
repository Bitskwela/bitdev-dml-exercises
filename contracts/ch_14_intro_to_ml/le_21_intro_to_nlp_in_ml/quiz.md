# Lesson 21 Quiz: Intro to NLP in ML

---
# Quiz 1
## Scenario: Reading the Notebook

Tita Malou's notebook has 20 mixed Tagalog/English entries. Dan turns them into vectors.

**Question 1:** What does bag-of-words do?
A. Sorts words alphabetically
B. Converts each document into a vector of WORD COUNTS — order is lost, counts are kept
C. Encrypts text
D. Compresses text

**Answer:** B
**Explanation:** BOW = unordered word counts per document. Simple but surprisingly effective baseline for text classification.

---

**Question 2:** With bag-of-words, why does "order 3 sinigang" still classify correctly even though we don't know "order" came BEFORE "sinigang"?
A. It doesn't
B. The presence of "order" alone is strongly correlated with the "order" class — counts matter, not order
C. Random luck
D. Position is preserved secretly

**Answer:** B
**Explanation:** Many classification problems are well-served by word presence/absence. Word order is bonus information, not always required.

---

**Question 3:** Why is mixing Tagalog and English in one sentence NOT a problem for BOW?
A. It is a problem
B. The vocabulary just collects every unique token regardless of language; the classifier learns weights for each — language-agnostic
C. The classifier translates
D. Random

**Answer:** B
**Explanation:** BOW treats all tokens as opaque symbols. The vocabulary is whatever the data contains.

---

**Question 4:** What is TF-IDF?
A. A type of model
B. A weighting scheme that down-weights words appearing in MANY documents and up-weights rare informative words
C. A tokenizer
D. A neural network

**Answer:** B
**Explanation:** TF-IDF reweights raw counts. Common words like "the" get small weights; rare informative words get bigger weights.

---

# Quiz 2
## Scenario: Filipino-Specific NLP

Dan classifies Filipino/English mixed text. Some standard NLP techniques need adjustment.

**Question 5:** Why might you NOT want to remove "stopwords" (po, na, ng, the, a) on Filipino notebook entries?
A. They're too short
B. Filipino small words often carry meaning (formality, plurals, conjunctions) — removing them can hurt classifier performance for Filipino text
C. They're alphabetical
D. There are no stopwords

**Answer:** B
**Explanation:** English NLP often strips stopwords, but Filipino's grammatical particles carry semantic weight. Defaults aren't universal.

---

**Question 6:** What are N-GRAMS in BOW?
A. Single words only
B. Sequences of N consecutive words (bigrams = pairs, trigrams = triples) — preserves some local word order
C. The number of documents
D. The number of classes

**Answer:** B
**Explanation:** N-grams capture short phrases. Useful for short documents (like notebook entries) where local order matters.

---

**Question 7:** Which classifier did Dan use on the BOW features?
A. A brand-new neural network
B. The same logistic regression from Lesson 13 (one-vs-rest for 3 classes)
C. K-Means
D. Decision Tree (impossible)

**Answer:** B
**Explanation:** Once text becomes numeric vectors, the same classifiers you've already built apply. The "new" part of NLP is the vectorization, not the model.

---
**Next:** Proceed to Lesson 21 exercises.
