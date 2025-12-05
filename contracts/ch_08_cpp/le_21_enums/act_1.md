# Lesson 21 Activities: Enums

## The Magic Number Nightmare

Bug report: **"Clearance type 4 crashes the system."** Tian found the code: `if (clearanceType == 1)` scattered everywhere. What does `1` mean? Business? Travel? Six months from now, will anyone remember?

**Magic numbers are a code smell.** Using `0, 1, 2, 3` for types is cryptic and error-prone. Someone can pass `99` or `-5` and the program has no idea what to do.

**Enums save the day!** Define meaningful names: `RESIDENCE, BUSINESS, TRAVEL`. Code becomes self-documenting. Instead of `if (clearanceType == 1)`, write `if (clearanceType == BUSINESS)`. Instantly readable. Plus, type safety—you can't accidentally pass a random integer!

---

## Task 1: Basic Enum Declaration

**Context:** Replace magic numbers with readable enum names.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

enum ClearanceType {
    RESIDENCE,   // 0
    BUSINESS,    // 1
    TRAVEL,      // 2
    EMPLOYMENT   // 3
};

int main() {
    ClearanceType type = RESIDENCE;
    
    if (type == RESIDENCE) {
        cout << "Residence clearance selected" << endl;
    }
    
    cout << "Type value: " << type << endl;  // Prints: 0
    
    return 0;
}
```

# Tasks for Learners

- Create an enum for barangay positions: CAPTAIN, KAGAWAD, SK_CHAIR, SECRETARY, TREASURER.

  ```cpp
  #include <iostream>
  using namespace std;

  enum BarangayPosition {
      CAPTAIN,
      KAGAWAD,
      SK_CHAIR,
      SECRETARY,
      TREASURER
  };

  int main() {
      BarangayPosition position = CAPTAIN;
      
      if (position == CAPTAIN) {
          cout << "Barangay Captain" << endl;
      }
      
      cout << "Position value: " << position << endl;  // Prints: 0
      
      position = KAGAWAD;
      cout << "Position value: " << position << endl;  // Prints: 1
      
      position = TREASURER;
      cout << "Position value: " << position << endl;  // Prints: 4
      
      return 0;
  }
  ```

---

## Task 2: Enums with Custom Values

**Context:** Assign specific values for fees or codes.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

enum ClearanceFee {
    RESIDENCE = 50,
    BUSINESS = 100,
    TRAVEL = 150,
    EMPLOYMENT = 75
};

int main() {
    ClearanceFee fee = BUSINESS;
    
    cout << "Business clearance fee: P" << fee << endl;  // P100
    
    double total = RESIDENCE + TRAVEL;  // 50 + 150
    cout << "Total for two clearances: P" << total << endl;
    
    return 0;
}
```

# Tasks for Learners

- Use the enum with custom values to calculate fees for different clearance types.

  ```cpp
  #include <iostream>
  using namespace std;

  enum ClearanceFee {
      RESIDENCE = 50,
      BUSINESS = 100,
      TRAVEL = 150,
      EMPLOYMENT = 75
  };

  int main() {
      ClearanceFee fee = BUSINESS;
      
      cout << "Business clearance fee: P" << fee << endl;  // P100
      
      double total = RESIDENCE + TRAVEL;  // 50 + 150
      cout << "Total for two clearances: P" << total << endl;  // P200
      
      // Calculate multiple fees
      double allFees = RESIDENCE + BUSINESS + TRAVEL + EMPLOYMENT;
      cout << "Total of all clearance types: P" << allFees << endl;  // P375
      
      // Apply discount
      double seniorDiscount = 0.20;
      double discountedBusiness = BUSINESS * (1 - seniorDiscount);
      cout << "Business clearance with senior discount: P" << discountedBusiness << endl;  // P80
      
      return 0;
  }
  ```

---

## Task 3: Switch Statements with Enums

**Context:** Enums work perfectly with switch statements.

**Challenge:** Display clearance information based on type.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

enum ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL,
    EMPLOYMENT
};

void displayClearanceInfo(ClearanceType type) {
    switch (type) {
        case RESIDENCE:
            cout << "Residence Clearance - P50" << endl;
            cout << "Required: Valid ID" << endl;
            break;
        case BUSINESS:
            cout << "Business Clearance - P100" << endl;
            cout << "Required: Business Permit" << endl;
            break;
        case TRAVEL:
            cout << "Travel Clearance - P150" << endl;
            cout << "Required: Valid ID + Destination" << endl;
            break;
        case EMPLOYMENT:
            cout << "Employment Clearance - P75" << endl;
            cout << "Required: Valid ID + Employment Letter" << endl;
            break;
        default:
            cout << "Unknown clearance type" << endl;
    }
}

int main() {
    displayClearanceInfo(RESIDENCE);
    cout << endl;
    displayClearanceInfo(BUSINESS);
    cout << endl;
    displayClearanceInfo(TRAVEL);
    
    return 0;
}
```

# Tasks for Learners

- Display clearance information for all clearance types using switch statements.

  ```cpp
  #include <iostream>
  using namespace std;

  enum ClearanceType {
      RESIDENCE,
      BUSINESS,
      TRAVEL,
      EMPLOYMENT
  };

  void displayClearanceInfo(ClearanceType type) {
      switch (type) {
          case RESIDENCE:
              cout << "Residence Clearance - P50" << endl;
              cout << "Required: Valid ID" << endl;
              break;
          case BUSINESS:
              cout << "Business Clearance - P100" << endl;
              cout << "Required: Business Permit" << endl;
              break;
          case TRAVEL:
              cout << "Travel Clearance - P150" << endl;
              cout << "Required: Valid ID + Destination" << endl;
              break;
          case EMPLOYMENT:
              cout << "Employment Clearance - P75" << endl;
              cout << "Required: Valid ID + Employment Letter" << endl;
              break;
          default:
              cout << "Unknown clearance type" << endl;
      }
  }

  int main() {
      cout << "=== CLEARANCE INFORMATION ==="  << endl << endl;
      
      displayClearanceInfo(RESIDENCE);
      cout << endl;
      displayClearanceInfo(BUSINESS);
      cout << endl;
      displayClearanceInfo(TRAVEL);
      cout << endl;
      displayClearanceInfo(EMPLOYMENT);
      
      return 0;
  }
  ```

---

## Task 4: Enums with Structs

**Context:** Combine enums with structs for organized data.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

enum ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL,
    EMPLOYMENT
};

struct Clearance {
    int id;
    string residentName;
    ClearanceType type;
    double fee;
    string date;
};

string typeToString(ClearanceType type) {
    switch (type) {
        case RESIDENCE: return "Residence";
        case BUSINESS: return "Business";
        case TRAVEL: return "Travel";
        case EMPLOYMENT: return "Employment";
        default: return "Unknown";
    }
}

int main() {
    Clearance c1 = {1001, "Juan Dela Cruz", RESIDENCE, 50.0, "2024-12-04"};
    Clearance c2 = {1002, "Maria Santos", BUSINESS, 100.0, "2024-12-04"};
    
    cout << "Clearance #" << c1.id << endl;
    cout << "Name: " << c1.residentName << endl;
    cout << "Type: " << typeToString(c1.type) << endl;
    cout << "Fee: P" << c1.fee << endl;
    cout << endl;
    
    cout << "Clearance #" << c2.id << endl;
    cout << "Name: " << c2.residentName << endl;
    cout << "Type: " << typeToString(c2.type) << endl;
    cout << "Fee: P" << c2.fee << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create multiple clearances using enums with structs and display them with a helper function.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  enum ClearanceType {
      RESIDENCE,
      BUSINESS,
      TRAVEL,
      EMPLOYMENT
  };

  struct Clearance {
      int id;
      string residentName;
      ClearanceType type;
      double fee;
      string date;
  };

  string typeToString(ClearanceType type) {
      switch (type) {
          case RESIDENCE: return "Residence";
          case BUSINESS: return "Business";
          case TRAVEL: return "Travel";
          case EMPLOYMENT: return "Employment";
          default: return "Unknown";
      }
  }

  void displayClearance(const Clearance& c) {
      cout << "Clearance #" << c.id << endl;
      cout << "Name: " << c.residentName << endl;
      cout << "Type: " << typeToString(c.type) << endl;
      cout << "Fee: P" << c.fee << endl;
      cout << "Date: " << c.date << endl;
      cout << endl;
  }

  int main() {
      Clearance clearances[4] = {
          {1001, "Juan Dela Cruz", RESIDENCE, 50.0, "2024-12-04"},
          {1002, "Maria Santos", BUSINESS, 100.0, "2024-12-04"},
          {1003, "Pedro Garcia", TRAVEL, 150.0, "2024-12-05"},
          {1004, "Ana Reyes", EMPLOYMENT, 75.0, "2024-12-05"}
      };
      
      cout << "=== BARANGAY CLEARANCES ===" << endl << endl;
      
      for (int i = 0; i < 4; i++) {
          displayClearance(clearances[i]);
      }
      
      // Calculate total fees
      double totalFees = 0;
      for (int i = 0; i < 4; i++) {
          totalFees += clearances[i].fee;
      }
      cout << "Total Fees Collected: P" << totalFees << endl;
      
      return 0;
  }
  ```

---

## Task 5: Payment Status System

**Context:** Use enums for tracking payment states.

**Challenge:** Build payment tracker with status transitions.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

enum PaymentStatus {
    PENDING,
    PROCESSING,
    PAID,
    OVERDUE,
    CANCELLED
};

struct Payment {
    int id;
    string residentName;
    double amount;
    PaymentStatus status;
};

string statusToString(PaymentStatus status) {
    switch (status) {
        case PENDING: return "Pending";
        case PROCESSING: return "Processing";
        case PAID: return "Paid";
        case OVERDUE: return "Overdue";
        case CANCELLED: return "Cancelled";
        default: return "Unknown";
    }
}

void displayPayment(const Payment& p) {
    cout << "Payment #" << p.id << " - " << p.residentName << endl;
    cout << "Amount: P" << p.amount << endl;
    cout << "Status: " << statusToString(p.status) << endl;
    cout << endl;
}

int main() {
    Payment payments[5] = {
        {101, "Juan Dela Cruz", 500.0, PAID},
        {102, "Maria Santos", 300.0, PENDING},
        {103, "Pedro Garcia", 450.0, PROCESSING},
        {104, "Ana Reyes", 200.0, OVERDUE},
        {105, "Jose Mendoza", 350.0, CANCELLED}
    };
    
    cout << "=== PAYMENT TRACKER ===" << endl;
    for (int i = 0; i < 5; i++) {
        displayPayment(payments[i]);
    }
    
    // Count by status
    int pendingCount = 0, paidCount = 0, overdueCount = 0;
    for (int i = 0; i < 5; i++) {
        if (payments[i].status == PENDING) pendingCount++;
        if (payments[i].status == PAID) paidCount++;
        if (payments[i].status == OVERDUE) overdueCount++;
    }
    
    cout << "Summary:" << endl;
    cout << "Paid: " << paidCount << endl;
    cout << "Pending: " << pendingCount << endl;
    cout << "Overdue: " << overdueCount << endl;
    
    return 0;
}
```

# Tasks for Learners

- Build a payment tracker with status transitions and summary statistics.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  enum PaymentStatus {
      PENDING,
      PROCESSING,
      PAID,
      OVERDUE,
      CANCELLED
  };

  struct Payment {
      int id;
      string residentName;
      double amount;
      PaymentStatus status;
  };

  string statusToString(PaymentStatus status) {
      switch (status) {
          case PENDING: return "Pending";
          case PROCESSING: return "Processing";
          case PAID: return "Paid";
          case OVERDUE: return "Overdue";
          case CANCELLED: return "Cancelled";
          default: return "Unknown";
      }
  }

  void displayPayment(const Payment& p) {
      cout << "Payment #" << p.id << " - " << p.residentName << endl;
      cout << "Amount: P" << p.amount << endl;
      cout << "Status: " << statusToString(p.status) << endl;
      cout << endl;
  }

  int main() {
      Payment payments[5] = {
          {101, "Juan Dela Cruz", 500.0, PAID},
          {102, "Maria Santos", 300.0, PENDING},
          {103, "Pedro Garcia", 450.0, PROCESSING},
          {104, "Ana Reyes", 200.0, OVERDUE},
          {105, "Jose Mendoza", 350.0, CANCELLED}
      };
      
      cout << "=== PAYMENT TRACKER ===" << endl << endl;
      for (int i = 0; i < 5; i++) {
          displayPayment(payments[i]);
      }
      
      // Count by status
      int pendingCount = 0, paidCount = 0, overdueCount = 0, processingCount = 0, cancelledCount = 0;
      double totalPaid = 0, totalPending = 0, totalOverdue = 0;
      
      for (int i = 0; i < 5; i++) {
          switch (payments[i].status) {
              case PENDING:
                  pendingCount++;
                  totalPending += payments[i].amount;
                  break;
              case PROCESSING:
                  processingCount++;
                  break;
              case PAID:
                  paidCount++;
                  totalPaid += payments[i].amount;
                  break;
              case OVERDUE:
                  overdueCount++;
                  totalOverdue += payments[i].amount;
                  break;
              case CANCELLED:
                  cancelledCount++;
                  break;
          }
      }
      
      cout << "=== SUMMARY ===" << endl;
      cout << "Paid: " << paidCount << " (P" << totalPaid << ")" << endl;
      cout << "Pending: " << pendingCount << " (P" << totalPending << ")" << endl;
      cout << "Processing: " << processingCount << endl;
      cout << "Overdue: " << overdueCount << " (P" << totalOverdue << ")" << endl;
      cout << "Cancelled: " << cancelledCount << endl;
      
      return 0;
  }
  ```

---

## Task 6: Complaint Priority System

**Context:** Use enums for priority levels and categories.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

enum Priority {
    LOW = 1,
    MEDIUM = 2,
    HIGH = 3,
    URGENT = 4
};

enum Category {
    NOISE,
    SANITATION,
    INFRASTRUCTURE,
    SECURITY,
    OTHER
};

struct Complaint {
    int id;
    string description;
    Category category;
    Priority priority;
    bool resolved;
};

string categoryToString(Category cat) {
    switch (cat) {
        case NOISE: return "Noise";
        case SANITATION: return "Sanitation";
        case INFRASTRUCTURE: return "Infrastructure";
        case SECURITY: return "Security";
        case OTHER: return "Other";
        default: return "Unknown";
    }
}

string priorityToString(Priority pri) {
    switch (pri) {
        case LOW: return "Low";
        case MEDIUM: return "Medium";
        case HIGH: return "High";
        case URGENT: return "Urgent";
        default: return "Unknown";
    }
}

void displayComplaint(const Complaint& c) {
    cout << "Complaint #" << c.id << endl;
    cout << "Description: " << c.description << endl;
    cout << "Category: " << categoryToString(c.category) << endl;
    cout << "Priority: " << priorityToString(c.priority) << endl;
    cout << "Status: " << (c.resolved ? "Resolved" : "Open") << endl;
    cout << endl;
}

int main() {
    Complaint complaints[5] = {
        {1, "Loud music at night", NOISE, HIGH, false},
        {2, "Garbage not collected", SANITATION, MEDIUM, false},
        {3, "Broken streetlight", INFRASTRUCTURE, LOW, false},
        {4, "Suspicious activity", SECURITY, URGENT, false},
        {5, "Document request", OTHER, LOW, true}
    };
    
    cout << "=== BARANGAY COMPLAINTS ===" << endl;
    for (int i = 0; i < 5; i++) {
        displayComplaint(complaints[i]);
    }
    
    // Filter urgent complaints
    cout << "=== URGENT COMPLAINTS ===" << endl;
    for (int i = 0; i < 5; i++) {
        if (complaints[i].priority == URGENT && !complaints[i].resolved) {
            displayComplaint(complaints[i]);
        }
    }
    
    return 0;
}
```

# Tasks for Learners

- Create a complaint priority system with filtering and categorization.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  enum Priority {
      LOW = 1,
      MEDIUM = 2,
      HIGH = 3,
      URGENT = 4
  };

  enum Category {
      NOISE,
      SANITATION,
      INFRASTRUCTURE,
      SECURITY,
      OTHER
  };

  struct Complaint {
      int id;
      string description;
      Category category;
      Priority priority;
      bool resolved;
  };

  string categoryToString(Category cat) {
      switch (cat) {
          case NOISE: return "Noise";
          case SANITATION: return "Sanitation";
          case INFRASTRUCTURE: return "Infrastructure";
          case SECURITY: return "Security";
          case OTHER: return "Other";
          default: return "Unknown";
      }
  }

  string priorityToString(Priority pri) {
      switch (pri) {
          case LOW: return "Low";
          case MEDIUM: return "Medium";
          case HIGH: return "High";
          case URGENT: return "Urgent";
          default: return "Unknown";
      }
  }

  void displayComplaint(const Complaint& c) {
      cout << "Complaint #" << c.id << endl;
      cout << "Description: " << c.description << endl;
      cout << "Category: " << categoryToString(c.category) << endl;
      cout << "Priority: " << priorityToString(c.priority) << endl;
      cout << "Status: " << (c.resolved ? "Resolved" : "Open") << endl;
      cout << endl;
  }

  int main() {
      Complaint complaints[5] = {
          {1, "Loud music at night", NOISE, HIGH, false},
          {2, "Garbage not collected", SANITATION, MEDIUM, false},
          {3, "Broken streetlight", INFRASTRUCTURE, LOW, false},
          {4, "Suspicious activity", SECURITY, URGENT, false},
          {5, "Document request", OTHER, LOW, true}
      };
      
      cout << "=== BARANGAY COMPLAINTS ===" << endl << endl;
      for (int i = 0; i < 5; i++) {
          displayComplaint(complaints[i]);
      }
      
      // Filter urgent complaints
      cout << "\n=== URGENT COMPLAINTS ===" << endl;
      bool hasUrgent = false;
      for (int i = 0; i < 5; i++) {
          if (complaints[i].priority == URGENT && !complaints[i].resolved) {
              displayComplaint(complaints[i]);
              hasUrgent = true;
          }
      }
      if (!hasUrgent) {
          cout << "No urgent complaints." << endl << endl;
      }
      
      // Statistics by category
      cout << "\n=== COMPLAINTS BY CATEGORY ===" << endl;
      int noiseCnt = 0, sanitationCnt = 0, infraCnt = 0, securityCnt = 0, otherCnt = 0;
      for (int i = 0; i < 5; i++) {
          switch (complaints[i].category) {
              case NOISE: noiseCnt++; break;
              case SANITATION: sanitationCnt++; break;
              case INFRASTRUCTURE: infraCnt++; break;
              case SECURITY: securityCnt++; break;
              case OTHER: otherCnt++; break;
          }
      }
      cout << "Noise: " << noiseCnt << endl;
      cout << "Sanitation: " << sanitationCnt << endl;
      cout << "Infrastructure: " << infraCnt << endl;
      cout << "Security: " << securityCnt << endl;
      cout << "Other: " << otherCnt << endl;
      
      // Resolution status
      int openCount = 0, resolvedCount = 0;
      for (int i = 0; i < 5; i++) {
          if (complaints[i].resolved) resolvedCount++;
          else openCount++;
      }
      cout << "\n=== STATUS ===" << endl;
      cout << "Open: " << openCount << endl;
      cout << "Resolved: " << resolvedCount << endl;
      
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Enum Essentials</strong></summary>

**Basic Syntax:**
```cpp
enum EnumName {
    VALUE1,    // 0
    VALUE2,    // 1
    VALUE3     // 2
};
```

**Custom Values:**
```cpp
enum Status {
    PENDING = 0,
    APPROVED = 1,
    REJECTED = -1
};
```

**Usage:**
```cpp
Status s = PENDING;
if (s == APPROVED) {
    // Do something
}
```

**Benefits:**
1. **Readability:** `status == APPROVED` vs `status == 1`
2. **Type Safety:** Can't accidentally pass wrong integer
3. **Self-Documenting:** Code explains itself
4. **Maintainability:** Change enum value in one place

**Best Practices:**
- Use UPPERCASE for enum values
- Group related constants
- Use with switch statements
- Create helper functions (toString)
- Combine with structs for organized data

**Common Use Cases:**
- States (PENDING, ACTIVE, INACTIVE)
- Types (STUDENT, TEACHER, ADMIN)
- Priority levels (LOW, MEDIUM, HIGH)
- Directions (NORTH, SOUTH, EAST, WEST)
- Days of week, months, etc.

</details>

---

**Remember:** Enums turn cryptic numbers into meaningful names. Every professional codebase uses them!
