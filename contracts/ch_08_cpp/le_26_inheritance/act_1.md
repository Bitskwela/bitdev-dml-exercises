# C++ Activity

Use inheritance to reuse shared properties: model barangay residents and vehicles.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

// --- Task 1: Basic Inheritance (Person -> Resident) ---
class Person {
protected:
    string name;
    int age;

public:
    Person(string n, int a) : name(n), age(a) {}

    void display() {
        cout << "[Person] Name: " << name << ", Age: " << age << endl;
    }
};

// TODO: Create a Resident class that inherits from Person
// - Add a private member 'string barangay'
// - Constructor takes name, age, barangay and chains to Person
// - Add showBarangay() that prints: "[Resident] <name> lives in <barangay>"

// --- Task 2: Vehicle & Car ---
class Vehicle {
protected:
    string brand;
    int year;

public:
    Vehicle(string b, int y) : brand(b), year(y) {}

    void display() {
        cout << "[Vehicle] Brand: " << brand << ", Year: " << year << endl;
    }

    string getBrand() { return brand; }
};

// TODO: Create a Car class that inherits from Vehicle
// - Add a private member 'int doors'
// - Constructor takes brand, year, doors and chains to Vehicle
// - Add showDoors() that prints: "[Car] This <brand> has <doors> doors."
// - Add getDoors() method

void run_demo() {
    // Your code here: create a Resident and a Car, then call
    // inherited + specialized methods to produce the expected output
}

int main() {
    cout << "--- Lesson 26: Inheritance ---" << endl;
    run_demo();
    cout << "\nInheritance demo completed successfully!" << endl;
    return 0;
}
```

## Task for Learners

- Create a `Resident` class that inherits publicly from `Person`.

  ```cpp
  class Resident : public Person {
  private:
      string barangay;

  public:
      Resident(string n, int a, string brgy) : Person(n, a), barangay(brgy) {}

      void showBarangay() {
          cout << "[Resident] " << name << " lives in " << barangay << endl;
      }
  };
  ```

- Create a `Car` class that inherits publicly from `Vehicle`, with a private `int doors`.

  ```cpp
  class Car : public Vehicle {
  private:
      int doors;

  public:
      Car(string b, int y, int d) : Vehicle(b, y), doors(d) {}

      void showDoors() {
          cout << "[Car] This " << brand << " has " << doors << " doors." << endl;
      }

      int getDoors() { return doors; }
  };
  ```

- In `run_demo()`, create one `Resident` and one `Car`, then call both the inherited `display()` and the specialized methods.

  ```cpp
  void run_demo() {
      Resident r("Juan", 30, "San Antonio");
      r.display();      // Shared method
      r.showBarangay(); // Specialized method

      Car myCar("Toyota", 2022, 4);
      myCar.display();   // Shared method
      myCar.showDoors(); // Specialized method

      assert(myCar.getBrand() == "Toyota");
      assert(myCar.getDoors() == 4);
  }
  ```

### Breakdown of the Activity

- **`: public Vehicle`**: Public inheritance means the base class's public members stay public in the derived class.
- **Constructor chaining**: `Vehicle(b, y)` in the initializer list calls the base constructor first.
- **`display()` / `getBrand()`**: Inherited from the base class without rewriting any code.
- **`showDoors()` / `showBarangay()`**: Derived-specific methods that only exist on the subclass.
