# Deploy Luto as a Streamlit App

Deploy your chatbot as a web app anyone can use from a browser.

---

## Prerequisites

```
pip install streamlit openai python-dotenv
```

---

## Task 1: Build `app.py`

The starter has the skeleton. Fill in:
- Page config (`st.set_page_config`)
- Session state initialization
- Sidebar with mode indicator, metrics, clear button, download
- Main chat interface: title, caption, message display, chat input
- Response handling with spinner

---

## Task 2: Run Locally

```
streamlit run act_1.py
```

Opens at http://localhost:8501. Chat with Luto.

---

## Task 3: Deploy to Streamlit Community Cloud

1. Push your code to GitHub
2. Go to https://share.streamlit.io
3. Connect your GitHub account
4. Select the repo and `app.py`
5. In "Advanced settings" → Secrets, add:
   ```
   OPENAI_API_KEY = "sk-..."
   ```
6. Click Deploy
7. Share the public URL!

---

## Challenge A: Quick-Ask Buttons

Add sidebar buttons for common queries:
- "Suggest rainy-day menu"
- "Calculate Sinigang profit"
- "Generate customer reply"

Each triggers a pre-filled message.

---

## Challenge B: Download Conversation

Add a download button that exports the conversation as JSON or plain text.

---

## What You've Learned

- Streamlit basics: title, chat_input, chat_message, session_state
- Running a local web app from pure Python
- Session state to persist data across reruns
- Deploying to Streamlit Community Cloud (free)
- Putting API keys in server secrets, never in code

---

## The Journey

This is the final lesson of Intro to AI.

Dan completed 25 lessons. You did too (or you're about to). From "What is AI?" to deploying a real, working AI chatbot.

**Next:** Build your own AI project. Your carinderia. Your jeepney. Your barangay. Your app. The skills are yours now.

**Salamat!**

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for a complete Streamlit app with sidebar, metrics, clear button, download, and MockOpenAI fallback.

</details>
