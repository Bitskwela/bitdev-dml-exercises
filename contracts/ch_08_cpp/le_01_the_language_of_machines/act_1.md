# Lesson 1 Activities: The Language of Machines

---

## Activity 1: Hello Philippines

**Objective:** Write your first C++ program that displays a greeting message.

**Task:**  
Write a C++ program that prints "Mabuhay, Pilipinas!" to the console.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Your code here
    
    return 0;
}
```

**Expected Output:**
```
Mabuhay, Pilipinas!
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Mabuhay, Pilipinas!" << endl;
    return 0;
}
```

---

## Activity 2: Personal Information Display

**Objective:** Practice using multiple `cout` statements to display information on separate lines.

**Task:**  
Write a program that prints your name, age, and school on separate lines.

**Expected Output:**
```
Name: Tian
Age: 16
School: Batangas National High School
```

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Print your name
    // Print your age
    // Print your school
    
    return 0;
}
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Name: Tian" << endl;
    cout << "Age: 16" << endl;
    cout << "School: Batangas National High School" << endl;
    return 0;
}
```

---

## Activity 3: ASCII Art House

**Objective:** Create simple ASCII art using multiple lines of output.

**Task:**  
Print a simple house using ASCII characters (asterisks and vertical bars).

**Expected Output:**
```
   *
  ***
 *****
*******
  | |
  | |
```

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Print the roof (triangle)
    
    // Print the walls
    
    return 0;
}
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "   *" << endl;
    cout << "  ***" << endl;
    cout << " *****" << endl;
    cout << "*******" << endl;
    cout << "  | |" << endl;
    cout << "  | |" << endl;
    return 0;
}
```

---

## Challenge Activity: Philippine Flag

**Objective:** Apply your knowledge to create a more complex ASCII art.

**Task:**  
Create a simplified ASCII representation of the Philippine flag.

**Expected Output:**
```
********************
********************
    ***   *** 
     * * * *
      *****
********************
********************
```

**Hint:**  
- Use asterisks (*) for the colored parts
- Use spaces for positioning
- Each line is a separate `cout` statement

**Try it yourself before checking the solution!**

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

int main() {
    // Blue stripe
    cout << "********************" << endl;
    cout << "********************" << endl;
    
    // White triangle with sun
    cout << "    ***   *** " << endl;
    cout << "     * * * *" << endl;
    cout << "      *****" << endl;
    
    // Red stripe
    cout << "********************" << endl;
    cout << "********************" << endl;
    
    return 0;
}
```

</details>

---

## Debugging Exercise: Fix the Errors

**Objective:** Practice identifying and fixing common C++ syntax errors.

**Task:**  
The following program has 5 errors. Find and fix them all.

**Buggy Code:**
```cpp
#include <iostream>

int Main() {
    cout << "Hello, World!" << endl
    Cout << "Welcome to C++!" << endl;
    return 0
}
```

**Errors to find:**
1. Missing namespace declaration
2. Wrong capitalization of main
3. Missing semicolon
4. Wrong capitalization of cout
5. Missing semicolon at return

<details>
<summary>Click to view corrected code</summary>

```cpp
#include <iostream>
using namespace std;  // Error 1: Added namespace

int main() {  // Error 2: Changed Main to main
    cout << "Hello, World!" << endl;  // Error 3: Added semicolon
    cout << "Welcome to C++!" << endl;  // Error 4: Changed Cout to cout
    return 0;  // Error 5: Added semicolon
}
```

</details>

---

## Reflection Questions

After completing the activities, think about these questions:

1. **What is the purpose of `#include <iostream>` in every program?**
   - It includes the input/output stream library needed for cout and cin

2. **Why do we need semicolons at the end of statements?**
   - Semicolons mark the end of each statement, telling the compiler where one instruction ends

3. **What happens if you forget `using namespace std;`?**
   - You would need to write `std::cout` instead of just `cout`

4. **What does `return 0;` mean in the main function?**
   - It returns 0 to the operating system, indicating the program executed successfully

---

## Next Steps

Great work completing Lesson 1 activities! You've learned:
- ✅ How to write and run basic C++ programs
- ✅ How to use `cout` to display output
- ✅ The importance of proper syntax (semicolons, case sensitivity)
- ✅ Basic program structure with `#include`, `main()`, and `return`

**Ready for Lesson 2?**  
Next, you'll learn about **variables and data types** - how to store and work with different kinds of data in C++!
