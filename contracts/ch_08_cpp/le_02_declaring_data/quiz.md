# Variables and Data Types Quiz

---

# Quiz 1

## Quiz: Understanding Data Types and Type Conversion

**Scenario:** 

Tian is building a simple payroll calculator for a small sari-sari store in Quezon City. The store owner, Aling Rosa, needs to calculate daily wages for her employees. Tian writes the following program:

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string employee_name = "Juan";
    int hours_worked = 9;
    double hourly_rate = 85.50;
    bool has_overtime = true;
    
    double basic_pay = hours_worked * hourly_rate;
    float overtime_rate = 1.5;
    double overtime_pay = 0;
    
    if (has_overtime) {
        int overtime_hours = 2;
        overtime_pay = overtime_hours * hourly_rate * overtime_rate;
    }
    
    double total_pay = basic_pay + overtime_pay;
    int rounded_pay = total_pay;
    
    cout << "Employee: " << employee_name << endl;
    cout << "Total Pay: " << total_pay << " pesos" << endl;
    cout << "Rounded Pay: " << rounded_pay << " pesos" << endl;
    
    return 0;
}
```

**Question 1:** What is the output value of `rounded_pay` in this program?

- A) `1026.75` (exact calculation)
- B) `1026` (truncated, decimal removed)
- C) `1027` (rounded up)
- D) Compiler error

**Answer:** B) `1026` (truncated)

---

**Question 2:** Why did Tian use `double` for `hourly_rate` instead of `int`?

- A) `double` is faster than `int`
- B) `double` can store decimal values like 85.50, while `int` only stores whole numbers
- C) `double` uses less memory
- D) `int` cannot store values above 85

**Answer:** B) `double` can store decimal values like 85.50, while `int` only stores whole numbers

---

# Quiz 2

**Question 3:** What happens when you assign a `double` value to an `int` variable (like `int rounded_pay = total_pay`)?

- A) The decimal part is rounded to the nearest integer
- B) The decimal part is truncated (removed/cut off)
- C) Compiler error occurs
- D) The value becomes 0

**Answer:** B) The decimal part is truncated

---

## Detailed Explanation

### Question 1: Type Conversion and Truncation

**Calculating the Result:**

Let's trace through Tian's program step by step:

```cpp
// Initial values
int hours_worked = 9;
double hourly_rate = 85.50;
bool has_overtime = true;

// Basic pay calculation
double basic_pay = hours_worked * hourly_rate;
// basic_pay = 9 * 85.50 = 769.50

// Overtime calculation
float overtime_rate = 1.5;
int overtime_hours = 2;
double overtime_pay = overtime_hours * hourly_rate * overtime_rate;
// overtime_pay = 2 * 85.50 * 1.5 = 256.50

// Total pay
double total_pay = basic_pay + overtime_pay;
// total_pay = 769.50 + 256.50 = 1026.00

// Wait! Let's recalculate more carefully:
// basic_pay = 9 * 85.50 = 769.50
// overtime_pay = 2 * 85.50 * 1.5 = 256.50
// total_pay = 769.50 + 256.50 = 1026.00

// But if overtime rate applies to overtime hours only:
// If standard rate for 8 hours, then overtime starts at hour 9:
// Actually, re-reading: overtime_hours = 2 as separate variable
// overtime_pay = 2 * 85.50 * 1.5 = 256.50
// total_pay = 769.50 + 256.50 = 1026.00

// Assignment to int
int rounded_pay = total_pay;
// rounded_pay = 1026 (decimal .00 truncated)
```

**Wait, let me recalculate carefully:**

```
basic_pay = 9 * 85.50 = 769.50
overtime_pay = 2 * 85.50 * 1.5 = 171.00 * 1.5 = 256.50
total_pay = 769.50 + 256.50 = 1026.00
```

Since `total_pay = 1026.00` (even though it's stored in double), when assigned to int, the decimal part is removed: `rounded_pay = 1026`.

**Understanding Truncation vs Rounding:**

**Truncation (what C++ does automatically):**
```cpp
double value = 1026.75;
int result = value;  // result = 1026 (decimal removed)

double negative = -1026.75;
int result2 = negative;  // result2 = -1026 (rounds toward zero)
```

**Rounding (requires explicit function):**
```cpp
#include <cmath>

double value = 1026.75;
int result = round(value);  // result = 1027 (rounds to nearest)

double value2 = 1026.25;
int result2 = round(value2);  // result2 = 1026

double value3 = 1026.50;
int result3 = round(value3);  // result3 = 1027 (rounds up at .5)
```

**Why Truncation Can Be Problematic:**

```cpp
// Sari-sari store pricing
double item_price = 45.99;
int cash_register = item_price;  // cash_register = 45 (lost 0.99!)

// Customer pays 100
int change = 100 - cash_register;  // change = 55
// But actual change should be 100 - 45.99 = 54.01

// Store loses 0.99 pesos!
```

**Correct Approach:**

```cpp
#include <cmath>

double item_price = 45.99;
int display_price = round(item_price);  // display_price = 46

// Or better: keep as double throughout
double item_price = 45.99;
double payment = 100.00;
double change = payment - item_price;  // change = 54.01
```

**Philippine Context - Centavo Issues:**

In the Philippines, 1 centavo coins are rare. Most transactions round to the nearest 5 or 25 centavos:

```cpp
#include <iostream>
#include <cmath>
using namespace std;

double round_to_nearest_quarter(double amount) {
    return round(amount * 4) / 4.0;  // Rounds to nearest 0.25
}

int main() {
    double bill = 123.67;
    double rounded = round_to_nearest_quarter(bill);
    
    cout << "Original: " << bill << endl;      // 123.67
    cout << "Rounded: " << rounded << endl;    // 123.75
    
    return 0;
}
```

---

### Question 2: Integer vs Floating-Point Types

**Data Type Comparison:**

| Type | Size | Range | Precision | Use Case |
|------|------|-------|-----------|----------|
| `int` | 4 bytes | -2,147,483,648 to 2,147,483,647 | Whole numbers only | Count, ID, age |
| `float` | 4 bytes | ±3.4e38 | ~6-7 decimal digits | Basic decimals |
| `double` | 8 bytes | ±1.7e308 | ~15-16 decimal digits | Money, precise calculations |
| `long long` | 8 bytes | ±9.2e18 | Whole numbers only | Large counts |

**Why Use `double` for Money?**

```cpp
// Scenario: Aling Rosa tracks daily sales
double sale1 = 45.50;   // Rice
double sale2 = 120.75;  // Cooking oil
double sale3 = 8.25;    // Candy

double total_sales = sale1 + sale2 + sale3;
// total_sales = 174.50 pesos

int wrong_total = sale1 + sale2 + sale3;
// wrong_total = 174 (lost 0.50 pesos!)
```

**Integer Limitations:**

```cpp
int hourly_rate = 85.50;  // Compiler warning! Truncates to 85
// Employee loses 0.50 pesos per hour!
// Over 8 hours: loses 4 pesos per day
// Over 20 working days: loses 80 pesos per month!
```

**When to Use Each Type:**

**Use `int` for:**
```cpp
int employee_count = 5;         // Counting people
int days_worked = 22;           // Counting days
int product_quantity = 150;     // Counting items
int customer_id = 10234;        // ID numbers
int age = 25;                   // Age in years
```

**Use `double` for:**
```cpp
double price = 125.50;          // Money with centavos
double weight = 2.5;            // Kilograms
double temperature = 32.8;      // Celsius
double distance = 15.75;        // Kilometers
double percentage = 12.5;       // Interest rates
```

**Use `float` for:**
```cpp
float simple_ratio = 1.5f;      // Simple multipliers
float coordinate_x = 100.5f;    // Graphics coordinates
// Note: Rarely used, double is preferred in most cases
```

**Memory Consideration:**

```cpp
int x = 100;        // 4 bytes
float y = 100.0f;   // 4 bytes
double z = 100.0;   // 8 bytes
```

For Tian's payroll program with 10 employees:
- Using `int`: 10 × 4 = 40 bytes
- Using `double`: 10 × 8 = 80 bytes
- Difference: 40 bytes (negligible on modern computers)

**Precision Matters:**

```cpp
// Philippine tax calculation (12% VAT)
double price_without_vat = 1000.00;
double vat_rate = 0.12;
double vat_amount = price_without_vat * vat_rate;  // 120.00
double total_price = price_without_vat + vat_amount;  // 1120.00

// If we used int:
int wrong_price = 1000;
int wrong_vat = wrong_price * 0.12;  // 0 (0.12 truncated to 0!)
int wrong_total = wrong_price + wrong_vat;  // 1000 (missing 120!)
```

---

### Question 3: Implicit Type Conversion

**Type Conversion Rules:**

C++ performs automatic (implicit) type conversion when assigning between different types:

```cpp
double precise = 1026.75;
int whole = precise;  // Implicit conversion: 1026.75 → 1026
```

**Conversion Hierarchy:**

```
bool → char → short → int → long → long long → float → double
  ↑                                                         ↓
  └─────────────── Narrowing (data loss) ──────────────────┘
```

**Widening Conversion (Safe):**
```cpp
int small = 100;
double large = small;  // 100 → 100.0 (no data loss)

int age = 25;
float age_float = age;  // 25 → 25.0
```

**Narrowing Conversion (Data Loss):**
```cpp
double money = 1500.75;
int rounded = money;  // 1500.75 → 1500 (lost 0.75!)

float precise = 3.14159f;
int pi = precise;  // 3.14159 → 3 (lost everything after decimal)
```

**Real-World Example: PUV Fare Calculator**

```cpp
#include <iostream>
using namespace std;

int main() {
    // Jeepney fare in Manila: 13 pesos base + 1.50 per km
    double base_fare = 13.00;
    double per_km_rate = 1.50;
    double distance = 5.7;  // kilometers
    
    double total_fare = base_fare + (per_km_rate * distance);
    // total_fare = 13.00 + (1.50 * 5.7) = 13.00 + 8.55 = 21.55
    
    // Driver only accepts whole pesos (no coins)
    int fare_to_pay = total_fare;  // 21.55 → 21 (truncated)
    
    cout << "Exact fare: " << total_fare << " pesos" << endl;
    cout << "Pay: " << fare_to_pay << " pesos" << endl;
    
    // Better approach: round up
    int fare_rounded_up = total_fare + 0.99;  // 21.55 + 0.99 = 22.54 → 22
    // Or use ceil function:
    // int fare_rounded_up = ceil(total_fare);  // Always rounds up
    
    return 0;
}
```

**Explicit Type Conversion (Casting):**

```cpp
// C-style cast
double value = 10.7;
int result = (int)value;  // result = 10

// C++ style cast (preferred)
double value2 = 10.7;
int result2 = static_cast<int>(value2);  // result2 = 10
```

**When Explicit Casting is Needed:**

```cpp
// Division of integers
int total_students = 45;
int passed_students = 38;

double pass_rate = passed_students / total_students;  // Wrong! = 0
// Because: 38 / 45 = 0 (integer division)

double correct_rate = static_cast<double>(passed_students) / total_students;
// 38.0 / 45 = 0.8444... (84.44% pass rate)

// Or simpler:
double correct_rate2 = passed_students * 100.0 / total_students;
// 38 * 100.0 = 3800.0, then 3800.0 / 45 = 84.44
```

**Mixed Type Arithmetic:**

```cpp
int whole = 10;
double decimal = 3.5;

double result = whole + decimal;  // int promoted to double
// 10 → 10.0, then 10.0 + 3.5 = 13.5

int wrong = whole + decimal;  // Result truncated
// 10.0 + 3.5 = 13.5 → 13 (assigned to int)
```

**Philippine Salary Example:**

```cpp
#include <iostream>
#include <cmath>
using namespace std;

int main() {
    // Monthly salary computation
    double daily_rate = 570.00;  // Current minimum wage NCR
    int days_worked = 26;
    double gross_salary = daily_rate * days_worked;  // 14,820.00
    
    // Deductions
    double sss_rate = 0.045;        // 4.5% SSS
    double philhealth_rate = 0.02;  // 2% PhilHealth  
    double pagibig = 100.00;        // Fixed 100
    
    double sss = gross_salary * sss_rate;           // 666.90
    double philhealth = gross_salary * philhealth_rate;  // 296.40
    double total_deductions = sss + philhealth + pagibig;  // 1063.30
    
    double net_salary = gross_salary - total_deductions;  // 13,756.70
    
    // Company rounds to nearest peso for payout
    int take_home = round(net_salary);  // 13,757
    
    cout << "Gross Salary: " << gross_salary << endl;
    cout << "Total Deductions: " << total_deductions << endl;
    cout << "Net Salary: " << net_salary << endl;
    cout << "Take Home Pay: " << take_home << " pesos" << endl;
    
    return 0;
}
```

**Common Pitfalls:**

```cpp
// Pitfall 1: Integer division
int a = 5, b = 2;
double result = a / b;  // result = 2.0 (not 2.5!)
// Fix: double result = static_cast<double>(a) / b;

// Pitfall 2: Overflow
int large = 2000000000;
int larger = large + large;  // Overflow! Undefined behavior
// Fix: use long long

// Pitfall 3: Loss of precision
double precise = 1234567890.123456789;
float less_precise = precise;  // Loses precision
// float only has ~6-7 digit precision

// Pitfall 4: Comparison with floating point
double value = 0.1 + 0.2;
if (value == 0.3) {  // Might be false due to floating point error!
    cout << "Equal" << endl;
}
// Fix: Use epsilon comparison
// if (abs(value - 0.3) < 0.00001) { ... }
```

---

## Key Concepts Summary

**1. Fundamental Data Types:**

**Integers (whole numbers):**
```cpp
int count = 100;          // Most common
short small = 10;         // Smaller range
long big = 1000000L;      // Larger range
long long huge = 1000000000000LL;  // Very large
```

**Floating-point (decimals):**
```cpp
float simple = 3.14f;     // 4 bytes, ~6-7 digits precision
double precise = 3.14159265359;  // 8 bytes, ~15-16 digits
```

**Boolean:**
```cpp
bool is_active = true;    // true or false only
bool has_license = false;
```

**Character:**
```cpp
char grade = 'A';         // Single character
char initial = 'T';
```

**String:**
```cpp
string name = "Tian";     // Multiple characters (needs #include <string>)
string address = "Quezon City";
```

**2. Type Sizes and Ranges:**

| Type | Bytes | Range |
|------|-------|-------|
| `bool` | 1 | true/false |
| `char` | 1 | -128 to 127 |
| `short` | 2 | -32,768 to 32,767 |
| `int` | 4 | -2.1B to 2.1B |
| `long` | 4/8 | System dependent |
| `long long` | 8 | -9.2e18 to 9.2e18 |
| `float` | 4 | ±3.4e38 (6-7 digits) |
| `double` | 8 | ±1.7e308 (15-16 digits) |

**3. Type Conversion:**

**Implicit (automatic):**
- Widening: int → double (safe)
- Narrowing: double → int (data loss)

**Explicit (casting):**
```cpp
int x = static_cast<int>(10.7);  // C++ style
int y = (int)10.7;               // C style
```

**4. Best Practices:**

- Use `int` for counting and whole numbers
- Use `double` for money and precise calculations
- Avoid `float` unless memory is critical
- Use explicit casting to show intent
- Be careful with integer division
- Round money appropriately for Philippine context
- Consider overflow for large calculations
- Use `long long` for very large numbers

**5. Philippine Developer Context:**

- Money: Always use `double` (pesos and centavos)
- Quantities: Use `int` (items, people, days)
- Rates/percentages: Use `double` (VAT 12%, interest rates)
- IDs: Use `int` or `long long` (employee IDs, transaction IDs)
- Measurements: Use `double` (weight in kg, distance in km)
