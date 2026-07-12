# Rewarding a Student, With a Reason

In Lesson 21 you added a bare, owner-only `mint`. Today you **replace** it with `rewardStudent` — same minting power, same `onlyOwner` lock, now with a memo the whole barangay can read. Open `act_1.sol` and work the TODOs. The Ownable wiring from Lesson 21 is already in place; you're adding your own event and the function that fires it.

## Task 1: Declare Your Own Event

Above the constructor, declare an event named `StudentRewarded` with three fields: `address indexed student`, `uint256 amount`, and `string reason`. That's who, how much, and why.

Mark **`student` as `indexed`** so a block explorer can filter "every reward to this student." Leave **`amount` and `reason` non-indexed**: they ride in the log's data section, readable in plain text. Do *not* index `reason` — a string in a topic is stored as a hash, and you'd never be able to read the sentence back.

## Task 2: Replace `mint` with `rewardStudent`

Write `rewardStudent(address student, uint256 amount, string calldata reason)`, marked `external onlyOwner` (the same lock from Lesson 21 carries over — only the instructor rewards). Inside, do two things in order:

1. `_mint(student, amount)` — the credits appear in the student's balance (and fire the inherited `Transfer` from the zero address).
2. `emit StudentRewarded(student, amount, reason)` — the reason goes on-chain, permanently, next to the amount.

Note `reason` is `string calldata`, not `memory`: you only read it, so take the cheaper read-only reference.

## Sample Output

Deploy from the instructor account, then call `rewardStudent` with Kevin's address, `200000000000000000000` (200 WCR), and the reason `"Finished final exercise"`. One call leaves **two** logs:

```text
[
  {
    "event": "Transfer",
    "args": {
      "from":  "0x0000000000000000000000000000000000000000",
      "to":    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
      "value": "200000000000000000000"
    }
  },
  {
    "event": "StudentRewarded",
    "args": {
      "student": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
      "amount":  "200000000000000000000",
      "reason":  "Finished final exercise"
    }
  }
]

balanceOf(0xAb84...cb2)  -> 200000000000000000000     // 200 WCR
totalSupply()            -> 1200000000000000000000     // grew by 200 from the initial 1,000
```

The `Transfer` is ERC-20's generic receipt — 200 base units, coming from the zero address (out of nowhere). The `StudentRewarded` is *yours* — same amount, same student, plus the one field the standard could never give you: the reason, in plain text, in a public log Dan cannot edit after the fact.

## Reflection Questions

1. One `rewardStudent` call produced two log entries. Where did each one come from, and why does the reason live in only one of them?
2. `student` is `indexed` but `reason` is not. Describe one thing you can do with an indexed field that you can't do with a non-indexed one — and why that trade-off is exactly right for these two particular fields.
3. Dan could have kept the reason in a private spreadsheet column instead. Name two concrete things the on-chain event gives Kevin that the spreadsheet never could.

## Challenge

**Challenge A — Two rewards, two permanent receipts.** Call `rewardStudent` on a fresh student with `50000000000000000000` (50 WCR) and reason `"Attendance week 1"`; read the `reason` back out of the log. Then reward the *same* student again, `100000000000000000000` (100 WCR), reason `"Finished exercise 3"`. Confirm their balance is now 150 WCR and that there are **two** separate `StudentRewarded` logs — a full history, not an overwrite.

**Challenge B — Two short written answers.** (1) In your own words, why is a reason stored on-chain in an event more trustworthy for the workshop than the same reason typed into Dan's private spreadsheet? Name at least two concrete differences. (2) What would break if you changed `string reason` to `string indexed reason`? Think about what actually gets stored in a topic for a variable-length type, and whether you could ever read the sentence back.

## What You've Learned

- **You can declare your own events**, with your own fields, on top of ERC-20's `Transfer`/`Approval` — that's the line between *using* a token and *building* an application.
- **`indexed` makes a field searchable (a topic); non-indexed makes it readable (data).** Index `student`; keep `reason` readable and never hash it away.
- **`string calldata` is the right home for a read-only argument** — no copy, cheaper gas, and it signals you won't mutate it.
- **One `rewardStudent` call emits two logs** — the inherited `Transfer` from the zero address and your `StudentRewarded` — welding the amount and the reason into one immutable record.
