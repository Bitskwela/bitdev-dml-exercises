# _Struct_-ing the Defense

![9.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_09_structing_the_defense/9.0%20-%20COVER.png)

## Scene

After securing a way to map data effectively, Neri realizes she needs to store more complex information. Hackana's malware has been manipulating multiple fields, like customer IDs, purchase histories, and timestamps, all tied to one record. To combat this, Neri needs a way to group related data together securely. She remembers her training on using `structs` in Solidity to create custom data types that can hold multiple fields. This will help her organize and manage the data more effectively.

Neri decides to use Solidity’s struct to create a robust, flexible data model to store multi-field data securely in her decentralized solution. She knows that by using `structs`, she can create a custom data type that can hold multiple fields, making it easier to manage complex data structures. This will help her combat Hackana's malware and ensure the integrity of her smart contracts.

## Solidity Topics: Struct

![9.1](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_09_structing_the_defense/9.1.png)

A `struct` is a custom data type in Solidity that allows developers to group multiple variables under one structure. It’s ideal for organizing complex data. Structs can contain different data types, including other structs, and are useful for creating complex data models. They help in organizing related data together, making it easier to manage and understand the structure of the data being handled.

Structs are particularly useful in scenarios where you need to represent complex entities with multiple attributes, such as user profiles, transactions, or any other data structure that requires grouping related information.

Structs are defined using the `struct` keyword, followed by the name of the struct and its fields. They can be used in mappings, arrays, or as function parameters and return types. Structs are value types, meaning they are copied when passed around, which can be beneficial for certain use cases but also requires careful consideration of gas costs and storage implications.

### Key Features of Structs

- They can hold different types of data (e.g., `strings`, `integers`, `booleans`).
- Structs can be stored in mappings or arrays for further organization.
- Structs can contain other structs, allowing for complex data models.
- They are value types, meaning they are copied when passed around.
- Structs can be used as function parameters and return types.
- They can be public or private, depending on the use case.

**Example:**

```solidity
// Example of Student Struct
struct Student {
    uint256 id;
    string name;
    string course;
}
```

**How to use struct in Solidity**

- Define a struct

  - Example:

    ```solidity
    struct Vehicle {
        uint256 id;
        string make;
        string model;
    }
    ```

- Create and assign values

  - Example:

    ```solidity
    Vehicle newVehicle = Vehicle(1, "Honda", "Civic");
    ```

- Store in a mapping

  - Example:

  ```solidity
    mapping(address => Vehicle) public carOwners;
  ```

- Cheatsheet in accessing and updating fields:

  - Access: `carOwners[msg.sender].model;`

  - Update: `carOwners[msg.sender].model = "BMW";`
