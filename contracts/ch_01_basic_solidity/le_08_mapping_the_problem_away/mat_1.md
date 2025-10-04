# Mapping the problem away

![8.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_08_mapping_the_problem_away/8.0%20-%20COVER.png)

## Scene

Neri tracks Hackana’s digital trail and discovers it’s siphoning funds and data by exploiting poorly managed user records in centralized systems. To counteract, she decides to build a decentralized data registry using Solidity’s mapping, which efficiently organizes and retrieves data.

Neri realizes that by designing a robust mapping-based solution, she can secure sensitive data like user balances, records, or permissions against tampering.

## Solidity Topics: `mapping`

![8.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_08_mapping_the_problem_away/8.1.png)

A `mapping` is a reference type in Solidity that associates keys to values. It functions like a dictionary or hash table and is highly efficient for lookups.

**Syntax:**

```solidity
mapping(address => uint256) public balances;
```

**Key Characteristics:**

- Keys are unique and can’t be iterated directly (no for loop).
- Common key types: `address`, `uint`, `bytes32`.
- Common value types: `uint`, `bool`, `string`, or even nested `mappings`.

**How to use mapping in Solidity**

- Declare a Mapping:

  - Syntax: `mapping(keyType => valueType) visibility name;`
  - Example: `mapping(address => uint256) public balances;`
    - **Explanation**: This maps the user address and their corresponding balances
      - `keyType: address` (user address).
      - `valueType: uint256` (user balance).

- Setting a mapping’s value:

  - Use the `mappingName[key] = value` syntax.

    **Example:** `balances[msg.sender] = 1000;`

    - **Explanation**: We’re assigning 1000 balance to the sender’s address

- Retrieving a mapping value:

  - Access the value using the `mappingName[key]` syntax.

    **Example:** `uint256 myBalance = balances[msg.sender];`

    - **Explanation:** We’re retrieving the sender’s balance by referencing it’s wallet address as a parameter

- Update a Value: - Simply assign a new value to the key.
  - **Example**: `balances[msg.sender] = balances[msg.sender] + 500;`
    - **Explanation**: We’re assigning additional `500` balance on the sender’s current balance
