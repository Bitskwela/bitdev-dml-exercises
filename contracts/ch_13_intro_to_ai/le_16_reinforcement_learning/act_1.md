# Delivery Agent (Q-Learning)

Train an AI agent to navigate a 5×5 Marikina grid from (0,0) to (4,4), avoiding obstacles, using Q-Learning.

---

## Prerequisites

```
pip install numpy
```

---

## Task 1: Define the Environment

```python
GRID_SIZE = 5
START = (0, 0)
GOAL = (4, 4)
OBSTACLES = [(1, 2), (2, 2), (3, 0)]
```

Rewards:
- Reaching goal: +100
- Hitting obstacle: -10
- Each step: -1 (encourage shortest path)

---

## Task 2: Initialize Q-Table

```python
# Q[row][col][action] — action: 0=up, 1=down, 2=left, 3=right
Q = np.zeros((GRID_SIZE, GRID_SIZE, 4))
```

---

## Task 3: Epsilon-Greedy Action Selection

```python
def choose_action(state, epsilon):
    if random.random() < epsilon:
        return random.randint(0, 3)      # explore
    r, c = state
    return int(np.argmax(Q[r, c]))       # exploit
```

---

## Task 4: Q-Update Rule

```python
Q[r][c][a] = Q[r][c][a] + alpha * (reward + gamma * max(Q[r'][c']) - Q[r][c][a])
```

Where:
- `alpha` = 0.1 (learning rate)
- `gamma` = 0.9 (discount factor)

---

## Task 5: Training Loop

Run 200 episodes. In each episode:
- Start at (0,0), reset
- Until done (reach goal or 100 steps):
  - Choose action (epsilon-greedy)
  - Step the environment
  - Update Q-table
- Decay epsilon: `epsilon *= 0.995`

Track reward per episode and success rate.

### Sample Output

```
Episode  20: avg reward -45.2, success rate 10%
Episode  50: avg reward -10.8, success rate 40%
Episode 100: avg reward +65.0, success rate 85%
Episode 200: avg reward +89.3, success rate 100%

Learned optimal path:
(0,0) → (0,1) → (0,2) → (0,3) → (0,4) → (1,4) → (2,4) → (3,4) → (4,4)
Steps: 8, Total reward: 92
```

---

## Challenge A: Power-ups

Add "shortcut cells" that give +20 bonus reward. Re-train. Does the agent discover them?

---

## Challenge B: Visualize Learning

Plot (or print) the average reward per 10 episodes. You should see a smooth upward curve.

---

## What You've Learned

- Q-learning algorithm (core RL)
- Epsilon-greedy exploration/exploitation
- Reward shaping (goal reward + step penalty)
- Why RL needs many episodes to converge
- How RL underpins AlphaGo, Tesla Autopilot, recommendation systems

Next up: **Ethics in AI** — Dan confronts bias in AI systems.
