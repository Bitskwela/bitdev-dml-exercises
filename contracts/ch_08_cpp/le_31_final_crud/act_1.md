# C++ Activity

Integrate OOP, STL, exceptions, and file I/O into a final Barangay Resident Management capstone.

```cpp
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <stdexcept>
#include <memory>
#include <cassert>

using namespace std;

// --- Base Class (Inheritance & Polymorphism) ---
class Person {
protected:
    string name;
    int age;
public:
    Person(string n = "", int a = 0) : name(n), age(a) {}
    virtual ~Person() {}

    virtual void display() const {
        cout << "Name: " << name << " | Age: " << age;
    }

    string getName() const { return name; }
    int getAge() const { return age; }
};

// TODO: Create a Resident class that inherits from Person with:
//       - private int id and string status (default "Active")
//       - constructor Resident(int i, string n, int a, string s = "Active")
//       - display() override printing "ID: <id> | Name: <name> | Age: <age> | Status: <status>"
//       - getId(), getStatus(), setStatus()

// --- Manager Class (STL, Exceptions, File I/O) ---
// TODO: Create a BarangayManager that holds vector<unique_ptr<Resident>> and:
//       - addResident(name, age): throws invalid_argument if name empty,
//         else adds and prints "Resident added successfully."
//       - findById(id): returns the Resident* or throws runtime_error("Resident not found!")
//       - updateStatus(id, newStatus): updates and prints "Status updated for <name>"
//       - deleteResident(id): erases the match (remove_if) and prints "Resident deleted."
//         or throws runtime_error if not found
//       - saveData(): writes each resident to "residents.txt" and prints
//         "Data saved to residents.txt"
//       - testLogic(): adds two residents, updates status of #1, deletes #2, saves

int main() {
    cout << "--- Barangay Resident Management System (Final Project) ---" << endl;
    // Your code here: construct a BarangayManager, run testLogic() inside a
    // try block, and on success print "Final Project logic validated successfully!"

    return 0;
}
```

## Task for Learners

- Create a `Resident` class that overrides `display()`.

  ```cpp
  class Resident : public Person {
  private:
      int id;
      string status; // "Active", "Inactive"
  public:
      Resident(int i, string n, int a, string s = "Active")
          : Person(n, a), id(i), status(s) {}

      void display() const override {
          cout << "ID: " << id << " | ";
          Person::display();
          cout << " | Status: " << status << endl;
      }

      int getId() const { return id; }
      string getStatus() const { return status; }
      void setStatus(string s) { status = s; }
  };
  ```

- Build the `BarangayManager` with the CRUD methods (STL + exceptions + file I/O).

  ```cpp
  class BarangayManager {
  private:
      vector<unique_ptr<Resident>> residents;
      int nextId = 1;
      const string filename = "residents.txt";

  public:
      void addResident(string name, int age) {
          if (name.empty()) throw invalid_argument("Name cannot be empty!");
          residents.push_back(make_unique<Resident>(nextId++, name, age, "Active"));
          cout << "Resident added successfully." << endl;
      }

      Resident* findById(int id) {
          for (auto& r : residents) {
              if (r->getId() == id) return r.get();
          }
          throw runtime_error("Resident not found!");
      }

      void updateStatus(int id, string newStatus) {
          Resident* r = findById(id);
          r->setStatus(newStatus);
          cout << "Status updated for " << r->getName() << endl;
      }

      void deleteResident(int id) {
          auto it = remove_if(residents.begin(), residents.end(),
              [id](const unique_ptr<Resident>& r) { return r->getId() == id; });

          if (it != residents.end()) {
              residents.erase(it, residents.end());
              cout << "Resident deleted." << endl;
          } else {
              throw runtime_error("Could not delete: ID not found.");
          }
      }

      void saveData() {
          ofstream outFile(filename);
          if (!outFile) return;
          for (const auto& r : residents) {
              outFile << r->getId() << "," << r->getName() << "," << r->getAge() << "," << r->getStatus() << endl;
          }
          outFile.close();
          cout << "Data saved to " << filename << endl;
      }
  };
  ```

- Add a `testLogic()` method that drives the CRUD flow, and call it from `main()`.

  ```cpp
  void testLogic() {
      addResident("Tian", 21);
      addResident("Miguel", 25);
      assert(residents.size() == 2);

      updateStatus(1, "Inactive");
      assert(findById(1)->getStatus() == "Inactive");

      deleteResident(2);
      assert(residents.size() == 1);

      saveData();
  }
  ```

  ```cpp
  BarangayManager bm;
  try {
      bm.testLogic();
      cout << "\nFinal Project logic validated successfully!" << endl;
  } catch (const exception& e) {
      cerr << "Error: " << e.what() << endl;
  }
  ```

### Breakdown of the Activity

- **`unique_ptr<Resident>`**: Smart pointer that automatically frees memory; no manual `delete` needed.
- **`make_unique<Resident>(...)`**: Creates a Resident on the heap wrapped in a unique_ptr.
- **`display()` override**: Polymorphic call that reuses `Person::display()` and adds the id/status.
- **`remove_if` + `erase`**: The erase-remove idiom deletes the matching resident from the vector.
- **Exceptions + file I/O**: `invalid_argument` / `runtime_error` guard the operations; `saveData()` persists records to `residents.txt`.
- **Integration**: This capstone exercises inheritance, polymorphism, STL, exceptions, and file I/O together.
