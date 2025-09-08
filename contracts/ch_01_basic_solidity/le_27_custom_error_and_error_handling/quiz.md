# Custom Errors and Error Handling Quiz

Help Neri use custom errors to outsmart Hackana! Test your knowledge of error handling in Solidity.

---

### 1. What is the main advantage of using custom errors in Solidity?

A) They make contracts slower

B) They use less gas than revert strings

C) They are only available in ERC-721 contracts

D) They cannot be used in functions

**Answer:** B

_Explanation: Custom errors are more gas-efficient than revert strings._

---

### 2. What happens when the following code is executed and the user is already registered?

```solidity
if (users[msg.sender].isRegistered) {
    revert UserAlreadyRegistered(msg.sender);
}
```

A) The function continues

B) The transaction reverts with a custom error

C) The user is registered again

D) Nothing happens

**Answer:** B

_Explanation: The transaction reverts and the custom error is returned._

---

### 3. How do you test for a custom error in Hardhat/Chai?

A) `.to.be.revertedWith("Error")`

B) `.to.be.revertedWithCustomError(contract, "ErrorName")`

C) `.to.emit(contract, "Error")`

D) `.to.be.calledWith("Error")`

**Answer:** B

_Explanation: Use `.to.be.revertedWithCustomError(contract, "ErrorName")` to test for custom errors._

---

### 4. In Neri's battle, why is using custom errors important for defending the contract against Hackana?

A) It confuses Hackana

B) It makes the contract more readable and efficient

C) It allows anyone to change the contract

D) It disables error handling

**Answer:** B

_Explanation: Custom errors make contracts more efficient and easier to audit, helping Neri defend against attacks._

---

Well done! Neri's contract is now safer and more efficient against Hackana's schemes.
