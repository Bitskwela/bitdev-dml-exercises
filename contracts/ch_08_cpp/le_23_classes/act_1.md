# C++ Activity

Transition from data-only structs to classes that group both data and behavior together.

```cpp
#include <iostream>
#include <string>
using namespace std;

class Resident {
public:
    string name;
    int age;

    // Your code here: Implement a method 'introduce' that prints name and age

    // Your code here: Implement a method 'haveBirthday' that increments age
};

int main() {
    // Your code here: Create a Resident object, set name and age

    // Your code here: Call introduce and haveBirthday methods

    return 0;
}
```

## Task for Learners

- Implement the `introduce` method that prints a greeting:

  ```cpp
  void introduce() {
      cout << "Hi, I'm " << name << ", " << age << " years old." << endl;
  }
  ```

- Implement the `haveBirthday` method that increments age by 1.

- Create a Resident object in `main`, assign values, and call both methods.

### Breakdown of the Activity

- **`class Resident { public: ... };`**: Defines a class with public members; methods and data live together.
- **`res.introduce()`**: Calling a method on an object -- the method accesses that object's own data.
- **`age++`**: Methods can directly modify the object's data members without needing parameters.
