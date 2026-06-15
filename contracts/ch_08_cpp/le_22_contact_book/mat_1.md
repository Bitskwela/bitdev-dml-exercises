# Lesson 22: Contact Book Project

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+22.0+-+COVER.png)

## Scene

Kuya Miguel closed his laptop and turned to Tian. "You've learned variables, control flow, functions, arrays, pointers, structs, and enums. But can you combine them into a complete, working system?"

"Let's find out," Kuya Miguel said. "Build a **Contact Book System** for the barangay -- add contacts, search by name, and display all records. No tutorial this time. I'll provide requirements, you implement the solution."

This was different from previous lessons. Now Tian was expected to combine structs, enums, vectors, and functions into something that works together as a real application.

## C++ Topics: Building a CRUD System

![22.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+22.1.png)

### Combining Structs and Enums

> Use an enum for contact categories (`PERSONAL`, `WORK`, `EMERGENCY`) and a struct to hold contact data together with that category.

### Using Vectors for Storage

> `vector<Contact>` provides dynamic storage that grows automatically. Use `push_back()` to add contacts without worrying about array capacity.

### Search by Iteration

> Loop through the vector and compare fields to find matching contacts. Return early when a match is found, or report "not found" after the loop.

### Menu-Driven Programs

> Use a `do-while` loop with a `switch` statement to create an interactive menu that repeats until the user chooses to exit.

#### Sample syntax

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

string categoryToString(ContactCategory cat) {
    switch (cat) {
        case PERSONAL: return "Personal";
        case WORK: return "Work";
        case EMERGENCY: return "Emergency";
        default: return "Unknown";
    }
}

int main() {
    vector<Contact> book;
    book.push_back({"Juan Dela Cruz", "0917-123-4567", PERSONAL});
    for (const auto& c : book) {
        cout << c.name << " [" << categoryToString(c.category)
             << "] - " << c.phone << endl;
    }
    return 0;
}
```

The Contact struct holds related data, the enum categorizes contacts, and the vector stores them dynamically. A helper function converts the enum to a readable string. This pattern forms the foundation of any CRUD system.

## Common Pitfalls ⚠️

**1. The classic `cin >>` then `getline` buffer bug**

```cpp
cin >> choice;
getline(cin, name);   // ❌ grabs the leftover newline (empty name)
cin >> choice; cin.ignore();
getline(cin, name);   // ✅
```

**2. No exit path in the menu loop** — a `do/while` must let `choice == 4` (Exit) actually break, or it runs forever.

**3. Passing the vector by value**

```cpp
void addContact(vector<Contact> book)   // ❌ edits a COPY, lost on return
void addContact(vector<Contact>& book)  // ✅ by reference, changes persist
```

**4. Unsafe enum cast** — `static_cast<ContactCategory>(cat)` trusts the input; validate `cat` is 0-2 first.

**5. Searching with `==` on names** — exact match misses "juan" vs "Juan". Decide if search should be case-insensitive / partial.
