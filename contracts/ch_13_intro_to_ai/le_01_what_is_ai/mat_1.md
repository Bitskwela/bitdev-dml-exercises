## Background Story

It was a regular Tuesday morning at the University of the Philippines Diliman when Dan Santos, a 20-year-old IT student from Quezon City, spotted something on the bulletin board outside the CS building.

**TechPinas AI Hackathon 2026**
*Grand Prize: Full scholarship + Brand new laptop*
*Open to all Filipino college students*
*Theme: AI Solutions for Filipino Communities*

Dan stared at the poster. Scholarship? Laptop? His current laptop took five minutes just to open VS Code. But there was a problem — he barely knew what AI actually was.

That night, back in his dorm, Dan messaged his cousin.

> **Dan:** Kuya JM, I saw this AI hackathon. But... what exactly is AI? Is it like in the movies? Robots taking over the world?
>
> **Kuya JM:** Haha! It's not like that, Dan. AI is everywhere already. You know Grab? When you book a ride, there's an AI optimizing your driver's route so they get to you faster.
>
> **Dan:** Wait, seriously? Grab uses AI?
>
> **Kuya JM:** Yeah! Shopee too — why do you always end up tempted to buy stuff? Because there's an AI recommending products based on your browsing history. And GCash has an AI that detects fraud so you don't get scammed.
>
> **Dan:** Wow... so AI isn't just robots?
>
> **Kuya JM:** Not at all! AI is any system that can perform tasks that normally require human intelligence. The face unlock on your phone? That's AI. Netflix recommendations? AI. Autocorrect on your keyboard? Also AI. It's all around you — you just don't notice it.
>
> **Dan:** Bro... it feels like everything I use already has AI.
>
> **Kuya JM:** Now you're getting it. Start with the basics, then build from there. You got this, Anak.

Dan looked around his dorm room differently now. His phone's face unlock. The spam filter on his Gmail. The YouTube videos that somehow knew exactly what he wanted to watch at 2 AM. AI was everywhere — and he had been using it all along without realizing it.

---

## Theory & Lecture Content

### 1. What Exactly is AI?

**Artificial Intelligence (AI)** is the field of computer science focused on creating systems that can perform tasks that normally require human intelligence. These tasks include understanding language, recognizing images, making decisions, learning from experience, and solving problems.

Think of it this way: when a machine does something "smart" — something you would normally need a human brain for — that is AI at work.

### 2. AI is Not Just Robots

Many people think AI means humanoid robots from the movies. In reality, most AI has no physical body at all. It is software — code running on servers and devices — that processes data and makes decisions.

### 3. 12 Real-World AI Examples in Filipino Daily Life

Here are AI systems you probably use every single day:

| # | AI System | What It Does | How You Encounter It |
|---|-----------|-------------|---------------------|
| 1 | **Grab** | Optimizes routes, matches you to the nearest driver, calculates dynamic pricing | Every time you book a ride in Metro Manila |
| 2 | **GCash Fraud Detection** | Analyzes transactions to catch suspicious activity | Protects your GCash wallet from scammers |
| 3 | **Shopee Recommendations** | Suggests products based on your browsing and purchase history | "Products You May Like" section |
| 4 | **Lazada Smart Search** | Understands what you mean even with typos or Taglish queries | Searching "pang work na sapatos" returns office shoes |
| 5 | **Netflix Recommendations** | Learns your viewing habits to suggest shows and movies | "Because You Watched..." suggestions |
| 6 | **YouTube Algorithm** | Recommends videos based on watch history and engagement | Your entire YouTube homepage |
| 7 | **Siri / Google Assistant** | Understands voice commands and responds in natural language | "Hey Siri, what's the weather today?" |
| 8 | **Spam Filter (Gmail)** | Detects and filters spam, phishing, and scam emails | Your spam folder catches 99% of junk |
| 9 | **Face Unlock** | Recognizes your face to unlock your phone | Every time you pick up your phone |
| 10 | **Autocorrect / Predictive Text** | Predicts the next word you want to type | Texting on your phone keyboard |
| 11 | **Waze** | Predicts traffic patterns, suggests fastest route, reroutes in real-time | Navigating EDSA during rush hour |
| 12 | **TikTok For You Page** | Learns what content you engage with and serves more of it | Endless scrolling at 2 AM |

### 4. The Core Idea: INPUT → PROCESS → OUTPUT

At its most basic level, AI follows this pattern:

```
INPUT (data) --> PROCESS (rules/logic) --> OUTPUT (decision/action)
```

- **Input:** The data the system receives (your location, your browsing history, your face)
- **Process:** The rules or learned patterns it uses to analyze that data
- **Output:** The decision or action it takes (recommend a product, unlock your phone, reroute your trip)

### 5. Traditional Programming vs AI

The difference between traditional programming and AI is *where the rules come from*:

- **Traditional programming:** A human writes all the rules explicitly. "If temperature > 30, turn on AC."
- **AI (machine learning):** The machine discovers the rules by analyzing data. You give it thousands of examples, and it figures out the patterns on its own.

Today, we start with the traditional approach — writing rules ourselves. In later lessons, we will learn how to let the machine discover the rules from data.

### 6. Rule-Based Systems (Expert Systems)

Before modern machine learning, early AI systems worked by having experts write rules by hand. These are called **rule-based systems** or **expert systems**. They work well for simple problems but do not scale. Imagine writing rules for 1,000 dishes across 50 factors — impossible by hand!

In our activity, you will build a rule-based ulam (dish) recommender — a simple expert system that recommends Filipino dishes based on weather, budget, and mood. This is exactly how early AI worked.

---

## Dan's Journal

> **Entry #1 — "AI Is Everywhere"**
>
> I used to think AI was like JARVIS from Iron Man — a super-smart robot that can talk to you and do everything.
>
> But today I learned that AI is actually everywhere. The Grab I always use to get to school — that's AI. The Shopee I always open during boring lectures — that's AI too, recommending products to me. Even the face unlock on my phone — AI!
>
> I built a simple ulam recommender using just if-else statements. It's basic, but I get the concept now: INPUT goes in, the program PROCESSES it using rules, then gives an OUTPUT. It's like asking Nanay what to cook for dinner — she considers the weather, the budget, who's eating, what's in the fridge — and then she decides. Same logic.
>
> The difference between what I built and real AI? Real AI learns the rules on its own from data. I had to write every single rule manually. Imagine if there were 1,000 dishes and 50 factors — it would be impossible to code all of that by hand!
>
> I'm excited about the hackathon. Baby steps for now. But at least I know this: **AI is just making machines do things that normally need human intelligence.** And it's already all around us.
>
> — Dan Santos, somewhere in his dorm in Diliman

---

## Key Takeaways

1. **AI is the science of making machines perform tasks that normally require human intelligence** — understanding language, recognizing images, making decisions, learning from experience.
2. **AI is already everywhere** in your daily life: Grab, Shopee, GCash, Netflix, face unlock, spam filters, Waze, autocorrect, and more.
3. **The basic AI pattern is: INPUT (data) → PROCESS (rules/logic) → OUTPUT (decision/action).**
4. **Rule-based AI** (like our ulam recommender) requires humans to write every rule by hand. This works for simple problems but does not scale.
5. **Modern AI (machine learning)** lets machines discover rules from data — but we will get to that in Lesson 3.

---

## Filipino Culture Cards

> Learn about the Filipino terms and cultural elements featured in this lesson!

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Kuya** | KOO-yah | Respectful term for an older brother or older male relative/friend. Filipinos use it even for non-relatives as a sign of respect and warmth. |
| **Anak** | AH-nahk | "Child" or "Son/Daughter" — a term of endearment used by Filipino elders and parents when speaking to younger family members. |
| **Carinderia** | kah-rin-DEH-ryah | A small, family-run eatery — the heart of Filipino street food culture. Customers point at dishes behind a glass counter ("turo-turo"). Affordable, home-cooked meals for working-class Filipinos. |
| **GCash** | jee-CASH | The Philippines' most popular mobile wallet — used for bills, shopping, and even street food. A game-changer for the unbanked population. |
| **Ulam** | OO-lahm | The main dish eaten with rice. In Filipino meals, rice is the base and ulam is whatever goes with it — meat, fish, or vegetables. |
| **Adobo** | ah-DOH-boh | The unofficial national dish — meat braised in vinegar, soy sauce, garlic, and bay leaves. Every Filipino family has their own recipe. |
| **Sinigang** | see-nee-GANG | A sour tamarind-based soup with pork or shrimp and vegetables. The ultimate comfort food, especially on rainy days. |
| **Halo-Halo** | HAH-loh HAH-loh | Literally "mix-mix" — a shaved ice dessert with sweet beans, jellies, fruits, ube ice cream, and evaporated milk. The iconic summer treat. |

---

## What's Next?

Dan is feeling good. He built his first "AI" program and finally understands what AI actually is. But that night, he makes a mistake — he opens YouTube and starts reading article after article about AI...

> *"AI Will Replace 80% of Jobs by 2030!"*
> *"Warning: Robot Overlords Are Coming!"*
> *"Is AI Going to Destroy Humanity?"*

Dan starts panicking. Is his IT degree going to be useless? Are robots going to take over the Philippines? He messages Kuya JM at 1 AM...

**Next Lesson: Narrow vs General AI** — Kuya JM calms Dan down and explains that the AI taking over the world is pure science fiction. The AI we have today can only do ONE specific thing. Time to separate fact from fiction.

**Next:** Quiz then exercises.
