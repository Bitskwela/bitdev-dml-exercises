# Lesson 7 Activities: Nested Control Structures

## Multi-Layer Verification System

Remember Tian's simple resident verification that worked for one person? The barangay secretary needs to process 50 residents, each with multiple documents. **Nesting** solves this: loops inside loops, conditions inside loops, creating complex multi-layer logic.

**This lesson is about complexity management.** Real problems aren't flat—they have layers. A delivery app loops through restaurants, then loops through each restaurant's menu. A game spawns enemies in zones, each with different behaviors. Today, you master nested structures!

**What makes nesting powerful:**
- **Nested loops** – Multi-dimensional iteration (tables, grids, patterns)
- **Conditions in loops** – Selective processing during iteration
- **Loops in conditions** – Execute repetition only when criteria met

---

## Task 1: Multiplication Table (Nested For Loops)

**Context:**  
Create a complete multiplication table that shows products from 1×1 to 10×10. Each row is controlled by outer loop, each column by inner loop.

**Your Challenge:**  
Use nested `for` loops to generate the entire table automatically.

**What You'll Practice:**
- Outer loop for rows
- Inner loop for columns  
- Multiplication in nested loops
- Tab formatting (`\t`)

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== MULTIPLICATION TABLE ===" << endl;
    cout << endl;
    
    // Outer loop: rows (1-10)
    // Inner loop: columns (1-10)
    // Print product with tab spacing
    
    return 0;
}
```

# Tasks for Learners

- Generate multiplication table using nested loops: Use outer loop for rows and inner loop for columns.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      cout << "=== MULTIPLICATION TABLE ===" << endl;
      cout << endl;
      
      for (int i = 1; i <= 10; i++) {  // Rows
          for (int j = 1; j <= 10; j++) {  // Columns
              cout << (i * j) << "\t";
          }
          cout << endl;
      }
      
      return 0;
  }
  ```

---

## Task 2: Attendance Grid (Nested Loops with Data)

**Context:**  
Track barangay meeting attendance for 5 residents across 7 days. Use nested loops to display a grid.

**Your Challenge:**  
Create a 2D attendance grid using nested loops.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== WEEKLY ATTENDANCE GRID ===" << endl;
    cout << "Day\tR1\tR2\tR3\tR4\tR5" << endl;
    cout << "--------------------------------------" << endl;
    
    // Outer loop: days (1-7)
    // Inner loop: residents (1-5)
    // Print 'P' for present
    
    return 0;
}
```

# Tasks for Learners

- Create attendance grid with nested loops: Display 7 days × 5 residents grid.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      cout << "=== WEEKLY ATTENDANCE GRID ===" << endl;
      cout << "Day\tR1\tR2\tR3\tR4\tR5" << endl;
      cout << "--------------------------------------" << endl;
      
      for (int day = 1; day <= 7; day++) {
          cout << day << "\t";
          for (int resident = 1; resident <= 5; resident++) {
              cout << "P\t";
          }
          cout << endl;
      }
      
      return 0;
  }
  ```

---

## Task 3: Star Pattern (Right Triangle)

**Context:**  
Generate visual patterns using nested loops. Each row has increasing number of stars.

**Your Challenge:**  
Print a right-angled triangle where row `i` has `i` stars.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int rows = 7;
    
    // Outer loop: row number
    // Inner loop: print stars (1 to i)
    
    return 0;
}
```

# Tasks for Learners

- Generate star pattern triangle: Use nested loops where inner loop runs i times for row i.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int rows = 7;
      
      for (int i = 1; i <= rows; i++) {
          for (int j = 1; j <= i; j++) {
              cout << "* ";
          }
          cout << endl;
      }
      
      return 0;
  }
  ```

---

## Task 4: Condition Inside Loop (Grade Classification)

**Context:**  
Process multiple student grades in one loop, classifying each one as passed/failed.

**Your Challenge:**  
Loop through 10 grades, check pass/fail condition for each.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int grades[] = {85, 92, 68, 74, 95, 58, 88, 79, 91, 64};
    
    cout << "=== GRADE CLASSIFICATION ===" << endl;
    
    // Loop through grades
    // Use if/else to classify each
    
    return 0;
}
```

# Tasks for Learners

- Classify grades with condition inside loop: Loop through grades array and check pass/fail for each.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int grades[] = {85, 92, 68, 74, 95, 58, 88, 79, 91, 64};
      
      cout << "=== GRADE CLASSIFICATION ===" << endl;
      
      for (int i = 0; i < 10; i++) {
          cout << "Student " << (i + 1) << ": " << grades[i] << " - ";
          
          if (grades[i] >= 75) {
              cout << "PASSED ✓" << endl;
          } else {
              cout << "FAILED ✗" << endl;
          }
      }
      
      return 0;
  }
  ```

---

## Task 5: Loop Inside Condition (Conditional Display)

**Context:**  
Ask if user wants to see a list. Only run the display loop if they say yes.

**Your Challenge:**  
Nest a for loop inside an if statement.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string response;
    
    cout << "Display resident list? (yes/no): ";
    cin >> response;
    
    // If yes, loop and display 20 residents
    // If no, show cancellation message
    
    return 0;
}
```

# Tasks for Learners

- Nest loop inside condition: Execute loop only if condition is true.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  int main() {
      string response;
      
      cout << "Display resident list? (yes/no): ";
      cin >> response;
      
      if (response == "yes") {
          cout << "\n=== RESIDENT LIST ===" << endl;
          for (int i = 1; i <= 20; i++) {
              cout << "Resident #" << i << endl;
          }
      } else {
          cout << "List display cancelled." << endl;
      }
      
      return 0;
  }
  ```


