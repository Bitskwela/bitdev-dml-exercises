# Deploy WCR to Sepolia and Run the Graduation Loop

There is **no new contract code** — `act_1.sol` (WorkshopCredit) and `RewardStore.sol` are the finished, tested contracts. Your job is to take them off the Remix sandbox and onto a real public testnet, then run the earn → approve → redeem loop end to end and read every step on Etherscan. Work the tasks in order.

## Task 1: Install MetaMask, Switch to Sepolia, Get Test ETH

1. Go to **https://metamask.io**, install the browser extension, and create a wallet. Write your **Secret Recovery Phrase** on paper and keep it offline. **Never share your seed phrase or private key with anyone — not a "faucet," not a "support agent," not Dan.** MetaMask will never ask for it. This is the exact scam Tita Malou feared; the defense is that nobody moves your credits without your key.
2. Open MetaMask → the network dropdown → enable **"Show test networks"** in Settings if needed → select **Sepolia**. Copy your account's `0x...` address.
3. Open a Sepolia faucet (search "Sepolia faucet" — Google Cloud, Alchemy, and Infura each run one). Paste your address, complete the check, and wait a minute. MetaMask should show a small SepoliaETH balance.
4. The loop needs **two** accounts: the **instructor** (deploys and owns both contracts) and **Kevin** the student (approves, buys). In MetaMask, click your avatar → **Add account** to make a second one, and fund **both** with a little test ETH — Kevin needs gas to `approve` and `buyItem`.

## Task 2: Point Remix at MetaMask

In Remix → **Deploy & Run Transactions** → the **Environment** dropdown → choose **"Injected Provider – MetaMask."** MetaMask pops up asking to connect — approve it. Confirm the **ACCOUNT** field now shows your MetaMask address and the network reads Sepolia (chain id `11155111`). Compile both `act_1.sol` and `RewardStore.sol` with Solidity `0.8.20` or newer.

## Task 3: Deploy Both Contracts and List the Turon

With the **instructor** account active:

1. Select `WorkshopCredit` → **Deploy**. MetaMask shows a *real* gas estimate now — Confirm, then wait for the block. Copy the deployed contract address from "Deployed Contracts."
2. Select `RewardStore`, paste the WCR address into the `creditToken` constructor field → **Deploy** → Confirm. New address.
3. On the store, call `addItem` with name `Turon` and price `100000000000000000000` (`100 * 10**18`). Confirm. `itemCount()` now returns `1`.

## Task 4: Run the Graduation Loop

1. **Reward Kevin (instructor).** On the WCR instance, `rewardStudent(Kevin's address, 200000000000000000000, "Finished final exercise")`. Confirm. Kevin's `balanceOf` is now 200 WCR; `totalSupply` is 1,200 WCR.
2. **Switch to Kevin.** In MetaMask, switch the active account to Kevin. Remix's `ACCOUNT` field follows it — from now on `msg.sender` is Kevin.
3. **Kevin approves the store.** On the **WCR** instance, `approve(RewardStore address, 100000000000000000000)`. Confirm. `allowance(Kevin, store)` reads 100 WCR — no credits have moved, this is only permission.
4. **Kevin buys the turon.** On the **RewardStore** instance, `buyItem(0)`. Confirm. In one transaction the store pulls 100 WCR (`transferFrom`) **and burns it** (`credit.burn`). Re-read the numbers: Kevin 100 WCR, store 0, `totalSupply` 1,100. The credit didn't move to a wallet — it ceased to exist.

## Task 5: Read the Ledger on Sepolia Etherscan

Open **https://sepolia.etherscan.io** and paste the **WCR contract address**. Etherscan auto-detects the ERC-20 and builds a **token page** — `Max Total Supply 1,100 WCR`, `Holders 2`. Open the **Holders** tab, then open the **buyItem transaction** and scroll to **Logs** — the decoded events, the ledger's own receipt. Read the three lines like Tita Malou did: Kevin paid the store 100 WCR; the store sent that 100 to `0x0000...0000` (the burn); `ItemPurchased` records what was bought and by whom. Open the earlier `rewardStudent` transaction and its Logs carry `StudentRewarded(... reason: "Finished final exercise")` — the *why*, on-chain, forever.

Optionally **verify** the contract (Etherscan's "Verify & Publish", or Remix's Etherscan plugin — needs your API key, exact compiler `0.8.20`, and matching optimization). Once verified, a green check appears and anyone can call the blue read functions from the browser, no Remix needed.

## Sample Output

The `buyItem` transaction's decoded Logs on Sepolia Etherscan:

```text
Transaction Action:  Transfer 100 WCR From 0x2b19...4D7e To 0x3D5b...9A70

Logs (3)
- Transfer(from: 0x2b19...4D7e, to: 0x3D5b...9A70, value: 100000000000000000000)
- Transfer(from: 0x3D5b...9A70, to: 0x0000...0000, value: 100000000000000000000)
- ItemPurchased(id: 0, buyer: 0x2b19...4D7e, price: 100000000000000000000)
```

And the token page's Holders tab after the burn:

```text
Rank  Address            Quantity        Percentage
1     0x7A3f...9C21       1,000 WCR       90.9091%     (instructor)
2     0x2b19...4D7e         100 WCR        9.0909%     (Kevin)
```

The middle `Transfer` — to `0x0000...0000` — is the burn: destroyed tokens show on any explorer as a transfer to the null address.

## Reflection Questions

1. Every green row you deployed on the Remix VM last lesson was private and gone at tab-close. What does moving the *same* contracts to Sepolia change about who can trust the ledger — and why does that matter more than any code change?
2. Sepolia's ETH has no monetary value and nobody buys WCR. In what specific sense is deploying to a testnet the *complete* answer to Tita Malou's "scam yan" from Lesson 1?
3. On Etherscan, the burn appears as a `Transfer` to `0x0000...0000` and the supply reads 1,100. If a burn is "destroying" tokens, why is it recorded as a transfer at all — and how does that keep the ledger honest?

## Challenge

**Challenge A — Your own live loop on Sepolia.** Deploy both contracts to Sepolia through MetaMask with two of your own accounts and run the complete loop: deploy WCR and RewardStore(WCR address), `addItem("Turon", 100 * 10**18)`; from the owner `rewardStudent(student, 200 * 10**18, "Finished final exercise")`; from the student `approve(store, 100 * 10**18)` then `buyItem(0)`; then open the token page and the `buyItem` transaction's Logs on `sepolia.etherscan.io`. Submit your **WCR address**, your **RewardStore address**, and a **link** to the `buyItem` transaction. After the burn the token page must read Total Supply 1,100 WCR and the Logs must contain exactly three events — two `Transfer` (one to `0x0000...0000`) and one `ItemPurchased`.

**Challenge B — The three-sentence pitch.** A sponsor asks Dan, *"Bakit blockchain? Bakit hindi na lang Excel?"* Write the three-sentence pitch you'd give: (1) what WCR *is*, in Tita Malou's terms, not a coder's; (2) why it's on a public ledger instead of a spreadsheet; and (3) one concrete thing this system does that a spreadsheet on Dan's laptop cannot. Push sentence (3) to something only a public, tamper-evident ledger gives you — if your answer could also be true of a shared Google Sheet, ask yourself who can secretly edit a Google Sheet, and who can secretly edit Sepolia.

## What You've Learned

- **Deploying to Sepolia turns a private rehearsal into a public ledger** — the same contracts, now readable by anyone on Earth with the link, permanent past any browser tab.
- **MetaMask signs; your key is the security model** — Remix reaches Sepolia through "Injected Provider – MetaMask," and no one moves your credits without your key.
- **You pay gas to write and nothing to read** — deploy, reward, approve, and buy cost test ETH; balances and allowances are free to read, on Sepolia exactly as on mainnet.
- **The deliverable was never the code — it was the URL you can hand someone** — Etherscan showing Kevin's reward, his purchase, and the burn, so trust stops depending on Dan's word.
