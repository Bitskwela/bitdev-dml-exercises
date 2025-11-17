# Lesson 31: Final Challenge - Complete Barangay CRUD System

**Estimated Reading Time:** 15 minutes

---

## The Story

"Kuya, it's time for the final challenge!" Tian said confidently.

"Build a **complete CRUD system** for barangay management!" Kuya Miguel announced. "Use everything you've learned: OOP, templates, exceptions, STL — all of it!"

---

## Project Requirements

Build a complete barangay management system with:
1. **Create**: Add residents, clearances, and dues
2. **Read**: Display, search, and filter records
3. **Update**: Modify resident and payment information
4. **Delete**: Remove records (soft delete)
5. **File I/O**: Save and load data
6. **Exception Handling**: Robust error management
7. **STL**: Use vector, map for efficient storage

---

## Complete CRUD System

```cpp
#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <fstream>
#include <algorithm>
#include <stdexcept>
using namespace std;

// Custom Exceptions
class NotFoundException : public exception {
private:
    string msg;
public:
    NotFoundException(string m) : msg(m) {}
    const char* what() const noexcept override {
        return msg.c_str();
    }
};

class InvalidDataException : public exception {
private:
    string msg;
public:
    InvalidDataException(string m) : msg(m) {}
    const char* what() const noexcept override {
        return msg.c_str();
    }
};

// Base Person class
class Person {
protected:
    int id;
    string name;
    int age;
    bool active;
    
public:
    Person(int i, string n, int a) : id(i), name(n), age(a), active(true) {
        if (name.empty()) {
            throw InvalidDataException("Name cannot be empty");
        }
        if (age < 0 || age > 150) {
            throw InvalidDataException("Invalid age");
        }
    }
    
    virtual ~Person() {}
    
    virtual void display() const {
        cout << "ID: " << id << ", Name: " << name << ", Age: " << age;
    }
    
    int getId() const { return id; }
    string getName() const { return name; }
    int getAge() const { return age; }
    bool isActive() const { return active; }
    
    void setName(string n) {
        if (!n.empty()) name = n;
    }
    
    void setAge(int a) {
        if (a >= 0 && a <= 150) age = a;
    }
    
    void deactivate() { active = false; }
    void reactivate() { active = true; }
};

// Resident class
class Resident : public Person {
private:
    string barangay;
    double balance;
    
public:
    Resident(int i, string n, int a, string brgy) 
        : Person(i, n, a), barangay(brgy), balance(0) {}
    
    void addDues(double amount) {
        if (amount <= 0) {
            throw InvalidDataException("Amount must be positive");
        }
        balance += amount;
    }
    
    void makePayment(double amount) {
        if (amount <= 0) {
            throw InvalidDataException("Amount must be positive");
        }
        if (amount > balance) {
            throw InvalidDataException("Payment exceeds balance");
        }
        balance -= amount;
    }
    
    void display() const override {
        Person::display();
        cout << ", Barangay: " << barangay << ", Balance: P" << balance;
        cout << ", Status: " << (active ? "Active" : "Inactive") << endl;
    }
    
    string getBarangay() const { return barangay; }
    double getBalance() const { return balance; }
    
    string toFileString() const {
        return to_string(id) + "," + name + "," + to_string(age) + "," 
             + barangay + "," + to_string(balance) + "," + to_string(active);
    }
};

// Clearance class
class Clearance {
private:
    int id;
    int residentId;
    string type;
    double fee;
    string status;
    string date;
    
public:
    Clearance(int i, int rId, string t, double f, string d) 
        : id(i), residentId(rId), type(t), fee(f), status("pending"), date(d) {
        if (fee < 0) {
            throw InvalidDataException("Fee cannot be negative");
        }
    }
    
    void approve() { status = "approved"; }
    void reject() { status = "rejected"; }
    
    void display() const {
        cout << "Clearance ID: " << id << ", Resident ID: " << residentId
             << ", Type: " << type << ", Fee: P" << fee 
             << ", Status: " << status << ", Date: " << date << endl;
    }
    
    int getId() const { return id; }
    int getResidentId() const { return residentId; }
    string getStatus() const { return status; }
    string getType() const { return type; }
};

// Main Management System
class BarangaySystem {
private:
    vector<Resident*> residents;
    vector<Clearance*> clearances;
    map<int, int> residentIndex;
    int nextResidentId;
    int nextClearanceId;
    
public:
    BarangaySystem() : nextResidentId(1001), nextClearanceId(2001) {}
    
    ~BarangaySystem() {
        for (auto r : residents) delete r;
        for (auto c : clearances) delete c;
    }
    
    // CREATE
    void addResident(string name, int age, string barangay) {
        try {
            Resident* r = new Resident(nextResidentId++, name, age, barangay);
            residents.push_back(r);
            residentIndex[r->getId()] = residents.size() - 1;
            cout << "✓ Resident added: " << name << " (ID: " << r->getId() << ")\n";
        }
        catch (exception& e) {
            cout << "Error adding resident: " << e.what() << endl;
            nextResidentId--;  // Rollback ID
        }
    }
    
    void addClearance(int residentId, string type, double fee, string date) {
        if (!findResident(residentId)) {
            cout << "Error: Resident not found\n";
            return;
        }
        
        try {
            Clearance* c = new Clearance(nextClearanceId++, residentId, type, fee, date);
            clearances.push_back(c);
            cout << "✓ Clearance added (ID: " << c->getId() << ")\n";
        }
        catch (exception& e) {
            cout << "Error adding clearance: " << e.what() << endl;
            nextClearanceId--;
        }
    }
    
    // READ
    void displayAllResidents() {
        cout << "\n===== ALL RESIDENTS =====\n";
        int count = 0;
        for (auto r : residents) {
            if (r->isActive()) {
                r->display();
                count++;
            }
        }
        cout << "Total active residents: " << count << endl;
    }
    
    Resident* findResident(int id) {
        auto it = residentIndex.find(id);
        if (it != residentIndex.end()) {
            return residents[it->second];
        }
        return nullptr;
    }
    
    void searchResident(string name) {
        cout << "\n===== SEARCH RESULTS =====\n";
        int found = 0;
        for (auto r : residents) {
            if (r->isActive() && r->getName().find(name) != string::npos) {
                r->display();
                found++;
            }
        }
        if (found == 0) {
            cout << "No residents found\n";
        }
    }
    
    void displayClearances(int residentId = -1) {
        cout << "\n===== CLEARANCES =====\n";
        for (auto c : clearances) {
            if (residentId == -1 || c->getResidentId() == residentId) {
                c->display();
            }
        }
    }
    
    // UPDATE
    void updateResident(int id, string newName, int newAge) {
        Resident* r = findResident(id);
        if (!r) {
            cout << "Resident not found\n";
            return;
        }
        
        if (!newName.empty()) r->setName(newName);
        if (newAge > 0) r->setAge(newAge);
        cout << "✓ Resident updated\n";
    }
    
    void addDuesToResident(int id, double amount) {
        Resident* r = findResident(id);
        if (!r) {
            cout << "Resident not found\n";
            return;
        }
        
        try {
            r->addDues(amount);
            cout << "✓ Added P" << amount << " to " << r->getName() << "'s balance\n";
        }
        catch (exception& e) {
            cout << "Error: " << e.what() << endl;
        }
    }
    
    void makePayment(int id, double amount) {
        Resident* r = findResident(id);
        if (!r) {
            cout << "Resident not found\n";
            return;
        }
        
        try {
            r->makePayment(amount);
            cout << "✓ " << r->getName() << " paid P" << amount << endl;
        }
        catch (exception& e) {
            cout << "Error: " << e.what() << endl;
        }
    }
    
    void approveClearance(int clearanceId) {
        for (auto c : clearances) {
            if (c->getId() == clearanceId) {
                c->approve();
                cout << "✓ Clearance #" << clearanceId << " approved\n";
                return;
            }
        }
        cout << "Clearance not found\n";
    }
    
    // DELETE (Soft delete)
    void deleteResident(int id) {
        Resident* r = findResident(id);
        if (!r) {
            cout << "Resident not found\n";
            return;
        }
        
        r->deactivate();
        cout << "✓ Resident deactivated (ID: " << id << ")\n";
    }
    
    // STATISTICS
    void displayStatistics() {
        cout << "\n===== STATISTICS =====\n";
        cout << "Total residents: " << residents.size() << endl;
        
        int active = count_if(residents.begin(), residents.end(), 
                             [](Resident* r) { return r->isActive(); });
        cout << "Active: " << active << endl;
        cout << "Inactive: " << (residents.size() - active) << endl;
        
        double totalBalance = 0;
        for (auto r : residents) {
            if (r->isActive()) {
                totalBalance += r->getBalance();
            }
        }
        cout << "Total outstanding balance: P" << totalBalance << endl;
        
        cout << "Total clearances: " << clearances.size() << endl;
        
        int pending = count_if(clearances.begin(), clearances.end(),
                               [](Clearance* c) { return c->getStatus() == "pending"; });
        int approved = count_if(clearances.begin(), clearances.end(),
                                [](Clearance* c) { return c->getStatus() == "approved"; });
        
        cout << "Pending clearances: " << pending << endl;
        cout << "Approved clearances: " << approved << endl;
    }
    
    // FILE I/O
    void saveToFile(const string& filename) {
        ofstream file(filename);
        if (!file) {
            cout << "Error opening file for writing\n";
            return;
        }
        
        file << residents.size() << endl;
        for (auto r : residents) {
            file << r->toFileString() << endl;
        }
        
        file.close();
        cout << "✓ Data saved to " << filename << endl;
    }
};

// Main menu system
void displayMenu() {
    cout << "\n===== BARANGAY MANAGEMENT SYSTEM =====\n";
    cout << "1. Add Resident\n";
    cout << "2. Display All Residents\n";
    cout << "3. Search Resident\n";
    cout << "4. Update Resident\n";
    cout << "5. Delete Resident\n";
    cout << "6. Add Dues\n";
    cout << "7. Make Payment\n";
    cout << "8. Add Clearance\n";
    cout << "9. Display Clearances\n";
    cout << "10. Approve Clearance\n";
    cout << "11. Statistics\n";
    cout << "12. Save Data\n";
    cout << "0. Exit\n";
    cout << "Choice: ";
}

int main() {
    BarangaySystem system;
    
    // Sample data
    system.addResident("Juan Dela Cruz", 30, "San Antonio");
    system.addResident("Maria Santos", 25, "San Pedro");
    system.addResident("Pedro Reyes", 45, "San Jose");
    
    system.addDuesToResident(1001, 150);
    system.addDuesToResident(1002, 100);
    
    system.addClearance(1001, "Residence", 50, "2024-11-17");
    system.addClearance(1002, "Business", 100, "2024-11-17");
    
    int choice;
    do {
        displayMenu();
        cin >> choice;
        
        try {
            switch (choice) {
                case 1: {
                    string name, barangay;
                    int age;
                    cin.ignore();
                    cout << "Name: "; getline(cin, name);
                    cout << "Age: "; cin >> age;
                    cin.ignore();
                    cout << "Barangay: "; getline(cin, barangay);
                    system.addResident(name, age, barangay);
                    break;
                }
                case 2:
                    system.displayAllResidents();
                    break;
                case 3: {
                    string name;
                    cin.ignore();
                    cout << "Search name: "; getline(cin, name);
                    system.searchResident(name);
                    break;
                }
                case 6: {
                    int id;
                    double amount;
                    cout << "Resident ID: "; cin >> id;
                    cout << "Amount: "; cin >> amount;
                    system.addDuesToResident(id, amount);
                    break;
                }
                case 7: {
                    int id;
                    double amount;
                    cout << "Resident ID: "; cin >> id;
                    cout << "Amount: "; cin >> amount;
                    system.makePayment(id, amount);
                    break;
                }
                case 11:
                    system.displayStatistics();
                    break;
                case 12:
                    system.saveToFile("barangay_data.txt");
                    break;
                case 0:
                    cout << "Thank you for using Barangay Management System!\n";
                    break;
                default:
                    cout << "Invalid choice!\n";
            }
        }
        catch (exception& e) {
            cout << "Error: " << e.what() << endl;
        }
        
    } while (choice != 0);
    
    return 0;
}
```

---

## Summary

"I built a complete system!" Tian exclaimed proudly.

"Excellent work!" Kuya Miguel said. "You mastered:
- **OOP**: Classes, inheritance, polymorphism
- **Templates**: Generic programming
- **STL**: Vector, map, algorithms
- **Exceptions**: Robust error handling
- **CRUD**: Complete data management
- **File I/O**: Data persistence"

"You're now a C++ developer! Keep building, keep learning!"

---

**Congratulations! You've completed the C++ course!** 🎉

**What you've learned:**
1. C++ fundamentals and syntax
2. Control structures and functions
3. Pointers and memory management
4. Object-Oriented Programming
5. Templates and generic programming
6. Exception handling
7. STL and modern C++
8. Building complete applications

**Next steps:**
- Build more projects
- Learn C++17/C++20 features
- Explore advanced topics (multithreading, networking)
- Contribute to open-source projects
- Never stop coding!

**Mabuhay, Developer!** 🚀
