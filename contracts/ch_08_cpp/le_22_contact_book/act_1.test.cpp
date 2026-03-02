#include <iostream>
#include <cassert>
#include <string>
#include <vector>

using namespace std;

enum ContactCategory { PERSONAL, WORK, EMERGENCY };

struct Contact {
    string name;
    string phone;
    ContactCategory category;
};

void testContactBook() {
    vector<Contact> contactBook;
    
    // Test Adding
    contactBook.push_back({"Juan Dela Cruz", "0917-123-4567", PERSONAL});
    assert(contactBook.size() == 1 && "Task: Contact addition failed.");
    assert(contactBook[0].name == "Juan Dela Cruz" && "Task: Incorrect contact name.");
    
    // Test Searching
    string searchName = "Juan Dela Cruz";
    bool found = false;
    for (const auto& c : contactBook) {
        if (c.name == searchName) {
            found = true;
            break;
        }
    }
    assert(found && "Task: Search function failed.");
    
    cout << "Test Task (Contact Book Implementation): PASS" << endl;
}

int main() {
    cout << "Running Lesson 22 Tests..." << endl;
    testContactBook();
    cout << "All Lesson 22 tests passed!" << endl;
    return 0;
}

