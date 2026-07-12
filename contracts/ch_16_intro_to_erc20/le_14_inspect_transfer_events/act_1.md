# Read the Receipts Your Token Leaves

Your token already emits a `Transfer` event on every move — you inherited it and never wrote a line of it. In this activity you'll add one event of your own, fire a transfer that leaves **two** receipts on the log, then crack open the transaction and read them field by field — decoded *and* raw. Open `act_1.sol` and work the TODOs in order.

## Task 1: Declare Your Own Event

Above the constructor, declare `event CreditsAwarded(address indexed to, uint256 amount, string note);`. Mark `to` as `indexed` so a reader can filter "every award to Kevin" — the same reason the inherited `Transfer` indexes its `from` and `to`. `amount` and `note` are not indexed, so they ride in the log's `data` blob. This declaration only describes the *shape* of the receipt; nothing is written until you `emit` it.

## Task 2: Fire a Transfer and Your Note in One Call

Fill in `awardWithNote(address to, uint256 amount, string calldata note)`:

1. Call `transfer(to, amount)` — this moves the credits and automatically fires the inherited `Transfer` event.
2. Then `emit CreditsAwarded(to, amount, note)` — your extra receipt, carrying the *reason* the credits moved.

One call, two log entries: `Transfer` records *who* and *how much*; `CreditsAwarded` records *why*. Note `awardWithNote` spends the *caller's* own balance, so call it from the instructor account.

## Task 3: Deploy and Read the Decoded Transfer Event

Compile (Ctrl+S) and, on **Remix VM (Cancun)** with the instructor account selected, click **Deploy**. Call `awardWithNote` with `to` = Kevin's address `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2`, `amount` = `100000000000000000000` (100 WCR), and `note` = `"linked-list exercise, week 3"`. Expand the successful transaction and open its **`logs`** field. Remix shows you the decoded `Transfer` event *and* your `CreditsAwarded` event, side by side.

## Task 4: Drop to the Raw Topics and Data

That decoded view is a convenience. Underneath, the actual `Transfer` log the EVM stored is just topics and data. Find the raw form in the receipt: `topics[0]` is the signature hash, `topics[1]` and `topics[2]` are `from` and `to` lowercased and left-padded to 32 bytes, and `data` is `value` in hex. Confirm for yourself that decoding is nothing more than un-padding the topics and converting the data from hex — exactly what Remix (and Etherscan) did for you.

## Task 5: Find the Transfer You Never Called

Scroll up to the **deployment** transaction and expand *its* `logs`. There's a `Transfer` event there too — and you never called `transfer`. That's your constructor's `_mint`, modeled as a **Transfer from the zero address** (`0x0000...0000`). Read its `from`, `to`, and `value`, and confirm the value is `1000 * 10**18`.

## Sample Output

Expanding the `awardWithNote` transaction's `logs` (Remix decodes both events):

```json
[
	{
		"topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
		"event": "Transfer",
		"args": {
			"from": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
			"to": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
			"value": "100000000000000000000"
		}
	},
	{
		"event": "CreditsAwarded",
		"args": {
			"to": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
			"amount": "100000000000000000000",
			"note": "linked-list exercise, week 3"
		}
	}
]
```

The same `Transfer`, underneath, as the raw log the EVM actually stored:

```text
topics:
  [0]  0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   <- "this is a Transfer"
  [1]  0x0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4   <- from  (instructor)
  [2]  0x000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb2   <- to    (Kevin)
data:
  0x0000000000000000000000000000000000000000000000056bc75e2d63100000       <- value (100 * 10**18)
```

The `Transfer` hiding in the **deployment** transaction — the mint you never called `transfer` for:

```json
[
	{
		"event": "Transfer",
		"args": {
			"from": "0x0000000000000000000000000000000000000000",
			"to": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
			"value": "1000000000000000000000"
		}
	}
]
```

## Reflection Questions

1. The `Transfer` event already records `from`, `to`, and `value`. What does your `CreditsAwarded` event add that `Transfer` can never carry — and why is that worth an extra log entry?
2. You marked `to` as `indexed` but left `amount` and `note` un-indexed. Using the rule "topics are searchable, data is not," explain why that split is the right choice for how someone would actually query these awards.
3. Minting shows up as a `Transfer` *from* the zero address. Why is it useful that a token's entire life — every credit born, moved, and later burned — rides on one single event type instead of separate `Mint`/`Burn`/`Transfer` events?

## Challenge: Read the Ledger's Receipts

**Challenge A — Convert a value back to human WCR by eye.** Expand your `awardWithNote` transaction and locate the three fields inside the `Transfer` event's `args`: `from`, `to`, and `value`. Write each down, then convert `value` back to human WCR by dividing by `10 ** 18`. State which account sent it and which received it, in plain words, as if explaining it to Tita Malou.

**Challenge B — Count the mints, and ask why the zero address.** Before looking, predict how many `Transfer` events your constructor's `_mint` emitted when you deployed. Verify by expanding the deployment transaction. Then answer, in your own words: why does OpenZeppelin model minting as a `Transfer` *from* `address(0)` (and burning as a `Transfer` *to* it) instead of inventing separate `Mint` and `Burn` events?

## What You've Learned

- **An event is a receipt the transaction writes itself** — permanent, public, and readable by anyone, which is exactly what Dan's notebook could never be.
- **`Transfer` is inherited and automatic**; every mint and transfer fires it, and you can add your own events with `event` + `emit` to record extra context like a reason `note`.
- **`indexed` fields become searchable topics; everything else lands in `data`** — you index the *who*, not the *how much*.
- **Decoding is just un-padding topics and converting data from hex**; a block explorer's "Transfers" tab is nothing but a token's full `Transfer` event history, rendered for humans.
