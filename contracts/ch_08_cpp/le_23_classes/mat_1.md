# Lesson 23: Classes

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+23.0+-+COVER.png)

## Scene

After finishing the Contact Book project, Tian showed it to Kuya Miguel. "It works! But I'm still just using structs with separate functions. You mentioned **classes** before. What's the difference?"

Kuya Miguel smiled. "Structs group data. Classes group data AND behavior together. Right now your `displayContact()` function lives separately from your Contact struct. With classes, the data and functions that operate on that data become one unit."

"Think about a smartphone," Kuya Miguel explained. "It has data: battery level, storage, phone number. It also has behaviors: make calls, send messages. You don't access the battery directly. The phone exposes buttons while hiding the complex internals. This is **Object-Oriented Programming**."

## C++ Topics: Classes and Objects

![23.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+23.1.png)

### What is a Class?

> A class is a blueprint that bundles data (attributes) and behavior (methods) together into a single unit. Objects are instances created from this blueprint.

### Access Specifiers

> `public` members are accessible from anywhere. `private` members are only accessible inside the class. Classes default to private; structs default to public.

### Methods

> Functions defined inside a class are called methods. They can directly access the class's data members without needing them passed as parameters.

### Encapsulation

> Hide internal data with `private` and expose controlled access through `public` methods (getters/setters). This protects data from invalid modifications.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

class Resident {
public:
    string name;
    int age;

    void introduce() {
        cout << "Hi, I'm " << name << ", " << age << " years old." << endl;
    }

    void haveBirthday() {
        age++;
        cout << name << " is now " << age << " years old!" << endl;
    }
};

int main() {
    Resident res;
    res.name = "Juan Dela Cruz";
    res.age = 30;
    res.introduce();
    res.haveBirthday();
    return 0;
}
```

The `Resident` class bundles `name` and `age` data with `introduce()` and `haveBirthday()` behavior. The methods access class data directly -- no need to pass the resident as a parameter. Each object manages its own state.
