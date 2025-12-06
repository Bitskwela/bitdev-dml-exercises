## Background Story

Tian stared at the bug report: "Clearance type 4 crashes the system." Looking at the code, Tian saw clearance types defined as integers: 0 = Residence, 1 = Business, 2 = Travel. Somewhere, someone passed 4, and the program had no idea what to do.

"This is a nightmare to maintain!" Tian complained. "What does `status = 2` mean? Is that Travel or something else? And there's nothing stopping someone from passing invalid numbers like 99 or -5!"

Kuya Miguel nodded. "You're using **magic numbers**—a classic code smell. When you see `if (clearanceType == 1)` six months from now, will you remember what 1 means? What if someone new joins the team?"

"This is where **enums** save the day," Kuya Miguel explained. "Instead of cryptic numbers, you define meaningful names: `RESIDENCE`, `BUSINESS`, `TRAVEL`. The code becomes self-documenting. Instead of `if (clearanceType == 1)`, you write `if (clearanceType == BUSINESS)`. Instantly readable. Plus, the compiler enforces type safety—you can't accidentally pass a random integer."

"Every professional codebase uses enums for states, types, and categories," Kuya Miguel said. "It's the difference between code that requires constant reference to documentation and code that explains itself. Let's fix your clearance system properly!"

---

## Theory & Lecture Content

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

---

## Closing Story

"This is so much clearer!" Tian said, refactoring his code to use ClearanceType::RESIDENCE instead of the number 1. "No more remembering what 1, 2, 3 mean. The code documents itself!"

Kuya Miguel smiled. "That's the point. Six months from now, when you come back to this code, you'll instantly understand ClearanceType::BUSINESS. But what did 2 mean? You'd have to look it up."

Tian practiced using enums with switch statements, converting enums to strings for display, and using enum class for type safety. "And enum class prevents accidental mixing of different enum types. Can't compare a ClearanceType to a PaymentStatus by mistake."

"Exactly! Enums are perfect for categories, states, options, error codes. Anywhere you have a fixed set of related constants. And they pair beautifully with structs: your Clearance struct has a ClearanceType member, your DuesRecord has a PaymentStatus member."

Tian saved his enum-enhanced code, feeling the improvement. "Ready for the next challenge!"

"Time to combine everything: structs, nested structs, enums, arrays, functions. You're building a complete Contact Book System."

**Next Lesson:** Mini Project - Contact Book System
