# Quiz: Lesson 22 - Contact Book System

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Project Design

### Question 1
What's the best data structure for a contact book?

```cpp
// Option A
string names[100];
string phones[100];
string emails[100];

// Option B
struct Contact {
    string name;
    string phone;
    string email;
};
Contact contacts[100];
```

A) Option A (simpler)  
B) Option B (organized)  
C) Both same  
D) Neither

**Answer: B) Option B (organized)**

**Explanation:**
**Option A problems:**
- Multiple parallel arrays
- Easy to get out of sync
- Hard to pass to functions

**Option B benefits:**
- ✓ Data grouped together
- ✓ Easy to pass to functions
- ✓ Can't get out of sync

```cpp
// With struct - clean!
void displayContact(const Contact& c) {
    cout << c.name << " - " << c.phone;
}
```

---

### Question 2
Why use enum for contact types?

```cpp
// Option A: Magic numbers
struct Contact {
    int type;  // 0=personal, 1=work, 2=family
};

// Option B: Enum
enum class ContactType {
    PERSONAL,
    WORK,
    FAMILY
};

struct Contact {
    ContactType type;
};
```

A) Both same  
B) Enum is clearer and type-safe  
C) Magic numbers are faster  
D) Enum uses more memory

**Answer: B) Enum is clearer and type-safe**

**Explanation:**
```cpp
// Option A - confusing
if (contact.type == 0) {  // What's 0?
    // ...
}

// Option B - clear!
if (contact.type == ContactType::PERSONAL) {  // ✓ Clear!
    // ...
}

// Also prevents errors:
contact.type = 999;  // ❌ With int - valid but wrong!
contact.type = ContactType::WORK;  // ✓ Type-safe!
```

---

### Question 3
What's the purpose of the `active` field?

```cpp
struct Contact {
    int id;
    string name;
    bool active;
};
```

A) Check if contact exists  
B) Soft delete (mark as deleted without removing)  
C) Validate contact data  
D) Track contact status

**Answer: B) Soft delete (mark as deleted without removing)**

**Explanation:**
```cpp
// Soft delete pattern
void deleteContact(int index) {
    contacts[index].active = false;  // Don't remove, just mark
}

void displayAll() {
    for (int i = 0; i < count; i++) {
        if (contacts[i].active) {  // Only show active
            display(contacts[i]);
        }
    }
}

// Benefits:
// - Can restore deleted contacts
// - Maintains array indices
// - Preserves history
```

---

## Section 2: CRUD Operations

### Question 4
What's missing from this add function?

```cpp
void addContact() {
    if (contactCount >= MAX_CONTACTS) {
        cout << "Full!\n";
        return;
    }
    
    Contact c;
    cout << "Name: ";
    cin >> c.name;  // ← Problem!
    
    contacts[contactCount++] = c;
}
```

A) Nothing wrong  
B) Should use `getline()` for names with spaces  
C) Missing ID assignment  
D) Both B and C

**Answer: D) Both B and C**

**Explanation:**
```cpp
void addContact() {
    if (contactCount >= MAX_CONTACTS) {
        cout << "Full!\n";
        return;
    }
    
    Contact c;
    c.id = nextId++;  // ✓ Assign unique ID
    c.active = true;
    
    cin.ignore();  // Clear buffer
    cout << "Name: ";
    getline(cin, c.name);  // ✓ Handle spaces!
    
    contacts[contactCount++] = c;
}

// cin >> only reads until whitespace
// "Juan Cruz" becomes just "Juan"
// getline() reads full line
```

---

### Question 5
How do you search for a contact by name?

```cpp
int findContact(const string& name) {
    // ???
}
```

A) Linear search through array  
B) Binary search (requires sorted array)  
C) Hash table lookup  
D) Database query

**Answer: A) Linear search through array**

**Explanation:**
```cpp
int findContact(const string& name) {
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active && contacts[i].name == name) {
            return i;  // Found at index i
        }
    }
    return -1;  // Not found
}

// Usage:
int index = findContact("Juan");
if (index != -1) {
    displayContact(contacts[index]);
}
```

---


# Quiz 2

### Question 6
What's the correct way to update a contact?

```cpp
void updateContact() {
    string name;
    cout << "Name: ";
    getline(cin, name);
    
    int index = findContact(name);
    
    if (index == -1) {
        cout << "Not found\n";
        return;
    }
    
    // How to update phone?
}
```

A) `contacts[index].phone = newPhone;`  
B) `contacts[index]->phone = newPhone;`  
C) `contacts.phone[index] = newPhone;`  
D) Create new contact

**Answer: A) `contacts[index].phone = newPhone;`**

**Explanation:**
```cpp
void updateContact() {
    cin.ignore();
    string name;
    cout << "Name: ";
    getline(cin, name);
    
    int index = findContact(name);
    if (index == -1) {
        cout << "Not found\n";
        return;
    }
    
    cout << "New phone: ";
    string newPhone;
    getline(cin, newPhone);
    
    contacts[index].phone = newPhone;  // ✓ Direct assignment
    
    cout << "Updated!\n";
}
```

---

## Section 3: Menu System

### Question 7
What's the output when user enters "3"?

```cpp
int main() {
    int choice;
    do {
        cout << "1. Add\n2. Display\n3. Exit\n";
        cin >> choice;
        
        switch (choice) {
            case 1:
                addContact();
                break;
            case 2:
                displayAll();
                break;
            case 3:
                cout << "Goodbye!\n";
                break;
        }
    } while (choice != 3);
    
    return 0;
}
```

A) Program crashes  
B) "Goodbye!" and exits  
C) Nothing happens  
D) Error

**Answer: B) "Goodbye!" and exits**

**Explanation:**
```cpp
// When choice = 3:
case 3:
    cout << "Goodbye!\n";  // Prints this
    break;

// Then:
while (choice != 3);  // False! Exit loop
return 0;  // Exit program
```

---

### Question 8
Why use `cin.ignore()` before `getline()`?

```cpp
int choice;
cin >> choice;

cin.ignore();  // Why this?

string name;
getline(cin, name);
```

A) Optional optimization  
B) Clear leftover newline from buffer  
C) Reset input stream  
D) Not necessary

**Answer: B) Clear leftover newline from buffer**

**Explanation:**
```cpp
// Without cin.ignore():
cin >> choice;     // User types "1\n"
                   // Reads 1, leaves '\n' in buffer
getline(cin, name); // Immediately reads '\n', gets empty string!

// With cin.ignore():
cin >> choice;      // User types "1\n"
cin.ignore();       // Removes '\n' from buffer
getline(cin, name); // Now correctly waits for input
```

---

## Section 4: Advanced Features

### Question 9
How do you count contacts by type?

```cpp
enum class ContactType {
    PERSONAL,  // 0
    WORK,      // 1
    FAMILY     // 2
};

void countByType() {
    int counts[3] = {0};
    // ???
}
```

A) Use switch statement  
B) Cast enum to int as array index  
C) Create separate counters  
D) Can't be done

**Answer: B) Cast enum to int as array index**

**Explanation:**
```cpp
void countByType() {
    int counts[3] = {0};  // [personal, work, family]
    
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            int typeIndex = static_cast<int>(contacts[i].type);
            counts[typeIndex]++;
        }
    }
    
    cout << "Personal: " << counts[0] << endl;
    cout << "Work: " << counts[1] << endl;
    cout << "Family: " << counts[2] << endl;
}
```

---


# Quiz 1

### Question 10
What's the output?

```cpp
Contact contacts[3] = {
    {1, "Juan", "0917", true},
    {2, "Maria", "0918", false},
    {3, "Pedro", "0919", true}
};
int contactCount = 3;

int active = 0;
for (int i = 0; i < contactCount; i++) {
    if (contacts[i].active) {
        active++;
    }
}
cout << active;
```

A) `0`  
B) `1`  
C) `2`  
D) `3`

**Answer: C) `2`**

**Explanation:**
```cpp
contacts[0].active = true   // ✓ Count
contacts[1].active = false  // Skip
contacts[2].active = true   // ✓ Count

active = 2
```

---

## Section 5: Best Practices

### Question 11
Why pass contacts as const reference?

```cpp
// Option A
void display(Contact c) { ... }

// Option B
void display(const Contact& c) { ... }
```

A) Both same  
B) Option B avoids copying and prevents modification  
C) Option A is faster  
D) Option B required for structs

**Answer: B) Option B avoids copying and prevents modification**

**Explanation:**
```cpp
// Option A - copies entire struct
void display(Contact c) {  // ❌ Slow for large structs
    cout << c.name;
}

// Option B - efficient and safe
void display(const Contact& c) {  // ✓ No copy, can't modify
    cout << c.name;
    // c.name = "hacked";  // ❌ Error! const prevents this
}
```

---


# Quiz 1

### Question 12
What's the best way to generate unique IDs?

```cpp
// Option A: Use array index
contacts[i].id = i;

// Option B: Use counter
int nextId = 1;
newContact.id = nextId++;

// Option C: Random number
newContact.id = rand();
```

A) Option A  
B) Option B  
C) Option C  
D) All same

**Answer: B) Option B**

**Explanation:**
**Option A problem:** IDs change when contacts deleted/reordered

**Option B benefits:** ✓ Always unique, ✓ Sequential, ✓ Persistent

**Option C problem:** Can have duplicates

```cpp
int nextId = 1;

void addContact() {
    Contact c;
    c.id = nextId++;  // 1, 2, 3, 4...
    contacts[contactCount++] = c;
}

// Even if contacts deleted, IDs stay unique
```

---


# Quiz 1

### Question 13
How do you display contacts sorted by name?

```cpp
void displaySorted() {
    // ???
}
```

A) Sort the original array  
B) Create sorted copy, display that  
C) Use sorted map/set  
D) Can't sort structs

**Answer: B) Create sorted copy, display that**

**Explanation:**
```cpp
void displaySorted() {
    // Copy active contacts
    Contact temp[MAX_CONTACTS];
    int tempCount = 0;
    
    for (int i = 0; i < contactCount; i++) {
        if (contacts[i].active) {
            temp[tempCount++] = contacts[i];
        }
    }
    
    // Bubble sort by name
    for (int i = 0; i < tempCount - 1; i++) {
        for (int j = 0; j < tempCount - i - 1; j++) {
            if (temp[j].name > temp[j + 1].name) {
                Contact swap = temp[j];
                temp[j] = temp[j + 1];
                temp[j + 1] = swap;
            }
        }
    }
    
    // Display sorted
    for (int i = 0; i < tempCount; i++) {
        display(temp[i]);
    }
}

// Original array unchanged!
```

---


# Quiz 1

### Question 14
What's wrong with this delete function?

```cpp
void deleteContact(int index) {
    for (int i = index; i < contactCount - 1; i++) {
        contacts[i] = contacts[i + 1];
    }
    contactCount--;
}
```

A) Nothing wrong  
B) Should use soft delete instead  
C) Index validation missing  
D) Both B and C

**Answer: D) Both B and C**

**Explanation:**
```cpp
// Problems:
// 1. Hard delete - can't restore
// 2. Shifts all elements - slow
// 3. No index validation

// Better approach:
void deleteContact(int index) {
    if (index < 0 || index >= contactCount) {  // ✓ Validate
        cout << "Invalid index\n";
        return;
    }
    
    contacts[index].active = false;  // ✓ Soft delete
    cout << "Contact marked as deleted\n";
}

// Benefits:
// - Can restore: contacts[index].active = true;
// - Fast: no shifting
// - Preserves IDs and indices
```

---


# Quiz 1

### Question 15
Design evaluation: Which contact book design is best?

```cpp
// Option A: Simple arrays
string names[100];
string phones[100];
int count = 0;

// Option B: Struct with enum
enum class ContactType {
    PERSONAL, WORK, FAMILY, EMERGENCY
};

struct Address {
    string street;
    string city;
};

struct Contact {
    int id;
    string name;
    string phone;
    string email;
    ContactType type;
    Address address;
    bool active;
};

Contact contacts[100];
int contactCount = 0;

// Option C: Struct without features
struct Contact {
    string name;
    string phone;
};
Contact contacts[100];
```

A) Option A (simplest)  
B) Option B (comprehensive)  
C) Option C (balanced)  
D) All same

**Answer: B) Option B (comprehensive)**

**Explanation:**
**Option A problems:**
- Parallel arrays hard to maintain
- No type safety
- Limited features

**Option C problems:**
- Missing ID (can't uniquely identify)
- No address structure
- No soft delete
- No type categorization

**Option B benefits:**
- ✓ Unique IDs (nextId++)
- ✓ Type-safe enums
- ✓ Nested structs (Address)
- ✓ Soft delete (active field)
- ✓ Comprehensive data model

```cpp
// Clean operations with Option B:
void addContact() {
    Contact c;
    c.id = nextId++;
    c.active = true;
    // ... get input
    c.type = ContactType::WORK;
    c.address.city = "Iloilo";
    contacts[contactCount++] = c;
}

// Type-safe queries:
if (c.type == ContactType::EMERGENCY) {
    prioritize(c);
}

// Soft delete:
c.active = false;  // Can restore later!
```

**Real-world projects need comprehensive design!**

---

**Score yourself:**
- 15/15: Project Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review CRUD operations
- Below 9: Practice the project

**Key Concepts:**
1. Structs organize related data
2. Enums provide type-safe categories
3. Soft delete preserves data
4. Use getline() for string input
5. Const references for efficiency
6. Sequential IDs for uniqueness
