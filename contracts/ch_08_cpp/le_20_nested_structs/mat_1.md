# Lesson 20: Nested Structs

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+20.0+-+COVER.png)

## Scene

Tian's Resident struct worked great for basic info, but now the barangay needed full birth dates: day, month, and year. Should each become a separate field in Resident?

"That'll make the struct huge," Tian thought aloud. "And what if I need dates for other things too? Do I duplicate all those fields?"

Kuya Miguel saw the dilemma. "This is where **nested structs** shine. A date is its own concept, so create a Date struct. Then a Resident has a Date. You're building with modular, reusable components."

## C++ Topics: Structs Inside Structs

![20.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+20.1.png)

### Nested Struct Definition

> Structs can contain other structs as members. Define the inner struct first, then use it as a member type in the outer struct.

### Accessing Nested Members

> Chain the dot operator to reach nested fields: `person.birthDate.year`. Each dot drills one level deeper into the hierarchy.

### Initializing Nested Structs

> Use nested braces for inline initialization: `Resident r = {"Juan", {30, 12, 1861}};` where the inner braces initialize the nested struct.

### Reusability

> Once defined, a struct like `Date` can be reused in multiple places -- Resident, Transaction, Clearance -- without duplicating fields.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

struct Date {
    int day;
    int month;
    int year;
};

struct Resident {
    string name;
    Date birthDate;
};

int main() {
    Resident person;
    person.name = "Crisostomo Ibarra";
    person.birthDate.day = 30;
    person.birthDate.month = 12;
    person.birthDate.year = 1861;

    cout << "Resident: " << person.name << endl;
    cout << "Birth Date: "
         << setfill('0') << setw(2) << person.birthDate.day << "/"
         << setfill('0') << setw(2) << person.birthDate.month << "/"
         << person.birthDate.year << endl;
    return 0;
}
```

The `Date` struct is defined separately, then used as a member inside `Resident`. Accessing nested members uses chained dots: `person.birthDate.year`. This keeps data organized and the `Date` struct reusable.
