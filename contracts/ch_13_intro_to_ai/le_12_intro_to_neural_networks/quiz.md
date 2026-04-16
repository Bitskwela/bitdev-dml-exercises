# Lesson 12 Quiz: Intro to Neural Networks

---
# Quiz 1
## Scenario: Dan's First Neuron
Dan drew a perceptron on a napkin.

**Question 1:** An artificial neuron (perceptron) performs:
A. Random number generation
B. Weighted sum of inputs + bias, then activation function
C. Database lookups
D. Image rendering

**Answer:** B
**Explanation:** Perceptron math: output = activation(x1*w1 + x2*w2 + ... + bias). That's it.

---

**Question 2:** What does a weight represent in a neuron?
A. The memory usage
B. The importance of that input to the decision
C. The number of layers
D. The random seed

**Answer:** B
**Explanation:** Weights encode importance. Higher weight = that input matters more. Negative weight = vote against firing.

---

**Question 3:** What does the bias do?
A. Adds randomness
B. Sets the default tendency (easier or harder to fire)
C. Changes the number of inputs
D. Nothing useful

**Answer:** B
**Explanation:** Bias shifts the threshold. Negative bias = neuron is hard to activate. Positive bias = easy to activate.

---

**Question 4:** What is the step activation function?
A. Output = input × 2
B. Output = 1 if weighted_sum > 0 else 0
C. Output = random
D. Output = sum of all inputs

**Answer:** B
**Explanation:** Step function produces a hard 0/1 decision. Sigmoid and ReLU are softer alternatives used in real networks.

---

**Question 5:** Training a neural network primarily means:
A. Installing Python
B. Finding the right weights (and biases) that produce good predictions
C. Writing rules by hand
D. Cleaning data

**Answer:** B
**Explanation:** Training = optimization. Algorithms like gradient descent adjust weights/biases to minimize prediction error.

---
# Quiz 2
## Scenario: One Neuron vs a Network
Dan learned a single neuron has limits.

**Question 6:** What is the main limitation of a single neuron?
A. Uses too much memory
B. Can only draw a straight line (linear decision boundary)
C. Too expensive to run
D. Only works in English

**Answer:** B
**Explanation:** A single neuron is a linear classifier — it can only separate data that's linearly separable. Complex patterns need multiple neurons stacked in layers.

---

**Question 7:** How do you make a neural network more powerful?
A. Use only one neuron
B. Stack more neurons in layers (making it "deep")
C. Remove the bias
D. Use random weights forever

**Answer:** B
**Explanation:** Stacking neurons in layers lets the network learn hierarchical features. That's exactly what deep learning is.

---
**Next:** Proceed to Lesson 12 exercises.
