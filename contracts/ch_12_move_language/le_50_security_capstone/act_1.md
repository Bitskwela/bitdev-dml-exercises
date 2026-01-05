# Activity 1: Security Capstone - Secure Vault

## The Challenge

For your capstone project, you will build a secure vault module that implements all the security practices you've learned throughout this course.

The vault allows users to:

- Deposit tokens
- Withdraw tokens (with proper authorization)
- Transfer between users (with admin capability)

Your implementation must pass the complete security checklist.

## Requirements

Build a `SecureVault` module with the following:

### Structs

1. **Vault** (has key)

   - `balance: u64`
   - `owner: address`
   - `locked: bool` (reentrancy guard)

2. **AdminCap** (has key, store)
   - Capability for admin functions

### Functions

1. **initialize_admin**

   - Creates AdminCap for the deployer
   - Can only be called once

2. **create_vault**

   - Creates a new vault for the signer
   - Must check vault doesn't already exist

3. **deposit**

   - Adds amount to caller's vault
   - Must validate amount > 0
   - Must check for overflow

4. **withdraw**

   - Removes amount from caller's vault
   - Must use reentrancy guard
   - Must check sufficient balance
   - Must update state before any external logic

5. **admin_transfer**
   - Requires AdminCap
   - Transfers between two vaults
   - Must validate both vaults exist
   - Must check balances

## Security Checklist

Your solution must satisfy:

- [ ] Access control via signer verification
- [ ] Capability pattern for admin functions
- [ ] Integer overflow/underflow protection
- [ ] Resource existence checks
- [ ] Input validation (amounts, addresses)
- [ ] Reentrancy protection

## Starter Code

```move
module secure_vault {
    use std::signer;

    // Error codes
    const E_ALREADY_INITIALIZED: u64 = 1;
    const E_VAULT_EXISTS: u64 = 2;
    const E_VAULT_NOT_FOUND: u64 = 3;
    const E_INSUFFICIENT_BALANCE: u64 = 4;
    const E_INVALID_AMOUNT: u64 = 5;
    const E_OVERFLOW: u64 = 6;
    const E_LOCKED: u64 = 7;
    const E_INVALID_ADDRESS: u64 = 8;

    const MAX_BALANCE: u64 = 18446744073709551615; // Max u64

    // TODO: Define Vault struct

    // TODO: Define AdminCap struct

    // TODO: Implement initialize_admin

    // TODO: Implement create_vault

    // TODO: Implement deposit (with overflow check)

    // TODO: Implement withdraw (with reentrancy guard)

    // TODO: Implement admin_transfer (with capability)
}
```

## Hints

1. For overflow protection: `assert!(vault.balance <= MAX_BALANCE - amount, E_OVERFLOW)`
2. For reentrancy: Set `locked = true` at start, `locked = false` at end
3. For admin capability: The function takes `&AdminCap` as a parameter
4. Remember to check `exists<Vault>(addr)` before accessing or creating

## Submission

Complete all functions following the security checklist. This is your capstone—demonstrate everything you've learned about Move security!
