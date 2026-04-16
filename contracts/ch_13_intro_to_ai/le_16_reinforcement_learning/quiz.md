# Lesson 16 Quiz: Reinforcement Learning

---
# Quiz 1
## Scenario: Training a Virtual Dog
Dan played PetPinas and realized it was teaching him RL.

**Question 1:** Reinforcement Learning is best described as:
A. Learning from labeled examples
B. Learning by trial and error through rewards and penalties
C. Memorizing every answer
D. Random guessing

**Answer:** B
**Explanation:** RL agents learn by acting in an environment, receiving rewards/penalties, and updating their strategy accordingly.

---

**Question 2:** In RL, what is a "policy"?
A. Insurance for the agent
B. A mapping from states to actions (what to do in each situation)
C. A law
D. A type of Python library

**Answer:** B
**Explanation:** The policy is the agent's strategy — "in state X, take action Y." Training = learning the optimal policy.

---

**Question 3:** Exploration vs exploitation means:
A. Explore the environment, never exploit it
B. Try new actions (explore) vs use proven strategies (exploit) — balance both
C. Only exploit, never explore
D. Neither matters

**Answer:** B
**Explanation:** Agents must balance trying new things (discovery) with using what works (reward). Epsilon-greedy is the standard technique.

---

**Question 4:** What does the Q-table store?
A. Final rewards
B. The expected future reward for taking an action in a given state
C. Random numbers
D. The environment's layout

**Answer:** B
**Explanation:** `Q[state][action]` ≈ "if I take this action now, how much total future reward do I expect?" The agent picks the action with the highest Q-value.

---

**Question 5:** In Q-learning, what does gamma (γ) control?
A. The learning rate
B. How much future rewards are valued vs immediate rewards
C. The temperature
D. Nothing

**Answer:** B
**Explanation:** γ is the discount factor. γ near 1 = care about long-term rewards. γ near 0 = only care about immediate rewards.

---
# Quiz 2
## Scenario: Real-World RL
Dan learned where RL is used.

**Question 6:** Which is NOT a typical RL use case?
A. AlphaGo beating world champions at Go
B. Robot arms learning to grasp objects
C. Tesla Autopilot navigating highways
D. Reading a single PDF to summarize it

**Answer:** D
**Explanation:** PDF summarization is NLP, not RL. RL is for sequential decision-making with rewards — games, robotics, routing, recommendations.

---

**Question 7:** Dan's delivery agent learned to go from (0,0) to (4,4) without any labeled examples. How?
A. It was pre-programmed
B. It randomly explored, received rewards (+100 goal, -10 obstacles, -1 step), and updated its Q-table
C. It guessed
D. It memorized the grid

**Answer:** B
**Explanation:** Classic Q-learning: random exploration + reward feedback + Q-table updates. No labeled data needed — just a reward signal.

---
**Next:** Proceed to Lesson 16 exercises.
