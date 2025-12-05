# Lesson 8 Activities: Logical Operators

## Fixing the Broken Clearance System

Remember Tian's clearance bug? It approved everyone who met ANY requirement instead of ALL requirements. **Logical operators** fix this: `&&` (AND), `||` (OR), `!` (NOT) combine conditions into intelligent decision logic.

**This lesson is about compound logic.** Real security doesn't check one thing—it checks multiple criteria together. Airport security needs ticket AND passport AND screening. Bank withdrawals need correct PIN AND sufficient balance. Today, your programs make complex multi-condition decisions!

---

## Task 1: Voter Eligibility (AND Operator)

**Context:**  
To vote in barangay elections, residents must be 18+ AND registered. Both must be true.

**Your Challenge:**  
Use `&&` operator to check BOTH conditions.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isRegistered;
    
    cout << "=== VOTER ELIGIBILITY CHECKER ===" << endl;
    cout << "Age: ";
    cin >> age;
    cout << "Registered? (1=Yes, 0=No): ";
    cin >> isRegistered;
    
    // Check if age >= 18 AND isRegistered
    
    return 0;
}
```

# Tasks for Learners

- Check voter eligibility with AND operator: Both conditions must be true.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int age;
      bool isRegistered;
      
      cout << "=== VOTER ELIGIBILITY CHECKER ===" << endl;
      cout << "Age: ";
      cin >> age;
      cout << "Registered? (1=Yes, 0=No): ";
      cin >> isRegistered;
      
      if (age >= 18 && isRegistered) {
          cout << "✓ Eligible to vote!" << endl;
      } else {
          cout << "✗ Not eligible." << endl;
      }
      
      return 0;
  }
  ```

---

## Task 2: Senior/PWD Discount (OR Operator)

**Context:**  
Barangay services offer discounts to senior citizens (60+) OR PWD. Either qualifies.

**Your Challenge:**  
Use `||` operator where at least ONE condition grants discount.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isPWD;
    
    cout << "Age: ";
    cin >> age;
    cout << "PWD? (1/0): ";
    cin >> isPWD;
    
    // Check if age >= 60 OR isPWD
    
    return 0;
}
```

# Tasks for Learners

- Apply discount with OR operator: Either condition qualifies for discount.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int age;
      bool isPWD;
      
      cout << "Age: ";
      cin >> age;
      cout << "PWD? (1/0): ";
      cin >> isPWD;
      
      if (age >= 60 || isPWD) {
          cout << "✓ 20% discount applies!" << endl;
      } else {
          cout << "No discount." << endl;
      }
      
      return 0;
  }
  ```

---

## Task 3: Access Control (NOT Operator)

**Context:**  
Deny entry if person is NOT a resident.

**Your Challenge:**  
Use `!` operator to reverse boolean condition.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    bool isResident;
    
    cout << "Resident? (1/0): ";
    cin >> isResident;
    
    // If !isResident, deny access
    
    return 0;
}
```

# Tasks for Learners

- Deny access with NOT operator: Reverse boolean condition.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      bool isResident;
      
      cout << "Resident? (1/0): ";
      cin >> isResident;
      
      if (!isResident) {
          cout << "✗ Access DENIED!" << endl;
      } else {
          cout << "✓ Welcome!" << endl;
      }
      
      return 0;
  }
  ```

---

## Task 4: Clearance Approval (Multiple AND)

**Context:**  
Barangay clearance requires valid ID AND paid dues AND no violations. All three must be true.

**Your Challenge:**  
Chain multiple `&&` operators.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    bool hasID, paidDues, noViolations;
    
    cout << "=== CLEARANCE CHECKER ===" << endl;
    cout << "Valid ID? (1/0): ";
    cin >> hasID;
    cout << "Paid dues? (1/0): ";
    cin >> paidDues;
    cout << "No violations? (1/0): ";
    cin >> noViolations;
    
    // Check all three conditions
    
    return 0;
}
```

# Tasks for Learners

- Approve clearance with multiple AND operators: All three conditions must be true.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      bool hasID, paidDues, noViolations;
      
      cout << "=== CLEARANCE CHECKER ===" << endl;
      cout << "Valid ID? (1/0): ";
      cin >> hasID;
      cout << "Paid dues? (1/0): ";
      cin >> paidDues;
      cout << "No violations? (1/0): ";
      cin >> noViolations;
      
      if (hasID && paidDues && noViolations) {
          cout << "✓ CLEARANCE APPROVED!" << endl;
      } else {
          cout << "✗ DENIED!" << endl;
      }
      
      return 0;
  }
  ```

---

## Task 5: Scholarship Eligibility (Complex Logic)

**Context:**  
Scholarship requires GPA ≥ 85 AND (resident OR financial need). Mix AND/OR operators.

**Your Challenge:**  
Use parentheses to group conditions: `(A || B) && C`

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double gpa;
    bool isResident, hasNeed;
    
    cout << "GPA: ";
    cin >> gpa;
    cout << "Resident? (1/0): ";
    cin >> isResident;
    cout << "Financial need? (1/0): ";
    cin >> hasNeed;
    
    // Check: gpa >= 85 AND (isResident OR hasNeed)
    
    return 0;
}
```

# Tasks for Learners

- Check scholarship eligibility with complex logic: Mix AND/OR operators with parentheses.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      double gpa;
      bool isResident, hasNeed;
      
      cout << "GPA: ";
      cin >> gpa;
      cout << "Resident? (1/0): ";
      cin >> isResident;
      cout << "Financial need? (1/0): ";
      cin >> hasNeed;
      
      if (gpa >= 85 && (isResident || hasNeed)) {
          cout << "✓ SCHOLARSHIP APPROVED!" << endl;
      } else {
          cout << "✗ Not eligible." << endl;
      }
      
      return 0;
  }
  ```


