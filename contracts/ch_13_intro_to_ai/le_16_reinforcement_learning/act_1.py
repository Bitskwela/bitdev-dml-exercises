# delivery_rl.py
# ============================================
# DELIVERY AGENT (Q-LEARNING)
# by: <Your Name>
# ============================================

import numpy as np
import random

random.seed(42)
np.random.seed(42)

# Environment
GRID_SIZE = 5
START = (0, 0)
GOAL = (4, 4)
OBSTACLES = [(1, 2), (2, 2), (3, 0)]

print("=" * 55)
print("  DELIVERY AGENT — Q-Learning on 5x5 Marikina grid")
print("=" * 55)

# TODO: Task 2 — Initialize Q-table
# Q = np.zeros((GRID_SIZE, GRID_SIZE, 4))   # 4 actions: up, down, left, right


# TODO: Task 3 — Epsilon-greedy action selection
# def choose_action(state, epsilon):
#     ...


# TODO: Task 4 — Step function
# def step(state, action):
#     Compute new state, reward, done flag
#     Rewards: goal=+100, obstacle=-10, step=-1


# TODO: Task 5 — Training loop (200 episodes)
# Hyperparams: alpha=0.1, gamma=0.9, epsilon=1.0, decay=0.995
#
# For each episode:
#   state = START
#   while not done and steps < 100:
#     action = choose_action(state, epsilon)
#     new_state, reward, done = step(state, action)
#     Q-update
#     state = new_state
#   epsilon *= decay
#
# Track rewards per episode.


# TODO: After training — print the learned optimal path from START to GOAL.
