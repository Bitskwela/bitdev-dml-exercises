## 🧑‍💻 Background Story

![ChainKilala Banner](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+15.0+-+COVER.png)

In a sunlit hall at the Filipino Consulate in San Francisco, Odessa ("Det") plugged her laptop into the projector. The banner read: **ChainKilala: Your On-Chain Profile, Dito Ka Kilala**. Filipino community leaders, students and OFWs leaned forward. "Dito, ikaw ang profile mo," Odessa smiled, unveiling a sleek UI that read profiles straight from the blockchain: name, status and credentials, with no central database to run.

![ChainKilala Demo](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+15.1.png)

Behind the scenes, Neri had deployed `ChainKilala` on Sepolia and set up profiles for a few attendees. As each visitor connected MetaMask, the page showed their profile. When Neri updated one on-chain, a `ProfileUpdated` event fired and the visitor's screen refreshed by itself.

Then a consulate officer asked the hard question: "So if someone writes 'NBI Clear' on their profile, is it verified?" Det answered honestly. "Not yet, po. Right now each person writes their own profile, and anyone in the world can read it. It is a public business card, not an ID. Verification needs a trusted issuer, and that is the next step." The officer nodded. Honest answers build more trust than big promises. 🇵🇭🆔🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

By the end of this lesson you can:

- read a profile that comes back as a **three-value tuple**, then read a list **item by item** using the count it reported,
- **subscribe to a contract event once** and remove the listener on cleanup, so reloads never stack up,
- explain honestly what on-chain identity data is (public and self-asserted) and what it is not (private or verified).

The activity grades the first two. The third keeps you from making promises your dApp cannot keep.

---

### 📐 What the Activity Builds

```
 useEffect (runs once)
 ├── provider + identity contract   (created ONCE)
 ├── load()                          (reads only)
 │     eth_requestAccounts → userAddress
 │     getProfile(userAddress)        → [name, status, count]
 │     getCredential(userAddress, i)  → one string per i < count
 ├── identity.on("ProfileUpdated", handler)   (subscribed ONCE)
 │     handler: if the event is for userAddress → load()
 ├── load()
 └── return cleanup → identity.off("ProfileUpdated", handler)
```

---

### 🔑 Key Concepts

#### 1. What on-chain identity data really is

Everything stored in a contract on a public chain can be read by anyone, forever. Marking a variable `private` in Solidity only stops *other contracts* from reading it; anyone can still read the raw storage from outside. And in this contract, **each user writes their own profile**, so nothing checks that it is true.

| Property      | What ChainKilala actually gives you                                  |
| ------------- | -------------------------------------------------------------------- |
| **Storage**   | Public blockchain, readable by anyone, kept permanently              |
| **Control**   | Only the wallet owner can write *their own* profile                  |
| **Privacy**   | None: every field is public                                          |
| **Truth**     | Self-asserted: the owner typed it, nobody verified it                |
| **Portability** | Any app can read it with just the address                          |

So treat an on-chain profile like a public business card, not a government ID. Two rules follow:

- **Never put personal data on-chain**: no birthdays, ID numbers, home addresses or phone numbers. In the Philippines, the Data Privacy Act (RA 10173) applies to personal data, and you cannot delete anything from a public chain.
- **Do not show self-asserted claims as verified.** A credential is only trustworthy if a trusted issuer signs or attests to it. Standards such as W3C Verifiable Credentials, and attestation systems such as the Ethereum Attestation Service, exist for that. They often keep the data off-chain and put only proofs or references on-chain.

#### 2. The contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChainKilala {
    struct Profile {
        string name;           // display name, typed by the owner
        string status;         // role or status, typed by the owner
        string[] credentials;  // claims, typed by the owner (nobody checks them)
    }

    mapping(address => Profile) private profiles;

    event ProfileUpdated(address indexed user);

    // Anyone can write their OWN profile, and nothing they write is verified
    function setProfile(
        string calldata _name,
        string calldata _status,
        string[] calldata _credentials
    ) external {
        Profile storage p = profiles[msg.sender];
        p.name = _name;
        p.status = _status;
        delete p.credentials;
        for (uint256 i = 0; i < _credentials.length; i++) {
            p.credentials.push(_credentials[i]);
        }
        emit ProfileUpdated(msg.sender);
    }

    function getProfile(address _user)
        external
        view
        returns (string memory name, string memory status, uint256 credentialCount)
    {
        Profile storage p = profiles[_user];
        return (p.name, p.status, p.credentials.length);
    }

    function getCredential(address _user, uint256 _index) external view returns (string memory) {
        return profiles[_user].credentials[_index];
    }

    // Also legal since Solidity 0.8 (ABI coder v2 is the default): return the whole list
    function getCredentials(address _user) external view returns (string[] memory) {
        return profiles[_user].credentials;
    }
}
```

#### 3. Count first, then one item per index

Solidity **can** return a whole `string[]` in one call (see `getCredentials` above; ABI coder v2 has been the default since Solidity 0.8.0). So why does the activity read one credential at a time?

- It matches the contract's public interface the app is given (`getProfile` + `getCredential`), the same count-then-index pattern you used for multisig proposals.
- Each call stays small and bounded. A single call returning a huge array can hit the RPC node's limits on how much a `view` call may compute or return.
- It is the same shape you need for public array getters, which always take an index.

```javascript
const [n, s, c] = await identity.getProfile(userAddress); // c is a bigint, e.g. 2n

const credList = [];
for (let i = 0; i < Number(c); i++) {
  credList.push(await identity.getCredential(userAddress, i));
}
```

If you control the contract and the list is short, `getCredentials(user)` in one call is a fine alternative in your own projects.

#### 4. Events: subscribe once, clean up always

A contract **event** is a log the contract writes when something happens. `ProfileUpdated(address indexed user)` says "this user's profile changed". In ethers v6 you listen with `contract.on(name, handler)` and stop with `contract.off(name, handler)`.

The classic bug is to subscribe **inside** the function that reloads:

```javascript
// ❌ Wrong: every reload adds ANOTHER listener
async function load() {
  // ...reads...
  identity.on("ProfileUpdated", load);
}
// event 1 → 2 listeners → event 2 triggers 2 reloads → 4 listeners → 8 reloads...
```

The fix is structural. Subscribe once in the effect body, and return the cleanup **from the effect**, because React only runs a cleanup that the effect itself returns:

```javascript
useEffect(() => {
  const identity = new ethers.Contract(CONTRACT, ABI, provider); // created once
  async function load() { /* reads only */ }

  function handleProfileUpdated(user) { /* if it is ours → load() */ }
  identity.on("ProfileUpdated", handleProfileUpdated); // once

  load();

  return () => {
    identity.off("ProfileUpdated", handleProfileUpdated); // same contract, same handler
  };
}, []);
```

Why the handler needs a name: `off` removes a listener by matching the **same function** you gave to `on`. An inline arrow function written twice is two different functions, so `off` would remove nothing.

Why compare addresses lower-cased: the same address can appear in checksum form (`0xAbC…`) or all lower-case (`0xabc…`). `user.toLowerCase() === userAddress.toLowerCase()` treats them as equal.

#### 5. Why a wallet here

In the Gas Fee Checker lesson you read public data with `JsonRpcProvider` and no wallet. The profile data here is public too, so a `JsonRpcProvider` could read anyone's profile given an address. This page is "**your** profile", though, so it needs to know which address is yours, and `eth_requestAccounts` through MetaMask answers that. If you built a "look up any address" page instead, you would use `JsonRpcProvider` plus an address input validated with `ethers.isAddress`.

---

### ⚠️ Common Mistakes

| Mistake                                      | Problem                                          | Solution                                                |
| -------------------------------------------- | ------------------------------------------------ | ------------------------------------------------------- |
| Subscribing inside `load()`                  | Listeners and reloads double with every event    | Subscribe once in the effect body                       |
| Returning the cleanup from `load()`          | React never runs it; the listener leaks          | `return () => identity.off(...)` at the end of the effect |
| Inline arrow handler                         | `off` cannot match it, so nothing is removed     | Name the handler and pass the same one to `on` and `off` |
| Destructuring only two tuple values          | The credential count is lost                     | `const [n, s, c] = await identity.getProfile(addr)`    |
| Calling the data "verified" or "private"     | Misleads users; it is public and self-asserted   | Say what it is; use attestations for real verification |
| Storing personal data on-chain               | Public forever; privacy-law risk                 | Keep personal data off-chain                            |

---

### ✅ How This Is Graded

The grader runs your component with ethers v6 against a mock Sepolia ChainKilala contract and a mock MetaMask. It checks that you request the account, read the profile for that address, render the name, status and both credentials (reading exactly two), subscribe to `ProfileUpdated`, reload exactly once per event (three profile reads after two events), call `off` on unmount, and leave the loading state. The activity page lists every detail.

---

### 🔗 External Resources

| Resource                               | Link                                                                 |
| -------------------------------------- | -------------------------------------------------------------------- |
| ethers v6: Contract events (`on`/`off`) | https://docs.ethers.org/v6/api/contract/                            |
| React: effects and cleanup             | https://react.dev/learn/synchronizing-with-effects                   |
| Solidity: ABI coder v2 (`pragma abicoder`) | https://docs.soliditylang.org/en/latest/layout-of-source-files.html#abi-coder-pragma |
| W3C Verifiable Credentials             | https://www.w3.org/TR/vc-data-model-2.0/                             |
| Ethereum Attestation Service           | https://attest.org/                                                  |
| Data Privacy Act of 2012 (RA 10173)    | https://privacy.gov.ph/data-privacy-act/                             |

---

## 🌟 Closing Story

After the demo, Neri changed one visitor's status on-chain, and the visitor's screen updated once, cleanly, without flickering through a pile of duplicate reloads. The consulate officers were impressed, but what stayed with them was Det's honesty: "This is a public profile you write yourself. Real verification comes next, from trusted issuers." They asked to talk about a pilot with verified attestations. Odessa grinned: "One step at a time." Mabuhay ChainKilala! 🇵🇭🆔🚀
