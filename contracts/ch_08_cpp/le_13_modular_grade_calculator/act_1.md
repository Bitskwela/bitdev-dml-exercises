# Lesson 13 Activities: Modular Grade Calculator

## The 150-Line Monster

Tian's grade calculator was a **tangled mess**—150 lines of spaghetti code where everything lived in `main()`. Debugging? Nightmare. Testing? Impossible. Reusing code? Copy-paste hell.

**Professional software uses modular design.** Your phone has separate modules: screen, battery, camera, processor. Each does ONE job well. If the camera breaks, you don't replace the whole phone!

**This lesson refactors chaos into clean, testable modules.**

---

## Task 1: Extract Input Function

**Context:** Separate the messy input code into its own function.

**Before (Tangled in main):**
```cpp
int main() {
    int numStudents;
    cout << "Enter number of students: ";
    cin >> numStudents;
    
    // ... 100 more lines
}
```

**After (Modular):**
```cpp
#include <iostream>
using namespace std;

int getNumberOfStudents() {
    int count;
    cout << "Enter number of students: ";
    cin >> count;
    return count;
}

int main() {
    int numStudents = getNumberOfStudents();
    
    // Clear and organized!
    return 0;
}
```

# Tasks for Learners

- Extract a function `getStudentGrades(int numStudents)` that prompts for and returns an array of grades.

  ```cpp
  #include <iostream>
  using namespace std;

  int getNumberOfStudents() {
      int count;
      cout << "Enter number of students: ";
      cin >> count;
      return count;
  }

  void getStudentGrades(int grades[], int numStudents) {
      for (int i = 0; i < numStudents; i++) {
          cout << "Enter grade for student " << (i + 1) << ": ";
          cin >> grades[i];
      }
  }

  int main() {
      int numStudents = getNumberOfStudents();
      int* grades = new int[numStudents];
      
      getStudentGrades(grades, numStudents);
      
      // Display grades
      cout << "\nGrades entered: ";
      for (int i = 0; i < numStudents; i++) {
          cout << grades[i] << " ";
      }
      cout << endl;
      
      delete[] grades;
      return 0;
  }
  ```

---

## Task 2: Calculate Average Module

**Context:** Create a reusable calculation function.

**Challenge:** Write `double calculateAverage(int grades[], int size)` that returns the average grade.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

double calculateAverage(int grades[], int size) {
    double sum = 0;
    for (int i = 0; i < size; i++) {
        sum += grades[i];
    }
    return sum / size;
}

int main() {
    int grades[] = {85, 92, 78, 88, 95};
    double avg = calculateAverage(grades, 5);
    cout << "Average: " << avg << endl;
    return 0;
}
```

# Tasks for Learners

- Create a reusable `calculateAverage` function and test with known inputs.

  ```cpp
  #include <iostream>
  using namespace std;

  double calculateAverage(int grades[], int size) {
      double sum = 0;
      for (int i = 0; i < size; i++) {
          sum += grades[i];
      }
      return sum / size;
  }

  int main() {
      int grades[] = {85, 92, 78, 88, 95};
      double avg = calculateAverage(grades, 5);
      cout << "Average: " << avg << endl;  // 87.6
      
      // Test with {100, 100}
      int testGrades[] = {100, 100};
      cout << "Test average: " << calculateAverage(testGrades, 2) << endl;  // 100.0
      
      return 0;
  }
  ```

---

## Task 3: Find Highest/Lowest Module

**Context:** Extract min/max logic into reusable functions.

**Challenge:** Create `int findHighest(int grades[], int size)` and `int findLowest(int grades[], int size)`.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int findHighest(int grades[], int size) {
    int max = grades[0];
    for (int i = 1; i < size; i++) {
        if (grades[i] > max) max = grades[i];
    }
    return max;
}

int findLowest(int grades[], int size) {
    int min = grades[0];
    for (int i = 1; i < size; i++) {
        if (grades[i] < min) min = grades[i];
    }
    return min;
}

int main() {
    int grades[] = {85, 92, 78, 88, 95};
    
    cout << "Highest: " << findHighest(grades, 5) << endl;
    cout << "Lowest: " << findLowest(grades, 5) << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create `findHighest` and `findLowest` functions to extract min/max logic into reusable modules.

  ```cpp
  #include <iostream>
  using namespace std;

  int findHighest(int grades[], int size) {
      int max = grades[0];
      for (int i = 1; i < size; i++) {
          if (grades[i] > max) max = grades[i];
      }
      return max;
  }

  int findLowest(int grades[], int size) {
      int min = grades[0];
      for (int i = 1; i < size; i++) {
          if (grades[i] < min) min = grades[i];
      }
      return min;
  }

  int main() {
      int grades[] = {85, 92, 78, 88, 95};
      
      cout << "Highest: " << findHighest(grades, 5) << endl;  // 95
      cout << "Lowest: " << findLowest(grades, 5) << endl;    // 78
      
      return 0;
  }
  ```

---

## Task 4: Count Passing/Failing Module

**Context:** Separate counting logic for clean reports.

**Challenge:** Create `int countPassing(int grades[], int size, int passingGrade)` and `int countFailing(...)`.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int countPassing(int grades[], int size, int passingGrade) {
    int count = 0;
    for (int i = 0; i < size; i++) {
        if (grades[i] >= passingGrade) count++;
    }
    return count;
}

int countFailing(int grades[], int size, int passingGrade) {
    return size - countPassing(grades, size, passingGrade);
}

int main() {
    int grades[] = {85, 92, 78, 88, 95, 60, 72};
    int passing = countPassing(grades, 7, 75);
    int failing = countFailing(grades, 7, 75);
    
    cout << "Passing (>=75): " << passing << endl;
    cout << "Failing (<75): " << failing << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create `countPassing` and `countFailing` functions to separate counting logic for clean reports.

  ```cpp
  #include <iostream>
  using namespace std;

  int countPassing(int grades[], int size, int passingGrade) {
      int count = 0;
      for (int i = 0; i < size; i++) {
          if (grades[i] >= passingGrade) count++;
      }
      return count;
  }

  int countFailing(int grades[], int size, int passingGrade) {
      return size - countPassing(grades, size, passingGrade);
  }

  int main() {
      int grades[] = {85, 92, 78, 88, 95, 60, 72};
      int passing = countPassing(grades, 7, 75);
      int failing = countFailing(grades, 7, 75);
      
      cout << "Passing (>=75): " << passing << endl;  // 5
      cout << "Failing (<75): " << failing << endl;    // 2
      
      return 0;
  }
  ```

---

## Task 5: Display Report Module

**Context:** Separate presentation from calculation.

**Challenge:** Create `void displayReport(int grades[], int size)` that uses all the above modules.

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

double calculateAverage(int grades[], int size) {
    double sum = 0;
    for (int i = 0; i < size; i++) sum += grades[i];
    return sum / size;
}

int findHighest(int grades[], int size) {
    int max = grades[0];
    for (int i = 1; i < size; i++) 
        if (grades[i] > max) max = grades[i];
    return max;
}

int findLowest(int grades[], int size) {
    int min = grades[0];
    for (int i = 1; i < size; i++) 
        if (grades[i] < min) min = grades[i];
    return min;
}

int countPassing(int grades[], int size, int passingGrade) {
    int count = 0;
    for (int i = 0; i < size; i++) 
        if (grades[i] >= passingGrade) count++;
    return count;
}

void displayReport(int grades[], int size) {
    cout << "\n=== GRADE REPORT ===" << endl;
    cout << fixed << setprecision(2);
    cout << "Average: " << calculateAverage(grades, size) << endl;
    cout << "Highest: " << findHighest(grades, size) << endl;
    cout << "Lowest: " << findLowest(grades, size) << endl;
    cout << "Passing (>=75): " << countPassing(grades, size, 75) << endl;
    cout << "Failing (<75): " << (size - countPassing(grades, size, 75)) << endl;
}

int main() {
    int grades[] = {85, 92, 78, 88, 95, 60, 72, 81, 90, 68};
    displayReport(grades, 10);
    return 0;
}
```

# Tasks for Learners

- Create `displayReport` function that uses all calculation modules to separate presentation from calculation.

  ```cpp
  #include <iostream>
  #include <iomanip>
  using namespace std;

  double calculateAverage(int grades[], int size) {
      double sum = 0;
      for (int i = 0; i < size; i++) sum += grades[i];
      return sum / size;
  }

  int findHighest(int grades[], int size) {
      int max = grades[0];
      for (int i = 1; i < size; i++) 
          if (grades[i] > max) max = grades[i];
      return max;
  }

  int findLowest(int grades[], int size) {
      int min = grades[0];
      for (int i = 1; i < size; i++) 
          if (grades[i] < min) min = grades[i];
      return min;
  }

  int countPassing(int grades[], int size, int passingGrade) {
      int count = 0;
      for (int i = 0; i < size; i++) 
          if (grades[i] >= passingGrade) count++;
      return count;
  }

  void displayReport(int grades[], int size) {
      cout << "\n=== GRADE REPORT ===" << endl;
      cout << fixed << setprecision(2);
      cout << "Average: " << calculateAverage(grades, size) << endl;
      cout << "Highest: " << findHighest(grades, size) << endl;
      cout << "Lowest: " << findLowest(grades, size) << endl;
      cout << "Passing (>=75): " << countPassing(grades, size, 75) << endl;
      cout << "Failing (<75): " << (size - countPassing(grades, size, 75)) << endl;
  }

  int main() {
      int grades[] = {85, 92, 78, 88, 95, 60, 72, 81, 90, 68};
      displayReport(grades, 10);
      return 0;
  }
  ```

---

## Task 6: Complete Modular System

**Context:** Combine all modules into a professional system.

**Challenge:** Build a complete grade calculator with menu system using all your modules.

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

// Input Module
int getNumberOfStudents() {
    int count;
    cout << "How many students? ";
    cin >> count;
    return count;
}

void inputGrades(int grades[], int size) {
    for (int i = 0; i < size; i++) {
        cout << "Student " << (i+1) << " grade: ";
        cin >> grades[i];
    }
}

// Calculation Modules
double calculateAverage(int grades[], int size) {
    double sum = 0;
    for (int i = 0; i < size; i++) sum += grades[i];
    return sum / size;
}

int findHighest(int grades[], int size) {
    int max = grades[0];
    for (int i = 1; i < size; i++) 
        if (grades[i] > max) max = grades[i];
    return max;
}

int findLowest(int grades[], int size) {
    int min = grades[0];
    for (int i = 1; i < size; i++) 
        if (grades[i] < min) min = grades[i];
    return min;
}

int countPassing(int grades[], int size) {
    int count = 0;
    for (int i = 0; i < size; i++) 
        if (grades[i] >= 75) count++;
    return count;
}

// Display Module
void displayReport(int grades[], int size) {
    cout << "\n=== COMPLETE GRADE REPORT ===" << endl;
    cout << fixed << setprecision(2);
    cout << "Total Students: " << size << endl;
    cout << "Average Grade: " << calculateAverage(grades, size) << endl;
    cout << "Highest Grade: " << findHighest(grades, size) << endl;
    cout << "Lowest Grade: " << findLowest(grades, size) << endl;
    cout << "Passing (>=75): " << countPassing(grades, size) << endl;
    cout << "Failing (<75): " << (size - countPassing(grades, size)) << endl;
    
    double passRate = (countPassing(grades, size) * 100.0) / size;
    cout << "Pass Rate: " << passRate << "%" << endl;
}

int main() {
    int numStudents = getNumberOfStudents();
    int* grades = new int[numStudents];
    
    inputGrades(grades, numStudents);
    displayReport(grades, numStudents);
    
    delete[] grades;
    return 0;
}
```

# Tasks for Learners

- Build a complete modular grade calculator system with menu using all your modules.

  ```cpp
  #include <iostream>
  #include <iomanip>
  using namespace std;

  // Input Module
  int getNumberOfStudents() {
      int count;
      cout << "How many students? ";
      cin >> count;
      return count;
  }

  void inputGrades(int grades[], int size) {
      for (int i = 0; i < size; i++) {
          cout << "Student " << (i+1) << " grade: ";
          cin >> grades[i];
      }
  }

  // Calculation Modules
  double calculateAverage(int grades[], int size) {
      double sum = 0;
      for (int i = 0; i < size; i++) sum += grades[i];
      return sum / size;
  }

  int findHighest(int grades[], int size) {
      int max = grades[0];
      for (int i = 1; i < size; i++) 
          if (grades[i] > max) max = grades[i];
      return max;
  }

  int findLowest(int grades[], int size) {
      int min = grades[0];
      for (int i = 1; i < size; i++) 
          if (grades[i] < min) min = grades[i];
      return min;
  }

  int countPassing(int grades[], int size) {
      int count = 0;
      for (int i = 0; i < size; i++) 
          if (grades[i] >= 75) count++;
      return count;
  }

  // Display Module
  void displayReport(int grades[], int size) {
      cout << "\n=== COMPLETE GRADE REPORT ===" << endl;
      cout << fixed << setprecision(2);
      cout << "Total Students: " << size << endl;
      cout << "Average Grade: " << calculateAverage(grades, size) << endl;
      cout << "Highest Grade: " << findHighest(grades, size) << endl;
      cout << "Lowest Grade: " << findLowest(grades, size) << endl;
      cout << "Passing (>=75): " << countPassing(grades, size) << endl;
      cout << "Failing (<75): " << (size - countPassing(grades, size)) << endl;
      
      double passRate = (countPassing(grades, size) * 100.0) / size;
      cout << "Pass Rate: " << passRate << "%" << endl;
  }

  int main() {
      int numStudents = getNumberOfStudents();
      int* grades = new int[numStudents];
      
      inputGrades(grades, numStudents);
      displayReport(grades, numStudents);
      
      delete[] grades;
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Modular Design Benefits</strong></summary>

**Why Modular?**
1. **Testable:** Test each function independently
2. **Reusable:** Use `calculateAverage()` in other programs
3. **Maintainable:** Bug in average? Fix one function, not 150 lines
4. **Readable:** Clear function names = self-documenting code
5. **Collaborative:** Different team members work on different modules

**Modular Principles:**
- Each function does ONE thing well
- Clear inputs and outputs
- No hidden dependencies (avoid globals!)
- Meaningful names (not `func1`, `func2`)

**Compare:**
- **Before:** 150 lines in `main()`, impossible to debug
- **After:** 6 small functions, each testable, clear purpose

</details>

---

**Professional tip:** If you can't explain what a function does in one sentence, it's doing too much. Break it down!
