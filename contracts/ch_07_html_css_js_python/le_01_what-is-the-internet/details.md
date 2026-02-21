<details>
<summary><strong>📝 Details (Ignore this)</strong></summary>

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
