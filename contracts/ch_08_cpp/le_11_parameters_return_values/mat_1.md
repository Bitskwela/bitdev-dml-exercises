# Parameters and Return Values

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+11.0+-+COVER.png)

## Scene

Tian created a function to update a resident's balance, but when the function finished, the balance hadn't changed. "Kuya, I passed the balance to my `deductFee()` function, subtracted 500, but the balance in main is still the same!"

Kuya Miguel examined the code. "You're passing by value. The function got a photocopy of your data, modified the copy, then threw it away. The original stayed untouched. You need to pass by **reference** -- that's like giving the function your house key instead of a photo of your house."

"This is critical for efficiency too," he continued. "Imagine passing a 10MB image to a function. By value means copying 10MB every time. By reference means passing just an address. Understanding parameters and return values separates beginners from efficient programmers!"

## C++ Topics: Parameters and Return Values

![11.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+11.1.png)

### Pass by Value

> The function receives a **copy** of the data. Changes inside the function do not affect the original variable. This is the default behavior in C++.

### Pass by Reference

> Adding `&` to a parameter makes the function work with the **original variable**. Changes inside the function persist after it returns.

### Return Values

> A function can send a result back using `return`. The caller captures it in a variable or uses it directly in an expression.

### Const Reference

> Use `const&` to pass large data efficiently without copying, while preventing the function from modifying it. Best for read-only access to strings and objects.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

void updateBalance(double& balance, double amount) {
    balance += amount;  // Modifies the original
}

double calculateInterest(double balance, double rate) {
    return balance * (rate / 100.0);  // Returns a value
}

int main() {
    double myBalance = 1000.0;
    updateBalance(myBalance, 500.0);
    double interest = calculateInterest(myBalance, 5.0);
    cout << "Balance: " << myBalance << endl;
    cout << "Interest: " << interest << endl;
    return 0;
}
```

`updateBalance` uses `&` to modify the original balance directly. `calculateInterest` passes by value (read-only) and returns the computed interest.

## Common Pitfalls ⚠️

**1. Pass-by-value can't change the caller's variable**

```cpp
void addBonus(int bal) { bal += 100; }   // ❌ caller's balance unchanged
void addBonus(int& bal) { bal += 100; }  // ✅ reference modifies the original
```

**2. Forgetting to use (or capture) the return value**

```cpp
computeInterest(bal);              // ❌ result discarded
double i = computeInterest(bal);   // ✅
```

**3. Reaching a path with no `return`** — a non-`void` function must return on every path, or you get undefined behavior.

**4. Copying large objects by value** — pass big structs/strings by `const&` to avoid expensive copies:

```cpp
double total(const vector<int>& items);  // ✅ no copy, can't mutate
```

**5. Mismatched argument order** — `transfer(to, from)` vs `transfer(from, to)` compiles fine but is a logic bug. Name parameters clearly.
