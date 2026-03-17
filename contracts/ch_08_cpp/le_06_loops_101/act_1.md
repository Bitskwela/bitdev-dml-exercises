# C++ Activity

Tian automates the barangay garbage collection reminders using a loop instead of writing 50 lines by hand.

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== GARBAGE COLLECTION REMINDERS ===" << endl;

    // Use a for loop to print 50 numbered reminders

    return 0;
}
```

## Task for Learners

- Write a `for` loop that counts from 1 to 50.

  ```cpp
  for (int i = 1; i <= 50; i++) {
  ```

- Inside the loop, print: "Reminder #[number]: Please segregate your waste properly."

  ```cpp
  cout << "Reminder #" << i << ": Please segregate your waste properly." << endl;
  ```

- Make sure the loop counter `i` appears in each message.

### Breakdown of the Activity

- **`for (int i = 1; i <= 50; i++)`**: Initializes `i` at 1, runs while `i <= 50`, increments after each pass.
- **`i++`**: Shorthand for `i = i + 1`; increments the counter each iteration.
- **`cout << ... << i << ...`**: Chains the loop variable into the output string.
