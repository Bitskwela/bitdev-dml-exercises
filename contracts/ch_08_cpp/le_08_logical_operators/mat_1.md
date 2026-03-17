# Logical Operators

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+8.0+-+COVER.png)

## Scene

Tian's barangay clearance system had a critical bug. It approved everyone who met ANY single requirement, not ALL requirements. A non-resident with unpaid dues? Approved. The barangay captain was furious.

"Kuya, I used if statements to check each requirement separately," Tian explained. "But the system treats them as individual checks. How do I make sure someone meets ALL conditions before approval?"

Kuya Miguel examined the code. "Think about airport security -- they don't just check if you have a ticket OR a passport OR went through screening. You need ALL of them. That's what logical operators do -- they combine multiple conditions into compound decision-making logic. Let's fix your clearance system!"

## C++ Topics: Logical Operators

![8.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+8.1.png)

### AND Operator (`&&`)

> Returns `true` only when BOTH conditions are true. Use it when all requirements must be met. Example: `if (age >= 18 && isRegistered)`

### OR Operator (`||`)

> Returns `true` when AT LEAST ONE condition is true. Use it when any one requirement is enough. Example: `if (isSenior || isPWD)`

### NOT Operator (`!`)

> Reverses a boolean value. `true` becomes `false` and vice versa. Example: `if (!hasPaid)` means "if has NOT paid."

### Combining Operators

> You can chain logical operators for complex conditions. Use parentheses for clarity: `if ((age >= 18 && hasID) || hasParentConsent)`

### Short-Circuit Evaluation

> With `&&`, if the first condition is `false`, the second is never checked. With `||`, if the first is `true`, the second is skipped. This can improve performance and prevent errors.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    int age = 20;
    bool isRegistered = true;

    if (age >= 18 && isRegistered) {
        cout << "Eligible to vote!" << endl;
    } else {
        cout << "Not eligible." << endl;
    }
    return 0;
}
```

This program uses the AND operator (`&&`) to ensure both conditions are true before granting eligibility. The voter must be 18 or older AND be registered. If either condition fails, the `else` block runs instead.
