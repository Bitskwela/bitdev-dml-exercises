# Lesson 16 Activities: Pointers

---

## Challenge 1: Swap Function

**Objective:** Use pointers to swap two integers.

**Task:** Write `swap(int* a, int* b)` that swaps values.

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    int x = 10, y = 20;
    
    cout << "Before: x = " << x << ", y = " << y << endl;
    swap(&x, &y);
    cout << "After: x = " << x << ", y = " << y << endl;
    
    return 0;
}
```

</details>

---

## Challenge 2: Array Maximum

**Objective:** Return pointer to largest element in array.

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

int* findMax(int arr[], int size) {
    int* maxPtr = &arr[0];
    
    for (int i = 1; i < size; i++) {
        if (arr[i] > *maxPtr) {
            maxPtr = &arr[i];
        }
    }
    
    return maxPtr;
}

int main() {
    int numbers[] = {45, 12, 89, 34, 67};
    int size = 5;
    
    int* max = findMax(numbers, size);
    
    cout << "Maximum value: " << *max << endl;
    cout << "At address: " << max << endl;
    
    return 0;
}
```

</details>

---

## Challenge 3: Balance Updater

**Objective:** Function that updates balance via pointer.

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

bool updateBalance(double* balance, double amount, bool isDeposit) {
    if (isDeposit) {
        *balance += amount;
        return true;
    } else {
        // Withdrawal
        if (*balance >= amount) {
            *balance -= amount;
            return true;
        }
        return false;  // Insufficient funds
    }
}

int main() {
    double balance = 1000.00;
    
    cout << fixed << setprecision(2);
    cout << "Initial balance: PHP " << balance << endl;
    
    // Deposit
    if (updateBalance(&balance, 500, true)) {
        cout << "Deposit successful. New balance: PHP " << balance << endl;
    }
    
    // Withdrawal
    if (updateBalance(&balance, 300, false)) {
        cout << "Withdrawal successful. New balance: PHP " << balance << endl;
    }
    
    // Failed withdrawal
    if (!updateBalance(&balance, 2000, false)) {
        cout << "Withdrawal failed - insufficient funds!" << endl;
    }
    
    return 0;
}
```

</details>

---

## Key Takeaways

- Pointers store memory addresses
- `&` gets address, `*` dereferences
- Always initialize pointers (`nullptr`)
- Pointers enable pass-by-reference
- Powerful but requires careful handling

**Congratulations!** You've completed the core C++ lessons with exercises. Lessons 17-31 cover advanced topics and projects.