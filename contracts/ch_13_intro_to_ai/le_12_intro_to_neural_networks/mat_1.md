## Previously on Dan's AI Journey...

Dan raced a heuristic recommender against a data-driven one — and watched the learning system discover patterns nobody hard-coded.

---

## Background Story

It was a slow afternoon at Tita Malou's carinderia. Rainy. Few customers. Dan sat at a corner table with a napkin and a pen. He was trying to draw "what happens inside a neural network."

He drew a circle. Three arrows going in. One arrow going out.

That's it. That's a neuron.

He called Kuya JM.

> **Dan:** *"Kuya, I drew a circle and some arrows. Is that really how neural networks work?"*
>
> **Kuya JM:** *"Yep. A neuron is just a function that takes inputs, multiplies each by a weight, adds them up, adds a bias, and decides: fire or don't fire. That's literally it. The brain has 86 billion of them connected together. Artificial neural networks just stack these neurons in layers."*
>
> **Dan:** *"So weights are... importance?"*
>
> **Kuya JM:** *"Exactly. High weight = 'this input really matters.' Low weight = 'this input barely matters.' Negative weight = 'this input votes AGAINST firing.' The bias is the default tendency — like a lenient vs strict neuron. And the activation function (step, sigmoid, relu) decides how the output behaves."*

Dan looked at his napkin. Three inputs: hunger, budget, proximity. Three weights he'd have to pick. One bias. One step function (fire if sum > 0). This was a customer decision predictor: "Will this person order?"

By dinner he'd built his first perceptron. He tested 8 customers, tweaked weights, watched predictions flip. He was starting to feel this.

---

## Theory & Lecture Content

### The Biological Inspiration

A biological neuron receives signals through dendrites, decides whether to fire, and sends a signal through its axon. An artificial neuron (perceptron) is a mathematical simplification of this.

### The Perceptron

```
  inputs     weights
  x1 --w1-->  \
  x2 --w2-->   Σ + bias  -->  activation  -->  output
  x3 --w3-->  /
```

Math:
```
weighted_sum = x1*w1 + x2*w2 + x3*w3 + bias
output = 1 if weighted_sum > 0 else 0     (step function)
```

### The Pieces

- **Inputs** (x1, x2, x3...): the features. For a customer: hunger, budget, proximity.
- **Weights** (w1, w2, w3...): the importance of each input. Higher = more influential.
- **Bias** (b): default tendency. Negative bias = neuron is "hard to activate."
- **Activation function**: turns the weighted sum into the output.
  - Step function: output 0 or 1 (hard threshold)
  - Sigmoid: outputs 0.0–1.0 (soft, for probabilities)
  - ReLU: output max(0, x) (modern default)

### The Python Version

```python
def neuron(inputs, weights, bias):
    s = sum(x * w for x, w in zip(inputs, weights)) + bias
    return 1 if s > 0 else 0
```

Four lines. That's a perceptron.

### Changing Weights Changes Behavior

Same inputs, different weights → different predictions. This is why training a neural network = finding the right weights.

| Scenario | Weights | Bias | Result |
|----------|---------|------|--------|
| Hunger-focused | [0.6, 0.3, 0.1] | -0.5 | Orders if hungry enough |
| Budget-focused | [0.2, 0.7, 0.1] | -0.5 | Orders if wealthy enough |
| Strict | [0.6, 0.3, 0.1] | -0.8 | Hard to convince |
| Lenient | [0.6, 0.3, 0.1] | -0.2 | Easy to convince |

### From One Neuron to a Network

One neuron can only draw a straight line (a linear decision boundary). Stack multiple neurons in layers → can approximate any function. That's the power of deep networks.

---

## Key Takeaways

1. **A perceptron is a function**: inputs × weights + bias → activation → output.
2. **Weights = importance**. Positive means "votes yes," negative means "votes no."
3. **Bias = default tendency**. Negative bias = harder to fire; positive = easier.
4. **Activation function** turns the weighted sum into output (step, sigmoid, ReLU).
5. **Same inputs + different weights = different predictions.** Training = finding the right weights.
6. **One neuron draws straight lines**; stacked neurons (layers) can draw any shape — that's deep learning.

---

## What's Next?

One neuron draws lines. Stack them in layers and you can solve complex problems. That's deep learning.

**Next Lesson: What is Deep Learning?** — Dan builds a 2-layer network from scratch.

**Next:** Quiz then exercises.
