# Lesson 22: Mini Project - Contact Book System

**Estimated Reading Time:** 12 minutes

---

## The Story

"Time for a real project, Tian!" Kuya Miguel announced. "Build a **Contact Book System** for the barangay. Use everything: structs, enums, arrays, functions!"

"I'm ready!" Tian said eagerly.

---

## Project Requirements

Build a contact book system that can:
1. Store multiple contacts
2. Add new contacts
3. Display all contacts
4. Search by name
5. Update contact information
6. Delete contacts
7. Save/load from file (bonus)

---

## Data Structures

```cpp
#include <iostream>
#include <string>
#include <fstream>
using namespace std;

enum class ContactType {
    PERSONAL,
    WORK,
    FAMILY,
    EMERGENCY
};

struct Address {
    string street;
    string barangay;
    string city;
    string zipCode;
};

struct Contact {
    int id;
    string name;
    string phone;
    string email;
    ContactType type;
    Address address;
    bool active;  // Soft delete
};

const int MAX_CONTACTS = 100;
Contact contacts[MAX_CONTACTS];
int contactCount = 0;
int nextId = 1;
```

---

## Helper Functions

### Type Conversion
```cpp
string typeToString(ContactType type) {
    switch (type) {
        case ContactType::PERSONAL:
            return "Personal";
        case ContactType::WORK:
            return "Work";
        case ContactType::FAMILY:
            return "Family";
        case ContactType::EMERGENCY:
            return "Emergency";
        default:
            return "Unknown";
    }
}

ContactType stringToType(const string& str) {
    if (str == "1" || str == "personal") return ContactType::PERSONAL;
    if (str == "2" || str == "work") return ContactType::WORK;
    if (str == "3" || str == "family") return ContactType::FAMILY;
    if (str == "4" || str == "emergency") return ContactType::EMERGENCY;
    return ContactType::PERSONAL;  // Default
}
```

---

## Core Features

### 1. Add Contact
```cpp
void addContact() {
    if (contactCount >= MAX_CONTACTS) {
        cout << "Contact book is full!\n";
        return;
    }
    
    Contact newContact;
    newContact.id = nextId++;
    newContact.active = true;
    
    cin.ignore();  // Clear input buffer
    
    cout << "\n===== ADD NEW CONTACT =====\n";
    cout << "Name: ";
    getline(cin, newContact.name);
    
    cout << "Phone: ";
    getline(cin, newContact.phone);
    
    cout << "Email: ";
    getline(cin, newContact.email);
    
    cout << "\nContact Type:\n";
    cout << "1. Personal\n";
    cout << "2. Work\n";
    cout << "3. Family\n";
    cout << "4. Emergency\n";
    cout << "Choice: ";
    string typeChoice;
    getline(cin, typeChoice);
    newContact.type = stringToType(typeChoice);
    
    cout << "\nAddress:\n";
    cout << "Street: ";
    getline(cin, newContact.address.street);
    
    cout << "Barangay: ";
    getline(cin, newContact.address.barangay);
    
    cout << "City: ";
    getline(cin, newContact.address.city);
    
    cout << "Zip Code: ";
    getline(cin, newContact.address.zipCode);
    
    contacts[contactCount++] = newContact;
    
    cout << "\n✓ Contact added successfully! (ID: " << newContact.id << ")\n";
}
```

---

### 2. Display All Contacts
```cpp
void displayContact(const Contact& c) {
    cout << "\n================================\n";
    cout << "ID: " << c.id << endl;
    cout << "Name: " << c.name << endl;
    cout << "Phone: " << c.phone << endl;
    cout << "Email: " << c.email << endl;
    cout << "Type: " << typeToString(c.type) << endl;
    cout << "Address:\n";
    cout << "  " << c.address.street << endl;
    cout << "  " << c.address.barangay << ", " << c.address.city;
    cout << " " << c.address.zipCode << endl;
    cout << "================================\n";
}

void displayAllContacts() {
    cout << "\n===== ALL CONTACTS =====\n";
    
    int activeCount = 0;
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            displayContact(contacts[i]);
            activeCount++;
        }
    }
    
    if (activeCount == 0) {
        cout << "No contacts found.\n";
    } else {
        cout << "\nTotal contacts: " << activeCount << endl;
    }
}
```

---

### 3. Search Contact
```cpp
int findContactByName(const string& name) {
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active && contacts[i].name == name) {
            return i;
        }
    }
    return -1;  // Not found
}

void searchContact() {
    cin.ignore();
    cout << "\nEnter name to search: ";
    string name;
    getline(cin, name);
    
    int index = findContactByName(name);
    
    if (index == -1) {
        cout << "Contact not found.\n";
    } else {
        displayContact(contacts[index]);
    }
}
```

---

### 4. Update Contact
```cpp
void updateContact() {
    cin.ignore();
    cout << "\nEnter name of contact to update: ";
    string name;
    getline(cin, name);
    
    int index = findContactByName(name);
    
    if (index == -1) {
        cout << "Contact not found.\n";
        return;
    }
    
    cout << "\nUpdating: " << contacts[index].name << endl;
    cout << "Leave blank to keep current value\n";
    
    cout << "\nNew phone (current: " << contacts[index].phone << "): ";
    string input;
    getline(cin, input);
    if (!input.empty()) {
        contacts[index].phone = input;
    }
    
    cout << "New email (current: " << contacts[index].email << "): ";
    getline(cin, input);
    if (!input.empty()) {
        contacts[index].email = input;
    }
    
    cout << "\n✓ Contact updated successfully!\n";
}
```

---

### 5. Delete Contact (Soft Delete)
```cpp
void deleteContact() {
    cin.ignore();
    cout << "\nEnter name of contact to delete: ";
    string name;
    getline(cin, name);
    
    int index = findContactByName(name);
    
    if (index == -1) {
        cout << "Contact not found.\n";
        return;
    }
    
    cout << "Are you sure you want to delete " << contacts[index].name << "? (y/n): ";
    char confirm;
    cin >> confirm;
    
    if (confirm == 'y' || confirm == 'Y') {
        contacts[index].active = false;  // Soft delete
        cout << "\n✓ Contact deleted successfully!\n";
    } else {
        cout << "Deletion cancelled.\n";
    }
}
```

---

## Menu System

```cpp
void displayMenu() {
    cout << "\n===== BARANGAY CONTACT BOOK =====\n";
    cout << "1. Add Contact\n";
    cout << "2. Display All Contacts\n";
    cout << "3. Search Contact\n";
    cout << "4. Update Contact\n";
    cout << "5. Delete Contact\n";
    cout << "6. Statistics\n";
    cout << "0. Exit\n";
    cout << "Choice: ";
}

int main() {
    int choice;
    
    do {
        displayMenu();
        cin >> choice;
        
        switch (choice) {
            case 1:
                addContact();
                break;
            case 2:
                displayAllContacts();
                break;
            case 3:
                searchContact();
                break;
            case 4:
                updateContact();
                break;
            case 5:
                deleteContact();
                break;
            case 6:
                displayStatistics();
                break;
            case 0:
                cout << "Thank you for using Contact Book!\n";
                break;
            default:
                cout << "Invalid choice!\n";
        }
        
    } while (choice != 0);
    
    return 0;
}
```

---

## Bonus: Statistics

```cpp
void displayStatistics() {
    cout << "\n===== STATISTICS =====\n";
    
    int activeCount = 0;
    int typeCounts[4] = {0};  // PERSONAL, WORK, FAMILY, EMERGENCY
    
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            activeCount++;
            int typeIndex = static_cast<int>(contacts[i].type);
            typeCounts[typeIndex]++;
        }
    }
    
    cout << "Total Active Contacts: " << activeCount << endl;
    cout << "\nBy Type:\n";
    cout << "  Personal: " << typeCounts[0] << endl;
    cout << "  Work: " << typeCounts[1] << endl;
    cout << "  Family: " << typeCounts[2] << endl;
    cout << "  Emergency: " << typeCounts[3] << endl;
}
```

---

## Complete Program

Here's the full working program:

```cpp
#include <iostream>
#include <string>
using namespace std;

enum class ContactType {
    PERSONAL,
    WORK,
    FAMILY,
    EMERGENCY
};

struct Address {
    string street;
    string barangay;
    string city;
    string zipCode;
};

struct Contact {
    int id;
    string name;
    string phone;
    string email;
    ContactType type;
    Address address;
    bool active;
};

const int MAX_CONTACTS = 100;
Contact contacts[MAX_CONTACTS];
int contactCount = 0;
int nextId = 1;

string typeToString(ContactType type) {
    switch (type) {
        case ContactType::PERSONAL: return "Personal";
        case ContactType::WORK: return "Work";
        case ContactType::FAMILY: return "Family";
        case ContactType::EMERGENCY: return "Emergency";
        default: return "Unknown";
    }
}

ContactType stringToType(const string& str) {
    if (str == "1" || str == "personal") return ContactType::PERSONAL;
    if (str == "2" || str == "work") return ContactType::WORK;
    if (str == "3" || str == "family") return ContactType::FAMILY;
    if (str == "4" || str == "emergency") return ContactType::EMERGENCY;
    return ContactType::PERSONAL;
}

void displayContact(const Contact& c) {
    cout << "\n================================\n";
    cout << "ID: " << c.id << endl;
    cout << "Name: " << c.name << endl;
    cout << "Phone: " << c.phone << endl;
    cout << "Email: " << c.email << endl;
    cout << "Type: " << typeToString(c.type) << endl;
    cout << "Address: " << c.address.street << ", ";
    cout << c.address.barangay << ", " << c.address.city << endl;
    cout << "================================\n";
}

void addContact() {
    if (contactCount >= MAX_CONTACTS) {
        cout << "Contact book is full!\n";
        return;
    }
    
    Contact newContact;
    newContact.id = nextId++;
    newContact.active = true;
    
    cin.ignore();
    cout << "\n===== ADD NEW CONTACT =====\n";
    cout << "Name: ";
    getline(cin, newContact.name);
    cout << "Phone: ";
    getline(cin, newContact.phone);
    cout << "Email: ";
    getline(cin, newContact.email);
    
    cout << "\nType (1=Personal, 2=Work, 3=Family, 4=Emergency): ";
    string typeChoice;
    getline(cin, typeChoice);
    newContact.type = stringToType(typeChoice);
    
    cout << "Street: ";
    getline(cin, newContact.address.street);
    cout << "Barangay: ";
    getline(cin, newContact.address.barangay);
    cout << "City: ";
    getline(cin, newContact.address.city);
    cout << "Zip: ";
    getline(cin, newContact.address.zipCode);
    
    contacts[contactCount++] = newContact;
    cout << "\n✓ Contact added! (ID: " << newContact.id << ")\n";
}

void displayAllContacts() {
    cout << "\n===== ALL CONTACTS =====\n";
    int count = 0;
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            displayContact(contacts[i]);
            count++;
        }
    }
    if (count == 0) cout << "No contacts.\n";
    else cout << "\nTotal: " << count << endl;
}

int findContactByName(const string& name) {
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active && contacts[i].name == name) {
            return i;
        }
    }
    return -1;
}

void searchContact() {
    cin.ignore();
    cout << "\nSearch name: ";
    string name;
    getline(cin, name);
    
    int index = findContactByName(name);
    if (index == -1) {
        cout << "Not found.\n";
    } else {
        displayContact(contacts[index]);
    }
}

void updateContact() {
    cin.ignore();
    cout << "\nUpdate name: ";
    string name;
    getline(cin, name);
    
    int index = findContactByName(name);
    if (index == -1) {
        cout << "Not found.\n";
        return;
    }
    
    cout << "New phone: ";
    getline(cin, contacts[index].phone);
    cout << "New email: ";
    getline(cin, contacts[index].email);
    
    cout << "\n✓ Updated!\n";
}

void deleteContact() {
    cin.ignore();
    cout << "\nDelete name: ";
    string name;
    getline(cin, name);
    
    int index = findContactByName(name);
    if (index == -1) {
        cout << "Not found.\n";
        return;
    }
    
    cout << "Delete " << contacts[index].name << "? (y/n): ";
    char confirm;
    cin >> confirm;
    
    if (confirm == 'y' || confirm == 'Y') {
        contacts[index].active = false;
        cout << "\n✓ Deleted!\n";
    }
}

void displayStatistics() {
    cout << "\n===== STATISTICS =====\n";
    int active = 0;
    int types[4] = {0};
    
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            active++;
            types[static_cast<int>(contacts[i].type)]++;
        }
    }
    
    cout << "Active: " << active << endl;
    cout << "Personal: " << types[0] << endl;
    cout << "Work: " << types[1] << endl;
    cout << "Family: " << types[2] << endl;
    cout << "Emergency: " << types[3] << endl;
}

void displayMenu() {
    cout << "\n===== CONTACT BOOK =====\n";
    cout << "1. Add\n2. Display All\n3. Search\n";
    cout << "4. Update\n5. Delete\n6. Statistics\n0. Exit\n";
    cout << "Choice: ";
}

int main() {
    int choice;
    
    do {
        displayMenu();
        cin >> choice;
        
        switch (choice) {
            case 1: addContact(); break;
            case 2: displayAllContacts(); break;
            case 3: searchContact(); break;
            case 4: updateContact(); break;
            case 5: deleteContact(); break;
            case 6: displayStatistics(); break;
            case 0: cout << "Goodbye!\n"; break;
            default: cout << "Invalid!\n";
        }
        
    } while (choice != 0);
    
    return 0;
}
```

---

## Summary

"I built a complete system!" Tian exclaimed proudly.

"Excellent work!" Kuya Miguel said. "You used:
- **Structs** for organizing data
- **Enums** for contact types
- **Arrays** for storage
- **Functions** for modularity
- **Nested structs** for address
- **Input validation**
- **Soft delete pattern**"

"Next chapter: **Object-Oriented Programming**!"

---

**Key Takeaways:**
1. Combine all concepts in real projects
2. Use enums for categories
3. Nested structs for complex data
4. Functions for modularity
5. Soft delete preserves data

**Next Lesson:** Classes and Objects - OOP Begins!
