# Mini Project #4: Barangay Aid Vault – Protect Against Common Solidity Vulnerabilities

![Barangay Aid Vault](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+4.0+-+COVER.png)

## Background story:

IAfter Typhoon Ulysses, digital wallets meant for emergency relief in the barangays were attacked. This time, the vulnerabilities weren’t reentrancy — but uninitialized ownership, tx.origin misuse, and lack of access control.

The **Department of Social Welfare and Development (DSWD)** is asking Neri to build a vault that’s not only functional but immune to rookie-level contract exploits that malicious actors use to target underfunded government systems.

![Neri vs Hackers](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+4.1.png)

## Key Security Concepts Covered

- Access Control using `onlyOwner` or `Ownable` pattern
- Avoiding tx.origin phishing attacks
- Proper constructor setup and ownership initialization
- Input validation for edge-case exploits
- Event logging for auditability

**Time Allotment**: 1 hour

**Topics Covered**:

- Access Control & Ownership
- `tx.origin` vs `msg.sender`
- Validations & Require Checks
- Fallback Protection
- Constructor Initialization

### Why this project matters?

This project upgrades you as a learner from “_Solidity tinkerers_” to **security-first smart contract developer**s — the type of devs every DeFi protocol in the world wants on their team. And in the real world, this prevents relief corruption and makes Web3 governance possible in barangays.
