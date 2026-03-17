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

// Your code here: Implement addContact function

// Your code here: Implement displayContacts function

// Your code here: Implement searchContact function

int main() {
    vector<Contact> contactBook;

    // Your code here: Create a menu loop (1=Add, 2=Display, 3=Search, 4=Exit)

    return 0;
}
