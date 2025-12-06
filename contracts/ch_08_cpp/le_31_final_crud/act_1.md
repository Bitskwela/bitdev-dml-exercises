# Lesson 31 Activities: Final CRUD Project

## The Final Test

"You've learned everything from variables to STL," the barangay captain said. "Now build a **complete, professional system**—the Barangay Resident Management System with full CRUD operations, file persistence, and everything we've covered!"

**This is your final project—integrating all 31 lessons:**
- Variables, data types, operators (Lessons 1-3)
- I/O, control flow, loops (Lessons 4-7)
- Functions, arrays, strings (Lessons 8-13)
- Pointers, dynamic memory, file I/O (Lessons 14-17)
- Structs, enums (Lessons 18-21)
- OOP: classes, constructors, encapsulation, inheritance, polymorphism (Lessons 23-27)
- Templates, exceptions, STL (Lessons 28-30)

**Requirements:**
✅ CRUD operations (Create, Read, Update, Delete)  
✅ File persistence (save/load from file)  
✅ Class hierarchy with inheritance  
✅ Exception handling  
✅ STL containers  
✅ Menu-driven interface  
✅ Input validation  

This is **portfolio-worthy code**—professional quality!

---

## Project Structure

**Three main classes:**
1. **Person** (base class) - name, age, contact
2. **Resident** (derived) - residentID, address, status
3. **ResidentManager** - manages all residents, file I/O, CRUD operations

---

## Starter Code Template

```cpp
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <stdexcept>
using namespace std;

// Base class
class Person {
protected:
    string name;
    int age;
    string contact;
    
public:
    Person(string n = "", int a = 0, string c = "")
        : name(n), age(a), contact(c) {}
    
    virtual ~Person() {}
    
    // Getters
    string getName() const { return name; }
    int getAge() const { return age; }
    string getContact() const { return contact; }
    
    // Setters with validation
    void setName(string n) {
        if (n.empty()) {
            throw invalid_argument("Name cannot be empty");
        }
        name = n;
    }
    
    void setAge(int a) {
        if (a < 0 || a > 150) {
            throw out_of_range("Age must be between 0 and 150");
        }
        age = a;
    }
    
    void setContact(string c) {
        contact = c;
    }
    
    virtual void display() const {
        cout << "Name: " << name << endl;
        cout << "Age: " << age << endl;
        cout << "Contact: " << contact << endl;
    }
};

// Derived class
class Resident : public Person {
private:
    int residentID;
    string address;
    string status;  // "Active" or "Inactive"
    
public:
    Resident(int id = 0, string n = "", int a = 0, string c = "",
             string addr = "", string stat = "Active")
        : Person(n, a, c), residentID(id), address(addr), status(stat) {}
    
    // Getters
    int getResidentID() const { return residentID; }
    string getAddress() const { return address; }
    string getStatus() const { return status; }
    
    // Setters
    void setResidentID(int id) { residentID = id; }
    void setAddress(string addr) { address = addr; }
    void setStatus(string stat) { status = stat; }
    
    void display() const override {
        cout << "=== Resident Information ===" << endl;
        cout << "ID: " << residentID << endl;
        Person::display();
        cout << "Address: " << address << endl;
        cout << "Status: " << status << endl;
    }
    
    // Serialize to file format
    string toFileFormat() const {
        return to_string(residentID) + "|" + name + "|" + 
               to_string(age) + "|" + contact + "|" + 
               address + "|" + status;
    }
    
    // Deserialize from file format
    static Resident fromFileFormat(const string& line) {
        // Parse: ID|Name|Age|Contact|Address|Status
        // TODO: Implement string parsing
        Resident r;
        // ... parse line and set fields
        return r;
    }
};

// Manager class
class ResidentManager {
private:
    vector<Resident> residents;
    string filename;
    int nextID;
    
public:
    ResidentManager(string file = "residents.txt") 
        : filename(file), nextID(1001) {
        loadFromFile();
    }
    
    // CREATE
    void addResident() {
        // TODO: Implement
        // Get input, validate, create Resident, add to vector
        // Use exception handling for validation
    }
    
    // READ
    void displayAll() {
        // TODO: Implement
        // Loop through vector and display each resident
    }
    
    void searchByID() {
        // TODO: Implement
        // Get ID, find resident, display
    }
    
    void searchByName() {
        // TODO: Implement
        // Get name, find matching residents, display
    }
    
    // UPDATE
    void updateResident() {
        // TODO: Implement
        // Get ID, find resident, get new data, update
    }
    
    // DELETE (soft delete - set status to Inactive)
    void deleteResident() {
        // TODO: Implement
        // Get ID, find resident, set status to Inactive
    }
    
    // File operations
    void saveToFile() {
        try {
            ofstream file(filename);
            if (!file.is_open()) {
                throw runtime_error("Cannot open file for writing");
            }
            
            for (const Resident& r : residents) {
                file << r.toFileFormat() << endl;
            }
            
            file.close();
            cout << "Data saved successfully!" << endl;
        }
        catch (exception& e) {
            cout << "Error saving: " << e.what() << endl;
        }
    }
    
    void loadFromFile() {
        // TODO: Implement
        // Open file, read lines, parse, create Residents, add to vector
        // Calculate nextID based on max ID in file
    }
    
    // Utility
    int getNextID() {
        return nextID++;
    }
};

// Main menu
void displayMenu() {
    cout << "\n=== Barangay Resident Management System ===" << endl;
    cout << "1. Add Resident" << endl;
    cout << "2. Display All Residents" << endl;
    cout << "3. Search by ID" << endl;
    cout << "4. Search by Name" << endl;
    cout << "5. Update Resident" << endl;
    cout << "6. Delete Resident (Deactivate)" << endl;
    cout << "7. Save and Exit" << endl;
    cout << "Choice: ";
}

int main() {
    ResidentManager manager;
    int choice;
    
    do {
        displayMenu();
        cin >> choice;
        cin.ignore();  // Clear newline
        
        try {
            switch (choice) {
                case 1:
                    manager.addResident();
                    break;
                case 2:
                    manager.displayAll();
                    break;
                case 3:
                    manager.searchByID();
                    break;
                case 4:
                    manager.searchByName();
                    break;
                case 5:
                    manager.updateResident();
                    break;
                case 6:
                    manager.deleteResident();
                    break;
                case 7:
                    manager.saveToFile();
                    cout << "Exiting..." << endl;
                    break;
                default:
                    cout << "Invalid choice!" << endl;
            }
        }
        catch (exception& e) {
            cout << "Error: " << e.what() << endl;
        }
        
    } while (choice != 7);
    
    return 0;
}
```

---

## Task 1: Implement File Parsing

**Goal:** Complete `Resident::fromFileFormat()` to parse file lines.

**Hint:** Use `find()` and `substr()` to split by `|` delimiter.

**Example:**
```cpp
static Resident fromFileFormat(const string& line) {
    // Parse: ID|Name|Age|Contact|Address|Status
    Resident r;
    
    size_t pos = 0;
    size_t nextPos;
    
    // Extract ID
    nextPos = line.find('|', pos);
    r.setResidentID(stoi(line.substr(pos, nextPos - pos)));
    pos = nextPos + 1;
    
    // Extract Name
    nextPos = line.find('|', pos);
    r.setName(line.substr(pos, nextPos - pos));
    pos = nextPos + 1;
    
    // ... continue for Age, Contact, Address, Status
    
    return r;
}
```

# Tasks for Learners

- Implement the `fromFileFormat()` method to parse pipe-delimited file lines into Resident objects using `find()` and `substr()`.

  ```cpp
  static Resident fromFileFormat(const string& line) {
      // Parse: ID|Name|Age|Contact|Address|Status
      Resident r;
      
      size_t pos = 0;
      size_t nextPos;
      
      // Extract ID
      nextPos = line.find('|', pos);
      r.setResidentID(stoi(line.substr(pos, nextPos - pos)));
      pos = nextPos + 1;
      
      // Extract Name
      nextPos = line.find('|', pos);
      r.setName(line.substr(pos, nextPos - pos));
      pos = nextPos + 1;
      
      // Extract Age
      nextPos = line.find('|', pos);
      r.setAge(stoi(line.substr(pos, nextPos - pos)));
      pos = nextPos + 1;
      
      // Extract Contact
      nextPos = line.find('|', pos);
      r.setContact(line.substr(pos, nextPos - pos));
      pos = nextPos + 1;
      
      // Extract Address
      nextPos = line.find('|', pos);
      r.setAddress(line.substr(pos, nextPos - pos));
      pos = nextPos + 1;
      
      // Extract Status
      r.setStatus(line.substr(pos));
      
      return r;
  }
  ```

---

## Task 2: Implement CREATE Operation

**Goal:** Complete `addResident()` to add new resident with validation.

**Steps:**
1. Get input from user (name, age, contact, address)
2. Validate each field (use exceptions for errors)
3. Create Resident with next ID
4. Add to vector
5. Display success message

**Example:**
```cpp
void addResident() {
    cout << "\n=== Add New Resident ===" << endl;
    
    string name, contact, address;
    int age;
    
    cout << "Name: ";
    getline(cin, name);
    
    cout << "Age: ";
    cin >> age;
    cin.ignore();
    
    cout << "Contact: ";
    getline(cin, contact);
    
    cout << "Address: ";
    getline(cin, address);
    
    Resident r(getNextID(), name, age, contact, address);
    residents.push_back(r);
    
    cout << "Resident added successfully with ID: " << r.getResidentID() << endl;
}
```

# Tasks for Learners

- Implement the CREATE operation by gathering user input, validating fields, creating a new Resident object, and adding it to the vector.

  ```cpp
  void addResident() {
      cout << "\n=== Add New Resident ===" << endl;
      
      string name, contact, address;
      int age;
      
      cout << "Name: ";
      getline(cin, name);
      
      cout << "Age: ";
      cin >> age;
      cin.ignore();
      
      cout << "Contact: ";
      getline(cin, contact);
      
      cout << "Address: ";
      getline(cin, address);
      
      Resident r(getNextID(), name, age, contact, address);
      residents.push_back(r);
      
      cout << "Resident added successfully with ID: " << r.getResidentID() << endl;
  }
  ```

---

## Task 3: Implement READ Operations

**Goal:** Complete `displayAll()`, `searchByID()`, and `searchByName()`.

**displayAll():**
```cpp
void displayAll() {
    if (residents.empty()) {
        cout << "No residents found." << endl;
        return;
    }
    
    cout << "\n=== All Residents ===" << endl;
    for (const Resident& r : residents) {
        r.display();
        cout << "-------------------" << endl;
    }
}
```

**searchByID():**
```cpp
void searchByID() {
    int id;
    cout << "Enter Resident ID: ";
    cin >> id;
    
    auto it = find_if(residents.begin(), residents.end(),
                     [id](const Resident& r) { return r.getResidentID() == id; });
    
    if (it != residents.end()) {
        it->display();
    } else {
        cout << "Resident not found." << endl;
    }
}
```

# Tasks for Learners

- Implement READ operations: `displayAll()` to show all residents, `searchByID()` to find by ID using `find_if()`, and `searchByName()` to search by name.

  ```cpp
  void displayAll() {
      if (residents.empty()) {
          cout << "No residents found." << endl;
          return;
      }
      
      cout << "\n=== All Residents ===" << endl;
      for (const Resident& r : residents) {
          r.display();
          cout << "-------------------" << endl;
      }
  }

  void searchByID() {
      int id;
      cout << "Enter Resident ID: ";
      cin >> id;
      
      auto it = find_if(residents.begin(), residents.end(),
                       [id](const Resident& r) { return r.getResidentID() == id; });
      
      if (it != residents.end()) {
          it->display();
      } else {
          cout << "Resident not found." << endl;
      }
  }

  void searchByName() {
      string name;
      cout << "Enter Name to search: ";
      getline(cin, name);
      
      bool found = false;
      cout << "\n=== Search Results ===" << endl;
      for (const Resident& r : residents) {
          if (r.getName().find(name) != string::npos) {
              r.display();
              cout << "-------------------" << endl;
              found = true;
          }
      }
      
      if (!found) {
          cout << "No residents found with name containing '" << name << "'" << endl;
      }
  }
  ```

---

## Task 4: Implement UPDATE Operation

**Goal:** Complete `updateResident()` to modify resident data.

**Steps:**
1. Get resident ID
2. Find resident in vector
3. Display current data
4. Get new data from user
5. Update resident
6. Display success message

**Example:**
```cpp
void updateResident() {
    int id;
    cout << "Enter Resident ID to update: ";
    cin >> id;
    cin.ignore();
    
    auto it = find_if(residents.begin(), residents.end(),
                     [id](const Resident& r) { return r.getResidentID() == id; });
    
    if (it == residents.end()) {
        cout << "Resident not found." << endl;
        return;
    }
    
    cout << "\n=== Current Data ===" << endl;
    it->display();
    
    cout << "\n=== Enter New Data ===" << endl;
    
    string name;
    cout << "Name (" << it->getName() << "): ";
    getline(cin, name);
    if (!name.empty()) {
        it->setName(name);
    }
    
    // ... continue for other fields
    
    cout << "Resident updated successfully!" << endl;
}
```

# Tasks for Learners

- Implement the UPDATE operation by finding a resident by ID, displaying current data, prompting for new data (allowing blank to keep current), and updating the fields.

  ```cpp
  void updateResident() {
      int id;
      cout << "Enter Resident ID to update: ";
      cin >> id;
      cin.ignore();
      
      auto it = find_if(residents.begin(), residents.end(),
                       [id](const Resident& r) { return r.getResidentID() == id; });
      
      if (it == residents.end()) {
          cout << "Resident not found." << endl;
          return;
      }
      
      cout << "\n=== Current Data ===" << endl;
      it->display();
      
      cout << "\n=== Enter New Data (press Enter to keep current) ===" << endl;
      
      string name;
      cout << "Name (" << it->getName() << "): ";
      getline(cin, name);
      if (!name.empty()) {
          it->setName(name);
      }
      
      string ageStr;
      cout << "Age (" << it->getAge() << "): ";
      getline(cin, ageStr);
      if (!ageStr.empty()) {
          it->setAge(stoi(ageStr));
      }
      
      string contact;
      cout << "Contact (" << it->getContact() << "): ";
      getline(cin, contact);
      if (!contact.empty()) {
          it->setContact(contact);
      }
      
      string address;
      cout << "Address (" << it->getAddress() << "): ";
      getline(cin, address);
      if (!address.empty()) {
          it->setAddress(address);
      }
      
      cout << "Resident updated successfully!" << endl;
  }
  ```

---

## Task 5: Implement DELETE Operation

**Goal:** Complete `deleteResident()` (soft delete - set status to Inactive).

**Example:**
```cpp
void deleteResident() {
    int id;
    cout << "Enter Resident ID to delete: ";
    cin >> id;
    
    auto it = find_if(residents.begin(), residents.end(),
                     [id](const Resident& r) { return r.getResidentID() == id; });
    
    if (it == residents.end()) {
        cout << "Resident not found." << endl;
        return;
    }
    
    it->setStatus("Inactive");
    cout << "Resident deactivated successfully!" << endl;
}
```

# Tasks for Learners

- Implement the DELETE operation using soft delete by finding the resident and setting their status to "Inactive" instead of removing from the vector.

  ```cpp
  void deleteResident() {
      int id;
      cout << "Enter Resident ID to delete: ";
      cin >> id;
      
      auto it = find_if(residents.begin(), residents.end(),
                       [id](const Resident& r) { return r.getResidentID() == id; });
      
      if (it == residents.end()) {
          cout << "Resident not found." << endl;
          return;
      }
      
      it->setStatus("Inactive");
      cout << "Resident deactivated successfully!" << endl;
  }
  ```

---

## Task 6: Implement File Loading

**Goal:** Complete `loadFromFile()` to load data at startup.

**Example:**
```cpp
void loadFromFile() {
    ifstream file(filename);
    if (!file.is_open()) {
        cout << "No existing data file. Starting fresh." << endl;
        return;
    }
    
    string line;
    int maxID = 1000;
    
    while (getline(file, line)) {
        if (line.empty()) continue;
        
        try {
            Resident r = Resident::fromFileFormat(line);
            residents.push_back(r);
            
            if (r.getResidentID() > maxID) {
                maxID = r.getResidentID();
            }
        }
        catch (exception& e) {
            cout << "Error loading resident: " << e.what() << endl;
        }
    }
    
    nextID = maxID + 1;
    file.close();
    
    cout << "Loaded " << residents.size() << " residents." << endl;
}
```

# Tasks for Learners

- Implement file loading to read resident data from a file at startup, parse each line, populate the vector, and calculate the next available ID.

  ```cpp
  void loadFromFile() {
      ifstream file(filename);
      if (!file.is_open()) {
          cout << "No existing data file. Starting fresh." << endl;
          return;
      }
      
      string line;
      int maxID = 1000;
      
      while (getline(file, line)) {
          if (line.empty()) continue;
          
          try {
              Resident r = Resident::fromFileFormat(line);
              residents.push_back(r);
              
              if (r.getResidentID() > maxID) {
                  maxID = r.getResidentID();
              }
          }
          catch (exception& e) {
              cout << "Error loading resident: " << e.what() << endl;
          }
      }
      
      nextID = maxID + 1;
      file.close();
      
      cout << "Loaded " << residents.size() << " residents." << endl;
  }
  ```

---

## Task 7: Add Advanced Features

**Optional enhancements:**

1. **Sort residents by name:**
```cpp
void sortByName() {
    sort(residents.begin(), residents.end(),
         [](const Resident& a, const Resident& b) {
             return a.getName() < b.getName();
         });
    cout << "Residents sorted by name!" << endl;
}
```

2. **Statistics:**
```cpp
void displayStatistics() {
    int active = count_if(residents.begin(), residents.end(),
                         [](const Resident& r) { return r.getStatus() == "Active"; });
    
    int seniors = count_if(residents.begin(), residents.end(),
                          [](const Resident& r) { return r.getAge() >= 60; });
    
    cout << "Total residents: " << residents.size() << endl;
    cout << "Active: " << active << endl;
    cout << "Inactive: " << (residents.size() - active) << endl;
    cout << "Senior citizens: " << seniors << endl;
}
```

3. **Export to CSV:**
```cpp
void exportToCSV() {
    ofstream file("residents.csv");
    file << "ID,Name,Age,Contact,Address,Status" << endl;
    
    for (const Resident& r : residents) {
        file << r.getResidentID() << ","
             << r.getName() << ","
             << r.getAge() << ","
             << r.getContact() << ","
             << r.getAddress() << ","
             << r.getStatus() << endl;
    }
    
    file.close();
    cout << "Exported to residents.csv" << endl;
}
```

# Tasks for Learners

- Add optional advanced features including sort by name using lambda comparator, display statistics with `count_if()`, and export data to CSV format.

  ```cpp
  // 1. Sort residents by name
  void sortByName() {
      sort(residents.begin(), residents.end(),
           [](const Resident& a, const Resident& b) {
               return a.getName() < b.getName();
           });
      cout << "Residents sorted by name!" << endl;
  }

  // 2. Display statistics
  void displayStatistics() {
      int active = count_if(residents.begin(), residents.end(),
                           [](const Resident& r) { return r.getStatus() == "Active"; });
      
      int seniors = count_if(residents.begin(), residents.end(),
                            [](const Resident& r) { return r.getAge() >= 60; });
      
      cout << "\n=== Statistics ===" << endl;
      cout << "Total residents: " << residents.size() << endl;
      cout << "Active: " << active << endl;
      cout << "Inactive: " << (residents.size() - active) << endl;
      cout << "Senior citizens: " << seniors << endl;
  }

  // 3. Export to CSV
  void exportToCSV() {
      ofstream file("residents.csv");
      if (!file.is_open()) {
          cout << "Error creating CSV file." << endl;
          return;
      }
      
      file << "ID,Name,Age,Contact,Address,Status" << endl;
      
      for (const Resident& r : residents) {
          file << r.getResidentID() << ","
               << r.getName() << ","
               << r.getAge() << ","
               << r.getContact() << ","
               << r.getAddress() << ","
               << r.getStatus() << endl;
      }
      
      file.close();
      cout << "Exported to residents.csv" << endl;
  }
  ```

---

<details>
<summary><strong>📝 Complete Implementation Checklist</strong></summary>

**Must-Have Features:**
- [x] Person base class with validation
- [x] Resident derived class
- [x] ResidentManager with vector storage
- [ ] File parsing (fromFileFormat)
- [ ] CREATE operation
- [ ] READ operations (all, by ID, by name)
- [ ] UPDATE operation
- [ ] DELETE operation (soft delete)
- [ ] File loading at startup
- [ ] File saving on exit
- [ ] Exception handling throughout
- [ ] Menu-driven interface

**Optional Enhancements:**
- [ ] Sort by name/age/ID
- [ ] Statistics display
- [ ] CSV export
- [ ] Search by age range
- [ ] Filter by status
- [ ] Bulk operations
- [ ] Data validation (phone format, etc.)
- [ ] Confirmation prompts
- [ ] Undo functionality

**Testing Checklist:**
- [ ] Add multiple residents
- [ ] Search works correctly
- [ ] Update preserves other data
- [ ] Delete sets Inactive status
- [ ] File saves correctly
- [ ] File loads on restart
- [ ] Invalid input handled gracefully
- [ ] Empty file handled
- [ ] Large dataset tested

</details>

---

<details>
<summary><strong>🎯 Concepts Integration Map</strong></summary>

**This project uses ALL 31 lessons:**

**Basic Concepts (1-7):**
- Variables, data types (name, age, ID)
- Operators (comparisons, arithmetic)
- I/O (cin, cout, getline)
- Conditionals (if statements for validation)
- Loops (while for menu, for to iterate residents)

**Intermediate Concepts (8-17):**
- Functions (all the member functions)
- Arrays → vectors (STL replacement)
- Strings (name, address manipulation)
- Pointers (implicit in references)
- Dynamic memory (vector handles this)
- File I/O (save/load operations)

**Advanced Concepts (18-27):**
- Structs → classes
- Enums (could add for status types)
- Classes (Person, Resident, Manager)
- Constructors (initialization)
- Encapsulation (private data, public methods)
- Inheritance (Resident extends Person)
- Polymorphism (virtual display())

**Modern C++ (28-30):**
- Templates (vector is a template)
- Exceptions (validation, file errors)
- STL (vector, string, algorithms)

**Result:** Professional, portfolio-worthy project!

</details>

---

## Reflection Questions

1. **How does inheritance help avoid code duplication?**
   - Person holds common fields (name, age, contact)
   - Resident adds specific fields (ID, address, status)
   - No need to repeat name/age/contact in Resident

2. **Why use soft delete instead of removing from vector?**
   - Preserves data history
   - Can reactivate later
   - Audit trail for who was deleted when
   - Real systems rarely permanently delete

3. **How does exception handling improve user experience?**
   - Invalid input doesn't crash program
   - Clear error messages guide user
   - Can retry input without restarting
   - Professional error handling

4. **Why use STL vector instead of arrays?**
   - Dynamic sizing (no fixed limit)
   - Automatic memory management
   - Rich methods (find_if, sort, etc.)
   - No manual new/delete

5. **How would you extend this for multiple barangays?**
   - Add barangay field to Resident
   - Map<string, vector<Resident>> for barangay → residents
   - Filter operations by barangay
   - Statistics per barangay

---

**Congratulations!** This final project demonstrates mastery of all 31 C++ lessons. This is **portfolio-worthy code** that shows professional software development skills!

**You've completed the journey from "Hello World" to a full CRUD application!** 🎉
