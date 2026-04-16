# Lesson 24 Quiz: Improve Chatbot

---
# Quiz 1
## Scenario: Testing with Tita Malou
Dan brought Luto to the carinderia for real user testing.

**Question 1:** What's the improvement cycle?
A. Build → Ship → Forget
B. Build → Test with users → Collect feedback → Improve → Repeat
C. Plan → Plan → Plan
D. Code → Debug

**Answer:** B
**Explanation:** Real software improves through iteration based on real user feedback — not one-and-done.

---

**Question 2:** Why trim old messages from the conversation history?
A. Looks prettier
B. Long histories blow up token costs since every call sends the full conversation
C. Required by Python
D. No reason

**Answer:** B
**Explanation:** Tokens scale with conversation length. A 50-message convo can cost 10x a 5-message one. Trimming keeps costs manageable.

---

**Question 3:** How do you make Luto's answers more grounded and less generic?
A. Use more Python
B. Inject real data (menu, prices, constraints) into the system prompt
C. Use a bigger model
D. Random words

**Answer:** B
**Explanation:** LLMs can't invent your specific business data. Put it in the system prompt so the model has something to work with.

---

**Question 4:** Why add `/suggest` and `/cost` commands to Luto?
A. To confuse users
B. Specialized commands often provide better UX than free-form chat for routine tasks
C. Required by OpenAI
D. Looks cool

**Answer:** B
**Explanation:** For predictable tasks (pricing, suggestions), commands with dedicated logic are faster, more reliable, and cheaper than chat.

---

**Question 5:** What makes an error message "helpful"?
A. Generic "Error occurred"
B. Tells the user WHAT happened AND HOW to fix it
C. Just the error type
D. No message

**Answer:** B
**Explanation:** "Authentication failed. Check .env for OPENAI_API_KEY" is way more helpful than "AuthError".

---
# Quiz 2
## Scenario: The Real Win
Tita Malou actually used the chatbot.

**Question 6:** What was the key success metric for Luto?
A. Number of lines of code
B. Whether Tita Malou (a non-tech user) could actually use it to do something useful
C. Model size
D. GitHub stars

**Answer:** B
**Explanation:** The real measure of any product: real users succeed with it. Code complexity doesn't matter if the user can't use it.

---

**Question 7:** What's a sign your system prompt needs updating?
A. Replies are too generic or use wrong pricing
B. The API is fast
C. Tokens are tracked
D. Nothing to update

**Answer:** A
**Explanation:** Generic replies = no grounding. Wrong pricing = missing/stale data. The fix is in the system prompt, not the code.

---
**Next:** Proceed to Lesson 24 exercises.
