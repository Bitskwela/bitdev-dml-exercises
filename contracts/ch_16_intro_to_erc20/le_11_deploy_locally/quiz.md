# Lesson 11 Quiz: Deploy Locally

---
# Quiz 1
## Scenario: The Dress Rehearsal Barangay

Dan's WorkshopCredit compiles clean — green check, no errors — and yet nothing has happened. "Where does it actually *go*?" he asks JM. "Feeling ko I built a jeepney and it's just parked." JM's answer: compiling only checked the *shape*; the contract has to be **deployed** to become real.

**Question 1:** Dan's contract compiles with no errors. What is still missing, and what does deploying add?
A. Nothing — a green check means the contract is already live on a blockchain
B. Compiling only proves the code is well-formed; the contract doesn't exist on any chain until you **deploy** it, which creates a live instance that holds state at an address
C. Deploying just recompiles the code a second time for safety
D. He needs to buy real ETH before the code will compile

**Answer:** B
**Explanation:** A green check checks *shape*, not existence. Deploying sends the bytecode to a chain, where the contract becomes a live instance with its own address and starts holding state — it's the recipe finally being cooked.

---

**Question 2:** What is the **Remix VM**, and why is it the right place for a first deploy?
A. A real public Ethereum network where mistakes are permanent
B. A complete simulated blockchain running **entirely in your browser tab** — no internet, no wallet, no install, fake ETH — that resets on reload, making it a safe rehearsal room
C. A cloud server you must pay a monthly fee to use
D. A separate app you download and install before deploying

**Answer:** B
**Explanation:** The Remix VM is a disposable sandbox chain inside the browser. Reload and everything resets — contract, balances, gas. That disposability is exactly what makes it safe to experiment before touching a real network.

---

**Question 3:** In the Remix VM you get 15 accounts with 100 pretend ETH each. What does the **selected** account determine?
A. Nothing; the account dropdown is only decorative
B. It becomes the **`msg.sender`** of the next transaction — so whoever is selected at Deploy is the deployer, and (because the constructor mints to `msg.sender`) the holder of the whole starting supply
C. It sets the compiler version
D. It decides the token's name and symbol

**Answer:** B
**Explanation:** The selected account acts on the next transaction. Deploy while the instructor account is selected and that account both deploys the contract and receives all 1,000 minted WCR — letting you play instructor and students yourself.

---

# Quiz 2
## Scenario: "Gas? May bayad?"

Tita Malou spots the word *gas* on Dan's screen and braces for a scam: "Magbabayad ka ng gas?" Dan explains it's a practice room — the ETH is pretend, gas is free here but still measured — while the deploy receipt fills the terminal.

**Question 4:** What is the honest answer to Tita Malou's worry about paying gas on the Remix VM?
A. Yes, she's right — deploying always costs real pesos
B. The ETH here is pretend, so gas is effectively free; gas is just the counter that measures a transaction's computational work, and on the sandbox nobody pays anything real
C. Gas is a hidden subscription fee Remix charges monthly
D. There is no gas on any blockchain, ever

**Answer:** B
**Explanation:** Gas measures work and is paid in ETH — but on the Remix VM the ETH is fake, so it costs zero pesos. It's still *measured* (the deployer's balance ticks below 100), which is why learning to read the number now is practice for the real network later.

---

**Question 5:** After deploying, the instructor account holds all 1,000 WCR and every other account holds 0. Which line caused that?
A. The `import` line at the top of the file
B. `_mint(msg.sender, 1000 * 10 ** decimals())` in the constructor — it mints the full supply to whoever deployed (`msg.sender`), and nobody else has been sent any yet
C. The `pragma solidity ^0.8.20;` line
D. The Account dropdown, which pays out credits to whoever is selected

**Answer:** B
**Explanation:** The constructor mints the entire supply to `msg.sender`, the deployer. Kevin's account shows 0 not because of a bug but because no one has minted or transferred anything to him.

---

**Question 6:** The receipt shows a `from` address (`0x5B38…eddC4`) and a `contract address` (`0xd914…9138`). What's the difference?
A. They're two names for the same thing
B. The `from` is an **account address** — a wallet that holds ETH and signs transactions — while the `contract address` is where the **deployed contract's** code and state (all the WCR balances) live
C. The `from` is the contract and the `contract address` is the wallet
D. The contract address is just the account address with the last digits changed

**Answer:** B
**Explanation:** An account address belongs to a person/wallet; a contract address belongs to a deployed contract. Confusing the two is a classic beginner mistake — the receipt shows both precisely so you can tell who acted from where the code now lives.

---

**Question 7:** The lesson says "deploy once, call many times." Which of these is a **deploy**, and which pattern is right for the rest?
A. Every interaction is a fresh deploy, so you redeploy before each call
B. **Deploy** creates the instance one time (a gas-costing transaction that hands you a contract address); afterward you **call** it many times — reads are free, writes are new gas-costing transactions
C. Deploy and call are the same operation with different buttons
D. You call once and deploy many times

**Answer:** B
**Explanation:** Deploying births the contract exactly once. From then on you interact by calling the live instance at its address — free for reads, gas-costing for writes. Deploying again would create a whole separate contract, not edit the old one.

---
**Next:** Proceed to Lesson 11 exercises.
