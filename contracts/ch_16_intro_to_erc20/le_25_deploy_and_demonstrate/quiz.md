# Lesson 25 Quiz: Deploy and Demonstrate

---
# Quiz 1
## Scenario: Off the Sandbox

Dan's contracts passed every test — but on the Remix VM, a sandbox inside his browser tab that vanishes when he closes it. For graduation he redeploys the *exact same* WorkshopCredit and RewardStore to Sepolia so Kevin and Tita Malou can read the ledger on their own phones.

**Question 1:** What is the core difference between the Remix VM and Sepolia?
A. The Remix VM runs newer Solidity than Sepolia
B. The Remix VM is a private fake blockchain inside your browser tab that disappears at tab-close; Sepolia is a real, public network held by thousands of nodes that anyone can read, permanently
C. Sepolia is faster and free; the Remix VM costs real money
D. There is no difference — both are the same network

**Answer:** B
**Explanation:** The VM was training wheels: private, instant, gone when you close the tab. Sepolia is a shared public ledger — the same machinery, but now readable by Kevin, Tita Malou, and anyone with the link.

---

**Question 2:** Why is a **testnet** like Sepolia — not mainnet — the right home for WCR?
A. Mainnet doesn't support ERC-20 tokens
B. Sepolia's ETH is free test ETH with no monetary value, so WCR gets a real, public, permanent, verifiable ledger with none of the speculation Tita Malou feared — nothing to buy, sell, or "moon"
C. Testnets are more secure than mainnet
D. Deploying to mainnet is illegal for students

**Answer:** B
**Explanation:** WCR was never money. A testnet gives Dan everything he wants — public, permanent, verifiable — and none of what makes "token" sound like a scam. Free test ETH keeps the mechanism real and the stakes honest.

---

**Question 3:** In the deploy-to-Sepolia flow, what is MetaMask's job?
A. It compiles the Solidity source code
B. It holds your account and **signs** transactions, acting as the bridge that lets Remix deploy to Sepolia via "Injected Provider – MetaMask" — nobody moves your credits without your key
C. It provides free test ETH directly
D. It stores the contract's total supply

**Answer:** B
**Explanation:** MetaMask holds the account (address + private key) and signs each transaction. Remix routes deploys and calls through it onto Sepolia. Your key is the whole security model — which is why you never share your seed phrase.

---

# Quiz 2
## Scenario: The Graduation Loop, On-Chain

Kevin earns 200 WCR, approves the store for 100, and calls `buyItem(0)`. The store pulls his 100 credits with `transferFrom` and burns them. Dan turns his phone to Tita Malou, showing `sepolia.etherscan.io`.

**Question 4:** On Etherscan, the `buyItem` transaction shows three Logs, one of which is a `Transfer` to `0x0000...0000`. What does that middle event represent?
A. Kevin accidentally sent credits to a stranger
B. The **burn** — destroyed tokens show on any block explorer as a transfer to the null (zero) address, which is why `totalSupply` dropped from 1,200 to 1,100
C. A refund of Kevin's credits
D. The store keeping the 100 WCR for itself

**Answer:** B
**Explanation:** A burn is recorded as a `Transfer` to `0x0000...0000`. The credit didn't move to a wallet — it left circulation, so the supply honestly reads 1,100 WCR: the ledger telling the true story of credits spent.

---

**Question 5:** Reading the ledger on Etherscan (`balanceOf`, `totalSupply`, the Holders tab) — does that cost gas?
A. Yes, every read costs gas just like a write
B. No — you pay gas only for transactions that **change state** (deploy, mint, transfer, approve, buy); reading is free forever, on Sepolia exactly as on mainnet
C. Reading costs gas only on mainnet
D. Reading is free only if the contract is verified

**Answer:** B
**Explanation:** You pay to write, never to read. Deploy, reward, approve, and buy cost (test) ETH; balances, supply, and allowances are free to read. The mechanism is identical to mainnet — only the ETH is free.

---

**Question 6:** When Dan hands Tita Malou the Etherscan URL instead of promising the numbers are honest, what has fundamentally changed since the Lesson 1 notebook?
A. Nothing — she still has to trust Dan's word
B. Trust no longer depends on Dan; the ledger is public and Dan cannot edit it, so "trust me" becomes "read it yourself" — anyone with the link can verify every credit that ever moved
C. The credits are now worth real pesos
D. Only Dan can read the Etherscan page

**Answer:** B
**Explanation:** The finale's whole point: the smudged notebook needed Dan to be trustworthy; the ledger needs nobody to be. He hands over a URL to a page he doesn't own and can't change, and lets the ledger speak.

---

**Question 7:** A faucet page asks for your Secret Recovery Phrase "to send your test ETH faster." What should you do?
A. Paste it — faucets need it to deliver ETH
B. Refuse — no faucet, support agent, or app ever needs your seed phrase or private key; anyone asking is trying to steal your account, and MetaMask itself never asks
C. Share only the first half of the phrase
D. Share it, since testnet ETH is worthless anyway

**Answer:** B
**Explanation:** Your key is the whole security model. Nobody moves your credits without it, so nobody legitimate ever asks for your seed phrase. This is exactly the scam Tita Malou feared — and the defense is that the key never leaves your hands.

---
**Next:** Proceed to Lesson 25 exercises.
