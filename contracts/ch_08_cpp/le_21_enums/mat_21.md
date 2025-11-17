# Lesson 21: Enums - Giving Names to Numbers

**Estimated Reading Time:** 10 minutes

---

## The Story

"Kuya, I have clearance types: 1 for Residence, 2 for Business, 3 for Travel. But the numbers are confusing!"

"Use **enums**!" Kuya Miguel said. "Give meaningful names to numbers. Instead of `1`, say `RESIDENCE`. Much clearer!"

---

## What Are Enums?

**Enums (enumerations)** create named constants:

```cpp
enum ClearanceType {
    RESIDENCE,   // 0
    BUSINESS,    // 1
    TRAVEL,      // 2
    EMPLOYMENT   // 3
};

// Use names instead of numbers
ClearanceType type = RESIDENCE;

if (type == RESIDENCE) {
    cout << "Residence clearance";
}
```

---

## Basic Enum Syntax

```cpp
enum Color {
    RED,     // 0
    GREEN,   // 1
    BLUE     // 2
};

Color c = RED;
cout << c;  // Prints: 0
```

**By default**, enums start at 0 and increment by 1.

---

## Custom Values

```cpp
enum ClearanceFee {
    RESIDENCE = 50,
    BUSINESS = 100,
    TRAVEL = 150,
    EMPLOYMENT = 75
};

ClearanceFee fee = BUSINESS;
cout << "Fee: P" << fee;  // Fee: P100
```

---

## Enum with Structs

```cpp
enum ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL
};

struct Clearance {
    int id;
    string residentName;
    ClearanceType type;
    double fee;
    string date;
};

int main() {
    Clearance c1;
    c1.id = 1001;
    c1.residentName = "Juan Dela Cruz";
    c1.type = RESIDENCE;  // Clear and readable!
    c1.fee = 50.0;
    c1.date = "2024-11-17";
    
    if (c1.type == RESIDENCE) {
        cout << "Residence clearance for " << c1.residentName << endl;
    }
    
    return 0;
}
```

---

## Switch Statement with Enums

```cpp
enum ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL,
    EMPLOYMENT
};

void displayClearanceInfo(ClearanceType type) {
    switch (type) {
        case RESIDENCE:
            cout << "Residence Clearance - P50\n";
            cout << "Required: Valid ID\n";
            break;
        case BUSINESS:
            cout << "Business Clearance - P100\n";
            cout << "Required: Business Permit\n";
            break;
        case TRAVEL:
            cout << "Travel Clearance - P150\n";
            cout << "Required: Valid ID + Destination\n";
            break;
        case EMPLOYMENT:
            cout << "Employment Clearance - P75\n";
            cout << "Required: Valid ID + Employment Letter\n";
            break;
        default:
            cout << "Unknown clearance type\n";
    }
}

int main() {
    displayClearanceInfo(RESIDENCE);
    displayClearanceInfo(BUSINESS);
    return 0;
}
```

---

## Calculating Fees with Enums

```cpp
enum ClearanceFee {
    RESIDENCE_FEE = 50,
    BUSINESS_FEE = 100,
    TRAVEL_FEE = 150,
    EMPLOYMENT_FEE = 75
};

double calculateTotalFees(int residenceCount, int businessCount, int travelCount) {
    double total = 0;
    total += residenceCount * RESIDENCE_FEE;
    total += businessCount * BUSINESS_FEE;
    total += travelCount * TRAVEL_FEE;
    return total;
}

int main() {
    double total = calculateTotalFees(5, 3, 2);  // 5 residence, 3 business, 2 travel
    cout << "Total: P" << total << endl;
    // Total: P(5*50 + 3*100 + 2*150) = P250 + P300 + P300 = P850
    return 0;
}
```

---

## Enum Class (C++11)

**Problem with old enums:** They pollute the namespace.

```cpp
enum Color { RED, GREEN, BLUE };
enum TrafficLight { RED, YELLOW, GREEN };  // ❌ Error! RED already defined
```

**Solution:** Use `enum class`:

```cpp
enum class Color {
    RED,
    GREEN,
    BLUE
};

enum class TrafficLight {
    RED,      // ✓ OK! Separate namespace
    YELLOW,
    GREEN
};

int main() {
    Color c = Color::RED;            // Must use Color::
    TrafficLight t = TrafficLight::RED;  // Must use TrafficLight::
    
    // if (c == t)  // ❌ Error! Different types
    
    if (c == Color::RED) {
        cout << "Color is red\n";
    }
    
    return 0;
}
```

---

## Enum Class Best Practices

```cpp
enum class ClearanceType {
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
};

void displayType(ClearanceType type) {
    switch (type) {
        case ClearanceType::RESIDENCE:
            cout << "Residence Clearance\n";
            break;
        case ClearanceType::BUSINESS:
            cout << "Business Clearance\n";
            break;
        case ClearanceType::TRAVEL:
            cout << "Travel Clearance\n";
            break;
        case ClearanceType::EMPLOYMENT:
            cout << "Employment Clearance\n";
            break;
    }
}

int main() {
    Clearance c;
    c.type = ClearanceType::RESIDENCE;
    displayType(c.type);
    return 0;
}
```

---

## Converting Enum to String

```cpp
enum class ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL,
    EMPLOYMENT
};

string typeToString(ClearanceType type) {
    switch (type) {
        case ClearanceType::RESIDENCE:
            return "Residence";
        case ClearanceType::BUSINESS:
            return "Business";
        case ClearanceType::TRAVEL:
            return "Travel";
        case ClearanceType::EMPLOYMENT:
            return "Employment";
        default:
            return "Unknown";
    }
}

int main() {
    ClearanceType type = ClearanceType::BUSINESS;
    cout << "Type: " << typeToString(type) << endl;  // Type: Business
    return 0;
}
```

---

## Practical Example: Barangay Dues System

```cpp
#include <iostream>
#include <string>
using namespace std;

enum class PaymentStatus {
    PAID,
    PENDING,
    OVERDUE
};

enum class DuesType {
    MONTHLY = 50,
    QUARTERLY = 140,
    ANNUAL = 500
};

struct DuesRecord {
    int residentId;
    string name;
    DuesType type;
    PaymentStatus status;
    string dueDate;
};

string statusToString(PaymentStatus status) {
    switch (status) {
        case PaymentStatus::PAID:
            return "PAID";
        case PaymentStatus::PENDING:
            return "PENDING";
        case PaymentStatus::OVERDUE:
            return "OVERDUE";
        default:
            return "UNKNOWN";
    }
}

string typeToString(DuesType type) {
    switch (type) {
        case DuesType::MONTHLY:
            return "Monthly";
        case DuesType::QUARTERLY:
            return "Quarterly";
        case DuesType::ANNUAL:
            return "Annual";
        default:
            return "Unknown";
    }
}

int getAmount(DuesType type) {
    return static_cast<int>(type);  // Convert enum to int
}

void displayRecord(const DuesRecord& record) {
    cout << "\n===== DUES RECORD =====\n";
    cout << "ID: " << record.residentId << endl;
    cout << "Name: " << record.name << endl;
    cout << "Type: " << typeToString(record.type);
    cout << " (P" << getAmount(record.type) << ")\n";
    cout << "Status: " << statusToString(record.status) << endl;
    cout << "Due Date: " << record.dueDate << endl;
    cout << "========================\n";
}

int main() {
    DuesRecord records[3] = {
        {1001, "Juan Dela Cruz", DuesType::MONTHLY, PaymentStatus::PAID, "2024-11-30"},
        {1002, "Maria Santos", DuesType::ANNUAL, PaymentStatus::PENDING, "2024-12-31"},
        {1003, "Pedro Reyes", DuesType::QUARTERLY, PaymentStatus::OVERDUE, "2024-10-31"}
    };
    
    cout << "BARANGAY DUES SUMMARY\n";
    cout << "=====================\n";
    
    for (int i = 0; i < 3; i++) {
        displayRecord(records[i]);
    }
    
    // Count by status
    int paid = 0, pending = 0, overdue = 0;
    for (int i = 0; i < 3; i++) {
        switch (records[i].status) {
            case PaymentStatus::PAID:
                paid++;
                break;
            case PaymentStatus::PENDING:
                pending++;
                break;
            case PaymentStatus::OVERDUE:
                overdue++;
                break;
        }
    }
    
    cout << "\nSTATISTICS\n";
    cout << "Paid: " << paid << endl;
    cout << "Pending: " << pending << endl;
    cout << "Overdue: " << overdue << endl;
    
    return 0;
}
```

---

## Common Patterns

### Pattern 1: State Management
```cpp
enum class GameState {
    MENU,
    PLAYING,
    PAUSED,
    GAME_OVER
};

GameState currentState = GameState::MENU;
```

### Pattern 2: Error Codes
```cpp
enum class ErrorCode {
    SUCCESS = 0,
    FILE_NOT_FOUND = 1,
    PERMISSION_DENIED = 2,
    INVALID_INPUT = 3
};
```

### Pattern 3: Options/Flags
```cpp
enum class Permission {
    READ = 1,
    WRITE = 2,
    EXECUTE = 4
};
```

---

## Summary

"Now my code is so much clearer!" Tian exclaimed.

"Yes!" Kuya Miguel said. "Enums give you:
- **Readable code** (RESIDENCE instead of 1)
- **Type safety** (can't mix enum types)
- **Easy maintenance** (change values in one place)
- **Better switch statements**"

"Next: **Contact Book Project** — combining everything!"

---

**Key Takeaways:**
1. Enums create named constants
2. Default values start at 0
3. Use `enum class` for better type safety
4. Perfect for categories and states
5. Great with switch statements

**Next Lesson:** Mini Project - Contact Book System
