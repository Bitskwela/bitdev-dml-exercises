# Lesson 19: Structs

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+19.0+-+COVER.png)

## Scene

Tian's resident management system was a nightmare. Tracking 100 residents required three parallel arrays: `names[100]`, `ages[100]`, and `dues[100]`. If indices got misaligned, resident data became corrupted.

"This is insane!" Tian exclaimed. "If I add phone numbers and addresses, I'll need five more arrays!"

Kuya Miguel laughed. "They don't use parallel arrays. They use **structs** -- custom data types that bundle related information into a single package. Instead of three separate arrays, you create one array of Resident objects where each Resident contains name, age, and dues together."

## C++ Topics: Defining and Using Structs

![19.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+19.1.png)

### What is a Struct?

> A struct is a user-defined data type that groups related variables of different types under one name. Think of it as a blueprint for creating data records.

### Accessing Members

> Use the dot operator (`.`) to access struct members: `person.name`, `person.age`. For pointers to structs, use the arrow operator (`->`).

### Initializer List

> Structs can be initialized inline: `Resident person = {"Juan", 35, true};` assigns values in the order the members are declared.

### Structs as Function Parameters

> Pass structs by `const` reference for read-only efficiency, or by reference to modify the original. Passing by value copies the entire struct.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    bool isVaccinated;
};

int main() {
    Resident person1;
    person1.name = "Juan Dela Cruz";
    person1.age = 35;
    person1.isVaccinated = true;

    cout << "Resident Name: " << person1.name << endl;
    cout << "Age: " << person1.age << endl;
    cout << "Vaccinated: " << (person1.isVaccinated ? "Yes" : "No") << endl;
    return 0;
}
```

The `Resident` struct bundles name, age, and vaccination status into one unit. Members are accessed using the dot operator. This is far cleaner than managing three separate parallel arrays.
