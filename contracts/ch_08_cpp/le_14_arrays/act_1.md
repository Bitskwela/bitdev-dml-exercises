# Lesson 14 Activities: Arrays

## The 500 Residents Problem

The barangay clerk wanted to track **500 residents**. The intern started writing:
```cpp
string resident1, resident2, resident3, resident4...
```

**Arrays are the solution to the impossible.** Instead of 500 variables, declare ONE:
```cpp
string residents[500];
```

**Arrays are everywhere:** player inventories, student records, product lists, leaderboards. This lesson masters indexed collections!

---

## Task 1: Basic Array Declaration

**Context:** Create and access arrays with zero-based indexing.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Declare array of 5 barangay officials
    string officials[5] = {"Kapitan", "Kagawad1", "Kagawad2", "Kagawad3", "SK Chair"};
    
    // Access elements (0-indexed!)
    cout << "First official: " << officials[0] << endl;
    cout << "Last official: " << officials[4] << endl;
    
    // Modify element
    officials[1] = "Kagawad Juan";
    cout << "Updated: " << officials[1] << endl;
    
    return 0;
}
```

**Task:** Create an array of 7 jeepney routes. Print the first and last routes.

---

## Task 2: Array Initialization Methods

**Context:** Different ways to create arrays.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Method 1: Full initialization
    int scores1[5] = {85, 92, 78, 88, 95};
    
    // Method 2: Partial initialization (rest become 0)
    int scores2[5] = {100, 90};  // {100, 90, 0, 0, 0}
    
    // Method 3: Let compiler count
    int scores3[] = {75, 80, 85, 90};  // Size is 4
    
    // Method 4: Declare then assign
    int scores4[3];
    scores4[0] = 88;
    scores4[1] = 92;
    scores4[2] = 76;
    
    cout << "Scores2[3]: " << scores2[3] << endl;  // 0
    
    return 0;
}
```

**Task:** Experiment with each method. Explain when to use each.

---

## Task 3: Loop Through Array

**Context:** Process all elements efficiently with loops.

**Challenge:** Calculate average of all grades.

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    int grades[10] = {85, 92, 78, 88, 95, 82, 90, 87, 91, 89};
    int size = 10;
    
    // Calculate sum
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += grades[i];
    }
    
    double average = sum / (double)size;
    
    cout << fixed << setprecision(2);
    cout << "Average: " << average << endl;
    
    return 0;
}
```

**Expected:** Average ≈ 87.70

---

## Task 4: Find Maximum in Array

**Context:** Search through array for specific value.

**Challenge:** Find the highest grade and its position.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int grades[8] = {85, 92, 78, 95, 88, 91, 82, 90};
    int size = 8;
    
    int maxGrade = grades[0];
    int maxIndex = 0;
    
    for (int i = 1; i < size; i++) {
        if (grades[i] > maxGrade) {
            maxGrade = grades[i];
            maxIndex = i;
        }
    }
    
    cout << "Highest grade: " << maxGrade << endl;
    cout << "Position: " << maxIndex << " (Student " << (maxIndex + 1) << ")" << endl;
    
    return 0;
}
```

---

## Task 5: Count Occurrences

**Context:** Count how many times a value appears.

**Challenge:** Count students with passing grades (>=75).

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int grades[10] = {85, 60, 78, 72, 95, 82, 68, 87, 91, 70};
    int size = 10;
    int passingGrade = 75;
    
    int passCount = 0;
    for (int i = 0; i < size; i++) {
        if (grades[i] >= passingGrade) {
            passCount++;
        }
    }
    
    cout << "Students passing (>=" << passingGrade << "): " << passCount << endl;
    cout << "Students failing (<" << passingGrade << "): " << (size - passCount) << endl;
    
    return 0;
}
```

---

## Task 6: Reverse an Array

**Context:** Manipulate array order.

**Challenge:** Reverse array in-place (without creating new array).

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int numbers[6] = {10, 20, 30, 40, 50, 60};
    int size = 6;
    
    cout << "Original: ";
    for (int i = 0; i < size; i++) {
        cout << numbers[i] << " ";
    }
    cout << endl;
    
    // Reverse by swapping
    for (int i = 0; i < size / 2; i++) {
        int temp = numbers[i];
        numbers[i] = numbers[size - 1 - i];
        numbers[size - 1 - i] = temp;
    }
    
    cout << "Reversed: ";
    for (int i = 0; i < size; i++) {
        cout << numbers[i] << " ";
    }
    cout << endl;
    
    return 0;
}
```

**Expected:** 60 50 40 30 20 10

---

## Task 7: Barangay Complaint Tracker

**Context:** Real-world array application—track complaint counts per barangay.

**Challenge:** Build a system to record and display complaints.

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    string barangays[5] = {"Poblacion", "San Jose", "Santa Maria", "Del Pilar", "San Antonio"};
    int complaints[5] = {12, 8, 15, 5, 10};
    int size = 5;
    
    cout << "=== BARANGAY COMPLAINT SUMMARY ===" << endl;
    cout << left << setw(20) << "Barangay" << "Complaints" << endl;
    cout << string(35, '-') << endl;
    
    int total = 0;
    for (int i = 0; i < size; i++) {
        cout << left << setw(20) << barangays[i] << complaints[i] << endl;
        total += complaints[i];
    }
    
    cout << string(35, '-') << endl;
    cout << left << setw(20) << "TOTAL" << total << endl;
    
    // Find barangay with most complaints
    int maxIndex = 0;
    for (int i = 1; i < size; i++) {
        if (complaints[i] > complaints[maxIndex]) {
            maxIndex = i;
        }
    }
    
    cout << "\nMost complaints: " << barangays[maxIndex] 
         << " (" << complaints[maxIndex] << ")" << endl;
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Array Essentials</strong></summary>

**Key Concepts:**
- **Zero-indexed:** First element is `arr[0]`, not `arr[1]`
- **Fixed size:** Size determined at declaration, can't change
- **Same type:** All elements must be same data type
- **Contiguous memory:** Elements stored next to each other in RAM

**Common Patterns:**
```cpp
// Loop through array
for (int i = 0; i < size; i++) {
    // Process arr[i]
}

// Find maximum
int max = arr[0];
for (int i = 1; i < size; i++) {
    if (arr[i] > max) max = arr[i];
}

// Count occurrences
int count = 0;
for (int i = 0; i < size; i++) {
    if (arr[i] == target) count++;
}
```

**Common Mistakes:**
- Off-by-one errors: `i <= size` instead of `i < size`
- Forgetting array size (use constant or variable!)
- Accessing out of bounds: `arr[100]` when size is 50

</details>

---

**Master arrays:** They're the foundation for every data structure you'll learn!
