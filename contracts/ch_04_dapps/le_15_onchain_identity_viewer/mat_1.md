## 🧑‍💻 Background Story

In a sunlit hall at the Filipino Consulate in San Francisco, Odessa ("Det") plugged her laptop into the projector. The banner read: **ChainKilala – Your On-Chain Identity, Dito Ka Kilala**. Filipino community leaders, students, and OFWs leaned forward. "Dito, ikaw ang profile mo," Odessa smiled, unveiling a sleek UI that read on-chain profiles: name, status, and credentials—no centralized database needed.

Behind the scenes, Neri had deployed `ChainKilala.sol` on a Sepolia testnet and pre-registered profiles for several attendees. As each visitor connected MetaMask, the UI fetched their DID-style data: "Elias", "Student", credentials like "NBI Clear" or "OFW ID". When profiles updated on-chain, a `ProfileUpdated` event fired and the browser refreshed automatically.

In under 30 minutes, Det had demonstrated decentralized identity to a room full of Pinoys far from home. No more paper forms at consulates—just code, wallets, and pride. After the demo, consulate officials asked about integration with PhilSys. Odessa grinned: "One step at a time. Next, we'll bridge real-world IDs on-chain." Mabuhay ChainKilala! 🇵🇭🆔🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build an **on-chain identity viewer** that reads DID-style (Decentralized Identifier) profile data from a smart contract. This introduces concepts of self-sovereign identity where users control their credentials without centralized databases.

---

### 📐 On-Chain Identity Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                  CHAINKILALA IDENTITY FLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    USER WALLET                           │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ Address: 0x1234...ABCD                           │    │   │
│   │  │ "This is MY identity on the blockchain"          │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                    setProfile(name, status, creds)              │
│                                │                                │
│   ┌────────────────────────────▼────────────────────────────┐   │
│   │                ChainKilala Contract                      │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │  mapping(address => Profile) profiles            │    │   │
│   │  │                                                  │    │   │
│   │  │  Profile {                                       │    │   │
│   │  │    name: "Juan dela Cruz"                        │    │   │
│   │  │    status: "OFW"                                 │    │   │
│   │  │    credentials: ["NBI Clear", "OFW ID", ...]     │    │   │
│   │  │  }                                               │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│                      getProfile(address)                        │
│                                │                                │
│   ┌────────────────────────────▼────────────────────────────┐   │
│   │                    React UI                              │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │  👤 Juan dela Cruz                               │    │   │
│   │  │  📋 Status: OFW                                  │    │   │
│   │  │  ✅ NBI Clear                                    │    │   │
│   │  │  ✅ OFW ID                                       │    │   │
│   │  │  ✅ PhilSys Verified                             │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. Decentralized Identity (DID) Basics

| Concept | Traditional ID | Decentralized ID |
|---------|---------------|------------------|
| **Storage** | Government database | Blockchain |
| **Control** | Issuing authority | User wallet |
| **Portability** | Limited by borders | Global |
| **Privacy** | Full data exposure | Selective disclosure |
| **Verification** | Manual lookup | Cryptographic proof |

```
Self-Sovereign Identity Principles:
├── Existence: Users exist independently of issuers
├── Control: Users control their identities
├── Access: Users have access to their own data
├── Transparency: Systems are transparent
├── Persistence: Identities are long-lived
├── Portability: Identities are portable
└── Consent: Users consent to data use
```

#### 2. Profile Data Structure

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainKilala {
    struct Profile {
        string name;           // Display name
        string status;         // Role or status (Student, OFW, etc.)
        string[] credentials;  // List of verified credentials
    }
    
    // Each address maps to a profile
    mapping(address => Profile) private profiles;
    
    // Track if profile exists
    mapping(address => bool) public hasProfile;
    
    event ProfileUpdated(address indexed user);
    
    function setProfile(
        string calldata _name,
        string calldata _status,
        string[] calldata _credentials
    ) external {
        profiles[msg.sender] = Profile(_name, _status, _credentials);
        hasProfile[msg.sender] = true;
        emit ProfileUpdated(msg.sender);
    }
    
    function getProfile(address _user) external view returns (
        string memory name,
        string memory status,
        uint256 credentialCount
    ) {
        Profile storage p = profiles[_user];
        return (p.name, p.status, p.credentials.length);
    }
    
    function getCredential(address _user, uint256 _index) 
        external view returns (string memory) 
    {
        return profiles[_user].credentials[_index];
    }
}
```

#### 3. Reading Credentials by Index

Since Solidity cannot return dynamic arrays of strings directly, we use a pattern:

```javascript
// Step 1: Get profile with credential count
const [name, status, credCount] = await contract.getProfile(userAddress);

// Step 2: Fetch each credential by index
const credentials = [];
for (let i = 0; i < credCount.toNumber(); i++) {
    const cred = await contract.getCredential(userAddress, i);
    credentials.push(cred);
}

// Or use Promise.all for parallel fetching
const credPromises = [];
for (let i = 0; i < credCount.toNumber(); i++) {
    credPromises.push(contract.getCredential(userAddress, i));
}
const credentials = await Promise.all(credPromises);
```

---

### 🏗️ React Component Pattern

```
┌─────────────────────────────────────────────────────────────────┐
│                    IDENTITY VIEWER COMPONENTS                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    IdentityApp                           │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: searchAddress, profile, loading, error   │    │   │
│   │  │ Effects: Event subscription for ProfileUpdated  │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │ Search  │      │  Profile    │     │ Credential  │         │
│   │   Bar   │      │   Card      │     │    List     │         │
│   │         │      │             │     │             │         │
│   │ 0x____  │      │ 👤 Name     │     │ ✅ Cred 1   │         │
│   │[Search] │      │ 📋 Status   │     │ ✅ Cred 2   │         │
│   │         │      │             │     │ ✅ Cred 3   │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Complete Fetching Implementation

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

function IdentityViewer() {
    const [searchAddress, setSearchAddress] = useState("");
    const [profile, setProfile] = useState(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    const fetchProfile = async (address) => {
        // Validate address format
        if (!ethers.utils.isAddress(address)) {
            setError("Invalid Ethereum address");
            return;
        }

        setLoading(true);
        setError(null);

        try {
            const provider = new ethers.providers.JsonRpcProvider(
                process.env.REACT_APP_RPC_URL
            );
            const contract = new ethers.Contract(
                process.env.REACT_APP_IDENTITY_ADDRESS,
                IDENTITY_ABI,
                provider
            );

            // Check if profile exists
            const exists = await contract.hasProfile(address);
            if (!exists) {
                setError("No profile found for this address");
                setProfile(null);
                return;
            }

            // Fetch profile data
            const [name, status, credCount] = await contract.getProfile(address);

            // Fetch all credentials in parallel
            const credPromises = [];
            for (let i = 0; i < credCount.toNumber(); i++) {
                credPromises.push(contract.getCredential(address, i));
            }
            const credentials = await Promise.all(credPromises);

            setProfile({ name, status, credentials });

        } catch (err) {
            setError("Failed to fetch profile: " + err.message);
        } finally {
            setLoading(false);
        }
    };

    // Listen for profile updates
    useEffect(() => {
        if (!searchAddress || !ethers.utils.isAddress(searchAddress)) return;

        const provider = new ethers.providers.JsonRpcProvider(
            process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
            process.env.REACT_APP_IDENTITY_ADDRESS,
            IDENTITY_ABI,
            provider
        );

        const handleUpdate = (user) => {
            if (user.toLowerCase() === searchAddress.toLowerCase()) {
                fetchProfile(searchAddress);
            }
        };

        contract.on("ProfileUpdated", handleUpdate);
        return () => contract.off("ProfileUpdated", handleUpdate);
    }, [searchAddress]);

    // ... render UI
}
```

---

### 📊 Address Validation

Always validate Ethereum addresses before using them:

```javascript
import { ethers } from "ethers";

// Check if valid address format
ethers.utils.isAddress("0x1234...ABCD")  // true
ethers.utils.isAddress("invalid")         // false

// Normalize to checksum format
const checksummed = ethers.utils.getAddress("0xabcd...");
// Returns: "0xAbCd..." (with proper capitalization)

// Compare addresses (case-insensitive)
function addressesMatch(a, b) {
    return a.toLowerCase() === b.toLowerCase();
}
```

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Not validating address | Crashes on bad input | Use `ethers.utils.isAddress()` |
| Sequential credential fetches | Slow with many credentials | Use `Promise.all()` |
| Case-sensitive comparison | Misses matching addresses | Use `.toLowerCase()` |
| No "not found" handling | Confusing empty state | Check `hasProfile` first |
| Forgetting event cleanup | Memory leaks | Return cleanup in useEffect |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Search accepts valid Ethereum addresses only
- [ ] Invalid addresses show error message
- [ ] Profile displays name and status correctly
- [ ] All credentials render in the list
- [ ] "Not found" shows for unregistered addresses
- [ ] ProfileUpdated event triggers re-fetch
- [ ] Loading spinner shows during fetch
- [ ] Error messages are user-friendly
- [ ] Event listeners clean up on unmount

---

### 🔗 External Resources

| Resource | Link |
|----------|------|
| W3C DID Core | https://www.w3.org/TR/did-core/ |
| Ethereum Name Service (ENS) | https://docs.ens.domains/ |
| Ethers Address Utilities | https://docs.ethers.org/v5/api/utils/address/ |
| Self-Sovereign Identity | https://www.lifewithalacrity.com/2016/04/the-path-to-self-soverereign-identity.html |



---

## 🌟 Closing Story

At the consulate, Odessa clicked on "Search" to show her mentor's on-chain profile—"Juan dela Cruz", "OFW", credentials gleaming. The room buzzed: decentralized IDs for Pinoys worldwide. As cameras flashed, Odessa whispered, "Next up: on-chain auth and signed claims." ChainKilala was only the beginning of the Philippine Web3 identity revolution. Mabuhay! 🇵🇭🆔🔥