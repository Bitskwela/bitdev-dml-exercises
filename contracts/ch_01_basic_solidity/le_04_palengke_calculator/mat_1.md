# Grocery Price Miscalculations at the Palengke

## Scene: Market Math Mishaps

One weekend, Neri heads to the local palengke (wet market) to buy groceries. She notices an issue at a stall where a vendor struggles to calculate the total bill for a customer buying a mix of vegetables, rice, and fish.

**“Kuya, sabi mo 250 pesos lang, bakit naging 300 na?”**

("_Sir, you said it was 250 pesos, why did it become 300 now?"_)

The vendor's old calculator and mental math led to errors in the total. Observing this, Neri envisions a smart contract that automates such calculations, ensuring accuracy every time.

This problem gives her the perfect opportunity to dive into math operations in Solidity, which are critical for any contract dealing with payments, balances, or numerical data.

## Solidity Topics: Math Operations

Solidity supports a variety of arithmetic operations, which are essential for managing financial transactions and other computations.

### Key Math Operations in Solidity

- Addition (`+`): Adding numbers, e.g., total price of goods.
- Subtraction (`-`): Calculating remaining balances or refunds.
- Multiplication (`*`): Used to compute totals based on quantity and price.
- Division (`/`): Splitting amounts or calculating averages.
- Modulus (`%`): Finding remainders, e.g., splitting funds evenly.

### Important Notes for Solidity Math

- Integer Division: Solidity uses integers (whole numbers), so `5 / 2` results in `2`, _not_ `2.5`.
- Overflow/Underflow (Old Versions): Previously, operations exceeding a number's limit caused errors. This is now mitigated in Solidity 0.8.0 and above.
- SafeMath Library: Was used to prevent overflow/underflow in earlier versions but is no longer required in Solidity 0.8+.

### Sample syntax

**Addition**:

```solidity
uint256 public sum = 5 + 3; // Result: 8
```

**Subtraction**:

```solidity
uint256 public difference = 10 - 3; // Result: 7
```

**Multiplication**:

```solidity
uint256 public product = 7 * 3; // Result: 21
```

**Division**:

```solidity
uint256 public quotient = 10 / 5; // Result: 2
```

**Modulo**:

```solidity
uint256 public remainder = 10 % 3; // Result: 1
```