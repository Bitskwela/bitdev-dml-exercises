# Lesson 19 Quiz: Prompt Engineering

---
# Quiz 1
## Scenario: From Vague to Specific
Dan learned that vague prompts produce vague responses.

**Question 1:** What is prompt engineering?
A. Writing Python code
B. The skill of crafting effective instructions for LLMs
C. Installing AI software
D. Fixing bugs in ChatGPT

**Answer:** B
**Explanation:** Prompt engineering is about writing instructions that get LLMs to produce useful, structured, reliable output.

---

**Question 2:** What does RCTFC stand for?
A. Random, Chaotic, Technical, Frustrating, Complex
B. Role, Context, Task, Format, Constraints
C. Read, Count, Type, Format, Compute
D. Rapid, Clean, Terse, Free, Clear

**Answer:** B
**Explanation:** RCTFC = Role (who), Context (situation), Task (what), Format (how output looks), Constraints (rules/limits).

---

**Question 3:** Which prompt is stronger?
A. "help me"
B. "As a Python tutor, explain list comprehensions with 3 Filipino food examples in under 200 words"
C. "please write something about AI"
D. "do stuff"

**Answer:** B
**Explanation:** B specifies Role (tutor), Context (learning), Task (explain), Format (examples), and Constraint (length). A, C, D are all too vague.

---

**Question 4:** When should you use few-shot examples in a prompt?
A. Always, for every prompt
B. When the task is unusual or output format is complex
C. Never
D. Only for Python code

**Answer:** B
**Explanation:** Few-shot examples help LLMs match a specific style or structure. For simple/common tasks, RCTFC alone is usually enough.

---

**Question 5:** "Think step by step" is an example of:
A. A greeting
B. Chain-of-thought prompting — forces the model to reason explicitly
C. Noise
D. A formatting trick

**Answer:** B
**Explanation:** Chain-of-thought improves accuracy on complex reasoning tasks by having the model show its work.

---
# Quiz 2
## Scenario: Reusable Templates
Dan built 4 templates for Luto.

**Question 6:** Why build prompt templates instead of writing fresh prompts each time?
A. Templates waste time
B. Templates ensure consistency, save time, and make prompts reusable
C. There's no reason
D. Templates always fail

**Answer:** B
**Explanation:** Templates codify the RCTFC pattern for a specific task. One well-crafted template becomes a reliable tool you can call repeatedly.

---

**Question 7:** What's a common mistake in prompts?
A. Forgetting to specify output format (getting prose when you wanted JSON)
B. Writing in English
C. Using punctuation
D. Using the letter E

**Answer:** A
**Explanation:** Missing format is one of the biggest mistakes. Always tell the LLM if you want a table, JSON, bullet list, or specific structure.

---
**Next:** Proceed to Lesson 19 exercises.
