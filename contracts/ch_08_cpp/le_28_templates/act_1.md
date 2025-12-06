# Lesson 28 Activities: Templates

## The Repetitive Code Problem

Tian needed `max()` for integers, then doubles, then strings. Each time: nearly identical code, only the type changed.

**"This is ridiculous! The logic is identical. Why separate functions for each type?"**

**Templates solve this!** Write generic code—the algorithm once, works for any type. This is how STL works: `vector<int>`, `vector<string>`—same container, different types!

**Templates = metaprogramming.** You write code that writes code!

---

## Task 1: Function Template

**Context:** One function for all types.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

// Template function
template <typename T>
T maximum(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    cout << maximum(10, 20) << endl;        // int
    cout << maximum(3.14, 2.71) << endl;    // double
    cout << maximum('a', 'z') << endl;      // char
    
    return 0;
}
```

# Tasks for Learners

- Create a `minimum()` template function that works with any comparable type.

  ```cpp
  #include <iostream>
  using namespace std;

  template <typename T>
  T maximum(T a, T b) {
      return (a > b) ? a : b;
  }

  template <typename T>
  T minimum(T a, T b) {
      return (a < b) ? a : b;
  }

  int main() {
      cout << "Maximum:" << endl;
      cout << maximum(10, 20) << endl;
      cout << maximum(3.14, 2.71) << endl;
      cout << maximum('a', 'z') << endl;
      
      cout << "\nMinimum:" << endl;
      cout << minimum(10, 20) << endl;
      cout << minimum(3.14, 2.71) << endl;
      cout << minimum('a', 'z') << endl;
      
      return 0;
  }
  ```

---

## Task 2: Multiple Template Parameters

**Context:** Templates with different types.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

template <typename T1, typename T2>
void display(T1 first, T2 second) {
    cout << first << " and " << second << endl;
}

template <typename T1, typename T2>
T1 multiply(T1 a, T2 b) {
    return a * b;
}

int main() {
    display(10, 3.14);           // int, double
    display("Age:", 25);         // const char*, int
    display(true, "active");     // bool, const char*
    
    cout << multiply(10, 2.5) << endl;     // 25
    cout << multiply(3.5, 4) << endl;      // 14
    
    return 0;
}
```

# Tasks for Learners

- Use template functions with multiple template parameters to handle different types.

  ```cpp
  #include <iostream>
  using namespace std;

  template <typename T1, typename T2>
  void display(T1 first, T2 second) {
      cout << first << " and " << second << endl;
  }

  template <typename T1, typename T2>
  T1 multiply(T1 a, T2 b) {
      return a * b;
  }

  int main() {
      display(10, 3.14);
      display("Age:", 25);
      display(true, "active");
      
      cout << multiply(10, 2.5) << endl;
      cout << multiply(3.5, 4) << endl;
      
      return 0;
  }
  ```

---

## Task 3: Template Swap Function

**Context:** Generic swap for any type.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

template <typename T>
void swapValues(T& a, T& b) {
    T temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 10, y = 20;
    swapValues(x, y);
    cout << "x=" << x << ", y=" << y << endl;  // 20, 10
    
    double d1 = 3.14, d2 = 2.71;
    swapValues(d1, d2);
    cout << "d1=" << d1 << ", d2=" << d2 << endl;
    
    string s1 = "Juan", s2 = "Maria";
    swapValues(s1, s2);
    cout << "s1=" << s1 << ", s2=" << s2 << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create a generic swap function that works with any data type.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  template <typename T>
  void swapValues(T& a, T& b) {
      T temp = a;
      a = b;
      b = temp;
  }

  int main() {
      int x = 10, y = 20;
      swapValues(x, y);
      cout << "x=" << x << ", y=" << y << endl;
      
      double d1 = 3.14, d2 = 2.71;
      swapValues(d1, d2);
      cout << "d1=" << d1 << ", d2=" << d2 << endl;
      
      string s1 = "Juan", s2 = "Maria";
      swapValues(s1, s2);
      cout << "s1=" << s1 << ", s2=" << s2 << endl;
      
      return 0;
  }
  ```

---

## Task 4: Class Template

**Context:** Generic classes (like STL containers).

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

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
    
    void display() {
        cout << "Value: " << value << endl;
    }
};

int main() {
    Box<int> intBox(42);
    intBox.display();
    
    Box<string> strBox("Hello");
    strBox.display();
    
    Box<double> dblBox(3.14);
    dblBox.display();
    
    return 0;
}
```

# Tasks for Learners

- Create a generic Box class template that can store and manipulate values of any type.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

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
      
      void display() {
          cout << "Value: " << value << endl;
      }
  };

  int main() {
      Box<int> intBox(42);
      intBox.display();
      
      Box<string> strBox("Hello");
      strBox.display();
      
      Box<double> dblBox(3.14);
      dblBox.display();
      
      return 0;
  }
  ```

---

## Task 5: Template Array Class

**Context:** Build your own dynamic array template.

**Starter Code:**
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
    intArr.set(0, 10);
    intArr.set(1, 20);
    intArr.set(2, 30);
    intArr.display();
    
    Array<string> strArr(3);
    strArr.set(0, "Juan");
    strArr.set(1, "Maria");
    strArr.set(2, "Pedro");
    strArr.display();
    
    return 0;
}
```

# Tasks for Learners

- Build a dynamic array template class that can store any type of data.

  ```cpp
  #include <iostream>
  #include <string>
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
          return T();
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
      intArr.set(0, 10);
      intArr.set(1, 20);
      intArr.set(2, 30);
      intArr.display();
      
      Array<string> strArr(3);
      strArr.set(0, "Juan");
      strArr.set(1, "Maria");
      strArr.set(2, "Pedro");
      strArr.display();
      
      return 0;
  }
  ```

---

## Task 6: Template Stack Class

**Context:** Generic stack data structure.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

template <typename T>
class Stack {
private:
    T* data;
    int capacity;
    int top;
    
public:
    Stack(int cap = 10) : capacity(cap), top(-1) {
        data = new T[capacity];
    }
    
    ~Stack() {
        delete[] data;
    }
    
    void push(T value) {
        if (top < capacity - 1) {
            data[++top] = value;
        } else {
            cout << "Stack overflow!" << endl;
        }
    }
    
    T pop() {
        if (!isEmpty()) {
            return data[top--];
        }
        cout << "Stack underflow!" << endl;
        return T();
    }
    
    T peek() {
        if (!isEmpty()) {
            return data[top];
        }
        return T();
    }
    
    bool isEmpty() {
        return top == -1;
    }
    
    int size() {
        return top + 1;
    }
};

int main() {
    Stack<int> intStack(5);
    intStack.push(10);
    intStack.push(20);
    intStack.push(30);
    
    cout << "Size: " << intStack.size() << endl;
    cout << "Top: " << intStack.peek() << endl;
    
    while (!intStack.isEmpty()) {
        cout << intStack.pop() << " ";
    }
    cout << endl;
    
    Stack<string> strStack(5);
    strStack.push("First");
    strStack.push("Second");
    strStack.push("Third");
    
    while (!strStack.isEmpty()) {
        cout << strStack.pop() << " ";
    }
    cout << endl;
    
    return 0;
}
```

# Tasks for Learners

- Implement a generic Stack data structure that works with any type.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  template <typename T>
  class Stack {
  private:
      T* data;
      int capacity;
      int top;
      
  public:
      Stack(int cap = 10) : capacity(cap), top(-1) {
          data = new T[capacity];
      }
      
      ~Stack() {
          delete[] data;
      }
      
      void push(T value) {
          if (top < capacity - 1) {
              data[++top] = value;
          } else {
              cout << "Stack overflow!" << endl;
          }
      }
      
      T pop() {
          if (!isEmpty()) {
              return data[top--];
          }
          cout << "Stack underflow!" << endl;
          return T();
      }
      
      T peek() {
          if (!isEmpty()) {
              return data[top];
          }
          return T();
      }
      
      bool isEmpty() {
          return top == -1;
      }
      
      int size() {
          return top + 1;
      }
  };

  int main() {
      Stack<int> intStack(5);
      intStack.push(10);
      intStack.push(20);
      intStack.push(30);
      
      cout << "Size: " << intStack.size() << endl;
      cout << "Top: " << intStack.peek() << endl;
      
      while (!intStack.isEmpty()) {
          cout << intStack.pop() << " ";
      }
      cout << endl;
      
      Stack<string> strStack(5);
      strStack.push("First");
      strStack.push("Second");
      strStack.push("Third");
      
      while (!strStack.isEmpty()) {
          cout << strStack.pop() << " ";
      }
      cout << endl;
      
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Template Essentials</strong></summary>

**Function Templates:**
```cpp
template <typename T>
T function(T param) {
    // Use T as a type
}
```

**Class Templates:**
```cpp
template <typename T>
class ClassName {
    T member;
public:
    ClassName(T val) : member(val) {}
};

// Usage
ClassName<int> obj(10);
```

**Multiple Parameters:**
```cpp
template <typename T1, typename T2>
void function(T1 a, T2 b) {
    // ...
}
```

**Benefits:**
1. **Code reuse:** Write once, use with any type
2. **Type safety:** Compile-time type checking
3. **No runtime overhead:** Templates resolved at compile time
4. **STL foundation:** vector, map, etc. are all templates

**Common Uses:**
- Data structures (stack, queue, tree)
- Algorithms (sort, search)
- Containers (array, list, map)
- Utilities (swap, min, max)

</details>

---

**Templates enable generic programming—the foundation of modern C++!**
