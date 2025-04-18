# Ether and Wei – Preparing for the Financial Counterstrike

## Scene

The day has finally arrived. Neri is at the forefront of the battle against Hackana, whose malware continues to exploit weak financial infrastructures and siphon off funds. Hackana’s latest scheme? Overcharging and draining wallets by manipulating small transaction units, making it hard for people to notice.

As Neri strategizes, her blockchain mentor sends her an urgent message:
_"**Neri, remember Ether and Wei. Those small units Hackana manipulates? They’re the building blocks of Ethereum transactions. Understand them, and you’ll gain the upper hand!**"_

Neri starts reviewing her notes. She recalls that Ether (ETH) is the main cryptocurrency of Ethereum, while Wei is its smallest denomination (like centavos to pesos). Understanding these units will be crucial for her to counter Hackana’s financial tricks.

## Solidity Topics: Ether and Wei

### More Info about Ether and Wei

In Ethereum, Ether (ETH) is the main currency used for transactions. Since dealing with large decimals can be tricky, Ethereum breaks Ether into smaller units called Wei for precise calculations.

Here’s the conversion:

_1 Ether = 10¹⁸ Wei (1 ETH = 1,000,000,000,000,000,000 Wei)._

### Why use Wei?

- It ensures accuracy in microtransactions.
- Prevents rounding errors during computations.

Solidity provides helper functions for conversions:

- `1 ether` equals `10**18 wei`.
- `1 gwei` equals `10**9 wei` (used for gas fees).

### Example usage in Solidity

```solidity
uint256 public oneEther = 1 ether; // 1 ETH in Wei
uint256 public gasFee = 1 gwei;   // Gas fee in Wei
uint256 public smallTransaction = 500 wei; // Microtransaction
```

### How to use Ether and Wei on real smart contract

**Basic conversion**

- Solidity uses the keywords ether, gwei, and wei for easier calculations.

  Example:

  ```solidty
  uint256 oneEtherInWei = 1 ether; // 1 ETH = 10^18 Wei
  uint256 gasPriceInGwei = 1 gwei; // 1 Gwei = 10^9 Wei
  ```

- Microtransaction
  Small amounts like 500 wei are often used for precise payments.

  Example:

  ```solidity
  uint256 payment = 500 wei;
  ```
