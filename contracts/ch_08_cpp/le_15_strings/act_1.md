# C++ Activity

Manipulate resident names using C++ string operations.

```cpp
#include <iostream>
#include <string>

using namespace std;

int main() {
    // 1. Two strings are declared for you
    string firstName = "Juan";
    string lastName = "Dela Cruz";

    // 2. TODO: Concatenate them into fullName with a space between
    // Your code here

    // 3. TODO: Print the full name and its length
    // Your code here

    // 4. TODO: Change the first character of fullName to 'R'
    // Your code here

    // 5. TODO: Print the modified fullName
    // Your code here

    return 0;
}
```

## Task for Learners

- Concatenate the two strings with a space:

  ```cpp
  string fullName = firstName + " " + lastName;
  ```

- Print the full name and its length:

  ```cpp
  cout << "Full Name: " << fullName << endl;
  cout << "Length: " << fullName.length() << " characters" << endl;
  ```

- Modify the first character and print the result:

  ```cpp
  fullName[0] = 'R';
  cout << "Modified: " << fullName << endl;
  ```

### Breakdown of the Activity

- **`string fullName = firstName + " " + lastName`**: The `+` operator joins strings together.
- **`.length()`**: Returns the number of characters in the string.
- **`fullName[0] = 'R'`**: Accesses the first character by index and replaces it.
