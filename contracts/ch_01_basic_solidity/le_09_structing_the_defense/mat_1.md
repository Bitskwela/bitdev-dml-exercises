# _Struct_-ing the Defense

## Scene

After securing a way to map data effectively, Neri realizes she needs to store more complex information. Hackana's malware has been manipulating multiple fields, like customer IDs, purchase histories, and timestamps, all tied to one record.

Neri decides to use Solidity’s struct to create a robust, flexible data model to store multi-field data securely in her decentralized solution.

## Solidity Topics: Struct

A `struct` is a custom data type in Solidity that allows developers to group multiple variables under one structure. It’s ideal for organizing complex data.

### Key Features of Structs

- They can hold different types of data (e.g., `strings`, `integers`, `booleans`).
- Structs can be stored in mappings or arrays for further organization.

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

- Defining a Struct:

  - Use the `struct` keyword

    - Example:

      ```solidity
      // Example of Vehicle Struct
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

  - Update: `carOwners[msg.sender].model = “BMW”;`
