# C++ Activity

Combine structs, enums, and functions to build a functional Contact Book system for the barangay.

```cpp
#include <iostream>
#include <string>
#include <vector>
using namespace std;

enum ContactCategory { PERSONAL, WORK, EMERGENCY };

struct Contact {
    string name;
    string phone;
    ContactCategory category;
};

// Your code here: Implement addContact, displayContacts, and searchContact functions

int main() {
    vector<Contact> contactBook;

    // Your code here: Create a simple menu loop to add, display, and search contacts

    return 0;
}
```

## Task for Learners

- Implement `addContact` that prompts for name, phone, and category, then adds to the vector:

  ```cpp
  void addContact(vector<Contact>& book) {
      Contact c;
      // prompt and fill c, then book.push_back(c);
  }
  ```

- Implement `displayContacts` that loops through and prints all contacts.

- Implement `searchContact` that finds a contact by exact name match.

- Wire them together in a `do-while` menu loop with options 1-4.

### Breakdown of the Activity

- **`vector<Contact>& book`**: Passing the vector by reference so additions persist outside the function.
- **`book.push_back(c)`**: Adds a new contact to the end of the dynamic vector.
- **`static_cast<ContactCategory>(cat)`**: Converts an integer input to the enum type safely.
- **`const auto& c : book`**: Range-based for loop that reads each contact without copying.
