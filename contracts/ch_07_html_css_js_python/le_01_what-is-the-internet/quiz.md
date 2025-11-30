# Internet Fundamentals Quiz

---

# Quiz 1

## Quiz: Understanding Network Architecture and IP Addressing

**Scenario:** 

Tian is setting up a new home network in Quezon City. He wants to understand how each component of his internet connection works. Here's Tian's network setup:

```
[Tian's Laptop]
    IP: 192.168.1.100
    ↓
[WiFi Router]
    Local IP: ________  (blank #1)
    Public IP: 203.177.45.123
    ↓
[Modem]
    ↓
[ISP: PLDT Fiber]
    Speed: 100 Mbps
    ↓
[Internet Backbone]
    (Submarine cables, satellites)
    ↓
[Facebook Server]
    IP: 157.240.1.35
    Location: Singapore
```

**Question 1:** What is the typical IP address of the WiFi Router for the local network (blank #1)?

- A) `203.177.45.123` (Public IP ng ISP)
- B) `192.168.1.1` (Private/Local IP)
- C) `157.240.1.35` (Server IP)
- D) `8.8.8.8` (Google DNS)

**Answer: B**

`192.168.1.1` is the typical private/local IP address for routers in home networks. This is a private IP range that's not accessible from the internet.

**Question 2:** When posting to Facebook, how many **major components** does the data pass through before reaching the server?

- A) 3 components (Router → ISP → Server)
- B) 4 components (Router → Modem → ISP → Server)
- C) 5 components (Router → Modem → ISP → Backbone → Server)
- D) 2 components (Router → Server)

**Answer: C**

Data passes through 5 major components: Router → Modem → ISP → Backbone → Server. Each component plays a crucial role in transmitting your data across the internet.

---

# Quiz 2

**Question 3:** Why does the router have **two IP addresses** (192.168.1.1 and 203.177.45.123)?

- A) Backup lang ang isa kung may sira
- B) Private IP para sa local devices, Public IP para sa internet communication
- C) Iba-iba per device ang IP
- D) Error yan, dapat isa lang

**Answer: B**

The router has a Private IP (192.168.1.1) for local network communication with devices inside your home, and a Public IP (203.177.45.123) assigned by the ISP for internet communication. This is how Network Address Translation (NAT) works.

---

## Detailed Explanation

### Question 1: Router IP Address

**Private IP vs Public IP:**

The WiFi router has **two faces** - like having two phone numbers:

1. **Private/Local IP (192.168.1.1)** - Used inside the home
   - Range: `192.168.0.0` to `192.168.255.255` or `10.0.0.0` to `10.255.255.255`
   - Not accessible from the internet
   - Only for devices inside the network (laptop, phone, TV)
   - Many homes use the same private IP because it's not visible from outside

2. **Public IP (203.177.45.123)** - Used to communicate with the internet
   - Assigned by ISP (PLDT, Globe, etc.)
   - Unique worldwide
   - This is what the Facebook server sees
   - This is your real "address" on the internet

**Why do we need Private IP?**
- Limited public IP addresses in the world (IPv4 = 4.3 billion addresses)
- If all devices needed public IPs, we would have run out
- That's why we created **Network Address Translation (NAT)** system
  - Only one public IP per household
  - Many devices inside use private IPs
  - Router translates between private and public

**Common Router IPs in the Philippines:**
- PLDT: Usually `192.168.1.1`
- Globe: Usually `192.168.254.254`
- Converge: Usually `192.168.1.1`
- These are manually configurable

---

### Question 2: Data Path (5 Components)

When Tian posts to Facebook, here's the data journey:

**1. WiFi Router**
   - Receives data from Tian's laptop
   - NAT: Changes source IP from `192.168.1.100` to `203.177.45.123` (public IP)
   - Forwards to modem

**2. Modem**
   - Converts digital signal to format understood by ISP infrastructure
   - Fiber modem = light signals
   - DSL modem = phone line signals
   - Cable modem = coaxial cable signals

**3. ISP (PLDT)**
   - Receives the data
   - Routes to correct destination based on target IP
   - Quality control, speed limiting, traffic management
   - Connects to international backbone

**4. Internet Backbone**
   - **Submarine cables** (in the Philippines, passes through Pacific Ocean)
   - Major cables: SEA-ME-WE (connects PH → Singapore → India → Middle East → Europe)
   - Fiber optic cables, speed of light transmission
   - Data travels ~200,000 km/second underwater
   - Has repeaters every 60-100km to boost signal

**5. Facebook Server (Singapore Data Center)**
   - Receives the HTTP/HTTPS request
   - Validates user credentials
   - Processes data (saves post to database)
   - Sends back response (confirmation)

**Time breakdown (typical):**
- Router → Modem: <1ms
- Modem → ISP: 5-10ms
- ISP → Backbone: 10-20ms
- Backbone (PH → SG): 30-50ms (underwater cables)
- Server processing: 50-100ms
- **Total:** 100-200ms (one-way)

---

### Question 3: Why Two IPs?

**Network Address Translation (NAT) Explained:**

Imagine your house is an apartment building:
- **Public IP** = Building address ("123 EDSA, QC")
- **Private IPs** = Unit numbers (Unit 1A, Unit 2B, etc.)

When mail arrives:
- Envelope shows: "123 EDSA, QC" (public)
- Guard (router) distributes to Unit 1A, 2B, etc. (private)

When sending mail:
- Unit 1A writes letter
- Guard puts building address (123 EDSA) as return address
- Recipient only sees building address, not unit number

**In networking:**

**Outgoing traffic (Tian → Facebook):**
```
1. Tian's laptop sends packet:
   Source: 192.168.1.100:12345 (private IP + port)
   Destination: 157.240.1.35:443 (Facebook server)

2. Router receives packet, NAT translation:
   Source: 203.177.45.123:54321 (public IP + new port)
   Destination: 157.240.1.35:443
   
3. Router keeps NAT table:
   192.168.1.100:12345 ↔ 203.177.45.123:54321
```

**Incoming traffic (Facebook → Tian):**
```
1. Facebook sends response:
   Source: 157.240.1.35:443
   Destination: 203.177.45.123:54321

2. Router checks NAT table:
   54321 → 192.168.1.100:12345
   
3. Router forwards to Tian's laptop:
   Source: 157.240.1.35:443
   Destination: 192.168.1.100:12345
```

**Benefits of NAT:**
- **Security:** Hides internal network structure
- **IP Conservation:** Only one public IP for 50+ devices at home
- **Flexibility:** Can add/remove devices without affecting public IP
- **Cost:** Only pay for one public IP

**Disadvantages:**
- **P2P issues:** Difficult to host servers (needs port forwarding)
- **Gaming:** Some games need port forwarding for optimal performance
- **VoIP:** Voice calls sometimes problematic

---

## Key Concepts Summary

**1. IP Address Types:**
- **Private:** 192.168.x.x, 10.x.x.x (local network only)
- **Public:** Unique globally, assigned by ISP
- **Static:** Fixed IP (usually paid extra)
- **Dynamic:** Changes periodically (default sa karamihan)

**2. Network Components:**
- **Router:** Traffic director, NAT, WiFi broadcast
- **Modem:** Signal converter (digital ↔ ISP format)
- **ISP:** Gateway to internet, DNS, routing
- **Backbone:** International connections, submarine cables

**3. Philippine Context:**
- PLDT, Globe, Converge = major ISPs
- Submarine cables: SEA-ME-WE, AAG, PLCN
- Nearest data centers: Singapore, Hong Kong
- Average latency to Singapore: 30-50ms
- Average latency to US West Coast: 150-200ms
- Average latency to Europe: 250-350ms
