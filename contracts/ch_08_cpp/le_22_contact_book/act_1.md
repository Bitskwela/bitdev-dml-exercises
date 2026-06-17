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

// Your code here: Implement a categoryToString helper function

// Your code here: Implement addContact, displayContacts, and searchContact functions

int main() {
    vector<Contact> contactBook;

    // Your code here: Create a menu loop (1=Add, 2=Display, 3=Search, 4=Exit)

    return 0;
}
```

## Task for Learners

- Implement a `categoryToString` helper that converts the enum to a readable string -- it must return exactly `"Personal"`, `"Work"`, `"Emergency"`, or `"Unknown"`:

  ```cpp
  string categoryToString(ContactCategory cat) {
      switch (cat) {
          case PERSONAL: return "Personal";
          case WORK: return "Work";
          case EMERGENCY: return "Emergency";
          default: return "Unknown";
      }
  }
  ```

- Implement `addContact` using these exact prompts (note `cin.ignore()` before the first `getline`), then push the contact and print `Contact added!`:

  ```cpp
  void addContact(vector<Contact>& book) {
      Contact c;
      cout << "Enter name: ";
      cin.ignore();
      getline(cin, c.name);
      cout << "Enter phone: ";
      getline(cin, c.phone);

      int cat;
      cout << "Select category (0:Personal, 1:Work, 2:Emergency): ";
      cin >> cat;
      c.category = static_cast<ContactCategory>(cat);

      book.push_back(c);
      cout << "Contact added!" << endl;
  }
  ```

- Implement `displayContacts` that prints the header `--- Contact List ---` then one line per contact in this exact format:

  ```cpp
  void displayContacts(const vector<Contact>& book) {
      cout << "\n--- Contact List ---" << endl;
      for (const auto& c : book) {
          cout << "Name: " << c.name << " | Phone: " << c.phone
               << " | Category: " << categoryToString(c.category) << endl;
      }
  }
  ```

- Implement `searchContact` that finds a contact by exact name match, printing the match as `Found: <name> [<Category>] - <phone>` or `Contact not found.` when there is no match:

  ```cpp
  void searchContact(const vector<Contact>& book) {
      string name;
      cout << "Enter name to search: ";
      cin.ignore();
      getline(cin, name);

      bool found = false;
      for (const auto& c : book) {
          if (c.name == name) {
              cout << "Found: " << c.name << " [" << categoryToString(c.category) << "] - " << c.phone << endl;
              found = true;
              break;
          }
      }
      if (!found) cout << "Contact not found." << endl;
  }
  ```

- Wire them together in a `do-while` menu loop (options 1-4) that prints this exact menu each iteration:

  ```cpp
  do {
      cout << "\n1. Add Contact\n2. Display All\n3. Search\n4. Exit\nChoice: ";
      cin >> choice;

      if (choice == 1) addContact(contactBook);
      else if (choice == 2) displayContacts(contactBook);
      else if (choice == 3) searchContact(contactBook);
  } while (choice != 4);
  ```

### Breakdown of the Activity

- **`vector<Contact>& book`**: Passing the vector by reference so additions persist outside the function.
- **`book.push_back(c)`**: Adds a new contact to the end of the dynamic vector.
- **`static_cast<ContactCategory>(cat)`**: Converts an integer input to the enum type safely.
- **`const auto& c : book`**: Range-based for loop that reads each contact without copying.
