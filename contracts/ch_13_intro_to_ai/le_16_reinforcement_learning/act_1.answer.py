# delivery_rl.py
# ============================================
# DELIVERY AGENT — Q-Learning Full Solution
# by Dan Santos
# ============================================

import numpy as np
import random

random.seed(42)
np.random.seed(42)

GRID_SIZE = 5
START = (0, 0)
GOAL = (4, 4)
OBSTACLES = {(1, 2), (2, 2), (3, 0)}

# 4 actions: 0=up, 1=down, 2=left, 3=right
ACTIONS = [(-1, 0), (1, 0), (0, -1), (0, 1)]

Q = np.zeros((GRID_SIZE, GRID_SIZE, 4))

ALPHA = 0.1
GAMMA = 0.9
EPISODES = 200
MAX_STEPS = 100


def choose_action(state, epsilon):
    if random.random() < epsilon:
        return random.randint(0, 3)
    r, c = state
    return int(np.argmax(Q[r, c]))


def step(state, action):
    r, c = state
    dr, dc = ACTIONS[action]
    new_r = max(0, min(GRID_SIZE - 1, r + dr))
    new_c = max(0, min(GRID_SIZE - 1, c + dc))
    new_state = (new_r, new_c)

    if new_state == GOAL:
        return new_state, 100, True
    if new_state in OBSTACLES:
        return new_state, -10, False
    return new_state, -1, False


print("=" * 55)
print("  DELIVERY AGENT — Q-Learning Training")
print("=" * 55)

epsilon = 1.0
decay = 0.995
all_rewards = []

for ep in range(1, EPISODES + 1):
    state = START
    total_reward = 0
    done = False
    steps = 0

    while not done and steps < MAX_STEPS:
        action = choose_action(state, epsilon)
        new_state, reward, done = step(state, action)
        r, c = state
        nr, nc = new_state

        best_next = np.max(Q[nr, nc])
        Q[r, c, action] += ALPHA * (reward + GAMMA * best_next - Q[r, c, action])

        state = new_state
        total_reward += reward
        steps += 1

    all_rewards.append(total_reward)
    epsilon *= decay

    if ep % 20 == 0:
        window = all_rewards[-20:]
        avg = sum(window) / len(window)
        success = sum(1 for r in window if r > 50) / len(window) * 100
        print(f"   Ep {ep:3d}: avg reward {avg:+6.1f}, success {success:.0f}%, epsilon {epsilon:.3f}")

# Show learned path
print("\n-- Learned optimal path --")
state = START
path = [state]
steps_taken = 0
while state != GOAL and steps_taken < 50:
    r, c = state
    action = int(np.argmax(Q[r, c]))
    state, _, done = step(state, action)
    path.append(state)
    steps_taken += 1

print(f"   Path: {' → '.join(str(p) for p in path)}")
print(f"   Length: {len(path) - 1} steps")

# Display grid
print("\n-- Final Q-values (max per cell) --")
for r in range(GRID_SIZE):
    row_str = "   "
    for c in range(GRID_SIZE):
        if (r, c) == START: tag = "S"
        elif (r, c) == GOAL: tag = "G"
        elif (r, c) in OBSTACLES: tag = "X"
        else: tag = f"{np.max(Q[r, c]):+.0f}"
        row_str += f"{tag:>5}"
    print(row_str)
