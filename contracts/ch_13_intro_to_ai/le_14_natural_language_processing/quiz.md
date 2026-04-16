# Lesson 14 Quiz: Natural Language Processing

---
# Quiz 1
## Scenario: Autocorrect Fail
Dan's autocorrect mangled his message. He wondered how AI reads text.

**Question 1:** What is the core challenge of NLP?
A. Python is too slow
B. Computers only understand numbers; words are not numbers
C. Text is too short
D. Nothing — it's easy

**Answer:** B
**Explanation:** NLP's fundamental job is converting text into numeric representations so that math / ML / DL can operate on it.

---

**Question 2:** What does tokenization mean?
A. Converting images to text
B. Splitting text into individual words or tokens
C. Encrypting text
D. Translating to Tagalog

**Answer:** B
**Explanation:** "I love adobo" → ["I", "love", "adobo"]. Tokenization is the first step in most NLP pipelines.

---

**Question 3:** Why do we remove stop words?
A. They take up storage
B. Words like "the", "is", "and" add noise without useful information
C. To encrypt data
D. We don't — they're always useful

**Answer:** B
**Explanation:** Stop words are filler — removing them focuses on meaningful content words.

---

**Question 4:** What is the "Bag of Words" approach?
A. A physical bag of books
B. Ignore word order, count word frequencies
C. A type of neural network
D. An encryption scheme

**Answer:** B
**Explanation:** Bag of Words treats text as just a collection of word counts. Simple but effective for many classification tasks.

---

**Question 5:** Dan's sentiment classifier detects:
A. Whether text is in English
B. Positive vs negative tone based on keyword matches
C. The length of the review
D. The author's age

**Answer:** B
**Explanation:** Keyword-based sentiment: count positive words vs negative words, then classify.

---
# Quiz 2
## Scenario: Why NLP Is Hard
Dan learned keyword matching has limits.

**Question 6:** Which is NOT a challenge for basic NLP?
A. Sarcasm ("Oh wow, super sarap" said bitterly)
B. Taglish / mixed languages
C. Counting the number of words
D. Context ambiguity (river bank vs money bank)

**Answer:** C
**Explanation:** Counting words is trivial. Sarcasm, slang, Taglish, and ambiguity are where basic NLP fails — modern LLMs handle these much better.

---

**Question 7:** Modern NLP breakthroughs (like ChatGPT) use:
A. Keyword matching
B. Transformers with hundreds of billions of parameters trained on massive text corpora
C. A dictionary lookup
D. Random guessing

**Answer:** B
**Explanation:** Modern LLMs are deep neural networks (transformers) with massive parameter counts, trained on internet-scale text data.

---
**Next:** Proceed to Lesson 14 exercises.
