# Palengke troubles and immutable data

![2.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_02_palengke_troubles/2.0%20-%20COVER.png)

## Scene:

After work, Neri heads to the palengke (wet market) to buy her groceries. Chaos reigns as vendors deal with failed QR transactions and confusion over cash payments. One vendor, Ate Linda, gets shortchanged because she couldn’t calculate exact change properly. Another vendor complains about inconsistent records, leading to mistrust among customers.

Neri reflects on how blockchain’s immutability can solve this. If payment records were on-chain and all parties agreed on a shared, transparent ledger, these disputes could vanish. She remembers how data types in Solidity define and structure information, ensuring it’s accurate, consistent, and secure.

### Solidity Topic: Data types

![2.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_02_palengke_troubles/2.1.png)

#### Explanation for Learners:

In Solidity, data types help structure information like _numbers_, _text_, or _true_/_false_ values.

Common data types include:

- Boolean (`bool`): Represents true/false values. Useful for conditions like _"Is the transaction valid?"_

  ```solidity
  bool isForSale = true;
  ```

- Integer `uint` and `int`:

  - Think of `uint` as a container for **non-negative whole numbers**. It can store zero and any positive number, but it **cannot** store negative numbers.
  - The `uint` keyword is followed by a number indicating the number of bits used to store the value (e.g., `uint8`, `uint16`, `uint256`). The larger the number of bits, the larger the number the variable can store.
  - `uint256` is the most commonly used unsigned integer type. It's the default if you just write `uint`.
  - **Example:** Imagine you're counting the number of mangoes a vendor sells. You'll never have a negative number of mangoes, so `uint` is perfect for this.

    ```solidity
    uint256 numberOfMangoes = 10; // This is valid
    // uint256 numberOfMangoes = -10; // This will cause an error because uint cannot be negative
    ```

    - `int` can store **both positive and negative whole numbers, including zero.**

    * Like `uint`, `int` also comes in different sizes (e.g., `int8`, `int16`, `int256`), with `int256` being the most common and the default if you just write `int`.

    * **Example:** Think about tracking a vendor's profit/loss. They can have a profit (positive number) or a loss (negative number), so `int` is suitable here.

      ```solidity
      int256 profit = 100;   // Positive profit
      int256 loss = -50;     // Negative loss
      ```

- String (`string`): Holds text, like a vendor’s name or product description.

  ```solidity
  string myMessage = "Is this available?";
  ```

- Address (`address`): Represents Ethereum wallet addresses, crucial for identifying participants in transactions.

  ```solidity
  address myWallet = 0xDF744BA5808cde3e87B3390A8A3DcE5cCB349068;

  ```

- Array (`array`): Stores multiple values of the same type. For example, a list of all transactions in the palengke.

  ```solidity
  // Fixed-size array: A list of the 3 most recent transaction amounts
  uint256[3] public recentTransactions = [1, 2, 3];

  // Dynamic array: A list of product prices
  uint256[] public productPrices = [10, 20, 30, 40, 50];

  // String array: A list of common vendor names
  string[] public vendorNames = ["Aling Nena", "Mang Juan", "Ate Maria"];
  ```

- Mapping (`mapping`): Key-value pairs that link one piece of data to another. Example: Linking a vendor’s address to their payment record.

  ```solidity
  // Mapping: Associate vendor addresses with their balances
  mapping(address => uint256) public vendorBalances;

  // Mapping: Associate student id with their grades
  mapping(uint => string) public studentGrades;

  // Mapping: Associate product name with its price
  mapping(string => uint) public productPrices;

  // Example usage in a function:
  function updateVendorBalance(address _vendor, uint256 _newBalance) public {
      vendorBalances[_vendor] = _newBalance;
  }

  function setStudentGrade(uint _studentId, string memory _grade) public {
      studentGrades[_studentId] = _grade;
  }

  function setProductPrice(string memory _productName, uint _price) public {
      productPrices[_productName] = _price]
  }
  ```
