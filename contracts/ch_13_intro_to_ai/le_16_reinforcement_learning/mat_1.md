## Previously on Dan's AI Journey...

Dan learned how AI sees images as number grids and built a brightness detector + color-based dish classifier.

---

## Background Story

Dan was on a break, playing a mobile game called PetPinas. In it, you train a virtual dog named Bantay. Feed him treats when he sits, scold him when he chews shoes. Over time, Bantay learns which actions earn rewards. By day 7, he sits on command.

Dan realized: *that's AI learning by trial and error. That's Reinforcement Learning.*

He messaged Kuya JM.

> **Dan:** *"Kuya, RL is like training a dog, right? Rewards and penalties?"*
>
> **Kuya JM:** *"Exactly. Agent (dog) + environment (world) + actions + rewards = RL. The agent explores, gets feedback, and updates its 'policy' — which is just a mapping of 'in state X, do action Y.' Over thousands of trials, it converges to the optimal policy. AlphaGo learned to beat world champions at Go that way. Tesla Autopilot. Recommendation systems. Robotics. All RL."*

Dan got inspired. What if he built an RL agent that learns to navigate Marikina? A delivery boy agent. Start at one corner of a grid, find the customer at the opposite corner, avoid obstacles (traffic, closed streets).

By night he had a working Q-learning implementation. The agent started stumbling randomly around the grid, bumping into walls. By episode 50 it found the goal half the time. By episode 150 it knew the shortest path. By episode 200 it was close to optimal.

---

## Theory & Lecture Content

### The RL Setup

- **Agent**: the decision-maker (our delivery boy)
- **Environment**: the world (Marikina grid)
- **State**: the situation right now (agent's position)
- **Action**: what the agent chooses to do (up, down, left, right)
- **Reward**: feedback from environment (+100 for reaching goal, -10 for obstacle, -1 per step)

### The Loop

```
while not done:
    state = environment.current_state()
    action = agent.choose_action(state)
    new_state, reward, done = environment.step(action)
    agent.learn(state, action, reward, new_state)
```

### Q-Table

The agent's memory. `Q[state][action]` = expected future reward from taking `action` in `state`.

Start all zeros. Update after every step:

```
Q[s][a] = Q[s][a] + α * (reward + γ * max(Q[s']) - Q[s][a])
```

- α (alpha) = learning rate (how fast to update)
- γ (gamma) = discount factor (how much to value future rewards)

### Exploration vs Exploitation

- **Explore**: try random actions to discover new strategies
- **Exploit**: use what you've learned to maximize reward

**Epsilon-greedy**: with probability ε, explore; otherwise exploit. Start ε high, decay over time.

### Why RL Is Powerful

- No labeled data required — just rewards
- Can learn complex strategies (AlphaGo beat Lee Sedol this way)
- Works in sequential decision problems (games, robotics, routing)

### Downsides

- Needs many many trials (sample inefficient)
- Reward design is tricky — wrong rewards = wrong behavior
- Hard to debug (agent does weird things for unclear reasons)

---

## Dan's Journal

> **March 30, 2026 — Dorm, late**
>
> Trained a delivery agent today. 5x5 Marikina grid. Start (0,0), goal (4,4), 2 obstacles. Reward: +100 goal, -10 obstacle, -1 each step.
>
> Episode 1-20: random stumbling. Agent bumps into walls, gets stuck in corners. Rewards ≈ -50 per episode.
>
> Episode 50-100: agent starts finding paths. Still messy. Rewards ≈ -10.
>
> Episode 150+: optimal path found. Rewards stabilize at +90 (100 - 10 steps).
>
> Watching the Q-table converge was satisfying. Started with zeros. Values grew near the goal first, then propagated backward to the start. Bellman equation in action.
>
> Real RL is used in Tesla Autopilot, Grab's dynamic pricing, YouTube recommendations. Mine is a 5x5 grid. Same core algorithm. Same math. Just smaller scale.

---

## Key Takeaways

1. **RL = agent + environment + actions + rewards.** Agent learns by trial and error.
2. **Q-table** stores "expected reward for taking action A in state S."
3. **Update rule**: `Q[s][a] += α * (reward + γ * max(Q[s']) - Q[s][a])`
4. **Exploration vs exploitation**: try new things vs use what works. Epsilon-greedy balances them.
5. **No labels needed** — just rewards. Great for games, robotics, routing.
6. **AlphaGo, Tesla Autopilot, ChatGPT's RLHF tuning** — all use RL.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Madiskarte** | mah-dis-KAR-teh | Resourceful, street-smart — a highly admired Filipino trait. |
| **Matiyaga** | mah-tee-YAH-gah | Patient, persistent, hardworking. A core Filipino value. |
| **Barangay** | bah-RAHNG-guy | Smallest administrative unit in the Philippines (a neighborhood). |

---

## What's Next?

All these AI techniques are powerful — but they can also cause real harm if used badly. Time to talk ethics.

**Next Lesson: Ethics in AI** — Dan learns about bias, fairness, and responsibility.

**Next:** Quiz then exercises.
