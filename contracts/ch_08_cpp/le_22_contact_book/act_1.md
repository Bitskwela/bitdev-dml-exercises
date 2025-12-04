# Lesson 22 Activities: Contact Book Project

## The Real Developer Test

Kuya Miguel closed his laptop: **"Can you combine everything you've learned into a complete, working system?"**

No tutorial this time. Just requirements. You architect the solution. You implement the features. You handle edge cases. **This is how real development works.**

Build a **Contact Book System** for the barangay—add contacts, search by name, update information, delete entries, display all records. Use structs, enums, arrays, functions. Clean code organization. Proper data management.

**This project proves you're ready to move from tutorial-following to actual software development!**

---

## Project Requirements

Build a contact book system that can:
1. ✅ Store multiple contacts
2. ✅ Add new contacts
3. ✅ Display all contacts
4. ✅ Search by name
5. ✅ Update contact information
6. ✅ Delete contacts
7. ✅ Use enums for contact types
8. ✅ Handle invalid input gracefully

---

## Starter Template

**Complete this implementation:**

```cpp
#include <iostream>
#include <string>
using namespace std;

enum ContactType {
    PERSONAL,
    WORK,
    FAMILY,
    EMERGENCY
};

struct Contact {
    int id;
    string name;
    string phone;
    string email;
    ContactType type;
    bool active;  // For soft delete
};

const int MAX_CONTACTS = 100;
Contact contacts[MAX_CONTACTS];
int contactCount = 0;
int nextId = 1;

// Helper function
string typeToString(ContactType type) {
    switch (type) {
        case PERSONAL: return "Personal";
        case WORK: return "Work";
        case FAMILY: return "Family";
        case EMERGENCY: return "Emergency";
        default: return "Unknown";
    }
}

// TODO: Implement these functions
void addContact();
void displayAllContacts();
void searchByName();
void updateContact();
void deleteContact();
void showMenu();

int main() {
    int choice;
    
    do {
        showMenu();
        cout << "Enter choice: ";
        cin >> choice;
        
        switch (choice) {
            case 1:
                addContact();
                break;
            case 2:
                displayAllContacts();
                break;
            case 3:
                searchByName();
                break;
            case 4:
                updateContact();
                break;
            case 5:
                deleteContact();
                break;
            case 0:
                cout << "Goodbye!" << endl;
                break;
            default:
                cout << "Invalid choice!" << endl;
        }
        
    } while (choice != 0);
    
    return 0;
}

void showMenu() {
    cout << "\n=== BARANGAY CONTACT BOOK ===" << endl;
    cout << "1. Add Contact" << endl;
    cout << "2. Display All Contacts" << endl;
    cout << "3. Search by Name" << endl;
    cout << "4. Update Contact" << endl;
    cout << "5. Delete Contact" << endl;
    cout << "0. Exit" << endl;
}
```

---

## Task 1: Implement addContact()

**Requirements:**
- Check if contact book is full
- Prompt for name, phone, email
- Let user select contact type (1-4)
- Assign unique ID
- Set active = true
- Add to array
- Increment contactCount

**Hint:**
```cpp
void addContact() {
    if (contactCount >= MAX_CONTACTS) {
        cout << "Contact book is full!" << endl;
        return;
    }
    
    Contact newContact;
    newContact.id = nextId++;
    newContact.active = true;
    
    cin.ignore();
    cout << "\nName: ";
    getline(cin, newContact.name);
    
    // TODO: Complete implementation
    
    contacts[contactCount++] = newContact;
    cout << "Contact added successfully!" << endl;
}
```

---

## Task 2: Implement displayAllContacts()

**Requirements:**
- Display header
- Loop through all contacts
- Show only active contacts
- Display ID, name, phone, email, type
- Show count of total contacts

**Example Output:**
```
=== ALL CONTACTS ===
ID   Name              Phone         Email               Type
----------------------------------------------------------------------
1    Juan Dela Cruz    09171234567   juan@email.com      Personal
2    Maria Santos      09187654321   maria@work.com      Work

Total active contacts: 2
```

---

## Task 3: Implement searchByName()

**Requirements:**
- Prompt for search term
- Search through all contacts
- Match partial names (case-insensitive if possible)
- Display matching contacts
- Handle "no results found"

**Hint:**
```cpp
void searchByName() {
    string searchTerm;
    cin.ignore();
    cout << "\nEnter name to search: ";
    getline(cin, searchTerm);
    
    bool found = false;
    cout << "\n=== SEARCH RESULTS ===" << endl;
    
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active && 
            contacts[i].name.find(searchTerm) != string::npos) {
            // Display contact
            found = true;
        }
    }
    
    if (!found) {
        cout << "No contacts found matching '" << searchTerm << "'" << endl;
    }
}
```

---

## Task 4: Implement updateContact()

**Requirements:**
- Prompt for contact ID
- Find contact by ID
- Display current information
- Let user update: name, phone, email, type
- Validate ID exists and is active
- Confirm update success

---

## Task 5: Implement deleteContact()

**Requirements:**
- Prompt for contact ID
- Find contact by ID
- Display contact to confirm
- Ask for confirmation (Y/N)
- Set active = false (soft delete)
- Don't actually remove from array

**Why soft delete?** Preserves history, allows undelete, maintains ID integrity.

---

## Task 6: Add Statistics Feature

**Challenge:** Add a menu option to show statistics.

**Display:**
- Total contacts
- Active contacts
- Deleted contacts
- Contacts by type (count each)

**Example:**
```
=== CONTACT STATISTICS ===
Total contacts: 10
Active: 8
Deleted: 2

By Type:
Personal: 3
Work: 4
Family: 1
Emergency: 0
```

---

## Task 7: Complete Working System

**Final Challenge:** Ensure all features work together seamlessly.

**Test Cases:**
1. Add 5 contacts with different types
2. Display all contacts
3. Search for a specific name
4. Update one contact's phone
5. Delete one contact
6. Display all (verify deleted contact doesn't show)
7. View statistics

**Code Quality Checklist:**
- ✅ Functions have clear purposes
- ✅ Variable names are meaningful
- ✅ Input validation prevents crashes
- ✅ User-friendly prompts and messages
- ✅ Consistent formatting
- ✅ No memory leaks (using arrays, not dynamic)
- ✅ Edge cases handled (empty list, ID not found, etc.)

---

<details>
<summary><strong>💡 Complete Solution Example</strong></summary>

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

enum ContactType {
    PERSONAL = 1,
    WORK = 2,
    FAMILY = 3,
    EMERGENCY = 4
};

struct Contact {
    int id;
    string name;
    string phone;
    string email;
    ContactType type;
    bool active;
};

const int MAX_CONTACTS = 100;
Contact contacts[MAX_CONTACTS];
int contactCount = 0;
int nextId = 1;

string typeToString(ContactType type) {
    switch (type) {
        case PERSONAL: return "Personal";
        case WORK: return "Work";
        case FAMILY: return "Family";
        case EMERGENCY: return "Emergency";
        default: return "Unknown";
    }
}

void addContact() {
    if (contactCount >= MAX_CONTACTS) {
        cout << "Contact book is full!" << endl;
        return;
    }
    
    Contact newContact;
    newContact.id = nextId++;
    newContact.active = true;
    
    cin.ignore();
    cout << "\n=== ADD NEW CONTACT ===" << endl;
    cout << "Name: ";
    getline(cin, newContact.name);
    
    cout << "Phone: ";
    getline(cin, newContact.phone);
    
    cout << "Email: ";
    getline(cin, newContact.email);
    
    cout << "\nContact Type:" << endl;
    cout << "1. Personal" << endl;
    cout << "2. Work" << endl;
    cout << "3. Family" << endl;
    cout << "4. Emergency" << endl;
    cout << "Choice: ";
    int typeChoice;
    cin >> typeChoice;
    newContact.type = (ContactType)typeChoice;
    
    contacts[contactCount++] = newContact;
    cout << "\n✓ Contact added successfully! (ID: " << newContact.id << ")" << endl;
}

void displayAllContacts() {
    cout << "\n=== ALL CONTACTS ===" << endl;
    cout << left << setw(5) << "ID" 
         << setw(20) << "Name" 
         << setw(15) << "Phone" 
         << setw(25) << "Email" 
         << setw(12) << "Type" << endl;
    cout << string(77, '-') << endl;
    
    int activeCount = 0;
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            cout << left << setw(5) << contacts[i].id
                 << setw(20) << contacts[i].name
                 << setw(15) << contacts[i].phone
                 << setw(25) << contacts[i].email
                 << setw(12) << typeToString(contacts[i].type) << endl;
            activeCount++;
        }
    }
    
    cout << "\nTotal active contacts: " << activeCount << endl;
}

void searchByName() {
    string searchTerm;
    cin.ignore();
    cout << "\nEnter name to search: ";
    getline(cin, searchTerm);
    
    cout << "\n=== SEARCH RESULTS ===" << endl;
    bool found = false;
    
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active && 
            contacts[i].name.find(searchTerm) != string::npos) {
            cout << "\nID: " << contacts[i].id << endl;
            cout << "Name: " << contacts[i].name << endl;
            cout << "Phone: " << contacts[i].phone << endl;
            cout << "Email: " << contacts[i].email << endl;
            cout << "Type: " << typeToString(contacts[i].type) << endl;
            found = true;
        }
    }
    
    if (!found) {
        cout << "No contacts found matching '" << searchTerm << "'" << endl;
    }
}

void updateContact() {
    int id;
    cout << "\nEnter contact ID to update: ";
    cin >> id;
    
    int index = -1;
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].id == id && contacts[i].active) {
            index = i;
            break;
        }
    }
    
    if (index == -1) {
        cout << "Contact not found!" << endl;
        return;
    }
    
    cout << "\n=== UPDATE CONTACT #" << id << " ===" << endl;
    cout << "Current: " << contacts[index].name << endl;
    
    cin.ignore();
    cout << "New name (or press Enter to keep): ";
    string newName;
    getline(cin, newName);
    if (!newName.empty()) {
        contacts[index].name = newName;
    }
    
    cout << "New phone (or press Enter to keep): ";
    string newPhone;
    getline(cin, newPhone);
    if (!newPhone.empty()) {
        contacts[index].phone = newPhone;
    }
    
    cout << "New email (or press Enter to keep): ";
    string newEmail;
    getline(cin, newEmail);
    if (!newEmail.empty()) {
        contacts[index].email = newEmail;
    }
    
    cout << "\n✓ Contact updated successfully!" << endl;
}

void deleteContact() {
    int id;
    cout << "\nEnter contact ID to delete: ";
    cin >> id;
    
    int index = -1;
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].id == id && contacts[i].active) {
            index = i;
            break;
        }
    }
    
    if (index == -1) {
        cout << "Contact not found!" << endl;
        return;
    }
    
    cout << "\nDelete contact: " << contacts[index].name << "?" << endl;
    cout << "Confirm (Y/N): ";
    char confirm;
    cin >> confirm;
    
    if (confirm == 'Y' || confirm == 'y') {
        contacts[index].active = false;
        cout << "✓ Contact deleted successfully!" << endl;
    } else {
        cout << "Deletion cancelled." << endl;
    }
}

void showMenu() {
    cout << "\n=== BARANGAY CONTACT BOOK ===" << endl;
    cout << "1. Add Contact" << endl;
    cout << "2. Display All Contacts" << endl;
    cout << "3. Search by Name" << endl;
    cout << "4. Update Contact" << endl;
    cout << "5. Delete Contact" << endl;
    cout << "0. Exit" << endl;
}

int main() {
    int choice;
    
    cout << "Welcome to Barangay Contact Book System!" << endl;
    
    do {
        showMenu();
        cout << "Enter choice: ";
        cin >> choice;
        
        switch (choice) {
            case 1:
                addContact();
                break;
            case 2:
                displayAllContacts();
                break;
            case 3:
                searchByName();
                break;
            case 4:
                updateContact();
                break;
            case 5:
                deleteContact();
                break;
            case 0:
                cout << "\nThank you for using the Contact Book!" << endl;
                break;
            default:
                cout << "Invalid choice! Please try again." << endl;
        }
        
    } while (choice != 0);
    
    return 0;
}
```

</details>

---

**This is your first complete system!** Every function matters. Every detail counts. Make it work, then make it better! 🚀
