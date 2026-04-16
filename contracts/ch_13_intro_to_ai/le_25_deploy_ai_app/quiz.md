# Lesson 25 Quiz: Deploy AI App

---
# Quiz 1
## Scenario: Demo Day
Dan deployed Luto for the hackathon.

**Question 1:** What's the difference between development and deployment?
A. Deployment is faster
B. Development runs on localhost for you; deployment runs on a public server for anyone with the URL
C. They're the same thing
D. Deployment is only for Python

**Answer:** B
**Explanation:** Dev = your local machine, your eyes only. Deploy = public URL, anyone's browser.

---

**Question 2:** What does Streamlit do?
A. Replaces Python
B. Turns Python scripts into web apps without HTML/CSS/JavaScript
C. Provides AI models
D. Manages git

**Answer:** B
**Explanation:** Streamlit is a Python framework for building web apps quickly. `st.chat_input()`, `st.chat_message()`, etc. give you a UI with almost no frontend code.

---

**Question 3:** Why use `st.session_state`?
A. Decoration
B. Streamlit reruns the whole script on every interaction — session_state persists data across those reruns
C. Not needed
D. For logging

**Answer:** B
**Explanation:** Without session_state, your conversation history gets reset every time the user types. Session state makes data survive reruns.

---

**Question 4:** Where should your OPENAI_API_KEY live when deployed to Streamlit Cloud?
A. In your code
B. In git
C. In the Streamlit Cloud Secrets dashboard (gets injected as env var)
D. In README.md

**Answer:** C
**Explanation:** Streamlit Cloud has a Secrets section specifically for sensitive values. NEVER put keys in code or git.

---

**Question 5:** Which is NOT a free Streamlit deployment option?
A. Streamlit Community Cloud
B. Hugging Face Spaces
C. GitHub Pages (for Streamlit apps specifically)
D. Vercel (doesn't host Streamlit)

**Answer:** C
**Explanation:** GitHub Pages is for static HTML only — it doesn't run Python. Streamlit Cloud and Hugging Face Spaces both support Streamlit for free.

---
# Quiz 2
## Scenario: The Real Prize
Dan finished his 25-lesson journey.

**Question 6:** Dan's "real prize" wasn't winning the hackathon. What was it?
A. Money
B. His mom actually uses Luto every day
C. A trophy
D. Internet fame

**Answer:** B
**Explanation:** A real user you care about using your work is the ultimate validation. Not awards. Not fame. Actual usefulness.

---

**Question 7:** What's the final takeaway of Intro to AI?
A. AI is magic
B. AI requires a PhD
C. Anyone can build useful AI if they understand how to talk to the machine
D. AI will take over the world

**Answer:** C
**Explanation:** Dan started at zero 25 days ago. Finished with a deployed AI app. The skills are learnable. The machines are just tools. You can build too.

---

**Salamat!** You've completed the Intro to AI journey.

**Next:** Build your own project. Carinderia, jeepney, barangay, anything. The skills are yours now.
