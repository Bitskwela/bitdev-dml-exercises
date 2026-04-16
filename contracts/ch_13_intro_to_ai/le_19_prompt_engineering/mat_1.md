## Previously on Dan's AI Journey...

Dan scoped out his hackathon project — Luto, an AI inventory tracker for carinderias — and built the demand prediction prototype.

---

## Background Story

Dan typed into ChatGPT: *"help me with AI"*. Response: a generic 2000-word summary. Useless.

Dan typed: *"help me with my project"*. Response: asked clarifying questions. Still not useful for coding.

He messaged Kuya JM.

> **Dan:** *"Kuya, ChatGPT is overrated. I ask for help and get Wikipedia responses."*
>
> **Kuya JM:** *"The problem isn't ChatGPT. It's your prompt. Imagine ordering at a carinderia: 'Give me food.' You'll get whatever the tindera feels like. 'Give me sinigang na baboy, extra broth, just a little chili, rice on the side.' Now you'll get exactly that."*
>
> **Kuya JM:** *"Use RCTFC: Role (who should AI be?), Context (the situation), Task (what exactly?), Format (how should the answer look?), Constraints (limits/rules)."*

Dan tried again. This time:

*"Role: You are an experienced carinderia owner in Marikina.*
*Context: I'm building an AI chatbot for small carinderias. My mom runs one with 15 years of experience.*
*Task: Suggest 5 daily menu items that are profitable and easy to prepare on a rainy day.*
*Format: Return a Markdown table with columns: Dish, Prep time (minutes), Cost, Suggested price, Profit per serving.*
*Constraints: Use Filipino dishes only. Ingredients must cost under P50 per serving."*

ChatGPT's response was perfect. A table, ready to use. Dan saved the prompt template and reused it for cost analysis, customer replies, inventory alerts. Within 2 hours he had 5 templates for his chatbot.

---

## Theory & Lecture Content

### What is Prompt Engineering?

**The skill of writing effective instructions for LLMs** so they produce useful, structured, reliable outputs.

### The RCTFC Framework

| Letter | Meaning | Example |
|--------|---------|---------|
| **R**ole | Who should the AI be? | "You are a carinderia expert with 15 years of experience" |
| **C**ontext | What's the situation? | "I'm building a chatbot for small Filipino food stalls" |
| **T**ask | What specifically to do? | "Suggest 5 rainy-day menu items" |
| **F**ormat | How should output look? | "Markdown table with columns: Dish, Cost, Price, Profit" |
| **C**onstraints | Rules and limits | "Filipino dishes only. Ingredients under P50 per serving." |

### Weak vs Strong Prompt

**Weak**: "Suggest dishes"
**Strong**: RCTFC prompt above

The strong version is 3x longer but the response is 10x more useful.

### Other Techniques

- **Few-shot examples**: show 2-3 desired input-output pairs
- **Chain of thought**: "Think step by step" makes reasoning explicit
- **Role separation**: system prompt = personality, user prompt = current request

### Common Mistakes

1. Too vague ("help me with code")
2. No format specified (get prose when you wanted JSON)
3. Missing context (AI guesses)
4. No constraints (rambling responses)
5. No examples (ambiguous expectations)

### Prompt Quality Scoring

Score 0-10:
- Specificity (0-3)
- Format specified (0-2)
- Context provided (0-2)
- Constraints (0-2)
- Examples (0-1)

A good prompt scores 8+.

---

## Dan's Journal

> **April 4, 2026 — Dorm**
>
> Prompt engineering is a SKILL. I underestimated it.
>
> Weak prompt: "help me build a chatbot." ChatGPT gave me a generic article.
>
> Strong prompt with RCTFC: I got working Python code, customized for my carinderia use case, with a specific tone matching Filipino conversational style.
>
> Built 5 prompt templates for Luto:
> 1. Menu suggestion (given weather + budget)
> 2. Customer reply (polite, Taglish-friendly)
> 3. Cost analysis (break-even calculation)
> 4. Inventory alert (urgency-appropriate tone)
> 5. General assistant (catch-all)
>
> Tomorrow: wire them into actual API calls.

---

## Key Takeaways

1. **Prompt engineering = writing effective instructions.** The quality of the prompt determines the quality of the output.
2. **RCTFC framework**: Role, Context, Task, Format, Constraints.
3. **Be specific**: "Suggest 5 dishes" > "Help with menu".
4. **Specify format**: tables, JSON, bullet lists — tell the AI what you want.
5. **Few-shot examples** help when the task is unusual.
6. **Templates save time**: build reusable prompts for common tasks.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Luto** | LOO-toh | "To cook" in Filipino — name of Dan's chatbot. |
| **Carinderia** | kah-rin-DEH-ryah | Small family-run eatery. |
| **Sinigang** | see-nee-GANG | Sour tamarind soup. |

---

## What's Next?

Dan can write great prompts. Now he needs to wire them up through APIs.

**Next Lesson: APIs in AI** — Dan learns how programs talk to AI services.

**Next:** Quiz then exercises.
