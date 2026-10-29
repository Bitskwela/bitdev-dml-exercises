## 🧑‍💻 Background Story

![Typhoon Relief](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+14.0+-+COVER.png)

A week after Typhoon Ulysses swept through Cagayan Valley, Odessa ("Det") sat in her BGC co-working nook, watching relief convoys slow to a crawl. "What if donations released automatically when a storm crossed a threshold?" she mused. Neri grinned: "Let's simulate an oracle feeding wind-speed data on-chain."

By midnight they had `TyphoonReliefChain` deployed on Sepolia. It holds a donation pool and a threshold wind speed. When the oracle reports a reading at or above that threshold, the contract sends the whole pool to the barangay relief fund.

The app has three widgets:

1. **Stats**: current wind speed, pool balance, and release status.
2. **Donate**: supporters send ETH to the pool.
3. **Oracle Feed**: simulates a weather service by sending a new wind speed on-chain.

"Stats first," Neri said. "Kapag mali ang status, walang maniniwala sa iba." If the panel ever says "Pending" after the money has gone out, nobody will trust the rest. That panel is your activity.

![Typhoon Relief DApp](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+14.1.png)

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

By the end of this lesson you can **build a stats panel for an oracle-driven contract**: read several values in parallel, read a contract's ETH balance from the provider, and render a status that always reflects the on-chain flag.

That is what the activity grades. You will also learn what an oracle is and how the relief contract decides to release funds, so you know what your panel is showing. The Donate and Oracle Feed widgets are previewed at the end but **not** graded.

---

### 📐 Oracle-Triggered Relief Flow

```
 OFF-CHAIN                         ON-CHAIN: TyphoonReliefChain
 ┌──────────────┐  updateWeather   ┌────────────────────────────────┐
 │ Weather data │ ───────────────▶ │ windSpeed = 185 km/h           │
 │ (oracle)     │   (185)          │ threshold = 100 km/h           │
 └──────────────┘                  │ pool = contract's ETH balance  │
                                   │ 185 ≥ 100 and not released?    │
                                   │   → released = true            │
                                   │   → send pool to barangay      │
                                   └───────────────┬────────────────┘
                                                   │ windSpeed(), released(),
                                                   │ getBalance(contract)
                                                   ▼
                                        ┌──────────────────────┐
                                        │ ReliefStats panel    │  ← this activity
                                        └──────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. The oracle problem

A smart contract can only see what is already on the blockchain. It cannot call a weather API, read a sensor, or check a website.

| Capability       | Smart contract | Oracle |
| ---------------- | -------------- | ------ |
| Read blockchain  | ✅             | ✅     |
| Write blockchain | ✅             | ✅     |
| HTTP requests    | ❌             | ✅     |
| Read sensors     | ❌             | ✅     |

An **oracle** is the bridge: an off-chain service that reads real-world data and writes it into a contract with a transaction. In production you would use a decentralized oracle network such as **Chainlink**, where many independent nodes report and the contract uses an aggregated value. Here we **simulate** the oracle with a single trusted address.

#### 2. The relief contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TyphoonReliefChain {
    address public immutable oracle;      // the only address allowed to report weather
    address public immutable beneficiary; // the barangay relief fund
    uint256 public immutable threshold;   // trigger point, in km/h
    uint256 public windSpeed;             // latest reading, in km/h
    bool public released;                 // has the pool been sent?

    event Donated(address indexed donor, uint256 amount);
    event DataUpdated(uint256 speed);
    event Released(address indexed to, uint256 amount);

    constructor(address _oracle, address _beneficiary, uint256 _threshold) {
        oracle = _oracle;
        beneficiary = _beneficiary;
        threshold = _threshold;
    }

    // Anyone can donate to the relief pool
    function donate() external payable {
        require(msg.value > 0, "Must send ETH");
        emit Donated(msg.sender, msg.value);
    }

    // Only the oracle may report weather; otherwise anyone could fake a typhoon
    function updateWeather(uint256 _speed) external {
        require(msg.sender == oracle, "Only the oracle");
        windSpeed = _speed;
        emit DataUpdated(_speed);

        if (_speed >= threshold && !released && address(this).balance > 0) {
            released = true; // effects before the external call
            uint256 amount = address(this).balance;
            (bool ok, ) = payable(beneficiary).call{value: amount}("");
            require(ok, "Transfer failed");
            emit Released(beneficiary, amount);
        }
    }
}
```

Three design choices worth noticing:

- **`require(msg.sender == oracle)`**: without it, anyone could call `updateWeather(999)` and trigger the release. Who is allowed to report data is the most important security question in any oracle design.
- **`released = true` before sending**: checks-effects-interactions, the same habit you learned in the reentrancy lessons.
- **No `balance` variable**: the pool is simply the contract's own ETH balance, `address(this).balance`. That is why the frontend reads it from the provider (next section). Donations that arrive *after* a release stay in the pool, so the balance can be above zero even when `released` is `true`.

#### 3. Contract variables vs chain state

| What you want         | Where it lives                | How the frontend reads it                |
| --------------------- | ----------------------------- | ---------------------------------------- |
| Wind speed            | Contract storage (`windSpeed`) | `await relief.windSpeed()`              |
| Release flag          | Contract storage (`released`)  | `await relief.released()`               |
| ETH in the pool       | The chain's account balance    | `await provider.getBalance(CONTRACT)`   |

Public state variables get automatic getter functions, so `windSpeed()` and `released()` exist even though the contract never writes them as functions. An address's ETH balance is not stored in any contract variable; the chain tracks it for every account, and the provider exposes it with `getBalance(address)`.

#### 4. Parallel reads with `Promise.all`

```javascript
const [ws, rel] = await Promise.all([relief.windSpeed(), relief.released()]);
// ws  = 185n (bigint)
// rel = true
```

Awaiting one read after another waits for two network round-trips. `Promise.all` starts both at once and resolves when both have finished, with results in the order you listed them.

#### 5. Status from the flag, not from hope

```jsx
<strong>{released ? "✅ Funds Dispatched" : "❌ Pending"}</strong>
```

The status must be **computed** from `released`. Text written by hand, like a fixed "Pending", looks right on the day you write it and becomes a lie the moment the oracle fires. During a typhoon, a lie in a relief dashboard costs trust you cannot buy back.

---

### ➕ Preview: The Write Widgets (not graded)

Writes need a signer. In ethers v6, `getSigner()` is `async`:

```javascript
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const relief = new ethers.Contract(CONTRACT, RELIEF_ABI, signer);

// Donate widget: send 0.1 ETH to the pool
const tx = await relief.donate({ value: ethers.parseEther("0.1") });
await tx.wait();

// Oracle Feed widget (only works from the oracle's address)
const tx2 = await relief.updateWeather(120);
await tx2.wait();
```

To refresh the panel when funds are released, subscribe once and unsubscribe on cleanup:

```javascript
useEffect(() => {
  const onReleased = () => loadStats();
  relief.on("Released", onReleased);
  return () => {
    relief.off("Released", onReleased);
  };
}, [relief]);
```

---

### 📊 Simulated vs Production Oracle

| Aspect      | Simulated (this lesson)       | Production (e.g. Chainlink)              |
| ----------- | ----------------------------- | ---------------------------------------- |
| Data source | One trusted address           | Many independent nodes                   |
| Trust model | You trust the oracle operator | Aggregated reports, no single reporter  |
| Cost        | Just gas                      | Gas plus the oracle network's fees       |
| Use case    | Learning, prototyping         | Real money, real decisions               |

---

### ⚠️ Common Mistakes

| Mistake                                 | Problem                                  | Solution                                      |
| --------------------------------------- | ---------------------------------------- | --------------------------------------------- |
| `getBalance` on the user's address      | Shows the donor's wallet, not the pool   | `provider.getBalance(CONTRACT)`               |
| Hardcoded "Pending" status              | Wrong as soon as funds are released      | `released ? "✅ Funds Dispatched" : "❌ Pending"` |
| Showing raw wei                         | 19 digits nobody can read                | `ethers.formatEther(bal)`                     |
| `updateWeather` with no access control  | Anyone can fake a typhoon and drain the pool | `require(msg.sender == oracle)`           |
| Forgetting `await tx.wait()` on writes  | UI refreshes before the change is mined  | Wait for the receipt first                    |

---

### ✅ How This Is Graded

The grader runs your component with ethers v6 against a mock Sepolia relief contract (wind speed 185, `released` true, pool 3.25 ETH). It checks that you read both values, call `provider.getBalance` with the contract's address, show 185 and 3.25 (never the raw wei), say the funds were dispatched or released, and do **not** still say "Pending" anywhere. The activity page lists every detail, including how to phrase a Filipino status.

---

### 🔗 External Resources

| Resource                   | Link                                                                 |
| -------------------------- | -------------------------------------------------------------------- |
| Chainlink Data Feeds       | https://docs.chain.link/data-feeds                                   |
| ethers v6: Providers       | https://docs.ethers.org/v6/api/providers/                            |
| ethers v6: Contracts       | https://docs.ethers.org/v6/api/contract/                             |
| MDN: `Promise.all`         | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all |
| Solidity security considerations | https://docs.soliditylang.org/en/latest/security-considerations.html |

---

## 🌟 Closing Story

At 2 a.m. the oracle reported 185 km/h. Within one block, `released` flipped to `true`. In Cagayan, the barangay captain refreshed the stats panel on his phone, and "❌ Pending" had become "✅ Funds Dispatched", with the pool balance read straight from the chain. Over cups of taho, Det and Neri toasted: next comes a real Chainlink feed, but tonight the panel told the truth. Bayanihan, on-chain. 🇵🇭🌪️🚀
