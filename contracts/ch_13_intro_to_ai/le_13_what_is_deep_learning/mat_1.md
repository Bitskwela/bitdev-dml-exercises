## Previously on Dan's AI Journey...

Dan built his first perceptron — inputs, weights, bias, step function. He understands how weights encode importance.

---

## Background Story

11:47 PM. Dan was supposed to be sleeping. Instead, he'd stumbled onto TensorFlow Playground — a browser-based neural network visualizer — and couldn't stop clicking.

He loaded the spiral dataset. Two classes, twisted in a spiral pattern. No straight line could ever separate them.

**1 neuron (no hidden layer)**: useless — a diagonal line that misclassified half the points.

**1 hidden layer (4 neurons)**: a gentle curve. 75% accuracy. Better.

**3 hidden layers (8 neurons each)**: the decision boundary snaked through the spiral like liquid mercury. 98% accuracy. Perfect.

Dan's jaw dropped. Same dataset. Same inputs. The only thing that changed was stacking more neurons in more layers. That's it. That's what "deep" means.

He texted Jasper at 12:30 AM:

> **Dan:** *"Bro. TensorFlow Playground. Spiral dataset. Three hidden layers. I get it now."*
>
> **Jasper:** *"Finally! Welcome to the club. Try adding regularization next."*

Then he messaged Kuya JM.

> **Dan:** *"Layers build on each other. First layer sees raw pixels or features. Second layer combines them into simple patterns. Third layer combines THOSE into complex patterns. Deep enough, and you can approximate any function."*
>
> **Kuya JM:** *"Yes — like when Mama smells sinigang cooking. Layer 1 of her brain: detect tamarind. Layer 2: recognize 'sour soup.' Layer 3: memory connection to rainy days. Layer 4: emotion + craving. Each layer abstracts what the previous one found. That's deep learning."*

---

## Theory & Lecture Content

### What Makes a Network "Deep"?

- **Shallow network**: 1 hidden layer (or none)
- **Deep network**: 2+ hidden layers

The more layers, the more abstract features the network can learn.

### Forward Pass

Data flows left to right through layers. Each layer computes:

```
hidden = activation(input @ W1 + b1)   # @ is matrix multiplication
output = activation(hidden @ W2 + b2)
```

### What Each Layer Learns

For face recognition:
- **Layer 1**: edges (vertical, horizontal, diagonal)
- **Layer 2**: simple shapes (eyes, noses, mouths)
- **Layer 3**: face parts
- **Layer 4**: whole faces

Each layer builds on the previous. You don't tell it what to learn — it discovers these features automatically.

### Sigmoid Activation

Step function outputs only 0 or 1 (hard). **Sigmoid** outputs smooth values in (0, 1):

```python
def sigmoid(x):
    return 1 / (1 + np.exp(-x))
```

- sigmoid(-5) ≈ 0.007
- sigmoid(0) = 0.5
- sigmoid(5) ≈ 0.993

Smooth outputs let us interpret results as probabilities and make training possible (gradient descent needs smooth functions).

### A 2-Layer Network in Pure numpy

```python
import numpy as np

np.random.seed(42)
X = np.array([...])  # inputs, shape (n_samples, 3)
w1 = np.random.randn(3, 4)    # layer 1 weights: 3 inputs -> 4 hidden
b1 = np.random.randn(4)
w2 = np.random.randn(4, 1)    # layer 2 weights: 4 hidden -> 1 output
b2 = np.random.randn(1)

def sigmoid(x): return 1 / (1 + np.exp(-x))

# Forward pass
hidden = sigmoid(X @ w1 + b1)
output = sigmoid(hidden @ w2 + b2)
```

That's a 2-layer neural network. ~21 learnable parameters. Real models have billions.

### Why Deep Learning Is Powerful

- **Automatic feature discovery** — the model finds useful patterns without human labeling them
- **Scales with data** — more data → better performance (unlike heuristics)
- **Universal approximator** — with enough neurons/layers, can represent any function
- **Excels at unstructured data** — images, speech, text

### When Deep Learning Works Best

- You have LOTS of data (thousands to billions of examples)
- The problem is complex (images, text, audio)
- Patterns are subtle / non-linear
- You have GPUs for training

For small structured data, often simpler ML models (random forests, gradient boosting) win.

---

## Key Takeaways

1. **Deep = 2+ hidden layers.** Each layer learns increasingly abstract features.
2. **Forward pass**: `output = activation(X @ W + b)` chained across layers.
3. **Sigmoid** activation produces smooth outputs in (0, 1), usable as probabilities.
4. **Layers automatically discover features** — no human tells the model what to look for.
5. **Deep learning excels at unstructured data** (images, speech, text) with lots of training data.
6. **Even 21 parameters** (our tiny network) is a neural network — real ones just have billions more.

---

## What's Next?

Dan built forward passes. But networks need to TRAIN — adjust millions of weights automatically. Meanwhile, different types of data (images, text, audio) need specialized architectures.

**Next Lesson: Natural Language Processing** — Dan discovers how AI reads and understands text.

**Next:** Quiz then exercises.
