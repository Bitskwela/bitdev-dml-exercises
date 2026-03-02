# C++ Activity:

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // 1. Declare two strings: firstName and lastName
    string firstName = "Juan";
    string lastName = "Dela Cruz";

    // 2. Concatenate them into a new string: fullName

    // 3. Print the full name and its length

    // 4. Change the first character of fullName to 'R'

    // 5. Print the modified fullName

    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: `std::string` class, string concatenation, `length()` function, character access and modification.

- Manipulate C++ strings:
  - Declare two `string` variables, `firstName` and `lastName`.
  - Create a third `string` variable, `fullName`, by concatenating `firstName`, a space, and `lastName`.
  - Print the `fullName` and its length using the `.length()` function.
  - Modify the first character of `fullName` and print the result.

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string firstName = "Juan";
    string lastName = "Dela Cruz";

    string fullName = firstName + " " + lastName;

    cout << "Full Name: " << fullName << endl;
    cout << "Length: " << fullName.length() << endl;

    fullName[0] = 'R';
    cout << "Modified: " << fullName << endl;

    return 0;
}
```
