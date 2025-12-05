# Lesson 1 Activities: The Language of Machines

## Your First Step into C++ Programming

Now that you understand what C++ is and why it's the language behind games, operating systems, and high-performance applications, it's time to write your first programs! Remember Tian's journey from JavaScript to C++—discovering the power of compiled languages that process millions of calculations per second.

Like Tian watching that Dota 2 tournament stream and realizing C++ makes games run at 60 FPS, you're about to experience the difference between interpreted languages and compiled powerhouses. Every complex system—from YouTube's video processing to hospital management software—starts with these fundamentals.

**What makes C++ special?**
- **Speed:** Milliseconds vs seconds in processing
- **Control:** Direct hardware access
- **Power:** Used in games, OS, embedded systems
- **Discipline:** Strict syntax teaches precision

In this activity, you'll practice the fundamental structure of C++ programs: the essential components (`#include`, `using namespace std`, `main()`, `cout`, `return 0`) that every C++ program needs. Think of this as learning the alphabet before writing sentences.

---

## Task 1: Hello Philippines

**Context:**  
You're building your first C++ program—just like Tian did after learning about how C++ powers Dota 2, Chrome, and massive systems processing millions of calculations per second. Your goal is to display a message to the console.

**Your Challenge:**  
Write a C++ program that greets the Philippines with the message "Mabuhay, Pilipinas!"

**What You'll Practice:**
- Program structure (`#include`, `using namespace std`, `main()`)
- Console output with `cout`
- Proper semicolon usage
- Return statements

**Boilerplate Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Write your cout statement here to print "Mabuhay, Pilipinas!"
    
    return 0;
}
```

# Tasks for Learners

- Display "Mabuhay, Pilipinas!" message: Use `cout` to print the greeting to the console.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      cout << "Mabuhay, Pilipinas!" << endl;
      return 0;
  }
  ```

### Breakdown for Learners

**Understanding the Components:**
- `#include <iostream>` - Provides input/output functionality (like importing a library)
- `using namespace std;` - Allows us to use `cout` without writing `std::cout` every time
- `int main()` - Entry point where program execution begins
- `cout << "text" << endl;` - Prints text to console, `endl` adds a new line
- `return 0;` - Signals successful program completion to the operating system

**Key Points:**
- Every C++ program must have a `main()` function
- Semicolons (`;`) are required at the end of statements
- `cout` is used for console output (think of it as console.log in JavaScript)
- C++ is case-sensitive: `Main` ≠ `main`, `Cout` ≠ `cout`

**Why It Matters:**
This is your foundation! Every C++ application—from Dota 2 to Windows itself—follows this basic structure. Understanding these components prepares you for building complex systems. The discipline C++ teaches makes you a better programmer in ANY language.

---

## Activity 2: Personal Information Display

**Objective:** Practice using multiple `cout` statements to display information on separate lines.

**Task:**  
Write a program that prints your name, age, and school on separate lines.

**Boilerplate Code:**
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

# Tasks for Learners

- Print personal information on separate lines: Use multiple `cout` statements to display name, age, and school.

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

### Breakdown for Learners

**Understanding Multiple Output Statements:**
- Each `cout` statement prints one line of text
- `endl` creates a new line after each output (like pressing Enter)
- You can chain multiple `cout` statements to build formatted displays
- Order matters: statements execute from top to bottom

**Key Points:**
- Use `endl` or `\n` to move to a new line
- Multiple `cout` statements = multiple lines of output
- Good formatting makes output readable and professional
- This technique is essential for creating menus, reports, and user interfaces

**Why It Matters:**
Real-world applications display information clearly: ATM screens show balance and transactions on separate lines, game UIs display health/score/inventory, and database reports present organized data. Mastering `cout` with `endl` is your first step to creating professional user interfaces.

---

## Activity 3: ASCII Art House

**Objective:** Create simple ASCII art using multiple lines of output.

**Task:**  
Print a simple house using ASCII characters (asterisks and vertical bars).

**Boilerplate Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Print the roof (triangle)
    
    // Print the walls
    
    return 0;
}
```

# Tasks for Learners

- Create ASCII art house: Use multiple `cout` statements to draw a house with a roof and walls.

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

### Breakdown for Learners

**Understanding ASCII Art:**
- Spaces control horizontal positioning (indentation)
- Asterisks (`*`) create the visible shapes
- Each `cout` prints one line of the drawing
- Proper spacing creates the illusion of a 2D image

**Key Points:**
- Count spaces carefully to align elements properly
- ASCII art = using keyboard characters to draw pictures
- The roof uses increasing asterisks: 1, 3, 5, 7 (odd numbers create symmetry)
- The walls use consistent `| |` with spacing to align under the roof
- This technique was used in early computer games and terminal UIs

**Why It Matters:**
ASCII art teaches precision and visual thinking. Filipino developers use similar concepts in terminal UIs, game development (sprites before graphics), and even modern loading animations. Understanding how characters create visual patterns prepares you for graphics programming and UI design.

---

## Challenge Activity: Philippine Flag

**Objective:** Apply your knowledge to create a more complex ASCII art.

**Task:**  
Create a simplified ASCII representation of the Philippine flag.

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

After completing these activities, reflect deeply on what you've learned:

1. **What is the purpose of `#include <iostream>` in every C++ program?**
   
   _[Write your answer here: Think about what tools this header file provides]_

2. **Why does C++ require semicolons at the end of statements? How does this differ from JavaScript?**
   
   _[Your answer: Consider how the compiler needs to know where one instruction ends]_

3. **What does `return 0;` mean in the main function? What does the operating system do with this value?**
   
   _[Your answer: Remember Kuya Miguel's "Mission accomplished!" analogy]_

4. **How is C++ different from JavaScript in terms of compilation? Why does this make C++ faster?**
   
   _[Your answer: Think about the book translation analogy—compiled vs interpreted]_

5. **What real-world applications in the Philippines might use C++ instead of JavaScript?**
   
   _[Your answer: Consider games, manufacturing, embedded systems, banking]_

6. **Why is C++ considered "strict" compared to JavaScript? Is this strictness helpful or annoying?**
   
   _[Your answer: Think about catching errors before running vs during running]_

---

## What You've Learned

Through these activities, you've practiced:

**Program Structure**: Understanding the essential components every C++ program needs  
**Console Output**: Using `cout` to display text and formatted information  
**Syntax Rules**: Following C++'s strict requirements for semicolons, case sensitivity  
**Code Organization**: Writing clean, readable code with proper indentation  
**Debugging**: Identifying and fixing common syntax errors  
**Comments**: Documenting code to explain logic and decisions
**Connection to Real World:**
- Every C++ application—from Dota 2 to Windows—starts with these basics
- Understanding program structure prepares you for building complex systems
- The discipline C++ teaches makes you a better programmer in ANY language
- Filipino game studios, BPO companies, and tech startups need C++ developers

**Salary Context (Philippines 2025):**
- Junior C++ Developer: ₱25,000 - ₱45,000/month
- Mid-level: ₱50,000 - ₱90,000/month  
- Game Engine Developer: ₱120,000+/month

---

## Next Steps

**Ready for Lesson 2?**  
Next, you'll learn about **variables and data types**—how C++ stores and manages different kinds of information. You'll discover why C++ makes you declare types explicitly and how this strictness prevents bugs and improves performance.

From hardcoded values to dynamic data storage—let's level up!t Steps

**Ready for Lesson 2?**  
Next, you'll learn about **variables and data types**—how C++ stores and manages different kinds of information. You'll discover why C++ makes you declare types explicitly and how this strictness prevents bugs and improves performance.

From hardcoded values to dynamic data storage—let's level up!