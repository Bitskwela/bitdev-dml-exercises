# Activity 1: Mapping Your Internet Journey

## Learning Objectives
After this activity, you'll be able to:
- Visualize how data travels from your device to the internet
- Identify the different components in your home network
- Understand the role of each component (device, router, ISP, servers)
- Trace the path of a real internet request

## Overview
In this activity, you'll create a visual map showing how YOUR device connects to the internet, and trace a real request (like opening Facebook or playing Mobile Legends).

---

## Part 1: Draw Your Home Network (15 minutes)

### Instructions:

**Step 1:** Get a piece of paper or open a drawing app on your device (pwede Paint, or kahit sa papel lang).

**Step 2:** Draw the following components and label them:

1. **Your Device** (phone, laptop, or desktop) - lagay mo sa left side ng paper
2. **WiFi Router** - yung physical device na may lights sa bahay niyo
3. **Modem** (if separate from router) - sometimes same device sila, sometimes different
4. **ISP Connection** - yung cable/fiber line papunta sa ISP niyo
5. **ISP (PLDT/Globe/Converge)** - represent this as a "cloud" or building
6. **Internet Backbone** - draw submarine cables or cell towers
7. **Destination Server** - Example: Facebook's servers, YouTube servers, ML game servers

**Step 3:** Draw arrows connecting each component showing the flow of data:
- Your Device → Router → Modem → ISP → Internet Backbone → Server
- Also draw the return path (kasi round-trip ang data!)

**Step 4:** Add labels to your arrows:
- "WiFi Signal" (device to router)
- "Fiber Optic Cable" or "DSL Cable" (modem to ISP)
- "Submarine Cable" or "Satellite" (ISP to backbone)
- "Request: Load Facebook.com"
- "Response: HTML + Images + Data"

---

## Part 2: Real-World Tracing (10 minutes)

### Instructions:

Now, let's trace a REAL connection from your device!

**Step 1:** Find your IP Address
- Open Google and search: "what is my ip"
- Write down the IP address shown (this is your public IP)
- Example: `203.177.XX.XX`

**Step 2:** Find your Router's IP Address
- **On Phone (Android):** Settings → WiFi → Tap your connected WiFi → Look for "Gateway" or "Router"
- **On Phone (iPhone):** Settings → WiFi → Tap (i) icon → Look for "Router"
- **On Computer (Windows):** Open Command Prompt → Type `ipconfig` → Find "Default Gateway"
- Write it down (usually `192.168.1.1` or similar)

**Step 3:** Identify your ISP
- Go to: `https://www.whatismyisp.com`
- Makikita mo dito kung sino ang ISP niyo at where their servers are located
- Write down: ISP name, ISP location

**Step 4:** Add these details to your drawing!
- Label your device with its local IP (like `192.168.1.5`)
- Label your router with its gateway IP (like `192.168.1.1`)
- Label your public IP (what the internet sees)
- Label your ISP name

---

## Part 3: Trace a Real Website (Advanced - Optional)

**For students who want to go deeper:**

You can use a tool called **traceroute** to see the actual path your data takes!

**On Windows:**
```
1. Press Windows + R
2. Type: cmd
3. Press Enter
4. Type: tracert google.com
5. Press Enter
```

You'll see a list of all the "hops" your data takes to reach Google! Each line is a router or server along the way. Cool diba?

**Note:** Some steps might show "Request timed out" — that's normal, some routers don't respond to traceroute.

---

## Submission Guidelines

### What to submit:
1. Your completed drawing/diagram (take a photo if paper, or save if digital)
2. A short description (3-5 sentences) explaining the journey of data from your device to a website
3. Your answers to Part 2 (your IPs and ISP info)

### Example Description:
"When I open Facebook on my phone, my device sends a request through WiFi to our home router. The router forwards it through our fiber optic cable to PLDT's servers. PLDT then routes my request through the internet backbone (submarine cables) to Facebook's servers in the US. Facebook's server sends back the webpage data following the same path in reverse. All of this happens in less than a second!"

---

## Reflection Questions (Answer these after the activity)

1. How many devices are connected to your home router? (Check with your family!)
2. What's the difference between your local IP (192.168.x.x) and your public IP?
3. Why do you think we need so many components (router, modem, ISP) just to access the internet?
4. If your ISP suddenly goes down, will you still have WiFi? Will you have internet? Why or why not?

---

## Troubleshooting

**Can't find your router's IP?**  
- Try `192.168.1.1` or `192.168.0.1` in your browser — yan ang common default IPs

**Traceroute not working?**  
- Some ISPs block traceroute. That's okay, just focus on Parts 1 and 2

**Don't have home WiFi?**  
- You can do this with mobile data! Your phone connects to cell towers → your telco (Smart/Globe/DITO) → internet backbone → servers
- Just draw "Cell Tower" instead of "Router"

---

## Bonus Challenge

Try visiting `https://www.submarinecablemap.com/` and find the actual submarine cables connecting the Philippines to other countries. These are the physical cables na dinadaanan ng data mo kapag nag-browse ka ng international sites!

Screenshot and share kung alin ang closest cable sa location niyo.
