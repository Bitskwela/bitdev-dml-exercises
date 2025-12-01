## Background Story

Tian needed a `max()` function to find the maximum of two values. First for integers, then doubles, then strings. Each time, Tian wrote nearly identical code with only the type changed.

"This is ridiculous!" Tian complained, looking at three nearly identical functions. "The logic is identical—compare two values and return the larger one. Why do I need separate functions for each type?"

Kuya Miguel grinned. "Welcome to the problem that **templates** solve. You're writing the same algorithm multiple times just because types differ. Templates let you write generic code—the algorithm once, works for any type."

"This is how STL works," Kuya Miguel explained. "You've used `vector<int>` and `vector<string>`. Think about it—vector needs to store data, resize, access elements, all the same operations regardless of what it stores. The STL developers didn't write separate vector classes for every possible type. They wrote one template that generates the appropriate code for whatever type you specify."

"Templates are metaprogramming," Kuya Miguel continued. "You're writing code that writes code. The compiler generates type-specific versions automatically. This is what makes C++ both powerful and efficient—generic programming without runtime overhead!"

---

## Theory & Lecture Content

## What are Templates?

**Templates** enable generic programming — write code that works with any data type.

```cpp
// Without templates - repetitive
int max(int a, int b) {
    return (a > b) ? a : b;
}

double max(double a, double b) {
    return (a > b) ? a : b;
}

// With templates - one function for all types!
template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    cout << max(10, 20) << endl;        // int
    cout << max(3.14, 2.71) << endl;    // double
    cout << max('a', 'z') << endl;      // char
    
    return 0;
}
```

---

## Function Templates

```cpp
template <typename T>
T add(T a, T b) {
    return a + b;
}

template <typename T>
void swap(T& a, T& b) {
    T temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 10, y = 20;
    swap(x, y);
    cout << x << ", " << y << endl;  // 20, 10
    
    string s1 = "Juan", s2 = "Maria";
    swap(s1, s2);
    cout << s1 << ", " << s2 << endl;  // Maria, Juan
    
    return 0;
}
```

---

## Multiple Template Parameters

```cpp
template <typename T1, typename T2>
void display(T1 a, T2 b) {
    cout << a << " and " << b << endl;
}

int main() {
    display(10, 3.14);           // int, double
    display("Age:", 25);         // const char*, int
    display(true, "active");     // bool, const char*
    
    return 0;
}
```

---

## Class Templates

```cpp
template <typename T>
class Box {
private:
    T value;
    
public:
    Box(T v) : value(v) {}
    
    T getValue() {
        return value;
    }
    
    void setValue(T v) {
        value = v;
    }
};

int main() {
    Box<int> intBox(42);
    cout << intBox.getValue() << endl;  // 42
    
    Box<string> strBox("Hello");
    cout << strBox.getValue() << endl;  // Hello
    
    Box<double> dblBox(3.14);
    cout << dblBox.getValue() << endl;  // 3.14
    
    return 0;
}
```

---

## Practical Example: Generic Array Class

```cpp
#include <iostream>
using namespace std;

template <typename T>
class Array {
private:
    T* data;
    int size;
    
public:
    Array(int s) : size(s) {
        data = new T[size];
    }
    
    ~Array() {
        delete[] data;
    }
    
    void set(int index, T value) {
        if (index >= 0 && index < size) {
            data[index] = value;
        }
    }
    
    T get(int index) {
        if (index >= 0 && index < size) {
            return data[index];
        }
        return T();  // Default value
    }
    
    int getSize() {
        return size;
    }
    
    void display() {
        for (int i = 0; i < size; i++) {
            cout << data[i] << " ";
        }
        cout << endl;
    }
};

int main() {
    Array<int> intArr(5);
    for (int i = 0; i < 5; i++) {
        intArr.set(i, i * 10);
    }
    intArr.display();  // 0 10 20 30 40
    
    Array<string> strArr(3);
    strArr.set(0, "Juan");
    strArr.set(1, "Maria");
    strArr.set(2, "Pedro");
    strArr.display();  // Juan Maria Pedro
    
    return 0;
}
```

---

## Template Specialization

```cpp
// Generic template
template <typename T>
class Printer {
public:
    void print(T value) {
        cout << "Value: " << value << endl;
    }
};

// Specialization for bool
template <>
class Printer<bool> {
public:
    void print(bool value) {
        cout << "Boolean: " << (value ? "true" : "false") << endl;
    }
};

int main() {
    Printer<int> intPrinter;
    intPrinter.print(42);  // Value: 42
    
    Printer<bool> boolPrinter;
    boolPrinter.print(true);  // Boolean: true
    
    return 0;
}
```

---

## Barangay Example: Generic Storage

```cpp
#include <iostream>
#include <string>
using namespace std;

template <typename T>
class Storage {
private:
    T* items;
    int capacity;
    int count;
    
public:
    Storage(int cap) : capacity(cap), count(0) {
        items = new T[capacity];
    }
    
    ~Storage() {
        delete[] items;
    }
    
    bool add(T item) {
        if (count < capacity) {
            items[count++] = item;
            return true;
        }
        return false;
    }
    
    T* find(T item) {
        for (int i = 0; i < count; i++) {
            if (items[i] == item) {
                return &items[i];
            }
        }
        return nullptr;
    }
    
    void displayAll() {
        for (int i = 0; i < count; i++) {
            cout << items[i] << endl;
        }
    }
    
    int getCount() {
        return count;
    }
};

struct Resident {
    int id;
    string name;
    
    bool operator==(const Resident& other) const {
        return id == other.id;
    }
    
    friend ostream& operator<<(ostream& os, const Resident& r) {
        os << "ID: " << r.id << ", Name: " << r.name;
        return os;
    }
};

int main() {
    // Store integers
    Storage<int> ids(100);
    ids.add(1001);
    ids.add(1002);
    ids.add(1003);
    cout << "IDs stored: " << ids.getCount() << endl;
    
    // Store residents
    Storage<Resident> residents(50);
    residents.add({1001, "Juan Dela Cruz"});
    residents.add({1002, "Maria Santos"});
    
    cout << "\nResidents:\n";
    residents.displayAll();
    
    return 0;
}
```

---

## Non-Type Template Parameters

```cpp
template <typename T, int SIZE>
class FixedArray {
private:
    T data[SIZE];
    
public:
    void set(int index, T value) {
        if (index >= 0 && index < SIZE) {
            data[index] = value;
        }
    }
    
    T get(int index) {
        if (index >= 0 && index < SIZE) {
            return data[index];
        }
        return T();
    }
    
    int size() {
        return SIZE;
    }
};

int main() {
    FixedArray<int, 5> arr1;
    FixedArray<string, 3> arr2;
    
    cout << arr1.size() << endl;  // 5
    cout << arr2.size() << endl;  // 3
    
    return 0;
}
```

---

## Summary

"Templates eliminate code duplication!" Tian exclaimed.

"Exactly!" Kuya Miguel said. "Remember:
- **template <typename T>** = generic type
- **Function templates** = generic functions
- **Class templates** = generic classes
- **Specialization** = custom behavior for specific types
- **Compile-time** = templates processed at compile time"

"Next: **Exception Handling** — dealing with errors gracefully!"

---

**Key Takeaways:**
1. Templates enable generic programming
2. Write once, use for any type
3. Function and class templates
4. Specialization for custom behavior
5. Compile-time code generation

---

## Closing Story

"I wrote one max function that works for any type!" Tian exclaimed, testing his template with integers, doubles, strings, even custom structs.

Kuya Miguel nodded. "That's the power of templates: write once, use everywhere. No more copying code for different types. The compiler generates the specific versions you need at compile time."

Tian practiced function templates, class templates, and even template specialization for special cases. "And I can have multiple template parameters, non-type parameters like array sizes, and specialize templates for specific types that need different behavior."

"Exactly! Templates are the foundation of generic programming and the STL. Vector, map, set: all template classes. Sort, find, count: all template functions. You can use any type that meets the requirements."

Tian created his generic Storage class that worked with integers, strings, and custom Resident structs. "This is incredibly powerful. But what happens when things go wrong at runtime?"

"Exception handling. Let's learn to deal with errors gracefully instead of crashing."

**Next Lesson:** Exception Handling - Error Management
