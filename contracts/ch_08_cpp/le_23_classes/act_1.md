# C++ Activity

Transition from data-only structs to classes that group both data and behavior together. In this activity you will build **two** classes -- a `Resident` (a person in Tian's barangay) and a `Student` -- each bundling its own data with the methods that act on it.

```cpp
#include <iostream>
#include <string>
using namespace std;

// TODO: Define the Resident class (public members).
//   - Data: string name; int age;
//   - Method introduce(): prints "Hi, I'm <name>, <age> years old."
//   - Method haveBirthday(): increments age, then prints "<name> is now <age> years old!"
class Resident {
public:
    string name;
    int age;

    // TODO: void introduce() { ... }

    // TODO: void haveBirthday() { ... }
};

// TODO: Define the Student class (public members).
//   - Data: string name; int grade;
//   - Method introduce(): prints "Student: <name>, Grade: <grade>"
//   - Method study(): adds 5 to grade (cap at 100), then prints
//     "<name> studied hard! Grade is now <grade>"
class Student {
public:
    string name;
    int grade;

    // TODO: void introduce() { ... }

    // TODO: void study() { ... }
};

// TODO: task1_demo(): create a Resident "Juan Dela Cruz" age 30,
//       call introduce() then haveBirthday().
void task1_demo() {
    // TODO: build the Resident object and call its methods here
}

// TODO: task2_demo(): create a Student "Pedro Garcia" grade 80,
//       then call study().
void task2_demo() {
    // TODO: build the Student object and call study() here
}

int main() {
    cout << "--- Lesson 23: Classes (OOP Basics) ---" << endl;

    // TODO: run task1_demo() and task2_demo()

    cout << "\nAll activities completed successfully!" << endl;

    return 0;
}
```

## Task for Learners

- Inside `Resident`, implement `introduce()` so it greets using the object's own data:

  ```cpp
  void introduce() {
      cout << "Hi, I'm " << name << ", " << age << " years old." << endl;
  }
  ```

- Inside `Resident`, implement `haveBirthday()` so it ages the resident by one year and announces it:

  ```cpp
  void haveBirthday() {
      age++;
      cout << name << " is now " << age << " years old!" << endl;
  }
  ```

- Inside `Student`, implement `introduce()`:

  ```cpp
  void introduce() {
      cout << "Student: " << name << ", Grade: " << grade << endl;
  }
  ```

- Inside `Student`, implement `study()` so the grade rises by 5 (capped at 100) and reports the new grade:

  ```cpp
  void study() {
      grade += 5;
      if (grade > 100) grade = 100; // Cap at 100
      cout << name << " studied hard! Grade is now " << grade << endl;
  }
  ```

- Fill in `task1_demo()` so it builds a `Resident`, introduces him, then gives him a birthday:

  ```cpp
  void task1_demo() {
      Resident res;
      res.name = "Juan Dela Cruz";
      res.age = 30;
      res.introduce();
      res.haveBirthday();
  }
  ```

- Fill in `task2_demo()` so it builds a `Student` and makes him study once:

  ```cpp
  void task2_demo() {
      Student s;
      s.name = "Pedro Garcia";
      s.grade = 80;
      s.study();
  }
  ```

- In `main`, run both demos between the header and the closing message:

  ```cpp
  task1_demo();
  task2_demo();
  ```

### Expected Output

```
--- Lesson 23: Classes (OOP Basics) ---
Hi, I'm Juan Dela Cruz, 30 years old.
Juan Dela Cruz is now 31 years old!
Pedro Garcia studied hard! Grade is now 85

All activities completed successfully!
```

> Note: `task2_demo()` calls only `s.study()` (not `s.introduce()`), so the `Student: ...` line is intentionally *not* printed. That is why the output jumps straight to the "studied hard" line.

### Breakdown of the Activity

- **`class Resident { public: ... };`**: Defines a class with public members; data (`name`, `age`) and methods (`introduce`, `haveBirthday`) live together as one unit.
- **`res.introduce()`**: Calling a method on an object -- the method reads that object's own data without it being passed in as a parameter.
- **`age++` / `grade += 5`**: Methods can directly modify the object's data members. Each object (`Resident`, `Student`) manages its own independent state.
- **Two classes, same idea**: `Student` mirrors `Resident` to show the blueprint-and-object pattern is reusable -- the data differs (`grade` vs `age`) but the structure is identical.
