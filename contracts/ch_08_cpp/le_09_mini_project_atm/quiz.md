# Quiz: Lesson 9 - Mini Project ATM Simulator

**Instructions:** Choose the best answer for each question about the ATM project.

---


# Quiz 1

### Question 1
In the ATM simulator, why is a `while` loop used for authentication?

A) To run the authentication exactly 3 times  
B) To keep trying until authenticated OR max attempts reached  
C) Because for loops don't work with conditions  
D) To make the code slower

**Answer: B) To keep trying until authenticated OR max attempts reached**

**Explanation:**
```cpp
while (attempts < 3 && !authenticated) {
    // Keep trying while attempts < 3 AND not yet authenticated
}
```

A `while` loop is perfect here because:
- We don't know in advance how many times the user will try
- We need to stop when authenticated OR when attempts reach 3
- The condition `attempts < 3 && !authenticated` controls both exit conditions

---

### Question 2
What happens if a user enters the wrong PIN 3 times?

A) Loop continues forever  
B) Program exits with `return 0`  
C) User gets unlimited attempts  
D) Balance is reset

**Answer: B) Program exits with `return 0`**

**Explanation:**
```cpp
if (attempts >= 3) {
    cout << "Card blocked. Please contact your bank." << endl;
    return 0;  // Exit the entire program
}
```

After 3 failed attempts, the program uses `return 0` to exit completely, simulating a card being blocked.

---

### Question 3
Why is the main menu implemented with a `while` loop?

A) For loops are not allowed  
B) To display the menu exactly once  
C) To keep showing menu until user chooses to exit  
D) To prevent user errors

**Answer: C) To keep showing menu until user chooses to exit**

**Explanation:**
```cpp
bool exitATM = false;

while (!exitATM) {
    // Display menu and process choices
    
    if (choice == 5) {
        exitATM = true;  // Exit condition
    }
}
```

The menu-driven pattern uses a loop to continuously show options until the user explicitly chooses to exit (option 5).

---

### Question 4
In the withdrawal function, what does this condition check?
```cpp
if (withdrawAmount > balance) {
    cout << "Insufficient balance!" << endl;
}
```

A) If withdrawal exceeds daily limit  
B) If user has enough funds  
C) If withdrawal is negative  
D) If PIN is correct

**Answer: B) If user has enough funds**

**Explanation:**
This is a critical validation - you can't withdraw more money than you have in your account. The condition checks if the requested withdrawal amount exceeds the available balance.

---

### Question 5
Why is there additional PIN verification for large withdrawals?

A) To annoy the user  
B) For security - to prevent unauthorized large transactions  
C) Because the code requires it  
D) To test the PIN again

**Answer: B) For security - to prevent unauthorized large transactions**

**Explanation:**
```cpp
if (withdrawAmount >= 10000) {
    cout << "Re-enter PIN to confirm: ";
    cin >> confirmPIN;
    
    if (confirmPIN != correctPIN) {
        continue;  // Cancel transaction
    }
}
```

This is a real-world security feature. Large transactions require additional authentication to ensure the rightful owner is performing the action, protecting against theft or fraud.

---


# Quiz 2

### Question 6
What does the `continue` statement do in the withdrawal verification?

A) Exits the program  
B) Skips to the next menu iteration without completing withdrawal  
C) Completes the withdrawal anyway  
D) Restarts authentication

**Answer: B) Skips to the next menu iteration without completing withdrawal**

**Explanation:**
```cpp
if (confirmPIN != correctPIN) {
    cout << "Transaction cancelled." << endl;
    continue;  // Skip rest of code, go back to menu
}
```

`continue` immediately jumps to the next iteration of the loop, skipping any code below it (like the withdrawal execution). This safely cancels the transaction.

---




### Question 7
How does the transaction history array work?

A) It stores unlimited transactions  
B) It stores up to 10 transactions using an array and counter  
C) It stores only the last transaction  
D) It doesn't actually store anything

**Answer: B) It stores up to 10 transactions using an array and counter**

**Explanation:**
```cpp
string transactions[10];  // Array of 10 transactions
int transactionCount = 0; // Counter

// Add transaction
if (transactionCount < 10) {
    transactions[transactionCount] = "Deposit: PHP 1000";
    transactionCount++;
}
```

The array has a fixed size (10). The counter tracks how many transactions have been stored. Once full, no more transactions are added (in a real system, you'd implement a rolling buffer).

---

### Question 8
What would happen if you removed this condition?
```cpp
if (depositAmount <= 0) {
    cout << "Invalid amount." << endl;
}
```

A) Nothing, the code works fine  
B) Users could deposit negative amounts (withdraw money)  
C) Compilation error  
D) Balance becomes zero

**Answer: B) Users could deposit negative amounts (withdraw money)**

**Explanation:**
Without this validation, a user could enter `-1000` as a deposit, and the code would execute:
```cpp
balance += depositAmount;  // balance += -1000
```

This would actually **decrease** the balance! Input validation prevents such exploits.

---

### Question 9
Which validation is checked FIRST for withdrawals?

A) PIN confirmation for large amounts  
B) Daily withdrawal limit  
C) If amount is positive  
D) If amount exceeds balance

**Answer: C) If amount is positive**

**Explanation:**
The validation chain follows this order:
```cpp
if (withdrawAmount <= 0) {          // Check 1: Must be positive
    // ...
} else if (withdrawAmount > balance) {  // Check 2: Must have funds
    // ...
} else if (withdrawAmount > 20000) {    // Check 3: Must be within limit
    // ...
} else {
    // Additional security for large amounts
}
```

It makes sense to check the simplest validation first (is it even a valid positive number?) before checking more complex business rules.

---


# Quiz 1

### Question 10
How would you modify the ATM to support multiple users?

```cpp
// Option A
int correctPIN = 1234;
double balance = 5000;

// Option B
int pins[] = {1234, 5678, 9012};
double balances[] = {5000, 10000, 7500};
int accountIndex;  // Which account is logged in

// Option C
vector<int> allPINs;
vector<double> allBalances;
```

A) Option A is already sufficient  
B) Option B with parallel arrays  
C) Option C with vectors  
D) Both B and C work

**Answer: D) Both B and C work**

**Explanation:**
**Option A** only handles one user - not scalable.

**Option B** uses parallel arrays:
```cpp
int pins[] = {1234, 5678, 9012};
double balances[] = {5000, 10000, 7500};
int accountIndex = -1;

// During authentication, find which account
for (int i = 0; i < 3; i++) {
    if (enteredPIN == pins[i]) {
        accountIndex = i;
        authenticated = true;
        break;
    }
}

// Then use: balances[accountIndex] throughout
```

**Option C** uses vectors (more advanced, learned later):
```cpp
vector<int> pins = {1234, 5678, 9012};
vector<double> balances = {5000, 10000, 7500};
// Similar logic but with dynamic sizing
```

Both approaches work. Option B uses arrays (what you know now), Option C uses STL vectors (covered in Lesson 30).

---

**Score yourself:**
- 10/10: Project Master! 🏆  
- 8-9: Excellent understanding!  
- 6-7: Good, review security features  
- Below 6: Re-read the project walkthrough  

**Key Project Concepts:**
1. **Authentication** - Secure PIN entry with attempt limits
2. **Menu-driven** - Loop-based interface
3. **Input validation** - Check all user inputs
4. **Security features** - Re-verification for large transactions
5. **Transaction tracking** - Array-based history
6. **Compound conditions** - Multiple validation checks
7. **Boolean flags** - Control program flow
8. **User experience** - Clear messages and formatting

**Real-World Applications:**
- Banking systems
- E-commerce payment flows
- Access control systems
- Inventory management
- Any system requiring authentication and transactions
