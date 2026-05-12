> **⚠️ Run this lesson locally — not in the sandbox.** Streamlit web apps cannot run inside the in-browser Python sandbox. Install with `pip install streamlit openai python-dotenv`, then run `streamlit run app.py` on your own machine to see this lesson end-to-end. The code in this lesson is read-along until you reach a local terminal.

---

## Previously on Dan's AI Journey...

Dan improved Luto with memory management, better prompts, and specialized commands — based on Tita Malou's real feedback.

---

## Background Story

**Hackathon day. April 11, 2026. 4:45 AM.**

Dan's alarm rang. He showered, put on the navy blue polo Tita Malou had ironed the night before, grabbed his secondhand Acer laptop, and took the MRT to BGC — Bonifacio Global City.

The venue was intimidating. Big LED screens. Sponsor banners: Google, Microsoft, Ayala, PLDT. Teams with matching t-shirts. Free coffee and pandesal at the hospitality table. Dan found his assigned corner: Table 47. He set up his laptop next to two older developers in crisp Patagonia jackets.

Jasper walked by with a MacBook Pro M4 and a professionally-printed banner. "Good luck, bro," he said, half-smiling. Dan nodded.

Morning flew by. Hackathon participants built in silence, typed furiously. Dan had deployed Luto to Streamlit the night before. He opened his demo URL on his phone to test. It worked.

At 2 PM, presentations began.

Dan's turn at 3:30. He walked up with a yellow pad of hand-written notes and his laptop. Plugged into the projector. The screen showed Luto's Streamlit interface — orange and white, simple, clean.

He typed live in front of the judges:

*"It's rainy today. What should I cook?"*

Luto responded: *"Sinigang na Baboy — perfect for rainy weather. At P65 per plate, profit P27 per serving. Plan for 1kg pork + 1 pack sinigang mix for 10 servings."*

A small gasp from the audience. A judge took notes.

Dan explained the 25-day journey. Showed the code. Showed Tita Malou's testimonial video. Ended with: *"This isn't a demo. My mom uses this every day now."*

He didn't know if he'd win. But standing in that room, among hundreds of developers in BGC — he belonged. 25 days ago, he didn't know what AI was. Now he'd built and deployed an AI chatbot that his mother used.

That was the real prize.

---

## Theory & Lecture Content

### Development vs Deployment

| Development | Deployment |
|-------------|------------|
| Runs on localhost | Runs on a public server |
| Only you can use it | Anyone with the URL can |
| Debug mode on | Optimized for users |
| API key in `.env` | API key in server secrets |

### What is Streamlit?

**Streamlit** turns Python scripts into web apps. No HTML/CSS/JavaScript needed.

```python
import streamlit as st

st.title("Luto")
user_input = st.chat_input("Ask anything...")
if user_input:
    st.chat_message("user").write(user_input)
    reply = chat(user_input)
    st.chat_message("assistant").write(reply)
```

That's a working chatbot web UI. Run with `streamlit run app.py`.

### Streamlit Building Blocks

| Widget | Purpose |
|--------|---------|
| `st.title()` | Page title |
| `st.markdown()` | Formatted text |
| `st.chat_input()` | Chat textbox |
| `st.chat_message()` | Message bubble |
| `st.session_state` | Persistent state across reruns |
| `st.sidebar` | Side panel |
| `st.button()` | Clickable button |
| `st.download_button()` | Download a file |

### Session State

Streamlit reruns the entire script on every interaction. To persist data:

```python
if "history" not in st.session_state:
    st.session_state.history = [{"role": "system", "content": SYSTEM}]

# Now history survives between reruns
```

### Deployment Options

1. **Streamlit Community Cloud** — free, connects to GitHub, auto-deploys
2. **Vercel** — frontends easily (for non-Streamlit apps)
3. **Hugging Face Spaces** — free, supports Streamlit/Gradio
4. **Railway / Render** — paid, full control

Streamlit Community Cloud is perfect for hackathon demos:
1. Push code to GitHub
2. Connect Streamlit Cloud
3. Set environment secrets (API key)
4. Deploy — get a public URL

### What Dan Did for Demo Day

- Built `app.py` with Streamlit
- Pushed to GitHub (with `.env` gitignored)
- Set OPENAI_API_KEY in Streamlit Cloud secrets
- Deployed to `luto.streamlit.app`
- Tested on his phone
- Projected on the big screen during demo

---

## Key Takeaways

1. **Deployment != development.** Dev = localhost + your hands. Deploy = public URL + anyone's hands.
2. **Streamlit** turns Python scripts into web apps with minimal code.
3. **Session state** persists data across Streamlit's reruns.
4. **Streamlit Community Cloud** is the fastest free deployment for hackathons.
5. **API keys go in server secrets**, never in code or git.
6. **The real prize** is users actually using your app. Not the trophy.

---

## The Journey Ends — and Begins

Dan completed 25 lessons:
- From "What is AI?" (Lesson 1) to "Deploy AI App" (Lesson 25)
- From zero Python to shipped Streamlit chatbot
- From a poster on a bulletin board to a demo at TechPinas

Kuya JM sent one final message that night:

> *"Now you know — anyone can build an AI app. As long as you know how to talk to the machine. And you, Dan, are one of us now. Welcome."*

Tita Malou added one final review to Luto's Facebook page:

> *"My son made this. Masarap gamitin. I use it every day. ★★★★★"*

That was enough.

**End of Intro to AI.**

**Next:** Quiz then exercises.
