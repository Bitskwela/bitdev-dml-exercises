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

void displayContacts(const vector<Contact>& book) {
    cout << "\n--- Contact List ---" << endl;
    for (const auto& c : book) {
        cout << "Name: " << c.name << " | Phone: " << c.phone 
             << " | Category: " << categoryToString(c.category) << endl;
    }
}

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

int main() {
    vector<Contact> contactBook;
    int choice;
    
    do {
        cout << "\n1. Add Contact\n2. Display All\n3. Search\n4. Exit\nChoice: ";
        cin >> choice;
        
        if (choice == 1) addContact(contactBook);
        else if (choice == 2) displayContacts(contactBook);
        else if (choice == 3) searchContact(contactBook);
        
    } while (choice != 4);
    
    return 0;
}
