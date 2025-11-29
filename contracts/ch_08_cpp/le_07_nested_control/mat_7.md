## Background Story

Tian's resident verification program worked perfectly—for exactly one person. But when the barangay secretary asked to process all 50 residents who applied this week, each with multiple documents to verify, Tian realized the code would become a nightmare.

"I need to loop through 50 residents," Tian said, thinking aloud. "But for each resident, I also need to check their ID, proof of address, and barangay clearance. And some checks only apply if they're above 18 years old. How do I handle layers of logic?"

Kuya Miguel pulled up a chair. "Welcome to the real world of programming! Most problems aren't simple 'do this 10 times' or 'check if this is true.' They're complex decision trees with repeating patterns at multiple levels. A delivery app checking restaurants in your area, then checking each restaurant's menu, then checking if each dish is available. A game spawning enemies in different zones, with each enemy having different attack patterns based on player level."

"This is called **nesting**—putting control structures inside other control structures. Loops inside loops, conditions inside loops, loops inside conditions. It sounds complicated, but it's how we model real-world complexity. Let's build your multi-layer verification system!"

---

## Theory & Lecture Content

## What is Nesting?

**Nesting** means placing one control structure inside another. You can nest:
- **Loops inside loops** (nested loops)
- **Conditions inside loops**
- **Loops inside conditions**
- **Conditions inside conditions**

This creates powerful, complex logic flows.

---

## 1. Conditions Inside Loops

**Most Common Pattern:** Check something on each iteration

### Example: Grade Classification

```cpp
#include <iostream>
using namespace std;

int main() {
    int grades[] = {85, 92, 74, 68, 95};
    int numStudents = 5;
    
    cout << "=== Grade Classification ===" << endl;
    
    for (int i = 0; i < numStudents; i++) {
        cout << "Student " << (i + 1) << ": " << grades[i] << " - ";
        
        if (grades[i] >= 90) {
            cout << "Excellent" << endl;
        } else if (grades[i] >= 80) {
            cout << "Very Good" << endl;
        } else if (grades[i] >= 75) {
            cout << "Good" << endl;
        } else {
            cout << "Needs Improvement" << endl;
        }
    }
    
    return 0;
}
```

**Output:**
```
=== Grade Classification ===
Student 1: 85 - Very Good
Student 2: 92 - Excellent
Student 3: 74 - Needs Improvement
Student 4: 68 - Needs Improvement
Student 5: 95 - Excellent
```

### Barangay Example: Monthly Due Status

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string residents[] = {"Juan", "Maria", "Pedro", "Ana", "Luis"};
    bool paid[] = {true, false, true, true, false};
    int numResidents = 5;
    
    cout << "=== Monthly Dues Report ===" << endl;
    
    for (int i = 0; i < numResidents; i++) {
        cout << residents[i] << ": ";
        
        if (paid[i]) {
            cout << "✓ PAID" << endl;
        } else {
            cout << "✗ UNPAID - Please settle dues" << endl;
        }
    }
    
    return 0;
}
```

**Output:**
```
=== Monthly Dues Report ===
Juan: ✓ PAID
Maria: ✗ UNPAID - Please settle dues
Pedro: ✓ PAID
Ana: ✓ PAID
Luis: ✗ UNPAID - Please settle dues
```

---

## 2. Loops Inside Loops (Nested Loops)

**Use Case:** When you need to work with multi-dimensional data

### Pattern: Multiplication Table

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== Multiplication Table (1-5) ===" << endl;
    
    for (int i = 1; i <= 5; i++) {           // Outer loop: rows
        for (int j = 1; j <= 5; j++) {       // Inner loop: columns
            cout << (i * j) << "\t";
        }
        cout << endl;  // New line after each row
    }
    
    return 0;
}
```

**Output:**
```
=== Multiplication Table (1-5) ===
1	2	3	4	5	
2	4	6	8	10	
3	6	9	12	15	
4	8	12	16	20	
5	10	15	20	25
```

**How it works:**
- Outer loop runs 5 times (i = 1 to 5)
- For each outer loop iteration, inner loop runs 5 times (j = 1 to 5)
- Total iterations: 5 × 5 = 25

### Barangay Example: Weekly Attendance Grid

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string days[] = {"Mon", "Tue", "Wed", "Thu", "Fri"};
    string residents[] = {"Juan", "Maria", "Pedro"};
    
    // Attendance: 1 = Present, 0 = Absent
    int attendance[3][5] = {
        {1, 1, 0, 1, 1},  // Juan's attendance
        {1, 1, 1, 1, 0},  // Maria's attendance
        {0, 1, 1, 1, 1}   // Pedro's attendance
    };
    
    cout << "=== Weekly Attendance Report ===" << endl;
    cout << "Name\t";
    for (int d = 0; d < 5; d++) {
        cout << days[d] << "\t";
    }
    cout << endl;
    
    for (int i = 0; i < 3; i++) {           // Loop through residents
        cout << residents[i] << "\t";
        
        for (int j = 0; j < 5; j++) {       // Loop through days
            if (attendance[i][j] == 1) {
                cout << "P\t";  // Present
            } else {
                cout << "A\t";  // Absent
            }
        }
        cout << endl;
    }
    
    return 0;
}
```

**Output:**
```
=== Weekly Attendance Report ===
Name	Mon	Tue	Wed	Thu	Fri	
Juan	P	P	A	P	P	
Maria	P	P	P	P	A	
Pedro	A	P	P	P	P
```

---

## 3. Pattern: Find Pairs

**Problem:** Find all pairs of numbers in an array that sum to a target

```cpp
#include <iostream>
using namespace std;

int main() {
    int numbers[] = {2, 4, 6, 8, 10};
    int target = 12;
    int size = 5;
    
    cout << "Finding pairs that sum to " << target << ":" << endl;
    
    for (int i = 0; i < size; i++) {
        for (int j = i + 1; j < size; j++) {  // Start from i+1 to avoid duplicates
            if (numbers[i] + numbers[j] == target) {
                cout << numbers[i] << " + " << numbers[j] 
                     << " = " << target << endl;
            }
        }
    }
    
    return 0;
}
```

**Output:**
```
Finding pairs that sum to 12:
2 + 10 = 12
4 + 8 = 12
```

### Barangay Example: Room Assignment Checker

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string residents[] = {"Juan", "Maria", "Pedro", "Ana"};
    int rooms[] = {101, 102, 101, 103};  // Room assignments
    int size = 4;
    
    cout << "=== Checking for Roommates ===" << endl;
    
    for (int i = 0; i < size; i++) {
        for (int j = i + 1; j < size; j++) {
            if (rooms[i] == rooms[j]) {
                cout << residents[i] << " and " << residents[j] 
                     << " share Room " << rooms[i] << endl;
            }
        }
    }
    
    return 0;
}
```

**Output:**
```
=== Checking for Roommates ===
Juan and Pedro share Room 101
```

---

## 4. Loops Inside Conditions

**Use Case:** Execute a loop only when a condition is met

### Example: Process Only if Authorized

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string username;
    string password;
    
    cout << "Enter username: ";
    cin >> username;
    cout << "Enter password: ";
    cin >> password;
    
    if (username == "admin" && password == "barangay2025") {
        cout << "\n=== Access Granted ===" << endl;
        cout << "Resident Records:" << endl;
        
        string residents[] = {"Juan", "Maria", "Pedro"};
        for (int i = 0; i < 3; i++) {
            cout << (i + 1) << ". " << residents[i] << endl;
        }
    } else {
        cout << "Access Denied!" << endl;
    }
    
    return 0;
}
```

### Barangay Example: Senior Citizen Discount

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    cout << "Enter your age: ";
    cin >> age;
    
    if (age >= 60) {
        cout << "\n=== Senior Citizen Discount Applied ===" << endl;
        
        double items[] = {100.50, 250.75, 89.99};
        double total = 0;
        
        for (int i = 0; i < 3; i++) {
            double discounted = items[i] * 0.80;  // 20% discount
            cout << "Item " << (i + 1) << ": PHP " << items[i] 
                 << " -> PHP " << discounted << endl;
            total += discounted;
        }
        
        cout << "Total: PHP " << total << endl;
    } else {
        cout << "Regular pricing applies." << endl;
    }
    
    return 0;
}
```

---

## 5. Complex Nesting: Statistics Calculator

```cpp
#include <iostream>
using namespace std;

int main() {
    int residents = 4;
    int days = 5;
    
    // Hours worked per day for each resident
    int hoursWorked[4][5] = {
        {8, 8, 7, 8, 8},   // Juan
        {8, 8, 8, 8, 8},   // Maria
        {6, 7, 8, 7, 6},   // Pedro
        {8, 9, 8, 8, 7}    // Ana
    };
    
    string names[] = {"Juan", "Maria", "Pedro", "Ana"};
    
    cout << "=== Weekly Work Hours Report ===" << endl;
    
    for (int i = 0; i < residents; i++) {
        int totalHours = 0;
        int daysPresent = 0;
        
        // Calculate total hours and days present
        for (int j = 0; j < days; j++) {
            totalHours += hoursWorked[i][j];
            
            if (hoursWorked[i][j] >= 8) {
                daysPresent++;
            }
        }
        
        double average = totalHours / 5.0;
        
        cout << names[i] << ":" << endl;
        cout << "  Total Hours: " << totalHours << endl;
        cout << "  Average: " << average << " hours/day" << endl;
        cout << "  Full Days: " << daysPresent << "/5" << endl;
        
        if (average >= 8.0) {
            cout << "  Status: Exemplary ✓" << endl;
        } else if (average >= 7.0) {
            cout << "  Status: Good" << endl;
        } else {
            cout << "  Status: Needs Improvement" << endl;
        }
        
        cout << endl;
    }
    
    return 0;
}
```

**Output:**
```
=== Weekly Work Hours Report ===
Juan:
  Total Hours: 39
  Average: 7.8 hours/day
  Full Days: 4/5
  Status: Good

Maria:
  Total Hours: 40
  Average: 8 hours/day
  Full Days: 5/5
  Status: Exemplary ✓

Pedro:
  Total Hours: 34
  Average: 6.8 hours/day
  Full Days: 1/5
  Status: Needs Improvement

Ana:
  Total Hours: 40
  Average: 8 hours/day
  Full Days: 4/5
  Status: Exemplary ✓
```

---

## 6. Pattern: Drawing Shapes with Nested Loops

### Right Triangle

```cpp
#include <iostream>
using namespace std;

int main() {
    int rows = 5;
    
    cout << "Right Triangle:" << endl;
    
    for (int i = 1; i <= rows; i++) {        // Outer: row number
        for (int j = 1; j <= i; j++) {       // Inner: stars per row
            cout << "*";
        }
        cout << endl;
    }
    
    return 0;
}
```

**Output:**
```
Right Triangle:
*
**
***
****
*****
```

### Number Pattern

```cpp
#include <iostream>
using namespace std;

int main() {
    int rows = 5;
    
    cout << "Number Pattern:" << endl;
    
    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= i; j++) {
            cout << j << " ";
        }
        cout << endl;
    }
    
    return 0;
}
```

**Output:**
```
Number Pattern:
1 
1 2 
1 2 3 
1 2 3 4 
1 2 3 4 5
```

---

## Common Nested Loop Mistakes

### Mistake 1: Using Same Variable Name

```cpp
// ❌ WRONG - Both loops use 'i'
for (int i = 0; i < 3; i++) {
    for (int i = 0; i < 3; i++) {  // ERROR: 'i' already declared
        cout << i;
    }
}
```

**Fix:**
```cpp
// ✅ CORRECT - Use different variable names
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        cout << i << "," << j << " ";
    }
}
```

### Mistake 2: Wrong Loop Bounds

```cpp
// ❌ WRONG - Inner loop uses wrong limit
int arr[3][4];  // 3 rows, 4 columns

for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {  // Should be j < 4
        cout << arr[i][j];
    }
}
```

---

## Performance Consideration

Nested loops can get slow quickly:
- 2 loops: n × m iterations
- 3 loops: n × m × p iterations

**Example:**
```cpp
// 3 nested loops
for (int i = 0; i < 100; i++) {        // 100 iterations
    for (int j = 0; j < 100; j++) {    // 100 iterations
        for (int k = 0; k < 100; k++) { // 100 iterations
            // Total: 100 × 100 × 100 = 1,000,000 iterations!
        }
    }
}
```

**Tip:** Use nested loops when needed, but be aware of performance with large datasets.

---

## Key Takeaways

1. **Conditions in loops** - Check something on each iteration
2. **Nested loops** - Process multi-dimensional data (tables, grids)
3. **Loops in conditions** - Execute repetition only when qualified
4. **Use different variable names** for nested loops (i, j, k)
5. **Watch performance** - Nested loops multiply iteration counts
6. **Indent properly** - Makes nested structures readable

---

## What's Next?

You've mastered basic nesting! Next lesson covers **logical operators and compound conditions** - combining multiple conditions with AND, OR, and NOT operators to create sophisticated decision logic.

**Kuya Miguel:** "You're getting the hang of complex logic, Tian! Next, we'll make your conditions even more powerful."

---

## Closing Story

Tian leaned back, his mind spinning with nested loops and layered conditions. "Kuya, that felt like solving a puzzle inside another puzzle."

"That's exactly what it is," Kuya Miguel replied. "Nested control structures let you handle complex, multi-dimensional problems. That attendance grid? That's how real systems track data across time and people."

Tian nodded, visualizing the patterns. "So I can nest loops inside loops, conditions inside loops, loops inside conditions... it's all about matching the structure to the problem."

"Right! And remember: indent properly so you can see the layers. Next lesson, we'll combine multiple conditions using logical operators. You'll check if someone is a resident AND has paid dues, or if they're a senior citizen OR a PWD. That's where things get really powerful."

Tian grinned, eager to continue. Nested logic was starting to feel natural.

**Reading time:** ~10 minutes
