# Lesson 22 Quiz: Build an LLM Chatbot (Part 1)

---
# Quiz 1
## Scenario: The Foundation
Dan wrote his first chat() function.

**Question 1:** What is the role of LUTO_SYSTEM_PROMPT?
A. Python code
B. Defines who the AI is, how it talks, and its rules
C. The user's first question
D. An API endpoint

**Answer:** B
**Explanation:** The system prompt sets identity, personality, capabilities, and constraints. It's the foundation of the chatbot's behavior.

---

**Question 2:** Why does chat() need a history list?
A. For logging
B. Because LLMs are stateless — you must send the full conversation each time for context
C. To save disk space
D. Not needed at all

**Answer:** B
**Explanation:** LLMs don't remember prior messages. To maintain context, every call sends the full history: system + all user/assistant exchanges.

---

**Question 3:** What should chat() do when the API fails?
A. Crash the program
B. Catch the error, return a helpful message, and log what went wrong
C. Silently ignore the error
D. Retry infinitely

**Answer:** B
**Explanation:** Chatbots must be resilient. Catch specific errors (Auth, RateLimit, Connection) and return useful feedback — never crash.

---

**Question 4:** What's a good first test for a chatbot?
A. Deploy to production
B. Send a scripted 5-message conversation to verify context and error handling
C. Skip testing
D. Ask 1 question and call it done

**Answer:** B
**Explanation:** Scripted multi-turn tests verify context preservation + error handling before adding UI complexity.

---

**Question 5:** Which is a good Luto system prompt element?
A. "You are Luto. Answer in Klingon."
B. "You are Luto, a warm Filipino carinderia assistant. Use PHP for prices, keep answers concise."
C. "You are ChatGPT."
D. "Don't talk at all."

**Answer:** B
**Explanation:** Good system prompts define identity, personality, and practical constraints (language, currency, length).

---
# Quiz 2
## Scenario: Design Decisions
Dan built the chatbot in layers.

**Question 6:** Why use a MockOpenAI class during development?
A. It's required
B. It lets you test the chatbot logic without spending API tokens or needing internet
C. It's faster than real AI
D. For humor

**Answer:** B
**Explanation:** Mock clients enable offline development and tests. Ship-ready code should always work in both mock and real modes.

---

**Question 7:** Separation of concerns in Dan's chatbot means:
A. Mixing everything into one big function
B. Splitting into layers: setup, personality, logic, testing — each with a clear purpose
C. Having no functions
D. Random organization

**Answer:** B
**Explanation:** Clean code organizes by concern — setup vs personality vs logic vs testing. Easier to read, debug, and extend.

---
**Next:** Proceed to Lesson 22 exercises.
