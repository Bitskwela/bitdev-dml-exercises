# Lesson 13 Quiz: What is Deep Learning?

---
# Quiz 1
## Scenario: TensorFlow Playground
Dan watched a neural network separate a spiral dataset only when stacked deep.

**Question 1:** What makes a neural network "deep"?
A. It uses lots of memory
B. It has 2+ hidden layers
C. It runs slowly
D. It uses Python

**Answer:** B
**Explanation:** "Deep" means multiple hidden layers. Each layer builds on the previous to learn increasingly abstract features.

---

**Question 2:** What does the sigmoid function do?
A. Outputs the input unchanged
B. Maps any input to a value in (0, 1)
C. Returns a random number
D. Multiplies by 2

**Answer:** B
**Explanation:** Sigmoid is smooth and saturates at 0 and 1 — perfect for interpreting outputs as probabilities and enabling gradient-based training.

---

**Question 3:** In a forward pass, what does `X @ W + b` compute (in Python 3.5+ syntax)?
A. The sum of X and W
B. Element-wise multiplication
C. Matrix multiplication X times W, plus bias
D. A random number

**Answer:** C
**Explanation:** `@` is the matrix multiplication operator in Python 3.5+. It's the core operation in every neural network layer.

---

**Question 4:** What does each hidden layer automatically learn?
A. Random noise
B. Increasingly abstract features from the input
C. The same features as the input
D. Nothing until trained

**Answer:** B
**Explanation:** Deep networks learn hierarchical representations. For images: edges → shapes → parts → objects. This happens automatically through training.

---

**Question 5:** With random weights, a neural network produces:
A. Random results (as expected)
B. Perfect predictions
C. A syntax error
D. The same answer every time

**Answer:** A
**Explanation:** Untrained networks are random. Training adjusts weights to produce useful predictions — that's what backpropagation does.

---
# Quiz 2
## Scenario: Why Deep Learning
Dan learned when deep learning is the right tool.

**Question 6:** Deep learning works BEST when:
A. You have a tiny dataset (10 rows)
B. You have lots of data, a complex problem, and GPUs available
C. You want maximum explainability
D. You're on a slow laptop

**Answer:** B
**Explanation:** Deep learning shines with big data and complex patterns (images, text, audio). For small structured data, simpler ML often wins.

---

**Question 7:** What does training a neural network actually do?
A. Randomly changes weights
B. Iteratively adjusts weights to minimize prediction error
C. Installs the library
D. Turns the network deeper

**Answer:** B
**Explanation:** Training uses gradient descent + backpropagation to nudge weights in the direction that reduces error — over thousands of iterations.

---
**Next:** Proceed to Lesson 13 exercises.
