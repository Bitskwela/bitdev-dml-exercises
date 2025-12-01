# Lesson 9 Activities: Mini Project - ATM System

This lesson is a **mini project** where you build a complete ATM (Automated Teller Machine) simulation. The main project is covered in the material file. This activity file contains **enhancement challenges** to extend your ATM system.

---

## Enhancement Challenge 1: Multiple Accounts

**Objective:** Modify the ATM system to support multiple user accounts.

**Task:**  
Instead of a single hardcoded account, implement an array-based system that stores multiple accounts with their respective PINs and balances.

**Requirements:**
- Store at least 3 accounts
- Let user select their account number first
- Validate account existence before PIN authentication

**Starter Code:**
```cpp
// Arrays for multiple accounts
int accountNumbers[] = {1001, 1002, 1003};
int pins[] = {1234, 5678, 9012};
double balances[] = {5000, 10000, 7500};
int numAccounts = 3;

int selectedAccount = -1;  // Index of selected account

// Step 1: Ask for account number
// Step 2: Find account in array
// Step 3: Authenticate with PIN
// Step 4: Perform operations on that account
```

**Hint:** Use a loop to search for the account number in the `accountNumbers` array. Store the index when found, then use that index to access the corresponding PIN and balance.

<details>
<summary>Click to view solution approach</summary>

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    // Account data
    int accountNumbers[] = {1001, 1002, 1003};
    int pins[] = {1234, 5678, 9012};
    double balances[] = {5000, 10000, 7500};
    int numAccounts = 3;
    
    int inputAccount, inputPIN;
    int accountIndex = -1;
    
    // Step 1: Find account
    cout << "=== ATM System ===" << endl;
    cout << "Enter account number: ";
    cin >> inputAccount;
    
    for (int i = 0; i < numAccounts; i++) {
        if (accountNumbers[i] == inputAccount) {
            accountIndex = i;
            break;
        }
    }
    
    if (accountIndex == -1) {
        cout << "Account not found!" << endl;
        return 1;
    }
    
    // Step 2: Authenticate
    cout << "Enter PIN: ";
    cin >> inputPIN;
    
    if (inputPIN != pins[accountIndex]) {
        cout << "Incorrect PIN!" << endl;
        return 1;
    }
    
    cout << "Login successful!" << endl;
    cout << "Welcome, Account " << accountNumbers[accountIndex] << endl;
    
    // Now use balances[accountIndex] for operations
    // ... rest of ATM menu system
    
    return 0;
}
```

</details>

---

## Enhancement Challenge 2: Daily Withdrawal Limit

**Objective:** Add a safety feature that prevents excessive daily withdrawals.

**Task:**  
Implement a daily withdrawal limit of ₱20,000. Track how much has been withdrawn today and prevent withdrawals that would exceed this limit.

**Requirements:**
- Set daily limit to ₱20,000
- Track total withdrawn amount for the day
- Display remaining daily limit
- Reject withdrawals that exceed limit

**Starter Code:**
```cpp
double dailyLimit = 20000.00;
double todayWithdrawn = 0.00;

// In withdrawal menu option:
double withdrawAmount;
cout << "Enter amount to withdraw: ";
cin >> withdrawAmount;

// Check daily limit
// Update todayWithdrawn if valid
// Display remaining limit
```

**Expected Behavior:**
```
Daily limit: PHP 20000.00
Already withdrawn today: PHP 5000.00
Remaining limit: PHP 15000.00

Enter amount to withdraw: 18000
Error: Exceeds daily limit!
Maximum you can withdraw: PHP 15000.00
```

<details>
<summary>Click to view solution</summary>

```cpp
// In the withdrawal section:
double withdrawAmount;
double remainingLimit = dailyLimit - todayWithdrawn;

cout << "\n=== WITHDRAW ===" << endl;
cout << fixed << setprecision(2);
cout << "Daily limit: PHP " << dailyLimit << endl;
cout << "Already withdrawn today: PHP " << todayWithdrawn << endl;
cout << "Remaining limit: PHP " << remainingLimit << endl;
cout << "\nEnter amount to withdraw: ";
cin >> withdrawAmount;

// Validation
if (withdrawAmount > balance) {
    cout << "Insufficient balance!" << endl;
} else if (withdrawAmount > remainingLimit) {
    cout << "Error: Exceeds daily withdrawal limit!" << endl;
    cout << "Maximum you can withdraw: PHP " << remainingLimit << endl;
} else if (withdrawAmount <= 0) {
    cout << "Invalid amount!" << endl;
} else {
    balance -= withdrawAmount;
    todayWithdrawn += withdrawAmount;
    cout << "\n=== WITHDRAWAL SUCCESSFUL ===" << endl;
    cout << "Amount withdrawn: PHP " << withdrawAmount << endl;
    cout << "New balance: PHP " << balance << endl;
    cout << "Remaining daily limit: PHP " << (dailyLimit - todayWithdrawn) << endl;
}
```

</details>

---

## Enhancement Challenge 3: Interest Calculation

**Objective:** Add a feature to show projected interest earnings.

**Task:**  
Implement an "Interest Calculator" menu option that shows how much interest the current balance would earn in one year at a 5% annual rate.

**Requirements:**
- Annual interest rate: 5% (0.05)
- Calculate: interest = balance × rate
- Display both monthly and yearly projections

**Starter Code:**
```cpp
const double ANNUAL_RATE = 0.05;  // 5% per year

// New menu option: Check Interest
// Calculate and display interest projections
```

**Expected Output:**
```
=== INTEREST CALCULATOR ===
Current Balance: PHP 10000.00
Annual Interest Rate: 5.00%

Projected Earnings:
- Monthly: PHP 41.67
- Yearly: PHP 500.00

Future Value (1 year): PHP 10500.00
```

<details>
<summary>Click to view solution</summary>

```cpp
// In menu option for interest calculator:
case 5:  // Check Interest
    cout << "\n=== INTEREST CALCULATOR ===" << endl;
    cout << fixed << setprecision(2);
    cout << "Current Balance: PHP " << balance << endl;
    cout << "Annual Interest Rate: " << (ANNUAL_RATE * 100) << "%" << endl;
    cout << "\nProjected Earnings:" << endl;
    
    double yearlyInterest = balance * ANNUAL_RATE;
    double monthlyInterest = yearlyInterest / 12.0;
    double futureValue = balance + yearlyInterest;
    
    cout << "- Monthly: PHP " << monthlyInterest << endl;
    cout << "- Yearly: PHP " << yearlyInterest << endl;
    cout << "\nFuture Value (1 year): PHP " << futureValue << endl;
    break;
```

</details>

---

## Enhancement Challenge 4: Transfer Money

**Objective:** Add the ability to transfer money to another account.

**Task:**  
Implement a "Transfer" feature that allows users to send money from their account to another account number.

**Requirements:**
- Ask for recipient account number
- Ask for transfer amount
- Validate:
  - Sufficient balance
  - Valid recipient account
  - Amount > 0
- Deduct from sender, add to recipient
- Display transfer receipt

**Starter Code:**
```cpp
// Assuming multiple accounts from Challenge 1
int recipientAccount;
double transferAmount;

cout << "Enter recipient account number: ";
cin >> recipientAccount;

cout << "Enter transfer amount: ";
cin >> transferAmount;

// Find recipient account index
// Validate balance and account
// Perform transfer
// Display receipt
```

**Expected Output:**
```
=== TRANSFER MONEY ===
Your balance: PHP 5000.00

Enter recipient account number: 1002
Enter transfer amount: 1000

=== TRANSFER RECEIPT ===
From Account: 1001
To Account: 1002
Amount: PHP 1000.00
Transaction Fee: PHP 10.00
Total Deducted: PHP 1010.00

New Balance: PHP 3990.00
Transfer successful!
```

<details>
<summary>Click to view solution</summary>

```cpp
// In transfer menu option:
case 6:  // Transfer Money
    int recipientAccount, recipientIndex = -1;
    double transferAmount;
    const double TRANSFER_FEE = 10.00;
    
    cout << "\n=== TRANSFER MONEY ===" << endl;
    cout << "Your balance: PHP " << balances[accountIndex] << endl;
    
    cout << "\nEnter recipient account number: ";
    cin >> recipientAccount;
    
    // Find recipient
    for (int i = 0; i < numAccounts; i++) {
        if (accountNumbers[i] == recipientAccount && i != accountIndex) {
            recipientIndex = i;
            break;
        }
    }
    
    if (recipientIndex == -1) {
        cout << "Recipient account not found!" << endl;
        break;
    }
    
    cout << "Enter transfer amount: ";
    cin >> transferAmount;
    
    double totalCost = transferAmount + TRANSFER_FEE;
    
    // Validate
    if (transferAmount <= 0) {
        cout << "Invalid amount!" << endl;
    } else if (totalCost > balances[accountIndex]) {
        cout << "Insufficient balance! (includes PHP 10 fee)" << endl;
    } else {
        // Perform transfer
        balances[accountIndex] -= totalCost;
        balances[recipientIndex] += transferAmount;
        
        cout << "\n=== TRANSFER RECEIPT ===" << endl;
        cout << fixed << setprecision(2);
        cout << "From Account: " << accountNumbers[accountIndex] << endl;
        cout << "To Account: " << recipientAccount << endl;
        cout << "Amount: PHP " << transferAmount << endl;
        cout << "Transaction Fee: PHP " << TRANSFER_FEE << endl;
        cout << "Total Deducted: PHP " << totalCost << endl;
        cout << "\nNew Balance: PHP " << balances[accountIndex] << endl;
        cout << "Transfer successful!" << endl;
    }
    break;
```

</details>

---

## Enhancement Challenge 5: Password Change (PIN Change)

**Objective:** Allow users to change their PIN for security.

**Task:**  
Implement a "Change PIN" feature that lets users update their PIN after verifying the old one.

**Requirements:**
- Ask for current PIN (verify it's correct)
- Ask for new PIN
- Ask to confirm new PIN
- Validate:
  - Old PIN is correct
  - New PIN matches confirmation
  - New PIN is 4 digits (optional validation)
- Update PIN in system

**Starter Code:**
```cpp
int oldPIN, newPIN, confirmPIN;

cout << "Enter current PIN: ";
cin >> oldPIN;

// Verify old PIN
// Get new PIN
// Confirm new PIN
// Update PIN
```

**Expected Output:**
```
=== CHANGE PIN ===
Enter current PIN: 1234
Enter new PIN: 5678
Confirm new PIN: 5678

PIN changed successfully!
Please remember your new PIN.
```

<details>
<summary>Click to view solution</summary>

```cpp
// In change PIN menu option:
case 7:  // Change PIN
    int oldPIN, newPIN, confirmPIN;
    
    cout << "\n=== CHANGE PIN ===" << endl;
    cout << "Enter current PIN: ";
    cin >> oldPIN;
    
    if (oldPIN != pins[accountIndex]) {
        cout << "Incorrect PIN!" << endl;
        cout << "PIN change failed." << endl;
        break;
    }
    
    cout << "Enter new PIN (4 digits): ";
    cin >> newPIN;
    
    // Optional: Validate 4 digits
    if (newPIN < 1000 || newPIN > 9999) {
        cout << "PIN must be 4 digits!" << endl;
        break;
    }
    
    cout << "Confirm new PIN: ";
    cin >> confirmPIN;
    
    if (newPIN != confirmPIN) {
        cout << "PINs do not match!" << endl;
        cout << "PIN change cancelled." << endl;
    } else {
        pins[accountIndex] = newPIN;
        cout << "\n=== SUCCESS ===" << endl;
        cout << "PIN changed successfully!" << endl;
        cout << "Please remember your new PIN." << endl;
    }
    break;
```

</details>

---

## Integration Challenge: Complete Enhanced ATM

**Objective:** Combine ALL the enhancements into one fully-featured ATM system.

**Task:**  
Create a complete ATM system that includes:
1. Multiple accounts
2. Daily withdrawal limits
3. Interest calculator
4. Money transfer
5. PIN change feature
6. Enhanced menu with all options
7. Proper error handling
8. Professional receipts and formatting

**Menu Structure:**
```
=== ATM MAIN MENU ===
1. Check Balance
2. Deposit
3. Withdraw
4. Transfer Money
5. Interest Calculator
6. Change PIN
7. Exit

Current Balance: PHP XXXXX.XX
Daily Limit Remaining: PHP XXXXX.XX
```

**This is your complete mini-project!** Try to implement all features with clean code, good variable names, and user-friendly messages.

---

## Reflection Questions

After completing these challenges:

1. **How does using arrays make the ATM system more scalable?**
   - Can easily add more accounts without changing core logic
   - Data is organized and manageable

2. **Why is a daily withdrawal limit important in real ATMs?**
   - Security: Limits damage from stolen cards
   - Fraud prevention
   - Banking regulations

3. **What additional validations would a real ATM need?**
   - Card insertion/expiry check
   - Network connectivity
   - Dispenser cash availability
   - Transaction logging for audit

4. **How would you improve error handling?**
   - Use functions for repeated validation
   - Implement retry limits (3 attempts)
   - Add transaction history
   - Better user feedback messages

---

## Next Steps

Congratulations on building a working ATM system! You've used:
- ✅ Loops (while, for)
- ✅ Conditionals (if-else, switch)
- ✅ Arrays (multiple accounts)
- ✅ Variables and data types
- ✅ Input/output formatting
- ✅ Basic algorithms (search, validate)

**Ready for Lesson 10?**  
Next, you'll learn about **functions** - how to organize your code into reusable blocks, which would make this ATM system much cleaner!
