# Lesson 1 Activities: What is the Internet?

## Understanding the Foundation

After learning about the global network connecting billions of devices, Tian wanted to solidify understanding through hands-on exploration. These activities help you see the internet infrastructure in action!

---

## Activity 1: Find Your IP Address

**Goal:** Discover your device's unique address on the internet.

**Instructions:**
1. Open your browser
2. Search "What is my IP address" on Google
3. Or visit: `whatismyipaddress.com`
4. Record your IP address
5. Try on both WiFi and mobile data (if available)

**Questions:**
1. What is your IPv4 address?
2. Is it public or private?
3. Does your IP change when you switch from WiFi to mobile data?
4. Why do you think it changes?

**Reflection:**
- How does knowing your IP address help you understand internet connectivity?
- What could someone potentially do with your IP address?

---

## Activity 2: Trace a Website's Journey

**Goal:** See the path data takes from your device to a server.

**Instructions:**
1. Open Command Prompt (Windows) or Terminal (Mac)
2. Type: `tracert facebook.com` (Windows) or `traceroute facebook.com` (Mac)
3. Watch as it shows each "hop" (router) your data passes through
4. Take a screenshot or note the number of hops

**Questions:**
1. How many hops did it take to reach Facebook?
2. What is the final IP address of Facebook's server?
3. Which hop took the longest time (highest ms)?
4. Can you identify any Philippine ISPs in the route?

**Expected Output Example:**
```
1    2 ms   192.168.1.1 (your router)
2   15 ms   PLDT gateway
3   25 ms   Manila exchange point
...
12  45 ms   Facebook server (Singapore)
```

---

## Activity 3: Speed Test Comparison

**Goal:** Measure your internet speed and understand bandwidth.

**Instructions:**
1. Visit `fast.com` (by Netflix)
2. Let it measure your download speed
3. Visit `speedtest.net` for detailed results (download, upload, ping)
4. Test at different times: morning, afternoon, evening
5. Record results in a table

**Table Template:**
| Time | Download (Mbps) | Upload (Mbps) | Ping (ms) |
|------|----------------|---------------|-----------|
| 8 AM |                |               |           |
| 1 PM |                |               |           |
| 8 PM |                |               |           |

**Questions:**
1. Which time had the fastest speed?
2. Why do you think speed varies by time of day?
3. What is your ISP's advertised speed vs actual speed?
4. Is your ping good for gaming (under 50ms)?

**Filipino Context:**
- Peak hours in PH: 6-11 PM (everyone streaming/gaming)
- ISP throttling common during peak times
- Mobile data often slower than advertised

---

## Activity 4: DNS Lookup Investigation

**Goal:** Understand how domain names convert to IP addresses.

**Instructions:**
1. Open Command Prompt/Terminal
2. Type: `nslookup google.com`
3. Try other websites: `facebook.com`, `youtube.com`, `deped.gov.ph`
4. Record the IP addresses

**Example Output:**
```
Server: 192.168.1.1
Address: 192.168.1.1#53

Name: google.com
Addresses: 142.250.185.46
```

**Questions:**
1. What IP address does `google.com` resolve to?
2. Try the IP address directly in your browser—does Google load?
3. Why do we use domain names instead of IP addresses?
4. What is the "Server" listed in the nslookup result?

**Challenge:**
Run `nslookup` on a Philippine government website (e.g., `gov.ph`, `deped.gov.ph`). Are the servers located in the Philippines or abroad?

---

## Activity 5: Identify Your Network Setup

**Goal:** Map out your home/school network configuration.

**Instructions:**
1. Draw a diagram showing:
   - Your device (phone/laptop)
   - Your router
   - Your ISP
   - The internet
   - A website server (e.g., Facebook)
2. Label each component
3. Draw arrows showing data flow
4. Add IP addresses where applicable

**Diagram Should Include:**
- Device IP: `192.168.x.x` (private)
- Router IP: `192.168.1.1` (gateway)
- Public IP: (from Activity 1)
- ISP name: (PLDT, Globe, etc.)
- Server IP: (from Activity 2 or 4)

**Questions:**
1. How many devices are connected to your home router?
2. Do all devices share the same public IP address?
3. What is the difference between your device's IP and your public IP?

---

## Activity 6: Research Philippine Internet History

**Goal:** Understand how the internet came to the Philippines.

**Research Topics:**
1. When did the internet arrive in the Philippines? (Answer: 1994)
2. What was the first ISP in the Philippines?
3. How has internet speed improved over the years?
4. What are the major submarine cables connecting PH to the world?

**Create a Timeline:**
```
1994 - ___________
2000 - ___________
2010 - ___________
2020 - ___________
2024 - ___________
```

**Discussion Questions:**
1. Why is Philippine internet slower than Singapore or South Korea?
2. What infrastructure challenges does the Philippines face?
3. How has internet access changed education in the Philippines?

---

## Activity 7: ISP Comparison Chart

**Goal:** Compare different Philippine ISPs.

**Research and fill out:**

| ISP | Plans (Mbps) | Price Range | Coverage | Customer Reviews |
|-----|--------------|-------------|----------|------------------|
| PLDT | | | | |
| Globe | | | | |
| Converge | | | | |
| DITO | | | | |

**Questions:**
1. Which ISP is available in your area?
2. Which offers the best value for money?
3. Why do rural areas have fewer ISP options?
4. What is "fiber optic" vs regular cable internet?

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Expected Answers

**Typical Results:**
- IPv4 format: `123.45.67.89` (4 numbers, 0-255 each)
- IP changes between WiFi and mobile data (different networks)
- WiFi uses home ISP, mobile uses cellular ISP

**Why IP Changes:**
Each network (WiFi, mobile data) has its own range of IP addresses. Your device gets assigned a different IP depending on which network you connect to.

## Activity 2: Expected Answers

**Typical Results:**
- 10-20 hops to reach major websites
- Facebook servers often in Singapore for PH users
- PLDT/Globe hops visible in early stages
- Higher ms = slower hop (congestion or distance)

**Understanding Hops:**
Each hop is a router passing your data along. More hops = longer distance or more complex routing.

## Activity 3: Expected Answers

**Typical PH Speeds:**
- Budget plans: 10-25 Mbps
- Mid-tier: 35-50 Mbps  
- Premium: 100-300 Mbps
- Peak hours typically 20-30% slower

**Why Speed Varies:**
Bandwidth is shared among all users in your area. During peak hours (evening), everyone is online, causing congestion.

## Activity 4: Expected Answers

**Google IPs:**
- Typically `142.250.x.x` or `172.217.x.x`
- Yes, you can browse using IP directly
- Domain names are easier to remember than numbers

**DNS Server:**
Usually your router (`192.168.1.1`) or ISP's DNS server.

## Activity 5: Sample Diagram

```
[Your Laptop]           [Facebook Server]
192.168.1.100           157.240.2.35
      ↓                       ↑
[WiFi Router] ←→ [ISP: PLDT] ←→ [Internet]
192.168.1.1      Public IP:        Backbone
                 123.45.67.89
```

**Explanation:**
Private IP (192.168.x.x) for local network, Public IP for internet, NAT translation at router.

## Activity 6: Philippine Internet Timeline

**Key Dates:**
- 1994: Internet arrives (PhilCom/PLDT)
- 2000: Internet cafes boom
- 2010: Mobile internet (3G)
- 2015: 4G LTE widespread
- 2020: Work-from-home surge
- 2024: 5G expansion, fiber becoming standard

**Submarine Cables:**
- SEA-ME-WE (Southeast Asia-Middle East-Western Europe)
- Asia-America Gateway (AAG)
- Philippine Domestic Submarine Cable Network

## Activity 7: ISP Comparison (2024 Typical)

**PLDT:**
- Plans: 25-500 Mbps
- Price: ₱1,299-5,999/month
- Coverage: Nationwide (best rural)
- Reviews: Stable but expensive

**Globe:**
- Plans: 25-500 Mbps
- Price: ₱1,299-5,999/month
- Coverage: Urban-focused
- Reviews: Good speed, inconsistent support

**Converge:**
- Plans: 35-600 Mbps
- Price: ₱1,500-6,000/month
- Coverage: Limited to certain cities
- Reviews: Fastest speeds, growing

**DITO:**
- Newer telco (mobile-focused)
- Growing home internet offerings
- Competitive pricing
- Limited coverage (expanding)

</details>

---

**Congratulations!** You've explored the internet infrastructure hands-on. You now understand IP addresses, DNS, routing, speed, and the Philippine internet landscape!

**Next:** How websites actually work—the client-server model!
