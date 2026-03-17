# C++ Activity

Build a Car class that inherits from Vehicle to reuse shared properties.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

class Vehicle {
protected:
    string brand;
public:
    Vehicle(string b) : brand(b) {}
    string getBrand() { return brand; }
};

// TODO: Create a Car class that inherits from Vehicle
// - Add a private member 'int doors'
// - Constructor takes brand and doors, chains to Vehicle
// - Add getDoors() method

int main() {
    // Your code here: create a Car and test inherited + own methods

    return 0;
}
```

## Task for Learners

- Create a `Car` class that inherits publicly from `Vehicle`.

  ```cpp
  class Car : public Vehicle {
  ```

- Add a private `int doors` member and a constructor that chains to `Vehicle`.

  ```cpp
  Car(string b, int d) : Vehicle(b), doors(d) {}
  ```

- Add a `getDoors()` method and test that `getBrand()` is inherited.

  ```cpp
  int getDoors() { return doors; }
  ```

### Breakdown of the Activity

- **`: public Vehicle`**: Public inheritance means `Vehicle`'s public members stay public in `Car`.
- **Constructor chaining**: `Vehicle(b)` in the initializer list calls the base constructor first.
- **`getBrand()`**: Inherited from `Vehicle` without rewriting any code.
- **`getDoors()`**: Car-specific method that only exists on the derived class.
