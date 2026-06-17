# C++ Activity

Use virtual functions so the correct method runs at runtime for each barangay member.

```cpp
#include <iostream>
#include <string>
#include <vector>
#include <cassert>

using namespace std;

// --- Task 1: Virtual Functions ---
class Person {
protected:
    string name;

public:
    Person(string n) : name(n) {}

    // TODO: Declare a virtual method introduce() that returns
    //       "I'm <name>, a person."

    // TODO: Add a virtual destructor
};

// TODO: Create a Resident class that overrides introduce()
//       to return "I'm <name>, a resident."

// TODO: Create an Official class that overrides introduce()
//       to return "I'm <name>, an official."

void run_demo() {
    // Your code here: store Resident, Official, and Person objects in a
    // vector<Person*>, print each introduce() under a
    // "--- Polymorphism in Action ---" header, then clean up the memory
}

int main() {
    cout << "--- Lesson 27: Polymorphism ---" << endl;
    run_demo();
    cout << "\nPolymorphism logic validated!" << endl;
    return 0;
}
```

## Task for Learners

- Add a `virtual` method `introduce()` to `Person` and a virtual destructor.

  ```cpp
  virtual string introduce() {
      return "I'm " + name + ", a person.";
  }

  virtual ~Person() {}
  ```

- Create a `Resident` class that overrides `introduce()`.

  ```cpp
  class Resident : public Person {
  public:
      Resident(string n) : Person(n) {}

      string introduce() override {
          return "I'm " + name + ", a resident.";
      }
  };
  ```

- Create an `Official` class that overrides `introduce()`.

  ```cpp
  class Official : public Person {
  public:
      Official(string n) : Person(n) {}

      string introduce() override {
          return "I'm " + name + ", an official.";
      }
  };
  ```

- In `run_demo()`, collect base pointers, print each introduction, then delete them.

  ```cpp
  void run_demo() {
      vector<Person*> barangayRegistry;

      barangayRegistry.push_back(new Resident("Juan"));
      barangayRegistry.push_back(new Official("Maria"));
      barangayRegistry.push_back(new Person("Stranger"));

      cout << "--- Polymorphism in Action ---" << endl;
      for (Person* p : barangayRegistry) {
          cout << p->introduce() << endl;
      }

      assert(barangayRegistry[0]->introduce() == "I'm Juan, a resident.");
      assert(barangayRegistry[1]->introduce() == "I'm Maria, an official.");
      assert(barangayRegistry[2]->introduce() == "I'm Stranger, a person.");

      for (Person* p : barangayRegistry) {
          delete p;
      }
      barangayRegistry.clear();
  }
  ```

### Breakdown of the Activity

- **`virtual`**: Enables dynamic dispatch so the runtime object type determines which method runs.
- **`override`**: Ensures the derived method actually overrides a base virtual function.
- **`virtual ~Person()`**: Virtual destructor ensures proper cleanup when deleting through a base pointer.
- **`vector<Person*>`**: A collection of base pointers holding mixed derived objects -- the core of polymorphism.
