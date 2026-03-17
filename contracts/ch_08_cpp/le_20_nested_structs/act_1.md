# C++ Activity

Organize complex resident data by nesting a Date struct within a Resident struct.

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

// Your code here: Define a Date struct with day, month, year (ints)

// Your code here: Define a Resident struct with name (string) and birthDate (Date)

int main() {
    // Your code here: Create a Resident variable

    // Your code here: Initialize name and nested birthDate members

    // Your code here: Print the resident's full details

    return 0;
}
```

## Task for Learners

- Define a `Date` struct with `day`, `month`, and `year` members:

  ```cpp
  struct Date {
      int day;
      int month;
      int year;
  };
  ```

- Define a `Resident` struct that contains a `string name` and a `Date birthDate`.

- Create a Resident, assign values using chained dots (e.g., `person.birthDate.year = 1861`), and print the details.

### Breakdown of the Activity

- **`Date birthDate`**: A struct used as a member inside another struct, creating a hierarchy.
- **`person.birthDate.day`**: Chained dot operators access nested members at each level.
- **`setfill('0') << setw(2)`**: Formats numbers with leading zeros for proper date display.
