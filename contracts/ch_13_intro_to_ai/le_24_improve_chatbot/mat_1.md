## Previously on Dan's AI Journey...

Dan wrapped `chat()` in an interactive loop with slash commands — Luto is officially a chatbot.

---

## Background Story

Wednesday afternoon, 2 PM. Dan took a jeepney from UP to Marikina. He brought his laptop to the carinderia.

"Ma, I made something. I want to test it with you."

Tita Malou put down her ladle. Skeptical. "Is that a robot? I don't like robots."

"No, Ma. It's an assistant. Just a program. Type your questions, it answers."

She sat down. Squinted at the keyboard. Typed, with one finger at a time and no punctuation: *"how much should i charge for sinigang"*

Luto: *"For Sinigang na Baboy with rice, a competitive price is P65-P75 per serving. At P220 ingredient cost for 10 servings, that gives you about P450 profit per batch."*

Tita Malou's eyes widened. "Anak... it knows how much sinigang costs?"

For the next 20 minutes she typed question after question. Some answers were great — specific, practical, Taglish-friendly. Others were too generic ("eat a variety of dishes") or used too much English jargon.

Dan took notes. Then he messaged Kuya JM.

> **Dan:** *"Kuya, feedback from Mama: too generic sometimes. Uses big words. Doesn't know our actual menu or our real prices."*
>
> **Kuya JM:** *"Iterate. Update the system prompt with actual menu + pricing data. Add /suggest and /cost commands for common tasks. Trim old messages so tokens stay reasonable. Handle errors with helpful suggestions, not jargon."*

Dan spent that evening improving Luto. Better prompts. Memory management. Two new commands. By 11 PM, Luto v3 was testing well.

At the end of the session Tita Malou took off her reading glasses. "Anak. You made this? You are so talented."

Her voice cracked.

Dan nearly cried.

---

## Theory & Lecture Content

### The Improvement Cycle

```
Build → Test with users → Collect feedback → Improve → Repeat
```

This is the real ML/AI workflow. Not one-and-done — iterate based on real user feedback.

### Memory Management

Long conversations get expensive. Keep only the last N exchanges:

```python
MAX_HISTORY_PAIRS = 8

def trim_history():
    global history
    # Keep system prompt + last N user/assistant pairs (2 messages per pair)
    if len(history) > 1 + MAX_HISTORY_PAIRS * 2:
        history = [history[0]] + history[-(MAX_HISTORY_PAIRS * 2):]
```

Call `trim_history()` at the end of each `chat()`.

### Better System Prompts with Real Data

Generic: "You are Luto, an assistant."
Better: "You are Luto. The menu is: Adobo P60, Sinigang P65, ... Use these prices when asked. If user mentions an item not on this list, say you'd need to check."

Inject real data into the prompt so answers are grounded.

### Specialized Commands

Build commands for common tasks that deserve dedicated logic:

- `/suggest` → generate a menu for a specific day/weather
- `/cost item ingredients` → compute cost + suggested price
- `/summary` → analyze topics discussed in the conversation

Specialized commands = better UX than free-form chat for routine tasks.

### Better Error Handling

Generic: "Error"
Helpful: "Authentication failed. Check your API key in `.env` — it may have expired. Run `echo $OPENAI_API_KEY` to verify it's set."

Tell the user what happened AND how to fix it.

---

## Key Takeaways

1. **User testing reveals what docs can't.** Real usage exposes gaps.
2. **Improvement cycle**: Build → Test → Collect feedback → Improve → Repeat.
3. **Memory management** trims old messages to keep tokens (and costs) reasonable.
4. **Better system prompts** inject real data (menu, prices, constraints).
5. **Specialized commands** (`/suggest`, `/cost`) often beat free-form chat for routine tasks.
6. **Helpful error messages** tell users what happened AND how to fix it.

---

## What's Next?

Luto works locally. But the hackathon judges won't see Dan's laptop — they need a public web demo. Time to deploy.

**Next Lesson: Deploy AI App** — Streamlit + hackathon day.

**Next:** Quiz then exercises.
