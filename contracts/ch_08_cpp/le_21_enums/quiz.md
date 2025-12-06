# Quiz: Lesson 21 - Enums

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Enum Basics

### Question 1
What are the values of these enum constants?

```cpp
enum ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL
};
```

A) 0, 1, 2  
B) 1, 2, 3  
C) Undefined  
D) Random values

**Answer: A) 0, 1, 2**

**Explanation:**
```cpp
enum ClearanceType {
    RESIDENCE,   // 0
    BUSINESS,    // 1
    TRAVEL       // 2
};

// By default, enums start at 0 and increment by 1
```

---

### Question 2
How do you set custom values?

```cpp
enum Fee {
    SMALL = 50,
    MEDIUM = 100,
    LARGE = 200
};

Fee f = MEDIUM;
cout << f;
```

A) `50`  
B) `100`  
C) `MEDIUM`  
D) Error

**Answer: B) `100`**

**Explanation:**
```cpp
enum Fee {
    SMALL = 50,    // Set to 50
    MEDIUM = 100,  // Set to 100
    LARGE = 200    // Set to 200
};

Fee f = MEDIUM;
cout << f;  // Prints the value: 100
```

---

### Question 3
What's the output?

```cpp
enum Level {
    LOW,
    MEDIUM = 5,
    HIGH
};

cout << LOW << " " << MEDIUM << " " << HIGH;
```

A) `0 5 6`  
B) `0 1 2`  
C) `1 5 6`  
D) Error

**Answer: A) `0 5 6`**

**Explanation:**
```cpp
enum Level {
    LOW,        // 0 (default)
    MEDIUM = 5, // 5 (explicitly set)
    HIGH        // 6 (continues from previous + 1)
};
```

---

## Section 2: Enum with Structs

### Question 4
Which code uses enums correctly with structs?

```cpp
// Option A
enum Type { RESIDENCE, BUSINESS };
struct Clearance {
    Type type;
    double fee;
};
Clearance c = {RESIDENCE, 50.0};

// Option B
struct Clearance {
    int type;  // 0 = residence, 1 = business
    double fee;
};
Clearance c = {0, 50.0};
```

A) Both valid, A is clearer  
B) Both valid, same  
C) Only A valid  
D) Only B valid

**Answer: A) Both valid, A is clearer**

**Explanation:**
```cpp
// Option A - Clear and readable
enum Type { RESIDENCE, BUSINESS };
struct Clearance {
    Type type;
    double fee;
};
Clearance c = {RESIDENCE, 50.0};  // ✓ Self-documenting

// Option B - Works but confusing
struct Clearance {
    int type;
    double fee;
};
Clearance c = {0, 50.0};  // ❌ What does 0 mean?
```

---

### Question 5
What's the output?

```cpp
enum Status {
    PENDING,
    APPROVED,
    REJECTED
};

struct Application {
    int id;
    Status status;
};

Application app = {1001, APPROVED};

if (app.status == APPROVED) {
    cout << "Application approved";
} else {
    cout << "Not approved";
}
```

A) `Application approved`  
B) `Not approved`  
C) Error  
D) Nothing

**Answer: A) `Application approved`**

**Explanation:**
```cpp
app.status = APPROVED;  // Set to APPROVED

if (app.status == APPROVED) {  // True!
    cout << "Application approved";
}
```

---

## Section 3: Enum Class

### Question 6
What's the difference between enum and enum class?

```cpp
// Regular enum
enum Color { RED, GREEN, BLUE };

// Enum class
enum class TrafficLight { RED, YELLOW, GREEN };
```

A) No difference  
B) Enum class requires scope resolution (::)  
C) Enum class can't have values  
D) Regular enum is deprecated

**Answer: B) Enum class requires scope resolution (::)**

**Explanation:**
```cpp
// Regular enum - no scope needed
enum Color { RED, GREEN, BLUE };
Color c = RED;  // ✓ OK

// Enum class - must use scope
enum class TrafficLight { RED, YELLOW, GREEN };
TrafficLight t = TrafficLight::RED;  // Must use TrafficLight::

// Benefit: No name conflicts
enum Color { RED };
enum Light { RED };  // ❌ Error! RED already defined

enum class Color { RED };
enum class Light { RED };  // ✓ OK! Different scopes
```

---


# Quiz 2

### Question 7
Which code compiles?

```cpp
enum class Status {
    PENDING,
    APPROVED
};

// Option A
Status s = PENDING;

// Option B
Status s = Status::PENDING;
```

A) Only A  
B) Only B  
C) Both  
D) Neither

**Answer: B) Only B**

**Explanation:**
```cpp
enum class Status {
    PENDING,
    APPROVED
};

// ❌ WRONG
Status s = PENDING;

// ✓ CORRECT
Status s = Status::PENDING;

// enum class requires explicit scope
```

---

### Question 8
Can you compare enum class values from different enums?

```cpp
enum class Color { RED, GREEN };
enum class Size { SMALL, LARGE };

Color c = Color::RED;
Size s = Size::SMALL;

if (c == s) {  // Valid?
    cout << "Equal";
}
```

A) Yes, both are 0  
B) No, compile error  
C) Yes, but warning  
D) Depends on compiler

**Answer: B) No, compile error**

**Explanation:**
```cpp
enum class Color { RED, GREEN };
enum class Size { SMALL, LARGE };

Color c = Color::RED;      // Type: Color
Size s = Size::SMALL;      // Type: Size

if (c == s) {  // ❌ Error! Different types
    cout << "Equal";
}

// Benefit: Type safety! Can't mix different enum classes
```

---

## Section 4: Practical Applications

### Question 9
What's the output?

```cpp
enum class Fee {
    RESIDENCE = 50,
    BUSINESS = 100,
    TRAVEL = 150
};

int getFee(Fee type) {
    return static_cast<int>(type);
}

int main() {
    Fee f = Fee::BUSINESS;
    cout << getFee(f);
}
```

A) `0`  
B) `1`  
C) `100`  
D) Error

**Answer: C) `100`**

**Explanation:**
```cpp
enum class Fee {
    RESIDENCE = 50,
    BUSINESS = 100,   // ← This
    TRAVEL = 150
};

Fee f = Fee::BUSINESS;
int value = static_cast<int>(f);  // Convert to int: 100
```

---


# Quiz 1

### Question 10
How do you convert enum to string?

```cpp
enum class Status {
    PENDING,
    APPROVED,
    REJECTED
};

string statusToString(Status s) {
    // ???
}
```

A) `return s;`  
B) Use switch statement  
C) Use toString() method  
D) Automatic conversion

**Answer: B) Use switch statement**

**Explanation:**
```cpp
string statusToString(Status s) {
    switch (s) {
        case Status::PENDING:
            return "Pending";
        case Status::APPROVED:
            return "Approved";
        case Status::REJECTED:
            return "Rejected";
        default:
            return "Unknown";
    }
}

// Usage:
Status s = Status::APPROVED;
cout << statusToString(s);  // "Approved"
```

---

## Section 5: Advanced Scenarios

### Question 11
What's the best enum structure for this system?

**Requirement:** Track clearance types with different fees:
- Residence: P50
- Business: P100
- Travel: P150

```cpp
// Option A
enum ClearanceType {
    RESIDENCE,
    BUSINESS,
    TRAVEL
};
double fees[] = {50, 100, 150};

// Option B
enum ClearanceFee {
    RESIDENCE = 50,
    BUSINESS = 100,
    TRAVEL = 150
};
```

A) Option A  
B) Option B  
C) Both same  
D) Neither

**Answer: B) Option B**

**Explanation:**
**Option A problems:**
- Separate array and enum
- Easy to get out of sync

**Option B benefits:**
- ✓ Values in one place
- ✓ Can't get out of sync
- ✓ Direct access to fee

```cpp
enum ClearanceFee {
    RESIDENCE = 50,
    BUSINESS = 100,
    TRAVEL = 150
};

ClearanceFee fee = BUSINESS;
cout << "Fee: P" << static_cast<int>(fee);  // Fee: P100
```

---


# Quiz 1

### Question 12
What's the output?

```cpp
enum class PaymentStatus {
    PAID,
    PENDING,
    OVERDUE
};

struct Record {
    string name;
    PaymentStatus status;
};

Record records[3] = {
    {"Juan", PaymentStatus::PAID},
    {"Maria", PaymentStatus::PENDING},
    {"Pedro", PaymentStatus::OVERDUE}
};

int count = 0;
for (int i = 0; i < 3; i++) {
    if (records[i].status == PaymentStatus::PAID) {
        count++;
    }
}
cout << count;
```

A) `0`  
B) `1`  
C) `2`  
D) `3`

**Answer: B) `1`**

**Explanation:**
```cpp
records[0].status = PaymentStatus::PAID     // ✓ Match!
records[1].status = PaymentStatus::PENDING
records[2].status = PaymentStatus::OVERDUE

count = 1  // Only Juan is PAID
```

---


# Quiz 1

### Question 13
Can enums be used in switch statements?

```cpp
enum class Priority {
    LOW,
    MEDIUM,
    HIGH
};

void handlePriority(Priority p) {
    switch (p) {
        case Priority::LOW:
            cout << "Low priority\n";
            break;
        case Priority::MEDIUM:
            cout << "Medium priority\n";
            break;
        case Priority::HIGH:
            cout << "High priority\n";
            break;
    }
}
```

A) Yes, perfect use case  
B) No, use if-else  
C) Only regular enums  
D) Not recommended

**Answer: A) Yes, perfect use case**

**Explanation:**
```cpp
// ✓ Enums are PERFECT for switch statements

switch (priority) {
    case Priority::LOW:
        // Handle low
        break;
    case Priority::MEDIUM:
        // Handle medium
        break;
    case Priority::HIGH:
        // Handle high
        break;
}

// Compiler warns if you miss a case!
```

---


# Quiz 1

### Question 14
What's wrong with this code?

```cpp
enum Color { RED, GREEN, BLUE };
enum TrafficLight { RED, YELLOW, GREEN };

Color c = RED;
TrafficLight t = RED;
```

A) Nothing wrong  
B) RED defined twice (name conflict)  
C) Can't have two enums  
D) Missing enum class

**Answer: B) RED defined twice (name conflict)**

**Explanation:**
```cpp
enum Color { RED, GREEN, BLUE };
enum TrafficLight { RED, YELLOW, GREEN };  
// ❌ Error! RED and GREEN already defined in Color

// Solution: Use enum class
enum class Color { RED, GREEN, BLUE };
enum class TrafficLight { RED, YELLOW, GREEN };  // ✓ OK!

Color c = Color::RED;              // Different scope
TrafficLight t = TrafficLight::RED;  // Different scope
```

---


# Quiz 1

### Question 15
Design a barangay clearance system with enums. Which is better?

**Requirements:**
- Track clearance type (Residence, Business, Travel, Employment)
- Track status (Pending, Approved, Rejected)
- Each type has different fee

```cpp
// Option A: Magic numbers
struct Clearance {
    int id;
    int type;     // 0=residence, 1=business, 2=travel, 3=employment
    int status;   // 0=pending, 1=approved, 2=rejected
    double fee;
};

// Option B: Enums
enum class ClearanceType {
    RESIDENCE = 50,
    BUSINESS = 100,
    TRAVEL = 150,
    EMPLOYMENT = 75
};

enum class Status {
    PENDING,
    APPROVED,
    REJECTED
};

struct Clearance {
    int id;
    ClearanceType type;
    Status status;
};
```

A) Option A (simpler)  
B) Option B (clearer)  
C) Both same  
D) Neither

**Answer: B) Option B (clearer)**

**Explanation:**
**Option A problems:**
- ❌ Magic numbers (what does 0, 1, 2 mean?)
- ❌ Easy to use wrong values
- ❌ No type safety

**Option B benefits:**
- ✓ Self-documenting code
- ✓ Type-safe (can't mix type and status)
- ✓ Fees embedded in enum
- ✓ Easy to maintain

```cpp
// Clear and readable!
Clearance c;
c.type = ClearanceType::BUSINESS;
c.status = Status::APPROVED;

// Easy to understand
if (c.status == Status::APPROVED) {
    int fee = static_cast<int>(c.type);
    cout << "Approved! Fee: P" << fee;
}

// Can't make this mistake:
// c.status = ClearanceType::BUSINESS;  // ❌ Compile error!
```

**Enums make code readable and safe!**

---

**Score yourself:**
- 15/15: Enum Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review enum class
- Below 9: Re-read enum concepts

**Key Concepts:**
1. Enums create named constants
2. Default values start at 0
3. Use `enum class` for type safety
4. Perfect for switch statements
5. Embed values directly in enum
