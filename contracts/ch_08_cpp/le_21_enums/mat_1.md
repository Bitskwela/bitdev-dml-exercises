# Lesson 21: Enums

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+21.0+-+COVER.png)

## Scene

Tian stared at the bug report: "Clearance type 4 crashes the system." Looking at the code, clearance types were defined as integers: 0 = Residence, 1 = Business, 2 = Travel. Someone passed 4, and the program had no idea what to do.

"What does `status = 2` even mean?" Tian complained. "And there's nothing stopping someone from passing 99 or -5!"

Kuya Miguel nodded. "You're using **magic numbers** -- a classic code smell. This is where **enums** save the day. Instead of cryptic numbers, you define meaningful names: `CAPTAIN`, `KAGAWAD`, `SECRETARY`. The code becomes self-documenting."

## C++ Topics: Enumerated Types

![21.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+21.1.png)

### What Are Enums?

> Enums (enumerations) create a set of named integer constants. By default, the first value is 0 and each subsequent value increments by 1.

### Enum with Switch Statements

> Enums pair naturally with `switch` statements, making control flow readable: `case CAPTAIN:` is far clearer than `case 0:`.

### Custom Values

> You can assign specific integer values to enum members: `enum Fee { RESIDENCE = 50, BUSINESS = 100 };` to encode data directly.

### Enum Class (C++11)

> `enum class` provides stronger type safety by scoping values: `Color::RED` and `TrafficLight::RED` can coexist without conflict.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

enum BarangayPosition {
    CAPTAIN,     // 0
    KAGAWAD,     // 1
    SECRETARY,   // 2
    TREASURER    // 3
};

int main() {
    BarangayPosition pos = SECRETARY;

    switch (pos) {
        case CAPTAIN:
            cout << "The Captain leads the barangay." << endl;
            break;
        case KAGAWAD:
            cout << "The Kagawad helps pass ordinances." << endl;
            break;
        case SECRETARY:
            cout << "The Secretary handles all records." << endl;
            break;
        case TREASURER:
            cout << "The Treasurer manages the funds." << endl;
            break;
    }
    return 0;
}
```

The `BarangayPosition` enum replaces magic numbers with readable names. The switch statement uses enum values directly, making the code self-documenting. Default values start at 0 and increment automatically.
