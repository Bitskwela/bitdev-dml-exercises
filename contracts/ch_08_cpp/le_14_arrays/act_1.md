# Lesson 14 Activities: Arrays

---

## Challenge 1: Attendance Tracker

**Objective:** Use arrays to track and analyze weekly attendance data.

**Task:**  
Create a program that:
- Stores attendance for 7 days (Mon-Sun) in an array
- Finds the day with highest and lowest attendance
- Calculates average attendance
- Displays a summary report

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string days[] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    int attendance[7];
    
    // Input attendance for each day
    // Find highest and lowest
    // Calculate average
    // Display report
    
    return 0;
}
```

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

int main() {
    string days[] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    int attendance[7];
    
    // Input
    cout << "=== WEEKLY ATTENDANCE TRACKER ===" << endl;
    for (int i = 0; i < 7; i++) {
        cout << "Enter attendance for " << days[i] << ": ";
        cin >> attendance[i];
    }
    
    // Find highest and lowest
    int highest = attendance[0];
    int lowest = attendance[0];
    string highestDay = days[0];
    string lowestDay = days[0];
    int total = 0;
    
    for (int i = 0; i < 7; i++) {
        total += attendance[i];
        
        if (attendance[i] > highest) {
            highest = attendance[i];
            highestDay = days[i];
        }
        
        if (attendance[i] < lowest) {
            lowest = attendance[i];
            lowestDay = days[i];
        }
    }
    
    double average = total / 7.0;
    
    // Display report
    cout << "\n=== ATTENDANCE SUMMARY ===" << endl;
    cout << "Highest: " << highestDay << " (" << highest << ")" << endl;
    cout << "Lowest: " << lowestDay << " (" << lowest << ")" << endl;
    cout << fixed << setprecision(2);
    cout << "Average: " << average << endl;
    cout << "Total: " << total << endl;
    
    return 0;
}
```

</details>

---

## Challenge 2: Clearance Fee Calculator with Parallel Arrays

**Objective:** Use parallel arrays to store related data.

**Task:**  
Create a clearance fee system that:
- Stores 5 resident ages in one array
- Calculates fee for each (₱50 for adults, ₱30 for seniors 60+)
- Stores fees in parallel array
- Displays total revenue

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    const int NUM_RESIDENTS = 5;
    int ages[NUM_RESIDENTS];
    double fees[NUM_RESIDENTS];
    double totalRevenue = 0;
    
    cout << "=== CLEARANCE FEE CALCULATOR ===" << endl;
    
    // Input ages
    for (int i = 0; i < NUM_RESIDENTS; i++) {
        cout << "Enter age of resident " << (i + 1) << ": ";
        cin >> ages[i];
        
        // Calculate fee
        if (ages[i] >= 60) {
            fees[i] = 30.00;  // Senior discount
        } else {
            fees[i] = 50.00;  // Regular fee
        }
        
        totalRevenue += fees[i];
    }
    
    // Display results
    cout << "\n=== FEE BREAKDOWN ===" << endl;
    cout << fixed << setprecision(2);
    for (int i = 0; i < NUM_RESIDENTS; i++) {
        cout << "Resident " << (i + 1) << " (Age " << ages[i] << "): PHP " << fees[i] << endl;
    }
    
    cout << "\n=== TOTAL REVENUE ===" << endl;
    cout << "PHP " << totalRevenue << endl;
    
    return 0;
}
```

</details>

---

## Challenge 3: Grade Analyzer

**Objective:** Process an array of student grades with statistics.

**Task:**  
Create a program that:
- Stores 10 student grades in an array
- Counts passing (>= 75) and failing grades
- Finds highest and lowest grade
- Calculates class average

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    const int NUM_STUDENTS = 10;
    double grades[NUM_STUDENTS];
    int passingCount = 0;
    int failingCount = 0;
    
    cout << "=== GRADE ANALYZER ===" << endl;
    
    // Input grades
    for (int i = 0; i < NUM_STUDENTS; i++) {
        cout << "Enter grade for student " << (i + 1) << ": ";
        cin >> grades[i];
    }
    
    // Initialize with first grade
    double highest = grades[0];
    double lowest = grades[0];
    double total = 0;
    
    // Analyze
    for (int i = 0; i < NUM_STUDENTS; i++) {
        total += grades[i];
        
        if (grades[i] >= 75) {
            passingCount++;
        } else {
            failingCount++;
        }
        
        if (grades[i] > highest) highest = grades[i];
        if (grades[i] < lowest) lowest = grades[i];
    }
    
    double average = total / NUM_STUDENTS;
    
    // Display results
    cout << "\n=== CLASS STATISTICS ===" << endl;
    cout << fixed << setprecision(2);
    cout << "Highest Grade: " << highest << endl;
    cout << "Lowest Grade: " << lowest << endl;
    cout << "Class Average: " << average << endl;
    cout << "Passing Students: " << passingCount << " (" 
         << (passingCount * 100.0 / NUM_STUDENTS) << "%)" << endl;
    cout << "Failing Students: " << failingCount << " (" 
         << (failingCount * 100.0 / NUM_STUDENTS) << "%)" << endl;
    
    return 0;
}
```

</details>

---

## Key Takeaways

- Arrays store multiple values of the same type
- Use zero-based indexing (0 to size-1)
- Always check array bounds
- Use loops to process array elements
- Parallel arrays store related data at same indices

**Next:** Lesson 15 - Strings (arrays of characters with superpowers!)
