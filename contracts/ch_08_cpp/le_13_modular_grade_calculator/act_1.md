# Lesson 13 Activities: Modular Grade Calculator

This lesson focuses on **modular programming** - breaking down complex programs into focused, reusable functions. The main grade calculator project is covered in the material file. These challenges apply modular programming principles to new projects.

---

## Challenge 1: Barangay Clearance System

**Objective:** Refactor a clearance system using modular functions.

**Task:**  
Create a barangay clearance system with separate functions for each task:
- `getClearanceInfo()` — input name, age, purpose
- `calculateFee()` — returns fee based on age (senior discount)
- `isEligible()` — checks if age >= 18
- `displayClearance()` — prints clearance details
- `updateStats()` — tracks clearances issued (static)

**Requirements:**
- Senior citizens (>= 60): 50% discount on base fee (PHP 150)
- Minors (< 18): Not eligible for clearance
- Track total clearances issued using static variable
- Display clearance number, name, fee, and purpose

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

const double BASE_FEE = 150.00;

// Function prototypes
void getClearanceInfo(string &name, int &age, string &purpose);
double calculateFee(int age);
bool isEligible(int age);
void displayClearance(string name, int age, string purpose, double fee);
int updateStats();

int main() {
    string name, purpose;
    int age;
    
    // Get clearance info
    // Check eligibility
    // Calculate fee
    // Display clearance
    // Update stats
    
    return 0;
}

// Implement functions here
```

**Expected Output:**
```
=== BARANGAY CLEARANCE SYSTEM ===

Enter name: Juan Dela Cruz
Enter age: 35
Purpose: Employment

=== CLEARANCE CERTIFICATE ===
Clearance #1001
Name: Juan Dela Cruz
Age: 35
Purpose: Employment
Fee: PHP 150.00

Total clearances issued: 1
```

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

const double BASE_FEE = 150.00;
const double SENIOR_DISCOUNT = 0.50;  // 50%

void getClearanceInfo(string &name, int &age, string &purpose) {
    cout << "Enter name: ";
    getline(cin, name);
    
    cout << "Enter age: ";
    cin >> age;
    cin.ignore();
    
    cout << "Purpose: ";
    getline(cin, purpose);
}

double calculateFee(int age) {
    if (age >= 60) {
        return BASE_FEE * (1 - SENIOR_DISCOUNT);
    }
    return BASE_FEE;
}

bool isEligible(int age) {
    return age >= 18;
}

void displayClearance(string name, int age, string purpose, double fee) {
    static int clearanceNumber = 1000;
    clearanceNumber++;
    
    cout << "\n=== CLEARANCE CERTIFICATE ===" << endl;
    cout << "Clearance #" << clearanceNumber << endl;
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    cout << "Purpose: " << purpose << endl;
    cout << fixed << setprecision(2);
    cout << "Fee: PHP " << fee << endl;
}

int updateStats() {
    static int totalClearances = 0;
    totalClearances++;
    return totalClearances;
}

int main() {
    string name, purpose;
    int age;
    
    cout << "=== BARANGAY CLEARANCE SYSTEM ===" << endl;
    cout << endl;
    
    getClearanceInfo(name, age, purpose);
    
    if (!isEligible(age)) {
        cout << "\nError: Must be 18 or older to get clearance!" << endl;
        return 1;
    }
    
    double fee = calculateFee(age);
    displayClearance(name, age, purpose, fee);
    
    int total = updateStats();
    cout << "\nTotal clearances issued: " << total << endl;
    
    return 0;
}
```

</details>

---

## Challenge 2: BMI Calculator (Modular Version)

**Objective:** Create a modular BMI calculator with focused functions.

**Task:**  
Build a BMI calculator using these functions:
- `getHeightWeight()` — input height (m) and weight (kg)
- `calculateBMI()` — returns BMI value
- `classifyBMI()` — returns classification string
- `displayResults()` — shows BMI and classification
- `trackPatients()` — count total patients (static)

**Requirements:**
- BMI = weight / (height * height)
- Classifications:
  - Underweight: BMI < 18.5
  - Normal: 18.5 <= BMI < 25
  - Overweight: 25 <= BMI < 30
  - Obese: BMI >= 30
- Track total number of patients processed

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

// Function prototypes
void getHeightWeight(double &height, double &weight);
double calculateBMI(double height, double weight);
string classifyBMI(double bmi);
void displayResults(string name, double bmi, string classification);
int trackPatients();

int main() {
    string name;
    double height, weight;
    
    // Implement logic here
    
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

void getHeightWeight(double &height, double &weight) {
    cout << "Enter height (in meters): ";
    cin >> height;
    cout << "Enter weight (in kg): ";
    cin >> weight;
}

double calculateBMI(double height, double weight) {
    return weight / (height * height);
}

string classifyBMI(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25.0) return "Normal";
    if (bmi < 30.0) return "Overweight";
    return "Obese";
}

void displayResults(string name, double bmi, string classification) {
    cout << "\n=== BMI RESULTS ===" << endl;
    cout << "Patient: " << name << endl;
    cout << fixed << setprecision(2);
    cout << "BMI: " << bmi << endl;
    cout << "Classification: " << classification << endl;
    
    // Health recommendations
    if (classification == "Normal") {
        cout << "Recommendation: Maintain your healthy lifestyle!" << endl;
    } else if (classification == "Underweight") {
        cout << "Recommendation: Increase calorie intake." << endl;
    } else {
        cout << "Recommendation: Consult a doctor and increase physical activity." << endl;
    }
}

int trackPatients() {
    static int patientCount = 0;
    patientCount++;
    return patientCount;
}

int main() {
    string name;
    double height, weight;
    
    cout << "=== BMI CALCULATOR ===" << endl;
    cout << "Enter patient name: ";
    getline(cin, name);
    
    getHeightWeight(height, weight);
    
    double bmi = calculateBMI(height, weight);
    string classification = classifyBMI(bmi);
    
    displayResults(name, bmi, classification);
    
    int totalPatients = trackPatients();
    cout << "\nTotal patients processed: " << totalPatients << endl;
    
    return 0;
}
```

</details>

---

## Challenge 3: Voting Eligibility Tracker

**Objective:** Build a modular voting eligibility system.

**Task:**  
Create a voter registration system with these functions:
- `getVoterInfo()` — input name, age, citizenship
- `isEligible()` — checks age >= 18 and citizenship == "Filipino"
- `displayEligibility()` — shows registration result
- `updateVoterStats()` — tracks eligible vs ineligible voters (static)

**Requirements:**
- Must be 18+ years old
- Must be Filipino citizen
- Display eligibility status with reason if not eligible
- Track statistics: total eligible, total ineligible

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

// Function prototypes
void getVoterInfo(string &name, int &age, string &citizenship);
bool isEligible(int age, string citizenship, string &reason);
void displayEligibility(string name, bool eligible, string reason);
void updateVoterStats(bool eligible);

int main() {
    // Implement voter registration logic
    
    return 0;
}
```

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
using namespace std;

void getVoterInfo(string &name, int &age, string &citizenship) {
    cout << "Enter full name: ";
    getline(cin, name);
    
    cout << "Enter age: ";
    cin >> age;
    cin.ignore();
    
    cout << "Enter citizenship: ";
    getline(cin, citizenship);
}

bool isEligible(int age, string citizenship, string &reason) {
    if (age < 18) {
        reason = "Must be 18 years or older";
        return false;
    }
    
    if (citizenship != "Filipino" && citizenship != "filipino") {
        reason = "Must be a Filipino citizen";
        return false;
    }
    
    reason = "All requirements met";
    return true;
}

void displayEligibility(string name, bool eligible, string reason) {
    cout << "\n=== VOTER REGISTRATION RESULT ===" << endl;
    cout << "Name: " << name << endl;
    
    if (eligible) {
        cout << "Status: ELIGIBLE TO VOTE ✓" << endl;
        cout << "Reason: " << reason << endl;
        cout << "You may proceed with voter registration." << endl;
    } else {
        cout << "Status: NOT ELIGIBLE ✗" << endl;
        cout << "Reason: " << reason << endl;
    }
}

void updateVoterStats(bool eligible) {
    static int eligibleCount = 0;
    static int ineligibleCount = 0;
    
    if (eligible) {
        eligibleCount++;
    } else {
        ineligibleCount++;
    }
    
    cout << "\n=== STATISTICS ===" << endl;
    cout << "Eligible voters: " << eligibleCount << endl;
    cout << "Ineligible applicants: " << ineligibleCount << endl;
    cout << "Total processed: " << (eligibleCount + ineligibleCount) << endl;
}

int main() {
    string name, citizenship, reason;
    int age;
    
    cout << "=== VOTER ELIGIBILITY CHECKER ===" << endl;
    cout << endl;
    
    getVoterInfo(name, age, citizenship);
    
    bool eligible = isEligible(age, citizenship, reason);
    
    displayEligibility(name, eligible, reason);
    
    updateVoterStats(eligible);
    
    return 0;
}
```

</details>

---

## Integration Challenge: Complete Modular System

**Objective:** Apply all modular programming principles to create a comprehensive barangay services system.

**Task:**  
Create a menu-driven system that offers:
1. Barangay Clearance
2. BMI Health Check
3. Voter Registration
4. View Statistics
5. Exit

Use all the functions from Challenges 1-3, organized into a single cohesive program with a main menu.

**This demonstrates real-world modular programming:**
- Each service has its own set of focused functions
- Shared functions (like statistics) are reused
- Main menu coordinates all services
- Easy to maintain and extend

---

## Reflection Questions

After completing these challenges:

1. **What makes a function "modular"?**
   - Does one thing well
   - Has a clear, focused purpose
   - Can be reused in different contexts
   - Has minimal dependencies

2. **Why is modular programming important?**
   - Easier to understand and maintain
   - Simplifies debugging (isolate problems)
   - Enables code reuse
   - Team members can work on different functions

3. **How do you decide what should be a separate function?**
   - If code is repeated, make it a function
   - If a task has a clear purpose, make it a function
   - If a section is complex, extract it to a function
   - Follow the "Single Responsibility Principle"

4. **What's the benefit of static variables in tracking functions?**
   - Maintain state across function calls
   - Don't need global variables
   - Encapsulate counter/tracker within function

---

## Key Takeaways

- **Modular programming** breaks complex programs into focused functions
- Each function should have a **single responsibility**
- Use **function prototypes** for organization
- **Parameters** pass data in, **return values** pass results out
- **Static variables** maintain state between calls
- Modular code is easier to **test, debug, and maintain**

**Next Lesson:**  
You'll learn about **arrays** - storing collections of data to process multiple values efficiently!
