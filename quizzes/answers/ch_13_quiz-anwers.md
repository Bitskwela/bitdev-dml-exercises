# Chapter 13 — Intro to AI: Quiz Answer Key

Source: 25 per-lesson `quiz.md` files in `contracts/ch_13_intro_to_ai/le_*/`.
This file aggregates every question, answer, and explanation in one place for instructors and reviewers.

## Table of Contents
1. [Lesson 1 — What is AI?](#lesson-1-what-is-ai)
2. [Lesson 2 — Narrow vs General AI](#lesson-2-narrow-vs-general-ai)
3. [Lesson 3 — AI vs ML vs DL](#lesson-3-ai-vs-ml-vs-dl)
4. [Lesson 4 — How AI Works](#lesson-4-how-ai-works)
5. [Lesson 5 — Data in AI](#lesson-5-data-in-ai)
6. [Lesson 6 — Structured vs Unstructured Data](#lesson-6-structured-vs-unstructured-data)
7. [Lesson 7 — Intro to Python for AI](#lesson-7-intro-to-python-for-ai)
8. [Lesson 8 — Python Basics — Lists, Loops, Decisions](#lesson-8-python-basics-lists-loops-decisions)
9. [Lesson 9 — Working with Libraries](#lesson-9-working-with-libraries)
10. [Lesson 10 — What is an Algorithm?](#lesson-10-what-is-an-algorithm)
11. [Lesson 11 — Heuristics vs Learning](#lesson-11-heuristics-vs-learning)
12. [Lesson 12 — Intro to Neural Networks](#lesson-12-intro-to-neural-networks)
13. [Lesson 13 — What is Deep Learning?](#lesson-13-what-is-deep-learning)
14. [Lesson 14 — Natural Language Processing](#lesson-14-natural-language-processing)
15. [Lesson 15 — Computer Vision](#lesson-15-computer-vision)
16. [Lesson 16 — Reinforcement Learning](#lesson-16-reinforcement-learning)
17. [Lesson 17 — Ethics in AI](#lesson-17-ethics-in-ai)
18. [Lesson 18 — AI Applications](#lesson-18-ai-applications)
19. [Lesson 19 — Prompt Engineering](#lesson-19-prompt-engineering)
20. [Lesson 20 — APIs in AI](#lesson-20-apis-in-ai)
21. [Lesson 21 — OpenAI API Basics](#lesson-21-openai-api-basics)
22. [Lesson 22 — Build an LLM Chatbot (Part 1)](#lesson-22-build-an-llm-chatbot-part-1)
23. [Lesson 23 — Build an LLM Chatbot (Part 2)](#lesson-23-build-an-llm-chatbot-part-2)
24. [Lesson 24 — Improve Chatbot](#lesson-24-improve-chatbot)
25. [Lesson 25 — Deploy AI App](#lesson-25-deploy-ai-app)

---

## Lesson 1 — What is AI?

### Quiz 1
#### Scenario: Dan's AI Awakening
Dan just learned that AI is already everywhere in his daily life. Help him check his understanding.

**Question 1:** Artificial Intelligence is best described as:
A. Humanoid robots that look and act like people
B. A field of computer science focused on systems that perform tasks requiring human intelligence
C. Any software that uses the internet
D. A programming language for smart devices

**Answer:** B
**Explanation:** AI is the field of creating systems that do tasks normally requiring human intelligence — understanding, deciding, learning — with or without a physical body.

**Question 2:** Which of the following is NOT an example of AI in daily Filipino life?
A. Grab matching you to the nearest driver
B. GCash flagging a suspicious transaction
C. A manual calculator performing 2 + 2
D. Lazada's search understanding "pang work na sapatos"

**Answer:** C
**Explanation:** A manual calculator just executes arithmetic — no learning, no pattern recognition, no intelligent decisions. The others all involve AI-driven decisions.

**Question 3:** The basic AI pattern is:
A. OUTPUT → INPUT → PROCESS
B. INPUT (data) → PROCESS (rules/logic) → OUTPUT (decision/action)
C. PROCESS → OUTPUT → INPUT
D. DATA → STORAGE → RETRIEVAL

**Answer:** B
**Explanation:** All AI systems take input data, process it with rules or learned patterns, and produce an output.

**Question 4:** In traditional programming, the rules come from:
A. Patterns the machine discovers from data
B. A human programmer writing them explicitly
C. Random guesses
D. The user in real time

**Answer:** B
**Explanation:** Traditional programming = humans write every rule. Machine learning = the machine discovers rules from data.

**Question 5:** A **rule-based system** (expert system) is:
A. An AI that learns rules automatically from millions of examples
B. An AI where humans hand-code every rule using if-else logic
C. A database of random facts
D. A type of neural network

**Answer:** B
**Explanation:** The ulam recommender is a rule-based system. Early AI worked this way before machine learning became practical.

### Quiz 2
#### Scenario: Scaling the Recommender
Dan's ulam recommender works with 3 inputs. He wonders what happens as the problem grows.

**Question 6:** What is the biggest limitation of hand-coded rule-based AI?
A. It uses too much memory
B. It cannot scale — writing thousands of rules by hand is impractical
C. It only works in English
D. It requires the internet

**Answer:** B
**Explanation:** Hand-coded rules work for small problems, but 1,000 dishes × 50 factors = impossible to write manually. This is why machine learning was invented.

**Question 7:** Which statement about AI is TRUE?
A. AI must have a physical body like a robot
B. AI is only used in advanced research labs, not everyday apps
C. AI is already embedded in everyday Filipino apps like Grab, Shopee, GCash, and Waze
D. AI was invented in 2023 with ChatGPT

**Answer:** C
**Explanation:** AI is software running inside the apps you already use every day — Grab routing, GCash fraud detection, Shopee recommendations, Waze traffic prediction, and many more.

---

## Lesson 2 — Narrow vs General AI

### Quiz 1
#### Scenario: Dan's Late-Night Panic
Dan read scary articles about AI taking over the world. Help him separate fact from fiction.

**Question 1:** Which type of AI is the ONLY one that exists today?
A. General AI (AGI)
B. Super AI (ASI)
C. Narrow AI (ANI)
D. Universal AI (UAI)

**Answer:** C
**Explanation:** Narrow AI is the only type that exists. It can do one specific task very well but nothing else.

**Question 2:** What is the best analogy for Narrow AI?
A. A general practitioner who treats everything
B. A specialist doctor who only treats one area
C. A superhuman genius who knows everything
D. A student learning all subjects equally

**Answer:** B
**Explanation:** Like a specialist doctor (e.g., ophthalmologist), Narrow AI is brilliant at one thing but cannot do anything else.

**Question 3:** General AI (AGI) is best described as:
A. AI that already exists in ChatGPT
B. A hypothetical AI with human-level intelligence across all domains
C. AI that is slightly better than Narrow AI
D. Any AI that uses the internet

**Answer:** B
**Explanation:** AGI would match human intelligence in every domain — learning any task, reasoning about anything, and adapting to any situation. It does not exist yet.

**Question 4:** Why is ChatGPT classified as Narrow AI and not General AI?
A. Because it is free to use
B. Because it can only generate text — it cannot drive, see, or physically act
C. Because it was made by a small company
D. Because it sometimes makes mistakes

**Answer:** B
**Explanation:** Despite seeming very capable, ChatGPT only does one thing: generate text responses. It cannot drive a car, cook food, or perform surgery.

**Question 5:** Super AI (ASI) is:
A. Currently being tested by Google
B. Expected to arrive by 2025
C. Pure science fiction — it does not exist and may never exist
D. The same as Narrow AI but faster

**Answer:** C
**Explanation:** If we cannot even build General AI, Super AI is orders of magnitude further away. It remains science fiction.

### Quiz 2
#### Scenario: Classifying Real Systems
Dan built an AI classifier. Help him classify these systems correctly.

**Question 6:** GCash fraud detection is an example of:
A. General AI — because it protects millions of people
B. Narrow AI — because it only detects suspicious transactions
C. Super AI — because it processes data very fast
D. Not AI at all

**Answer:** B
**Explanation:** GCash fraud detection does ONE thing: spot suspicious transactions. It cannot translate languages, drive cars, or recommend movies.

**Question 7:** Which statement about the three types of AI is TRUE?
A. General AI will be built within the next 5 years
B. Narrow AI is weak and not useful
C. Every AI system in daily use today is Narrow AI
D. Super AI already exists in military labs

**Answer:** C
**Explanation:** Grab, GCash, Shopee, Siri, ChatGPT, Netflix, Waze, face unlock, spam filters — ALL are Narrow AI. It is the only type that exists.

---

## Lesson 3 — AI vs ML vs DL

### Quiz 1
#### Scenario: The Nesting Dolls
Dan learned that AI, ML, and DL are nested like matryoshka dolls. Test your understanding.

**Question 1:** Which is the BROADEST category?
A. Machine Learning
B. Deep Learning
C. Artificial Intelligence
D. Neural Networks

**Answer:** C
**Explanation:** AI is the biggest "doll" — it covers ALL techniques that make machines act smart, including rule-based systems, ML, and DL.

**Question 2:** The relationship between AI, ML, and DL is:
A. They are three completely separate fields
B. DL is inside ML, which is inside AI
C. AI is inside ML, which is inside DL
D. ML and DL are the same thing

**Answer:** B
**Explanation:** DL ⊂ ML ⊂ AI. Deep Learning is a subset of Machine Learning, which is a subset of Artificial Intelligence.

**Question 3:** Dan's ulam recommender from Lesson 1 is classified as:
A. Machine Learning — because it makes predictions
B. Deep Learning — because it uses Python
C. AI (rule-based) — because the rules are hardcoded by a human
D. Not AI at all

**Answer:** C
**Explanation:** The ulam recommender uses if-else rules written by Dan. It doesn't learn from data — making it rule-based AI, not ML.

**Question 4:** What is the KEY difference between rule-based AI and Machine Learning?
A. ML is faster than AI
B. In AI, humans write the rules. In ML, the machine discovers rules from data.
C. ML works offline, AI needs internet
D. AI uses Python, ML uses Java

**Answer:** B
**Explanation:** The fundamental difference: rule-based AI = human writes rules, ML = machine learns rules from data.

**Question 5:** The Filipino food analogy is:
A. Pagkain = DL, Lutong Pinoy = ML, Sinigang = AI
B. Pagkain = AI, Lutong Pinoy = ML, Sinigang = DL
C. Pagkain = ML, Lutong Pinoy = AI, Sinigang = DL
D. All three are the same

**Answer:** B
**Explanation:** AI (broadest) = pagkain (food). ML (more specific) = lutong Pinoy. DL (most specific) = sinigang. All sinigang is lutong Pinoy, but not all lutong Pinoy is sinigang.

### Quiz 2
#### Scenario: Classify Real Systems
Help Dan classify these real-world AI systems.

**Question 6:** Shopee's product recommendations that improve the more you shop are:
A. AI (rule-based)
B. Machine Learning
C. Deep Learning
D. Not AI

**Answer:** B
**Explanation:** Shopee learns from your browsing and purchase data to improve recommendations. That's ML — the system discovers patterns from data.

**Question 7:** Your phone's face unlock feature uses:
A. AI (rule-based)
B. Machine Learning (basic)
C. Deep Learning (neural networks for image recognition)
D. Simple pattern matching

**Answer:** C
**Explanation:** Face recognition requires neural networks with many layers to process visual data — that's Deep Learning.

---

## Lesson 4 — How AI Works

### Quiz 1
#### Scenario: The Pipeline
Dan discovered that Tita Malou is basically a human AI model. Test your understanding of the pipeline.

**Question 1:** What are the three steps of the AI pipeline?
A. Input → Output → Result
B. Data → Model → Output
C. Code → Compile → Run
D. Question → Answer → Score

**Answer:** B
**Explanation:** Every AI system follows this pipeline: DATA (input) → MODEL (processing) → OUTPUT (prediction or decision).

**Question 2:** In the AI pipeline, what is "DATA"?
A. Only numbers stored in a spreadsheet
B. The raw information that goes into the system (numbers, text, images, audio, sensors)
C. The Python code that runs the program
D. The final prediction produced by the system

**Answer:** B
**Explanation:** Data is the raw input. It can be anything relevant — numbers, text, images, audio, sensor readings — as long as it's relevant to the prediction.

**Question 3:** In the AI pipeline, what is the "MODEL"?
A. The user of the AI system
B. The computer hardware
C. The part that processes data and finds patterns
D. The database where data is stored

**Answer:** C
**Explanation:** The model is the "brain" — a mathematical function (or human experience, in Tita Malou's case) that processes data and produces an output.

**Question 4:** "Garbage in, garbage out" means:
A. AI produces random results
B. If your data is bad or irrelevant, your predictions will be bad too
C. AI can only work with clean data
D. You should always delete old data

**Answer:** B
**Explanation:** The output is only as good as the data and model. Bad data = bad predictions, no matter how smart the model is.

**Question 5:** Tita Malou's prediction ("Cook extra sinigang tonight") is the:
A. DATA step
B. MODEL step
C. OUTPUT step
D. TRAINING step

**Answer:** C
**Explanation:** The prediction or decision is the OUTPUT — the final result of the pipeline. Data goes in, model processes, output comes out.

### Quiz 2
#### Scenario: Comparing to Real AI
Dan's sales predictor uses hardcoded rules. Real AI would work differently.

**Question 6:** What is the KEY difference between Tita Malou and real AI?
A. Real AI is always better than humans
B. Real AI processes more data and scales beyond one carinderia
C. Tita Malou is faster than AI
D. Real AI doesn't need data

**Answer:** B
**Explanation:** Tita Malou can predict for one carinderia from 15 years of experience. Real AI can process millions of data points and make predictions for thousands of locations simultaneously.

**Question 7:** In Dan's sales predictor, who wrote the scoring rules?
A. The computer learned them automatically
B. Dan hardcoded them based on Tita Malou's experience
C. The rules came from Kuya JM
D. There are no rules — it's random

**Answer:** B
**Explanation:** Dan's predictor is rule-based AI. He hardcoded the scoring weights. In real Machine Learning, the machine would discover these rules from historical sales data.

---

## Lesson 5 — Data in AI

### Quiz 1
#### Scenario: The Barangay Goldmine
Dan realized he's been working with data for months at the barangay office. Test your understanding.

**Question 1:** What does "GIGO" stand for in the context of AI?
A. Great In, Great Out
B. Garbage In, Garbage Out
C. Good Information, Good Output
D. General Input, General Output

**Answer:** B
**Explanation:** GIGO means bad data produces bad predictions, no matter how sophisticated the model.

**Question 2:** Data used to TEACH the model is called:
A. Test Data
B. Validation Data
C. Training Data
D. Production Data

**Answer:** C
**Explanation:** Training data is what the model learns from. Test data is held back to verify the model learned correctly.

**Question 3:** Why do we split data into training/test/validation sets?
A. To save disk space
B. To make sure the model truly learned patterns instead of memorizing answers
C. To make training faster
D. Because the CSV file is too big

**Answer:** B
**Explanation:** Testing on unseen data reveals whether the model can generalize. Testing on training data is like getting the exam questions in advance.

**Question 4:** Which is NOT a characteristic of good data?
A. Complete (no missing values)
B. Accurate (correct values)
C. Duplicated (the same row repeated many times)
D. Consistent (same format throughout)

**Answer:** C
**Explanation:** Duplicates inflate the importance of certain records and distort analysis. Good data should be deduplicated.

**Question 5:** What does `csv.DictReader` return for each row?
A. A list of values
B. A tuple of values
C. A dictionary where keys are column names
D. A single string

**Answer:** C
**Explanation:** `csv.DictReader` turns each row into a dict keyed by the header row, making it easy to access columns by name (e.g., `row["revenue"]`).

### Quiz 2
#### Scenario: Finding Data
Dan explores public data sources for his hackathon.

**Question 6:** Which of these is a Philippine-specific source for open government data?
A. Kaggle
B. data.gov.ph
C. UCI ML Repository
D. World Bank

**Answer:** B
**Explanation:** data.gov.ph is the Philippine Open Data portal. Kaggle, UCI, and World Bank are also great, but data.gov.ph is PH-specific.

**Question 7:** Dan's mom tracks sales in her handwritten notebook. What is the biggest problem with this approach?
A. It's too fast
B. The data can't be easily analyzed, shared, or fed into an AI model
C. Notebooks are expensive
D. There's nothing wrong with it

**Answer:** B
**Explanation:** Handwritten data can't be processed by computers without expensive OCR. To use data for AI, it needs to be in a structured digital format like CSV.

---

## Lesson 6 — Structured vs Unstructured Data

### Quiz 1
#### Scenario: The Great Data Audit
Dan looked at his mom's notebook, GCash records, and Facebook photos — all "data" but very different.

**Question 1:** Structured data is best described as:
A. Any data you can read
B. Data organized into fixed rows and columns (like a spreadsheet)
C. Only data stored in databases
D. Data written in English

**Answer:** B
**Explanation:** Structured data has a fixed schema — every row has the same columns. Think CSV, Excel, SQL tables.

**Question 2:** Which of these is UNSTRUCTURED data?
A. A GCash transaction CSV
B. A barangay resident database table
C. A customer review tweet
D. A spreadsheet of sales

**Answer:** C
**Explanation:** Tweets are free-form text with no fixed format — unstructured. They can be analyzed only with NLP techniques.

**Question 3:** JSON is an example of:
A. Structured data
B. Unstructured data
C. Semi-structured data
D. Not data at all

**Answer:** C
**Explanation:** JSON has structure (keys and values) but is flexible — fields can contain nested objects, arrays, or free text. That makes it semi-structured.

**Question 4:** Roughly what percentage of the world's data is unstructured?
A. 10%
B. 30%
C. 50%
D. 80%

**Answer:** D
**Explanation:** About 80% of all data is unstructured — images, video, audio, text. This is why deep learning (which handles unstructured data) became so important.

**Question 5:** Why is deep learning considered revolutionary?
A. It runs faster than other algorithms
B. It can process unstructured data (images, text, audio) that traditional algorithms struggle with
C. It requires less data than regular ML
D. It only works online

**Answer:** B
**Explanation:** Deep learning unlocked 80% of the world's data by enabling computers to process images, text, and audio — things traditional ML couldn't handle well.

### Quiz 2
#### Scenario: Building the Right AI
Different data types need different AI techniques.

**Question 6:** You want to build an AI that reads customer reviews of the carinderia. What technique do you need?
A. Linear regression
B. Natural Language Processing (NLP)
C. Computer Vision
D. Bubble sort

**Answer:** B
**Explanation:** Reviews are unstructured text, so you need NLP — the branch of AI that processes human language.

**Question 7:** Why do data scientists spend 80% of their time cleaning data?
A. Because raw data is almost always messy, incomplete, or inconsistent
B. Because cleaning is fun
C. Because there's no better use of their time
D. Because computers can't process data at all

**Answer:** A
**Explanation:** Real-world data is messy — typos, missing values, inconsistent formats. Before any ML model can use data, it must be cleaned and structured.

---

## Lesson 7 — Intro to Python for AI

### Quiz 1
#### Scenario: Why Python?
Dan spent the afternoon learning Python. Test his understanding.

**Question 1:** Why does Python dominate AI and data science?
A. It is the fastest programming language
B. Readability, powerful libraries, community, and being free
C. It's the only language that supports math
D. It was invented for AI

**Answer:** B
**Explanation:** Python isn't the fastest — but its readability, massive library ecosystem (numpy, pandas, tensorflow), community, and open-source nature make it perfect for AI.

**Question 2:** Which Python library is most commonly used for data analysis with DataFrames?
A. tensorflow
B. matplotlib
C. pandas
D. pytorch

**Answer:** C
**Explanation:** pandas is the go-to library for loading, cleaning, and analyzing structured data (CSV, Excel). tensorflow/pytorch are for deep learning.

**Question 3:** What does `type(60)` return?
A. `'number'`
B. `<class 'int'>`
C. `'integer'`
D. An error

**Answer:** B
**Explanation:** `type()` returns the class of the value. For 60, that's `<class 'int'>`. Use `.__name__` to get just `'int'`.

**Question 4:** What does the `%` operator do?
A. Calculates a percentage
B. Returns the remainder after division
C. Multiplies by 100
D. Divides by 100

**Answer:** B
**Explanation:** `%` is the modulo operator. `5 % 3 = 2` because 5 divided by 3 leaves a remainder of 2. Useful for checking even/odd, cycles, etc.

**Question 5:** What's the correct way to format a float with 2 decimal places in an f-string?
A. `f"P{price, 2}"`
B. `f"P{price:.2f}"`
C. `f"P{price%.2}"`
D. `f"P{round(price)}"`

**Answer:** B
**Explanation:** `:.2f` inside f-strings formats a float with exactly 2 decimal places. `.1f` for 1 decimal, etc.

### Quiz 2
#### Scenario: Python Syntax
Help Dan navigate Python basics.

**Question 6:** What does `int("60")` return?
A. "60" (still a string)
B. 60 (as an integer)
C. An error
D. 60.0 (as a float)

**Answer:** B
**Explanation:** `int()` converts a numeric string to an integer. `int("60")` → 60. Use `float()` for decimal conversion.

**Question 7:** What's the main advantage of f-strings over concatenation?
A. They run faster
B. They make code more readable by embedding variables directly in the string
C. They are required in Python 3
D. They are the only way to print

**Answer:** B
**Explanation:** `f"Price: {price}"` is much cleaner than `"Price: " + str(price)`. f-strings make code readable and concise — a core Python value.

---

## Lesson 8 — Python Basics — Lists, Loops, Decisions

### Quiz 1
#### Scenario: Building the Ordering System
Dan needed loops to handle 20+ menu items.

**Question 1:** What is the correct way to access the first item in a list `menu`?
A. `menu(0)`
B. `menu[0]`
C. `menu.first()`
D. `menu{0}`

**Answer:** B
**Explanation:** Python lists use square brackets and zero-based indexing. `menu[0]` is the first item.

**Question 2:** Which loop is best when you don't know in advance how many times to repeat?
A. for loop
B. while loop
C. range loop
D. enumerate loop

**Answer:** B
**Explanation:** `while True:` loops are perfect for "keep going until condition X." For loops are for iterating over a known collection.

**Question 3:** What does `break` do inside a loop?
A. Pauses the loop
B. Skips to the next iteration
C. Exits the loop immediately
D. Restarts the loop

**Answer:** C
**Explanation:** `break` exits the loop completely. `continue` skips to the next iteration.

**Question 4:** What is a dictionary in Python?
A. A book of word definitions
B. A collection of key-value pairs
C. A type of list
D. A spell checker

**Answer:** B
**Explanation:** A dict stores data as key-value pairs: `{"name": "Adobo", "price": 60}`. Access values by key: `dish["name"]`.

**Question 5:** Which operator means "AND" in Python?
A. `&`
B. `&&`
C. `and`
D. `+`

**Answer:** C
**Explanation:** Python uses keywords `and`, `or`, `not` for logical operations (not symbols like `&&` or `||` from other languages).

### Quiz 2
#### Scenario: Code Decisions
Dan added a senior discount.

**Question 6:** Which condition correctly checks if total is more than 500 AND it's payday?
A. `if total > 500 & is_payday:`
B. `if total > 500 and is_payday:`
C. `if total > 500, is_payday:`
D. `if total > 500 + is_payday:`

**Answer:** B
**Explanation:** Use `and` keyword to combine conditions. `&` is bitwise AND (different operation).

**Question 7:** What does `for i, item in enumerate(menu, 1):` do?
A. Loops through menu but only the first item
B. Loops through menu with a counter starting at 1
C. Loops 1 time through menu
D. Causes a syntax error

**Answer:** B
**Explanation:** `enumerate(menu, 1)` returns pairs of (index, item) starting from 1 — useful for numbered displays.

---

## Lesson 9 — Working with Libraries

### Quiz 1
#### Scenario: Standing on the Shoulders of Giants
Dan discovered that pandas can do in 3 lines what takes 50 in raw Python.

**Question 1:** What is the standard import convention for pandas?
A. `import pandas`
B. `import pandas as pd`
C. `from pandas import *`
D. `import pd from pandas`

**Answer:** B
**Explanation:** `import pandas as pd` is the near-universal convention. Using `pd` keeps code concise and matches what you see everywhere online.

**Question 2:** What does `df.head()` return?
A. Only the header/column names
B. The first 5 rows by default
C. A single row
D. Nothing — it just prints

**Answer:** B
**Explanation:** `df.head()` returns the first 5 rows. Pass a number to get more: `df.head(10)`.

**Question 3:** Which pandas method gives you summary statistics (count, mean, std, min, max)?
A. `df.summarize()`
B. `df.describe()`
C. `df.stats()`
D. `df.info()`

**Answer:** B
**Explanation:** `df.describe()` gives count, mean, std, min, quartiles, and max for numeric columns. `df.info()` shows types and null counts instead.

**Question 4:** How do you filter a DataFrame to rows where revenue > 500?
A. `df.filter(revenue > 500)`
B. `df[df["revenue"] > 500]`
C. `df.where(revenue, 500)`
D. `df.select(revenue > 500)`

**Answer:** B
**Explanation:** Boolean indexing: `df["revenue"] > 500` creates a mask of True/False, and `df[mask]` returns only the True rows.

**Question 5:** What does `df.groupby("item")["revenue"].sum()` compute?
A. The grand total revenue
B. Revenue for the first item only
C. Total revenue per item
D. An error

**Answer:** C
**Explanation:** Group by item, then sum revenue within each group. The result is one row per unique item with its total revenue.

### Quiz 2
#### Scenario: Why Libraries
Dan saw a 50-line task shrink to 3 lines.

**Question 6:** Why is numpy faster than a pure Python for loop for math operations?
A. Numpy is written in C and uses vectorized operations
B. Numpy uses magic
C. Numpy only works on small data
D. Numpy uses more memory

**Answer:** A
**Explanation:** Numpy's operations are implemented in C (and SIMD-optimized). Vectorized ops like `arr1 * arr2` are 10-100x faster than a Python for loop doing the same work.

**Question 7:** What's the difference between `pip install pandas` and `import pandas`?
A. They're the same
B. `pip install` downloads and installs the library once; `import` makes it available in your program
C. `pip install` is for Python 2, `import` is for Python 3
D. `pip install` is optional

**Answer:** B
**Explanation:** `pip install` is a one-time download. After that, every Python program can `import` pandas to use it.

---

## Lesson 10 — What is an Algorithm?

### Quiz 1
#### Scenario: Dan vs Jasper's Jargon
Dan learned that algorithms are just recipes.

**Question 1:** An algorithm is best described as:
A. A type of AI
B. A finite, well-defined sequence of instructions to solve a problem
C. A Python function
D. A sorting method

**Answer:** B
**Explanation:** Algorithms are step-by-step recipes. They have inputs, outputs, and a finite number of definite steps.

**Question 2:** Which of these is NOT a property of an algorithm?
A. Finite (must terminate)
B. Definite (each step unambiguous)
C. Infinite (runs forever)
D. Has input and produces output

**Answer:** C
**Explanation:** Algorithms MUST terminate in a finite number of steps. An infinite loop isn't an algorithm.

**Question 3:** Big O notation measures:
A. How much memory an algorithm uses
B. How the runtime grows as input size grows
C. How many bugs an algorithm has
D. The age of the algorithm

**Answer:** B
**Explanation:** Big O describes the algorithm's runtime complexity as n (input size) grows. O(n²) means quadratic growth — doubling n quadruples the time.

**Question 4:** Bubble sort has complexity:
A. O(1)
B. O(log n)
C. O(n)
D. O(n²)

**Answer:** D
**Explanation:** Bubble sort has nested loops — each item compared to every other. Quadratic. Slow on big data.

**Question 5:** Which Python function uses Timsort (O(n log n)) under the hood?
A. `sort(list)`
B. `sorted(list)`
C. `list.order()`
D. `organize(list)`

**Answer:** B
**Explanation:** Python's built-in `sorted()` and `.sort()` both use Timsort — a hybrid of merge sort and insertion sort — running in O(n log n).

### Quiz 2
#### Scenario: Searching and Combos
Dan built search and combo algorithms.

**Question 6:** Binary search requires that the data is:
A. Large
B. Sorted
C. Numeric
D. In a dictionary

**Answer:** B
**Explanation:** Binary search cuts the range in half each step by comparing to the middle. If data isn't sorted, "middle" is meaningless — you'd miss the target.

**Question 7:** On a list of 1,000,000 items, roughly how many comparisons does binary search need (worst case)?
A. 1,000,000
B. 500,000
C. About 20
D. 1

**Answer:** C
**Explanation:** log₂(1,000,000) ≈ 20. Binary search is dramatically faster than linear search on large sorted data.

---

## Lesson 11 — Heuristics vs Learning

### Quiz 1
#### Scenario: Jeepney vs Waze
Dan compared Mang Tonyo's experience-based shortcuts to Waze's data-driven rerouting.

**Question 1:** A heuristic is:
A. A machine learning algorithm
B. A rule of thumb written by humans from experience
C. A type of neural network
D. A sorting method

**Answer:** B
**Explanation:** Heuristics are hand-coded rules based on human expertise. Fast to deploy but don't improve without human intervention.

**Question 2:** A learning system differs from a heuristic because:
A. It runs faster
B. It discovers rules from data instead of humans writing them
C. It doesn't need a computer
D. It uses Python

**Answer:** B
**Explanation:** The key difference: who creates the rules. Heuristic = human. Learning = machine, from data.

**Question 3:** Which is TRUE about learning systems?
A. They work without any data
B. They improve as more data becomes available
C. They are always more accurate than heuristics
D. They never make mistakes

**Answer:** B
**Explanation:** Learning systems get better with more data. But they can be less accurate than good heuristics if data is scarce or noisy.

**Question 4:** Dan's ulam recommender from Lesson 1 is:
A. A learning system
B. A heuristic
C. A neural network
D. A random generator

**Answer:** B
**Explanation:** The ulam recommender uses hand-coded if-else rules — pure heuristic. No learning from data.

**Question 5:** When should you prefer a heuristic over a learning system?
A. When you have millions of data points
B. When you need maximum accuracy
C. When you have no data, need explainability, or are building an MVP
D. Never

**Answer:** C
**Explanation:** Heuristics shine when you're data-poor, need explainability, or need to deploy fast. Upgrade to learning when you have data and accuracy matters.

### Quiz 2
#### Scenario: The Showdown
Dan pitted heuristic vs learning on carinderia sales data.

**Question 6:** Why did the learning system outperform the heuristic?
A. It used more CPU power
B. It discovered subtle patterns from 200 days of data that Mama never noticed
C. It used random guessing
D. It cheated by looking at test data

**Answer:** B
**Explanation:** With enough data, learning systems find micro-patterns (like "rainy Fridays specifically" vs all rainy days) that humans miss.

**Question 7:** What's the practical workflow Kuya JM suggests?
A. Always use learning
B. Always use heuristics
C. Start with heuristics (no data needed), upgrade to learning when data arrives
D. Flip a coin

**Answer:** C
**Explanation:** Pragmatic engineering: heuristics get you live fast with zero data. Once you've collected data, retrain with a learning system for better accuracy.

---

## Lesson 12 — Intro to Neural Networks

### Quiz 1
#### Scenario: Dan's First Neuron
Dan drew a perceptron on a napkin.

**Question 1:** An artificial neuron (perceptron) performs:
A. Random number generation
B. Weighted sum of inputs + bias, then activation function
C. Database lookups
D. Image rendering

**Answer:** B
**Explanation:** Perceptron math: output = activation(x1*w1 + x2*w2 + ... + bias). That's it.

**Question 2:** What does a weight represent in a neuron?
A. The memory usage
B. The importance of that input to the decision
C. The number of layers
D. The random seed

**Answer:** B
**Explanation:** Weights encode importance. Higher weight = that input matters more. Negative weight = vote against firing.

**Question 3:** What does the bias do?
A. Adds randomness
B. Sets the default tendency (easier or harder to fire)
C. Changes the number of inputs
D. Nothing useful

**Answer:** B
**Explanation:** Bias shifts the threshold. Negative bias = neuron is hard to activate. Positive bias = easy to activate.

**Question 4:** What is the step activation function?
A. Output = input × 2
B. Output = 1 if weighted_sum > 0 else 0
C. Output = random
D. Output = sum of all inputs

**Answer:** B
**Explanation:** Step function produces a hard 0/1 decision. Sigmoid and ReLU are softer alternatives used in real networks.

**Question 5:** Training a neural network primarily means:
A. Installing Python
B. Finding the right weights (and biases) that produce good predictions
C. Writing rules by hand
D. Cleaning data

**Answer:** B
**Explanation:** Training = optimization. Algorithms like gradient descent adjust weights/biases to minimize prediction error.

### Quiz 2
#### Scenario: One Neuron vs a Network
Dan learned a single neuron has limits.

**Question 6:** What is the main limitation of a single neuron?
A. Uses too much memory
B. Can only draw a straight line (linear decision boundary)
C. Too expensive to run
D. Only works in English

**Answer:** B
**Explanation:** A single neuron is a linear classifier — it can only separate data that's linearly separable. Complex patterns need multiple neurons stacked in layers.

**Question 7:** How do you make a neural network more powerful?
A. Use only one neuron
B. Stack more neurons in layers (making it "deep")
C. Remove the bias
D. Use random weights forever

**Answer:** B
**Explanation:** Stacking neurons in layers lets the network learn hierarchical features. That's exactly what deep learning is.

---

## Lesson 13 — What is Deep Learning?

### Quiz 1
#### Scenario: TensorFlow Playground
Dan watched a neural network separate a spiral dataset only when stacked deep.

**Question 1:** What makes a neural network "deep"?
A. It uses lots of memory
B. It has 2+ hidden layers
C. It runs slowly
D. It uses Python

**Answer:** B
**Explanation:** "Deep" means multiple hidden layers. Each layer builds on the previous to learn increasingly abstract features.

**Question 2:** What does the sigmoid function do?
A. Outputs the input unchanged
B. Maps any input to a value in (0, 1)
C. Returns a random number
D. Multiplies by 2

**Answer:** B
**Explanation:** Sigmoid is smooth and saturates at 0 and 1 — perfect for interpreting outputs as probabilities and enabling gradient-based training.

**Question 3:** In a forward pass, what does `X @ W + b` compute (in Python 3.5+ syntax)?
A. The sum of X and W
B. Element-wise multiplication
C. Matrix multiplication X times W, plus bias
D. A random number

**Answer:** C
**Explanation:** `@` is the matrix multiplication operator in Python 3.5+. It's the core operation in every neural network layer.

**Question 4:** What does each hidden layer automatically learn?
A. Random noise
B. Increasingly abstract features from the input
C. The same features as the input
D. Nothing until trained

**Answer:** B
**Explanation:** Deep networks learn hierarchical representations. For images: edges → shapes → parts → objects. This happens automatically through training.

**Question 5:** With random weights, a neural network produces:
A. Random results (as expected)
B. Perfect predictions
C. A syntax error
D. The same answer every time

**Answer:** A
**Explanation:** Untrained networks are random. Training adjusts weights to produce useful predictions — that's what backpropagation does.

### Quiz 2
#### Scenario: Why Deep Learning
Dan learned when deep learning is the right tool.

**Question 6:** Deep learning works BEST when:
A. You have a tiny dataset (10 rows)
B. You have lots of data, a complex problem, and GPUs available
C. You want maximum explainability
D. You're on a slow laptop

**Answer:** B
**Explanation:** Deep learning shines with big data and complex patterns (images, text, audio). For small structured data, simpler ML often wins.

**Question 7:** What does training a neural network actually do?
A. Randomly changes weights
B. Iteratively adjusts weights to minimize prediction error
C. Installs the library
D. Turns the network deeper

**Answer:** B
**Explanation:** Training uses gradient descent + backpropagation to nudge weights in the direction that reduces error — over thousands of iterations.

---

## Lesson 14 — Natural Language Processing

### Quiz 1
#### Scenario: Autocorrect Fail
Dan's autocorrect mangled his message. He wondered how AI reads text.

**Question 1:** What is the core challenge of NLP?
A. Python is too slow
B. Computers only understand numbers; words are not numbers
C. Text is too short
D. Nothing — it's easy

**Answer:** B
**Explanation:** NLP's fundamental job is converting text into numeric representations so that math / ML / DL can operate on it.

**Question 2:** What does tokenization mean?
A. Converting images to text
B. Splitting text into individual words or tokens
C. Encrypting text
D. Translating to Tagalog

**Answer:** B
**Explanation:** "I love adobo" → ["I", "love", "adobo"]. Tokenization is the first step in most NLP pipelines.

**Question 3:** Why do we remove stop words?
A. They take up storage
B. Words like "the", "is", "and" add noise without useful information
C. To encrypt data
D. We don't — they're always useful

**Answer:** B
**Explanation:** Stop words are filler — removing them focuses on meaningful content words.

**Question 4:** What is the "Bag of Words" approach?
A. A physical bag of books
B. Ignore word order, count word frequencies
C. A type of neural network
D. An encryption scheme

**Answer:** B
**Explanation:** Bag of Words treats text as just a collection of word counts. Simple but effective for many classification tasks.

**Question 5:** Dan's sentiment classifier detects:
A. Whether text is in English
B. Positive vs negative tone based on keyword matches
C. The length of the review
D. The author's age

**Answer:** B
**Explanation:** Keyword-based sentiment: count positive words vs negative words, then classify.

### Quiz 2
#### Scenario: Why NLP Is Hard
Dan learned keyword matching has limits.

**Question 6:** Which is NOT a challenge for basic NLP?
A. Sarcasm ("Oh wow, super sarap" said bitterly)
B. Taglish / mixed languages
C. Counting the number of words
D. Context ambiguity (river bank vs money bank)

**Answer:** C
**Explanation:** Counting words is trivial. Sarcasm, slang, Taglish, and ambiguity are where basic NLP fails — modern LLMs handle these much better.

**Question 7:** Modern NLP breakthroughs (like ChatGPT) use:
A. Keyword matching
B. Transformers with hundreds of billions of parameters trained on massive text corpora
C. A dictionary lookup
D. Random guessing

**Answer:** B
**Explanation:** Modern LLMs are deep neural networks (transformers) with massive parameter counts, trained on internet-scale text data.

---

## Lesson 15 — Computer Vision

### Quiz 1
#### Scenario: Facebook Food Photos
Dan photographed dishes for his mom's page and wondered how AI could classify them.

**Question 1:** An image is stored as:
A. A single string
B. A 3D array of shape (height, width, 3) with RGB values
C. A list of pixels
D. A JSON object

**Answer:** B
**Explanation:** Images are 3D arrays — each pixel has 3 channel values (Red, Green, Blue) from 0 to 255.

**Question 2:** What does each RGB channel value represent?
A. Alpha transparency
B. A color intensity from 0 (none) to 255 (max)
C. Brightness in percent
D. A random pixel

**Answer:** B
**Explanation:** Each of R, G, B is an integer 0-255. `[255, 0, 0]` = pure red. `[255, 255, 255]` = white.

**Question 3:** How do you convert an RGB image to grayscale?
A. Delete one channel
B. Average the three channels to get a single brightness value per pixel
C. Multiply by 0
D. You can't

**Answer:** B
**Explanation:** `gray = image.mean(axis=2)` collapses the 3 RGB channels into 1 brightness channel.

**Question 4:** Approximately how many numbers are in a 1080x1920 RGB photo?
A. 100
B. 100,000
C. About 6 million
D. 1 billion

**Answer:** C
**Explanation:** 1080 × 1920 × 3 = 6,220,800 numbers. AI on images means processing massive arrays.

**Question 5:** What is the primary modern technique for computer vision?
A. Simple averaging
B. Convolutional Neural Networks (CNNs)
C. Binary search
D. Regex

**Answer:** B
**Explanation:** CNNs automatically learn features (edges → shapes → parts → objects) from pixels. They're the backbone of modern image classification, object detection, and face recognition.

### Quiz 2
#### Scenario: Classifier Limits
Dan's color classifier confused Adobo and Bistek (both brown).

**Question 6:** Why did Dan's color-based classifier confuse Adobo and Bistek?
A. The images were blurry
B. Both dishes have similar average brown color — color alone isn't enough
C. The computer was slow
D. His Python was outdated

**Answer:** B
**Explanation:** Color averaging loses texture and shape information. Real CNNs look at all three together — which is why they can distinguish visually similar dishes.

**Question 7:** Which is NOT a typical computer vision task?
A. Face recognition
B. OCR (reading text in images)
C. Image classification
D. Sorting a list of numbers

**Answer:** D
**Explanation:** Sorting numbers is a general algorithm, not a CV task. CV tasks deal with pixels: classification, detection, segmentation, OCR, face recognition, etc.

---

## Lesson 16 — Reinforcement Learning

### Quiz 1
#### Scenario: Training a Virtual Dog
Dan played PetPinas and realized it was teaching him RL.

**Question 1:** Reinforcement Learning is best described as:
A. Learning from labeled examples
B. Learning by trial and error through rewards and penalties
C. Memorizing every answer
D. Random guessing

**Answer:** B
**Explanation:** RL agents learn by acting in an environment, receiving rewards/penalties, and updating their strategy accordingly.

**Question 2:** In RL, what is a "policy"?
A. Insurance for the agent
B. A mapping from states to actions (what to do in each situation)
C. A law
D. A type of Python library

**Answer:** B
**Explanation:** The policy is the agent's strategy — "in state X, take action Y." Training = learning the optimal policy.

**Question 3:** Exploration vs exploitation means:
A. Explore the environment, never exploit it
B. Try new actions (explore) vs use proven strategies (exploit) — balance both
C. Only exploit, never explore
D. Neither matters

**Answer:** B
**Explanation:** Agents must balance trying new things (discovery) with using what works (reward). Epsilon-greedy is the standard technique.

**Question 4:** What does the Q-table store?
A. Final rewards
B. The expected future reward for taking an action in a given state
C. Random numbers
D. The environment's layout

**Answer:** B
**Explanation:** `Q[state][action]` ≈ "if I take this action now, how much total future reward do I expect?" The agent picks the action with the highest Q-value.

**Question 5:** In Q-learning, what does gamma (γ) control?
A. The learning rate
B. How much future rewards are valued vs immediate rewards
C. The temperature
D. Nothing

**Answer:** B
**Explanation:** γ is the discount factor. γ near 1 = care about long-term rewards. γ near 0 = only care about immediate rewards.

### Quiz 2
#### Scenario: Real-World RL
Dan learned where RL is used.

**Question 6:** Which is NOT a typical RL use case?
A. AlphaGo beating world champions at Go
B. Robot arms learning to grasp objects
C. Tesla Autopilot navigating highways
D. Reading a single PDF to summarize it

**Answer:** D
**Explanation:** PDF summarization is NLP, not RL. RL is for sequential decision-making with rewards — games, robotics, routing, recommendations.

**Question 7:** Dan's delivery agent learned to go from (0,0) to (4,4) without any labeled examples. How?
A. It was pre-programmed
B. It randomly explored, received rewards (+100 goal, -10 obstacles, -1 step), and updated its Q-table
C. It guessed
D. It memorized the grid

**Answer:** B
**Explanation:** Classic Q-learning: random exploration + reward feedback + Q-table updates. No labeled data needed — just a reward signal.

---

## Lesson 17 — Ethics in AI

### Quiz 1
#### Scenario: Dr. Reyes' Lecture
Dan learned that AI can scale unfairness fast.

**Question 1:** AI systems inherit bias from:
A. The programmer's mood
B. The training data
C. The computer brand
D. The weather

**Answer:** B
**Explanation:** Models learn patterns from data. If the data reflects historical discrimination, the model will reproduce it — often at scale.

**Question 2:** Which is an example of SAMPLING bias?
A. Training only on Metro Manila loan applicants, then deploying nationwide
B. A random number generator
C. Using Python instead of R
D. Overfitting

**Answer:** A
**Explanation:** When training data doesn't represent the whole population (e.g., only NCR), the model performs badly on unrepresented groups (like Mindanao).

**Question 3:** What is the key test for disparate impact?
A. Does the model use more memory for some groups?
B. Do groups with the SAME qualifications receive DIFFERENT outcomes?
C. How fast does the model run?
D. How many parameters does it have?

**Answer:** B
**Explanation:** Compare applicants with the same income (or same qualification). If outcomes differ by group, there's bias beyond qualifications.

**Question 4:** Which is NOT one of the 5 Pillars of Responsible AI?
A. Fairness
B. Transparency
C. Profitability
D. Accountability

**Answer:** C
**Explanation:** The 5 Pillars are Fairness, Transparency, Accountability, Privacy, and Safety. Profitability is a business goal, not an ethics principle.

**Question 5:** If a fair model has 4% lower accuracy than a biased model, you should:
A. Always use the biased one (accuracy rules)
B. Consider the tradeoff — fairness usually wins, especially for consequential decisions
C. Throw away both
D. Use whichever is shorter to code

**Answer:** B
**Explanation:** Accuracy on biased labels isn't a true quality measure. A slightly "less accurate" fair model is often actually better — it doesn't perpetuate historical harms.

### Quiz 2
#### Scenario: Real-World Harm
AI bias has hurt real people.

**Question 6:** Which is a real-world AI bias incident?
A. Amazon hiring AI penalizing resumes with "women's" in them
B. COMPAS criminal justice tool showing higher risk scores for Black defendants
C. Facial recognition with much higher error rates for dark-skinned women
D. All of the above

**Answer:** D
**Explanation:** All three are real, documented cases where biased training data led to discriminatory AI outcomes.

**Question 7:** The bias feedback loop says:
A. AI improves automatically
B. Biased data → biased model → unfair decisions → new biased data → repeat, amplifying bias
C. Bias disappears over time
D. Humans always fix bias before it spreads

**Answer:** B
**Explanation:** Unchecked, AI systems can amplify bias as their decisions feed back into future training data. Humans must actively break the cycle.

---

## Lesson 18 — AI Applications

### Quiz 1
#### Scenario: SM Mall AI Safari
Dan spotted AI everywhere and started brainstorming.

**Question 1:** Which is NOT a common AI application domain?
A. Fraud detection in fintech
B. Route optimization in ride-hailing
C. Content recommendations in streaming
D. Manually adding 2 + 2

**Answer:** D
**Explanation:** 2 + 2 is basic arithmetic, not AI. The other three are classic production AI use cases.

**Question 2:** A good hackathon AI project should:
A. Use the most complex model
B. Solve a real problem for a real user
C. Have the most data
D. Take months to build

**Answer:** B
**Explanation:** Hackathons reward REAL impact. A simple project solving a real user problem beats a fancy model demo.

**Question 3:** Which framework helps decide whether to build vs buy vs combine?
A. Who has the data, how unique is the problem, and how fast do you need it
B. How much money you have
C. How famous the library is
D. The weather

**Answer:** A
**Explanation:** Build = unique need + skills. Buy = common problem + off-the-shelf. Combine = pretrained + your customization. Hackathons usually favor combine.

**Question 4:** Dan chose Luto (inventory predictor) over a neural network because:
A. Neural networks are outdated
B. He hated neural networks
C. A simple model solves Mama's real pain — elegance over flash
D. Random choice

**Answer:** C
**Explanation:** Simple > complex when simple works. A weighted moving average handles carinderia demand well and is easy to explain. Save neural networks for when you need them.

**Question 5:** PH-specific AI opportunities include:
A. Filipino language NLP (underserved)
B. Typhoon damage assessment from satellite imagery
C. Sari-sari store inventory automation
D. All of the above

**Answer:** D
**Explanation:** The Philippines has tons of specific problems waiting for AI solutions — local language, disaster response, micro-retail.

### Quiz 2
#### Scenario: The Luto Decision
Dan committed to his hackathon idea.

**Question 6:** The four questions for any AI project are:
A. Language, location, library, latency
B. Problem, Data, Technique, Impact
C. CPU, GPU, RAM, disk
D. Model size, training time, accuracy, latency

**Answer:** B
**Explanation:** Problem (what pain?), Data (do you have it?), Technique (what AI fits?), Impact (who benefits, how much?).

**Question 7:** Which technique did Dan choose for Luto?
A. Deep neural network with 10 hidden layers
B. Weighted moving average with day-of-week patterns
C. Random guessing
D. A database query

**Answer:** B
**Explanation:** Simple time-series averaging is perfect for small-scale demand prediction. Interpretable, easy to ship, good enough accuracy.

---

## Lesson 19 — Prompt Engineering

### Quiz 1
#### Scenario: From Vague to Specific
Dan learned that vague prompts produce vague responses.

**Question 1:** What is prompt engineering?
A. Writing Python code
B. The skill of crafting effective instructions for LLMs
C. Installing AI software
D. Fixing bugs in ChatGPT

**Answer:** B
**Explanation:** Prompt engineering is about writing instructions that get LLMs to produce useful, structured, reliable output.

**Question 2:** What does RCTFC stand for?
A. Random, Chaotic, Technical, Frustrating, Complex
B. Role, Context, Task, Format, Constraints
C. Read, Count, Type, Format, Compute
D. Rapid, Clean, Terse, Free, Clear

**Answer:** B
**Explanation:** RCTFC = Role (who), Context (situation), Task (what), Format (how output looks), Constraints (rules/limits).

**Question 3:** Which prompt is stronger?
A. "help me"
B. "As a Python tutor, explain list comprehensions with 3 Filipino food examples in under 200 words"
C. "please write something about AI"
D. "do stuff"

**Answer:** B
**Explanation:** B specifies Role (tutor), Context (learning), Task (explain), Format (examples), and Constraint (length). A, C, D are all too vague.

**Question 4:** When should you use few-shot examples in a prompt?
A. Always, for every prompt
B. When the task is unusual or output format is complex
C. Never
D. Only for Python code

**Answer:** B
**Explanation:** Few-shot examples help LLMs match a specific style or structure. For simple/common tasks, RCTFC alone is usually enough.

**Question 5:** "Think step by step" is an example of:
A. A greeting
B. Chain-of-thought prompting — forces the model to reason explicitly
C. Noise
D. A formatting trick

**Answer:** B
**Explanation:** Chain-of-thought improves accuracy on complex reasoning tasks by having the model show its work.

### Quiz 2
#### Scenario: Reusable Templates
Dan built 4 templates for Luto.

**Question 6:** Why build prompt templates instead of writing fresh prompts each time?
A. Templates waste time
B. Templates ensure consistency, save time, and make prompts reusable
C. There's no reason
D. Templates always fail

**Answer:** B
**Explanation:** Templates codify the RCTFC pattern for a specific task. One well-crafted template becomes a reliable tool you can call repeatedly.

**Question 7:** What's a common mistake in prompts?
A. Forgetting to specify output format (getting prose when you wanted JSON)
B. Writing in English
C. Using punctuation
D. Using the letter E

**Answer:** A
**Explanation:** Missing format is one of the biggest mistakes. Always tell the LLM if you want a table, JSON, bullet list, or specific structure.

---

## Lesson 20 — APIs in AI

### Quiz 1
#### Scenario: The Restaurant Analogy
Dan learned APIs from Kuya JM over coffee.

**Question 1:** An API is best understood as:
A. A type of AI
B. The "waiter" between your code and a remote service
C. A Python library
D. A database

**Answer:** B
**Explanation:** API = Application Programming Interface — a defined way for programs to talk to each other. The restaurant analogy: customer (your code) → waiter (API) → kitchen (server).

**Question 2:** Which HTTP method creates new data?
A. GET
B. POST
C. DELETE
D. HEAD

**Answer:** B
**Explanation:** POST sends data to create new resources. GET fetches, PUT updates, DELETE removes.

**Question 3:** Status code 200 means:
A. The server exploded
B. Success — OK
C. Unauthorized
D. Rate limited

**Answer:** B
**Explanation:** 2xx = success, 3xx = redirect, 4xx = your mistake, 5xx = server's mistake. 200 is the classic "OK".

**Question 4:** What should you NEVER do with an API key?
A. Store it in an environment variable
B. Commit it to a git repository
C. Load it from a `.env` file
D. Rotate it when exposed

**Answer:** B
**Explanation:** Committing keys to git is the #1 way to leak them. Use env vars and `.env` (gitignored) instead.

**Question 5:** JSON is:
A. A type of Python code
B. A text-based data format that APIs commonly use
C. A Python library
D. A new AI model

**Answer:** B
**Explanation:** JSON (JavaScript Object Notation) is the de facto standard for API data exchange. `json.dumps()` and `json.loads()` convert between Python dicts and JSON strings.

### Quiz 2
#### Scenario: Status Codes
Dan got a 429 response and needed to understand why.

**Question 6:** Status code 429 means:
A. Success
B. Server down
C. Too many requests — you're being rate limited
D. Not found

**Answer:** C
**Explanation:** 429 = Too Many Requests. The API is throttling you. Wait, then retry with exponential backoff.

**Question 7:** What's the best Python library for API calls?
A. pandas
B. requests
C. matplotlib
D. random

**Answer:** B
**Explanation:** `requests` is the standard for HTTP in Python. Clean API: `requests.get(url)`, `requests.post(url, json=...)`.

---

## Lesson 21 — OpenAI API Basics

### Quiz 1
#### Scenario: First Real Call
Dan made his first OpenAI API call and watched AI respond to HIS code.

**Question 1:** In an OpenAI chat request, what is the "system" message for?
A. System logs
B. Defining the AI's personality, rules, and style
C. Error reporting
D. Network settings

**Answer:** B
**Explanation:** The system message sets the tone and behavior — e.g., "You are Luto, a friendly Filipino carinderia assistant." It's typically sent once at the beginning.

**Question 2:** What does `temperature=0.0` produce?
A. Random creative responses
B. Deterministic, focused responses
C. Broken responses
D. Nothing

**Answer:** B
**Explanation:** Temperature 0 = no randomness. The model picks the most likely next token every time. High temperature (1.5) = more creative/random.

**Question 3:** LLMs are "stateless." What does that mean?
A. They don't work
B. They don't remember previous messages — you must send the full history each time
C. They only use memory
D. They delete themselves

**Answer:** B
**Explanation:** Each API call is independent. For multi-turn context, you re-send all prior messages in the `messages` list.

**Question 4:** What's the "assistant" role in a conversation history?
A. The human's message
B. The AI's previous reply (included so future calls have context)
C. A system admin
D. Nothing

**Answer:** B
**Explanation:** When building a history, include past AI replies as `{"role": "assistant", "content": "..."}` so the model knows what it said before.

**Question 5:** Roughly how many words is 1 token?
A. 0.1
B. About 0.75 words (for English)
C. 10
D. 100

**Answer:** B
**Explanation:** 1 token ≈ 0.75 English words ≈ 4 characters. Non-English languages use more tokens per word.

### Quiz 2
#### Scenario: Cost and Safety
Dan tracked his P500 budget.

**Question 6:** Why use a mock OpenAI client during development?
A. It's funnier
B. Saves API credits and runs offline/deterministically
C. It's required
D. It's faster for the user

**Answer:** B
**Explanation:** Mock clients let you code and test without burning tokens. Switch to the real client once everything works.

**Question 7:** Where should your OpenAI API key live?
A. Hardcoded in your Python file
B. Committed to your git repo
C. In an environment variable / `.env` file that's gitignored
D. In the README

**Answer:** C
**Explanation:** Never commit keys. Use `os.environ.get("OPENAI_API_KEY")` and `.env` files that git ignores.

---

## Lesson 22 — Build an LLM Chatbot (Part 1)

### Quiz 1
#### Scenario: The Foundation
Dan wrote his first chat() function.

**Question 1:** What is the role of LUTO_SYSTEM_PROMPT?
A. Python code
B. Defines who the AI is, how it talks, and its rules
C. The user's first question
D. An API endpoint

**Answer:** B
**Explanation:** The system prompt sets identity, personality, capabilities, and constraints. It's the foundation of the chatbot's behavior.

**Question 2:** Why does chat() need a history list?
A. For logging
B. Because LLMs are stateless — you must send the full conversation each time for context
C. To save disk space
D. Not needed at all

**Answer:** B
**Explanation:** LLMs don't remember prior messages. To maintain context, every call sends the full history: system + all user/assistant exchanges.

**Question 3:** What should chat() do when the API fails?
A. Crash the program
B. Catch the error, return a helpful message, and log what went wrong
C. Silently ignore the error
D. Retry infinitely

**Answer:** B
**Explanation:** Chatbots must be resilient. Catch specific errors (Auth, RateLimit, Connection) and return useful feedback — never crash.

**Question 4:** What's a good first test for a chatbot?
A. Deploy to production
B. Send a scripted 5-message conversation to verify context and error handling
C. Skip testing
D. Ask 1 question and call it done

**Answer:** B
**Explanation:** Scripted multi-turn tests verify context preservation + error handling before adding UI complexity.

**Question 5:** Which is a good Luto system prompt element?
A. "You are Luto. Answer in Klingon."
B. "You are Luto, a warm Filipino carinderia assistant. Use PHP for prices, keep answers concise."
C. "You are ChatGPT."
D. "Don't talk at all."

**Answer:** B
**Explanation:** Good system prompts define identity, personality, and practical constraints (language, currency, length).

### Quiz 2
#### Scenario: Design Decisions
Dan built the chatbot in layers.

**Question 6:** Why use a MockOpenAI class during development?
A. It's required
B. It lets you test the chatbot logic without spending API tokens or needing internet
C. It's faster than real AI
D. For humor

**Answer:** B
**Explanation:** Mock clients enable offline development and tests. Ship-ready code should always work in both mock and real modes.

**Question 7:** Separation of concerns in Dan's chatbot means:
A. Mixing everything into one big function
B. Splitting into layers: setup, personality, logic, testing — each with a clear purpose
C. Having no functions
D. Random organization

**Answer:** B
**Explanation:** Clean code organizes by concern — setup vs personality vs logic vs testing. Easier to read, debug, and extend.

---

## Lesson 23 — Build an LLM Chatbot (Part 2)

### Quiz 1
#### Scenario: The Interactive Luto
Dan added a loop and slash commands.

**Question 1:** What bug did Dan almost miss with his chat loop?
A. Using print() instead of input()
B. Putting `history = [...]` INSIDE the loop, resetting conversation context every turn
C. Not installing the openai library
D. Nothing

**Answer:** B
**Explanation:** Classic scope bug. If history is re-initialized inside the loop, LLM context is lost every turn. History must live OUTSIDE the loop.

**Question 2:** Why do slash commands start with `/`?
A. Tradition
B. To distinguish them from regular chat messages so the program can route them differently
C. It's required by Python
D. Random choice

**Answer:** B
**Explanation:** The `/` prefix is a convention that makes commands easy to parse and distinguish from normal user input.

**Question 3:** What should `/clear` do?
A. Delete all files
B. Reset conversation history but keep the system prompt
C. Close the program
D. Nothing

**Answer:** B
**Explanation:** `/clear` resets the conversation so the user can start fresh without losing Luto's personality (which lives in the system prompt).

**Question 4:** Why track total tokens during a session?
A. It's required by Python
B. To monitor API cost and warn the user if usage is high
C. For fun
D. No reason

**Answer:** B
**Explanation:** Tokens cost money. Tracking usage helps you stay within budget and warn users before they hit limits.

**Question 5:** Why does token usage grow each turn?
A. Bug in Python
B. Because LLMs are stateless — you send the full history with every request, so older messages count every time
C. Random
D. The API charges more for later turns

**Answer:** B
**Explanation:** Every call sends the full history. A 10-turn conversation has ~10x the tokens of the first turn. This is why memory management matters (next lesson).

### Quiz 2
#### Scenario: Patterns That Matter
Dan made interactive decisions.

**Question 6:** Why does `history` need to live OUTSIDE the loop?
A. Because it's faster
B. So conversation context persists across turns
C. Random
D. Because Python requires it

**Answer:** B
**Explanation:** If you re-create history each turn, every message is a fresh conversation. Putting it outside the loop lets it accumulate context.

**Question 7:** What does the `/quit` command typically show?
A. Nothing
B. A session summary with message count, tokens used, duration
C. The error log
D. The source code

**Answer:** B
**Explanation:** Good chatbots give feedback on exit — so the user understands what happened and how much they used.

---

## Lesson 24 — Improve Chatbot

### Quiz 1
#### Scenario: Testing with Tita Malou
Dan brought Luto to the carinderia for real user testing.

**Question 1:** What's the improvement cycle?
A. Build → Ship → Forget
B. Build → Test with users → Collect feedback → Improve → Repeat
C. Plan → Plan → Plan
D. Code → Debug

**Answer:** B
**Explanation:** Real software improves through iteration based on real user feedback — not one-and-done.

**Question 2:** Why trim old messages from the conversation history?
A. Looks prettier
B. Long histories blow up token costs since every call sends the full conversation
C. Required by Python
D. No reason

**Answer:** B
**Explanation:** Tokens scale with conversation length. A 50-message convo can cost 10x a 5-message one. Trimming keeps costs manageable.

**Question 3:** How do you make Luto's answers more grounded and less generic?
A. Use more Python
B. Inject real data (menu, prices, constraints) into the system prompt
C. Use a bigger model
D. Random words

**Answer:** B
**Explanation:** LLMs can't invent your specific business data. Put it in the system prompt so the model has something to work with.

**Question 4:** Why add `/suggest` and `/cost` commands to Luto?
A. To confuse users
B. Specialized commands often provide better UX than free-form chat for routine tasks
C. Required by OpenAI
D. Looks cool

**Answer:** B
**Explanation:** For predictable tasks (pricing, suggestions), commands with dedicated logic are faster, more reliable, and cheaper than chat.

**Question 5:** What makes an error message "helpful"?
A. Generic "Error occurred"
B. Tells the user WHAT happened AND HOW to fix it
C. Just the error type
D. No message

**Answer:** B
**Explanation:** "Authentication failed. Check .env for OPENAI_API_KEY" is way more helpful than "AuthError".

### Quiz 2
#### Scenario: The Real Win
Tita Malou actually used the chatbot.

**Question 6:** What was the key success metric for Luto?
A. Number of lines of code
B. Whether Tita Malou (a non-tech user) could actually use it to do something useful
C. Model size
D. GitHub stars

**Answer:** B
**Explanation:** The real measure of any product: real users succeed with it. Code complexity doesn't matter if the user can't use it.

**Question 7:** What's a sign your system prompt needs updating?
A. Replies are too generic or use wrong pricing
B. The API is fast
C. Tokens are tracked
D. Nothing to update

**Answer:** A
**Explanation:** Generic replies = no grounding. Wrong pricing = missing/stale data. The fix is in the system prompt, not the code.

---

## Lesson 25 — Deploy AI App

### Quiz 1
#### Scenario: Demo Day
Dan deployed Luto for the hackathon.

**Question 1:** What's the difference between development and deployment?
A. Deployment is faster
B. Development runs on localhost for you; deployment runs on a public server for anyone with the URL
C. They're the same thing
D. Deployment is only for Python

**Answer:** B
**Explanation:** Dev = your local machine, your eyes only. Deploy = public URL, anyone's browser.

**Question 2:** What does Streamlit do?
A. Replaces Python
B. Turns Python scripts into web apps without HTML/CSS/JavaScript
C. Provides AI models
D. Manages git

**Answer:** B
**Explanation:** Streamlit is a Python framework for building web apps quickly. `st.chat_input()`, `st.chat_message()`, etc. give you a UI with almost no frontend code.

**Question 3:** Why use `st.session_state`?
A. Decoration
B. Streamlit reruns the whole script on every interaction — session_state persists data across those reruns
C. Not needed
D. For logging

**Answer:** B
**Explanation:** Without session_state, your conversation history gets reset every time the user types. Session state makes data survive reruns.

**Question 4:** Where should your OPENAI_API_KEY live when deployed to Streamlit Cloud?
A. In your code
B. In git
C. In the Streamlit Cloud Secrets dashboard (gets injected as env var)
D. In README.md

**Answer:** C
**Explanation:** Streamlit Cloud has a Secrets section specifically for sensitive values. NEVER put keys in code or git.

**Question 5:** Which is NOT a free Streamlit deployment option?
A. Streamlit Community Cloud
B. Hugging Face Spaces
C. GitHub Pages (for Streamlit apps specifically)
D. Vercel (doesn't host Streamlit)

**Answer:** C
**Explanation:** GitHub Pages is for static HTML only — it doesn't run Python. Streamlit Cloud and Hugging Face Spaces both support Streamlit for free.

### Quiz 2
#### Scenario: The Real Prize
Dan finished his 25-lesson journey.

**Question 6:** Dan's "real prize" wasn't winning the hackathon. What was it?
A. Money
B. His mom actually uses Luto every day
C. A trophy
D. Internet fame

**Answer:** B
**Explanation:** A real user you care about using your work is the ultimate validation. Not awards. Not fame. Actual usefulness.

**Question 7:** What's the final takeaway of Intro to AI?
A. AI is magic
B. AI requires a PhD
C. Anyone can build useful AI if they understand how to talk to the machine
D. AI will take over the world

**Answer:** C
**Explanation:** Dan started at zero 25 days ago. Finished with a deployed AI app. The skills are learnable. The machines are just tools. You can build too.

**Salamat!** You've completed the Intro to AI journey.

**Next:** Build your own project. Carinderia, jeepney, barangay, anything. The skills are yours now.
