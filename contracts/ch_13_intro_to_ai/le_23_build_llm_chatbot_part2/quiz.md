# Lesson 23 Quiz: Build an LLM Chatbot (Part 2)

---
# Quiz 1
## Scenario: The Interactive Luto
Dan added a loop and slash commands.

**Question 1:** What bug did Dan almost miss with his chat loop?
A. Using print() instead of input()
B. Putting `history = [...]` INSIDE the loop, resetting conversation context every turn
C. Not installing the openai library
D. Nothing

**Answer:** B
**Explanation:** Classic scope bug. If history is re-initialized inside the loop, LLM context is lost every turn. History must live OUTSIDE the loop.

---

**Question 2:** Why do slash commands start with `/`?
A. Tradition
B. To distinguish them from regular chat messages so the program can route them differently
C. It's required by Python
D. Random choice

**Answer:** B
**Explanation:** The `/` prefix is a convention that makes commands easy to parse and distinguish from normal user input.

---

**Question 3:** What should `/clear` do?
A. Delete all files
B. Reset conversation history but keep the system prompt
C. Close the program
D. Nothing

**Answer:** B
**Explanation:** `/clear` resets the conversation so the user can start fresh without losing Luto's personality (which lives in the system prompt).

---

**Question 4:** Why track total tokens during a session?
A. It's required by Python
B. To monitor API cost and warn the user if usage is high
C. For fun
D. No reason

**Answer:** B
**Explanation:** Tokens cost money. Tracking usage helps you stay within budget and warn users before they hit limits.

---

**Question 5:** Why does token usage grow each turn?
A. Bug in Python
B. Because LLMs are stateless — you send the full history with every request, so older messages count every time
C. Random
D. The API charges more for later turns

**Answer:** B
**Explanation:** Every call sends the full history. A 10-turn conversation has ~10x the tokens of the first turn. This is why memory management matters (next lesson).

---
# Quiz 2
## Scenario: Patterns That Matter
Dan made interactive decisions.

**Question 6:** Why does `history` need to live OUTSIDE the loop?
A. Because it's faster
B. So conversation context persists across turns
C. Random
D. Because Python requires it

**Answer:** B
**Explanation:** If you re-create history each turn, every message is a fresh conversation. Putting it outside the loop lets it accumulate context.

---

**Question 7:** What does the `/quit` command typically show?
A. Nothing
B. A session summary with message count, tokens used, duration
C. The error log
D. The source code

**Answer:** B
**Explanation:** Good chatbots give feedback on exit — so the user understands what happened and how much they used.

---
**Next:** Proceed to Lesson 23 exercises.
