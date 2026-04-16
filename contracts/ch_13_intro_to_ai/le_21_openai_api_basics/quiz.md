# Lesson 21 Quiz: OpenAI API Basics

---
# Quiz 1
## Scenario: First Real Call
Dan made his first OpenAI API call and watched AI respond to HIS code.

**Question 1:** In an OpenAI chat request, what is the "system" message for?
A. System logs
B. Defining the AI's personality, rules, and style
C. Error reporting
D. Network settings

**Answer:** B
**Explanation:** The system message sets the tone and behavior — e.g., "You are Luto, a friendly Filipino carinderia assistant." It's typically sent once at the beginning.

---

**Question 2:** What does `temperature=0.0` produce?
A. Random creative responses
B. Deterministic, focused responses
C. Broken responses
D. Nothing

**Answer:** B
**Explanation:** Temperature 0 = no randomness. The model picks the most likely next token every time. High temperature (1.5) = more creative/random.

---

**Question 3:** LLMs are "stateless." What does that mean?
A. They don't work
B. They don't remember previous messages — you must send the full history each time
C. They only use memory
D. They delete themselves

**Answer:** B
**Explanation:** Each API call is independent. For multi-turn context, you re-send all prior messages in the `messages` list.

---

**Question 4:** What's the "assistant" role in a conversation history?
A. The human's message
B. The AI's previous reply (included so future calls have context)
C. A system admin
D. Nothing

**Answer:** B
**Explanation:** When building a history, include past AI replies as `{"role": "assistant", "content": "..."}` so the model knows what it said before.

---

**Question 5:** Roughly how many words is 1 token?
A. 0.1
B. About 0.75 words (for English)
C. 10
D. 100

**Answer:** B
**Explanation:** 1 token ≈ 0.75 English words ≈ 4 characters. Non-English languages use more tokens per word.

---
# Quiz 2
## Scenario: Cost and Safety
Dan tracked his P500 budget.

**Question 6:** Why use a mock OpenAI client during development?
A. It's funnier
B. Saves API credits and runs offline/deterministically
C. It's required
D. It's faster for the user

**Answer:** B
**Explanation:** Mock clients let you code and test without burning tokens. Switch to the real client once everything works.

---

**Question 7:** Where should your OpenAI API key live?
A. Hardcoded in your Python file
B. Committed to your git repo
C. In an environment variable / `.env` file that's gitignored
D. In the README

**Answer:** C
**Explanation:** Never commit keys. Use `os.environ.get("OPENAI_API_KEY")` and `.env` files that git ignores.

---
**Next:** Proceed to Lesson 21 exercises.
