## 🧑‍💻 Background Story

In a sunlit hall at the Filipino Consulate in San Francisco, Odessa ("Det") plugged her laptop into the projector. The banner read: **ChainKilala – Your On-Chain Identity, Dito Ka Kilala**. Filipino community leaders, students, and OFWs leaned forward. "Dito, ikaw ang profile mo," Odessa smiled, unveiling a sleek UI that read on-chain profiles: name, status, and credentials—no centralized database needed.

Behind the scenes, Neri had deployed `ChainKilala.sol` on a Sepolia testnet and pre-registered profiles for several attendees. As each visitor connected MetaMask, the UI fetched their DID-style data: "Elias", "Student", credentials like "NBI Clear" or "OFW ID". When profiles updated on-chain, a `ProfileUpdated` event fired and the browser refreshed automatically.

In under 30 minutes, Det had demonstrated decentralized identity to a room full of Pinoys far from home. No more paper forms at consulates—just code, wallets, and pride. After the demo, consulate officials asked about integration with PhilSys. Odessa grinned: "One step at a time. Next, we'll bridge real-world IDs on-chain." Mabuhay ChainKilala! 🇵🇭🆔🚀

---

## 📚 Theory & Web3 Lecture

1. DID-Style Profiles on-Chain

   - Store user profiles in a mapping: `mapping(address => Profile)`.
   - `struct Profile { string name; string status; uint256 credCount; }`
   - Credentials stored separately by index.

2. Solidity Contract Functions & Events

   - `function setProfile(string calldata name, string calldata status, string[] calldata creds) external`
   - `function getProfile(address user) external view returns (string name, string status, uint256 credCount)`
   - `function getCredential(address user, uint256 idx) external view returns (string cred)`
   - `event ProfileUpdated(address indexed user)` for frontend reactivity.

3. Ethers.js Integration

   - **Provider** (read-only):
     ```js
     const provider = new ethers.providers.JsonRpcProvider(
       process.env.REACT_APP_RPC_URL
     );
     ```
   - **Contract Instance**:
     ```js
     const identity = new ethers.Contract(
       process.env.REACT_APP_IDENTITY_ADDRESS,
       IDENTITY_ABI,
       provider
     );
     ```
   - **Reading Data**:
     ```js
     const [name, status, count] = await identity.getProfile(addr);
     const creds = [];
     for (let i = 0; i < count.toNumber(); i++) {
       creds.push(await identity.getCredential(addr, i));
     }
     ```
   - **Listening to Events**:
     ```js
     identity.on("ProfileUpdated", (user) => {
       if (user.toLowerCase() === addr.toLowerCase()) {
         // re-fetch profile
       }
     });
     ```

4. React Hooks & State

   - `useState` for `name`, `status`, `creds`, `loading`, `error`.
   - `useEffect` on mount (and on `selectedAddress`) to fetch data and subscribe to events.
   - Clean up listeners on unmount to prevent memory leaks.

5. Best Practices
   - Validate Ethereum addresses with `ethers.utils.isAddress()`.
   - Wrap on-chain calls in `try/catch` and show user-friendly messages.
   - Store `RPC_URL` & `IDENTITY_ADDRESS` in `.env`.
   - Keep UI responsive: show spinners while loading.

🔗 Further Reading

- Ethers.js: https://docs.ethers.org
- Solidity Events: https://docs.soliditylang.org
- DID Concepts: https://w3c.github.io/did-core

---

## 🌟 Closing Story

At the consulate, Odessa clicked on "Search" to show her mentor's on-chain profile—"Juan dela Cruz", "OFW", credentials gleaming. The room buzzed: decentralized IDs for Pinoys worldwide. As cameras flashed, Odessa whispered, "Next up: on-chain auth and signed claims." ChainKilala was only the beginning of the Philippine Web3 identity revolution. Mabuhay! 🇵🇭🆔🔥