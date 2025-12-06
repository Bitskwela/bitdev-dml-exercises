# Lesson 20 Activities: Nested Structs

## Structs Within Structs

Tian's `Resident` struct was getting huge:
```cpp
struct Resident {
    string name;
    int age;
    string street;
    string barangay;
    string city;
    string province;
    string zipCode;
    // ... 20 fields!
};
```

**Nested structs organize hierarchical data.** Just like your phone has modular components (battery, screen, camera), structs can contain other structs!

```cpp
struct Address {
    string street;
    string barangay;
    string city;
};

struct Resident {
    string name;
    int age;
    Address address;  // Nested struct!
};
```

**Clean, modular, professional!**

---

## Task 1: Basic Nested Struct

**Context:** Create and access nested struct members.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Address {
    string street;
    string barangay;
    string city;
};

struct Resident {
    string name;
    int age;
    Address address;  // Nested!
};

int main() {
    Resident r1;
    r1.name = "Juan Dela Cruz";
    r1.age = 35;
    r1.address.street = "123 Main St";
    r1.address.barangay = "Poblacion";
    r1.address.city = "Iloilo City";
    
    cout << "Name: " << r1.name << endl;
    cout << "Age: " << r1.age << endl;
    cout << "Address: " << r1.address.street << ", " 
         << r1.address.barangay << ", " 
         << r1.address.city << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create and access nested struct members using dot notation for each level.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Address {
      string street;
      string barangay;
      string city;
  };

  struct Resident {
      string name;
      int age;
      Address address;
  };

  int main() {
      Resident r1;
      r1.name = "Juan Dela Cruz";
      r1.age = 35;
      r1.address.street = "123 Main St";
      r1.address.barangay = "Poblacion";
      r1.address.city = "Iloilo City";
      
      cout << "Name: " << r1.name << endl;
      cout << "Age: " << r1.age << endl;
      cout << "Address: " << r1.address.street << ", " 
           << r1.address.barangay << ", " 
           << r1.address.city << endl;
      
      return 0;
  }
  ```

**Note:** Use dot notation for each level: `r1.address.city`

---

## Task 2: Nested Struct Initialization

**Context:** Initialize nested structs efficiently.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct ContactInfo {
    string phone;
    string email;
};

struct Address {
    string street;
    string barangay;
};

struct Resident {
    string name;
    Address address;
    ContactInfo contact;
};

int main() {
    // Method 1: Aggregate initialization
    Resident r1 = {
        "Juan Dela Cruz",
        {"123 Main St", "Poblacion"},
        {"09171234567", "juan@email.com"}
    };
    
    // Method 2: Uniform initialization
    Resident r2{
        "Maria Santos",
        {"456 Oak Ave", "San Jose"},
        {"09187654321", "maria@email.com"}
    };
    
    cout << r1.name << " - " << r1.contact.phone << endl;
    cout << r2.name << " - " << r2.contact.email << endl;
    
    return 0;
}
```

# Tasks for Learners

- Initialize nested structs efficiently using aggregate or uniform initialization.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct ContactInfo {
      string phone;
      string email;
  };

  struct Address {
      string street;
      string barangay;
  };

  struct Resident {
      string name;
      Address address;
      ContactInfo contact;
  };

  int main() {
      // Method 1: Aggregate initialization
      Resident r1 = {
          "Juan Dela Cruz",
          {"123 Main St", "Poblacion"},
          {"09171234567", "juan@email.com"}
      };
      
      // Method 2: Uniform initialization
      Resident r2{
          "Maria Santos",
          {"456 Oak Ave", "San Jose"},
          {"09187654321", "maria@email.com"}
      };
      
      cout << r1.name << " - " << r1.contact.phone << endl;
      cout << r2.name << " - " << r2.contact.email << endl;
      
      return 0;
  }
  ```

---

## Task 3: Array of Nested Structs

**Context:** Manage complex data collections.

**Challenge:** Track multiple residents with complete information.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Address {
    string street;
    string barangay;
    string city;
};

struct Resident {
    string name;
    int age;
    Address address;
};

void displayResident(const Resident& r) {
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Address: " << r.address.street << ", " 
         << r.address.barangay << ", " 
         << r.address.city << endl;
    cout << endl;
}

int main() {
    Resident residents[3] = {
        {"Juan Dela Cruz", 35, {"123 Main St", "Poblacion", "Iloilo City"}},
        {"Maria Santos", 28, {"456 Oak Ave", "San Jose", "Iloilo City"}},
        {"Pedro Garcia", 42, {"789 Pine Rd", "Santa Maria", "Iloilo City"}}
    };
    
    cout << "=== RESIDENT DIRECTORY ===" << endl;
    for (int i = 0; i < 3; i++) {
        cout << "Resident " << (i+1) << ":" << endl;
        displayResident(residents[i]);
    }
    
    return 0;
}
```

# Tasks for Learners

- Track multiple residents with complete information using an array of nested structs.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Address {
      string street;
      string barangay;
      string city;
  };

  struct Resident {
      string name;
      int age;
      Address address;
  };

  void displayResident(const Resident& r) {
      cout << "Name: " << r.name << endl;
      cout << "Age: " << r.age << endl;
      cout << "Address: " << r.address.street << ", " 
           << r.address.barangay << ", " 
           << r.address.city << endl;
      cout << endl;
  }

  int main() {
      Resident residents[3] = {
          {"Juan Dela Cruz", 35, {"123 Main St", "Poblacion", "Iloilo City"}},
          {"Maria Santos", 28, {"456 Oak Ave", "San Jose", "Iloilo City"}},
          {"Pedro Garcia", 42, {"789 Pine Rd", "Santa Maria", "Iloilo City"}}
      };
      
      cout << "=== RESIDENT DIRECTORY ===" << endl;
      for (int i = 0; i < 3; i++) {
          cout << "Resident " << (i+1) << ":" << endl;
          displayResident(residents[i]);
      }
      
      return 0;
  }
  ```

---

## Task 4: Deep Nesting

**Context:** Structs can nest multiple levels deep.

**Challenge:** Model a complete barangay organizational structure.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Contact {
    string phone;
    string email;
};

struct Address {
    string street;
    string barangay;
};

struct Person {
    string name;
    int age;
    Address address;
    Contact contact;
};

struct Office {
    string title;
    Person official;
};

int main() {
    Office kapitan = {
        "Barangay Captain",
        {
            "Juan Dela Cruz",
            45,
            {"Municipal Hall", "Poblacion"},
            {"09171234567", "kapitan@barangay.gov"}
        }
    };
    
    cout << "=== BARANGAY OFFICIAL ===" << endl;
    cout << "Title: " << kapitan.title << endl;
    cout << "Name: " << kapitan.official.name << endl;
    cout << "Age: " << kapitan.official.age << endl;
    cout << "Address: " << kapitan.official.address.street << ", " 
         << kapitan.official.address.barangay << endl;
    cout << "Phone: " << kapitan.official.contact.phone << endl;
    cout << "Email: " << kapitan.official.contact.email << endl;
    
    return 0;
}
```

# Tasks for Learners

- Model a complete barangay organizational structure using deep nesting (multiple levels).

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Contact {
      string phone;
      string email;
  };

  struct Address {
      string street;
      string barangay;
  };

  struct Person {
      string name;
      int age;
      Address address;
      Contact contact;
  };

  struct Office {
      string title;
      Person official;
  };

  int main() {
      Office kapitan = {
          "Barangay Captain",
          {
              "Juan Dela Cruz",
              45,
              {"Municipal Hall", "Poblacion"},
              {"09171234567", "kapitan@barangay.gov"}
          }
      };
      
      cout << "=== BARANGAY OFFICIAL ===" << endl;
      cout << "Title: " << kapitan.title << endl;
      cout << "Name: " << kapitan.official.name << endl;
      cout << "Age: " << kapitan.official.age << endl;
      cout << "Address: " << kapitan.official.address.street << ", " 
           << kapitan.official.address.barangay << endl;
      cout << "Phone: " << kapitan.official.contact.phone << endl;
      cout << "Email: " << kapitan.official.contact.email << endl;
      
      return 0;
  }
  ```

**Note:** `kapitan.official.contact.phone` - three levels deep!

---

## Task 5: Searching Nested Data

**Context:** Find residents by barangay.

**Challenge:** Filter residents based on nested struct field.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Address {
    string street;
    string barangay;
};

struct Resident {
    string name;
    Address address;
};

void displayResidentsByBarangay(Resident residents[], int size, string targetBarangay) {
    cout << "Residents in " << targetBarangay << ":" << endl;
    
    int count = 0;
    for (int i = 0; i < size; i++) {
        if (residents[i].address.barangay == targetBarangay) {
            cout << "- " << residents[i].name 
                 << " (" << residents[i].address.street << ")" << endl;
            count++;
        }
    }
    
    if (count == 0) {
        cout << "No residents found." << endl;
    }
}

int main() {
    Resident residents[5] = {
        {"Juan Dela Cruz", {"123 Main St", "Poblacion"}},
        {"Maria Santos", {"456 Oak Ave", "San Jose"}},
        {"Pedro Garcia", {"789 Pine Rd", "Poblacion"}},
        {"Ana Reyes", {"321 Elm St", "Santa Maria"}},
        {"Jose Mendoza", {"654 Maple Dr", "Poblacion"}}
    };
    
    displayResidentsByBarangay(residents, 5, "Poblacion");
    cout << endl;
    displayResidentsByBarangay(residents, 5, "San Jose");
    
    return 0;
}
```

# Tasks for Learners

- Find residents by barangay by filtering residents based on nested struct field.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Address {
      string street;
      string barangay;
  };

  struct Resident {
      string name;
      Address address;
  };

  void displayResidentsByBarangay(Resident residents[], int size, string targetBarangay) {
      cout << "Residents in " << targetBarangay << ":" << endl;
      
      int count = 0;
      for (int i = 0; i < size; i++) {
          if (residents[i].address.barangay == targetBarangay) {
              cout << "- " << residents[i].name 
                   << " (" << residents[i].address.street << ")" << endl;
              count++;
          }
      }
      
      if (count == 0) {
          cout << "No residents found." << endl;
      }
  }

  int main() {
      Resident residents[5] = {
          {"Juan Dela Cruz", {"123 Main St", "Poblacion"}},
          {"Maria Santos", {"456 Oak Ave", "San Jose"}},
          {"Pedro Garcia", {"789 Pine Rd", "Poblacion"}},
          {"Ana Reyes", {"321 Elm St", "Santa Maria"}},
          {"Jose Mendoza", {"654 Maple Dr", "Poblacion"}}
      };
      
      displayResidentsByBarangay(residents, 5, "Poblacion");
      cout << endl;
      displayResidentsByBarangay(residents, 5, "San Jose");
      
      return 0;
  }
  ```

---

## Task 6: Modifying Nested Structs

**Context:** Update nested struct fields via functions.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Address {
    string street;
    string barangay;
    string city;
};

struct Resident {
    string name;
    Address address;
};

void updateAddress(Resident& r, string newStreet, string newBarangay) {
    r.address.street = newStreet;
    r.address.barangay = newBarangay;
    cout << "Address updated for " << r.name << endl;
}

void displayResident(const Resident& r) {
    cout << "Name: " << r.name << endl;
    cout << "Address: " << r.address.street << ", " 
         << r.address.barangay << ", " 
         << r.address.city << endl;
}

int main() {
    Resident r = {"Juan Dela Cruz", {"123 Main St", "Poblacion", "Iloilo City"}};
    
    cout << "Before:" << endl;
    displayResident(r);
    cout << endl;
    
    updateAddress(r, "456 New Ave", "San Jose");
    
    cout << "\nAfter:" << endl;
    displayResident(r);
    
    return 0;
}
```

# Tasks for Learners

- Update nested struct fields via functions using pass-by-reference.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Address {
      string street;
      string barangay;
      string city;
  };

  struct Resident {
      string name;
      Address address;
  };

  void updateAddress(Resident& r, string newStreet, string newBarangay) {
      r.address.street = newStreet;
      r.address.barangay = newBarangay;
      cout << "Address updated for " << r.name << endl;
  }

  void displayResident(const Resident& r) {
      cout << "Name: " << r.name << endl;
      cout << "Address: " << r.address.street << ", " 
           << r.address.barangay << ", " 
           << r.address.city << endl;
  }

  int main() {
      Resident r = {"Juan Dela Cruz", {"123 Main St", "Poblacion", "Iloilo City"}};
      
      cout << "Before:" << endl;
      displayResident(r);
      cout << endl;
      
      updateAddress(r, "456 New Ave", "San Jose");
      
      cout << "\nAfter:" << endl;
      displayResident(r);
      
      return 0;
  }
  ```

---

## Task 7: Complete Barangay Database

**Context:** Build professional database with nested structures.

**Challenge:** Register residents with complete hierarchical data.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

struct Contact {
    string phone;
    string email;
};

struct Address {
    string street;
    string barangay;
    string city;
    string province;
    string zipCode;
};

struct Resident {
    int id;
    string name;
    int age;
    Address address;
    Contact contact;
};

void displayResident(const Resident& r) {
    cout << "\n" << string(50, '=') << endl;
    cout << "ID: " << r.id << endl;
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "\nAddress:" << endl;
    cout << "  Street: " << r.address.street << endl;
    cout << "  Barangay: " << r.address.barangay << endl;
    cout << "  City: " << r.address.city << endl;
    cout << "  Province: " << r.address.province << endl;
    cout << "  Zip: " << r.address.zipCode << endl;
    cout << "\nContact:" << endl;
    cout << "  Phone: " << r.contact.phone << endl;
    cout << "  Email: " << r.contact.email << endl;
}

void displaySummary(Resident residents[], int count) {
    cout << "\n=== RESIDENT SUMMARY ===" << endl;
    cout << left << setw(5) << "ID" 
         << setw(20) << "Name" 
         << setw(5) << "Age" 
         << setw(15) << "Barangay" << endl;
    cout << string(45, '-') << endl;
    
    for (int i = 0; i < count; i++) {
        cout << left << setw(5) << residents[i].id
             << setw(20) << residents[i].name
             << setw(5) << residents[i].age
             << setw(15) << residents[i].address.barangay << endl;
    }
}

int main() {
    const int MAX_RESIDENTS = 10;
    Resident residents[MAX_RESIDENTS];
    int count = 0;
    
    cout << "=== BARANGAY DATABASE SYSTEM ===" << endl;
    
    char addMore = 'y';
    while (addMore == 'y' && count < MAX_RESIDENTS) {
        cout << "\n--- Register Resident " << (count + 1) << " ---" << endl;
        
        residents[count].id = count + 1;
        
        cin.ignore();
        cout << "Name: ";
        getline(cin, residents[count].name);
        
        cout << "Age: ";
        cin >> residents[count].age;
        
        cin.ignore();
        cout << "Street: ";
        getline(cin, residents[count].address.street);
        
        cout << "Barangay: ";
        getline(cin, residents[count].address.barangay);
        
        cout << "City: ";
        getline(cin, residents[count].address.city);
        
        cout << "Province: ";
        getline(cin, residents[count].address.province);
        
        cout << "Zip Code: ";
        getline(cin, residents[count].address.zipCode);
        
        cout << "Phone: ";
        getline(cin, residents[count].contact.phone);
        
        cout << "Email: ";
        getline(cin, residents[count].contact.email);
        
        count++;
        
        if (count < MAX_RESIDENTS) {
            cout << "\nAdd another resident? (y/n): ";
            cin >> addMore;
        }
    }
    
    displaySummary(residents, count);
    
    cout << "\n\nView detailed info? Enter ID (0 to skip): ";
    int viewID;
    cin >> viewID;
    
    if (viewID > 0 && viewID <= count) {
        displayResident(residents[viewID - 1]);
    }
    
    return 0;
}
```

# Tasks for Learners

- Build a professional database with nested structures to register residents with complete hierarchical data.

  ```cpp
  #include <iostream>
  #include <string>
  #include <iomanip>
  using namespace std;

  struct Contact {
      string phone;
      string email;
  };

  struct Address {
      string street;
      string barangay;
      string city;
      string province;
      string zipCode;
  };

  struct Resident {
      int id;
      string name;
      int age;
      Address address;
      Contact contact;
  };

  void displayResident(const Resident& r) {
      cout << "\n" << string(50, '=') << endl;
      cout << "ID: " << r.id << endl;
      cout << "Name: " << r.name << endl;
      cout << "Age: " << r.age << endl;
      cout << "\nAddress:" << endl;
      cout << "  Street: " << r.address.street << endl;
      cout << "  Barangay: " << r.address.barangay << endl;
      cout << "  City: " << r.address.city << endl;
      cout << "  Province: " << r.address.province << endl;
      cout << "  Zip: " << r.address.zipCode << endl;
      cout << "\nContact:" << endl;
      cout << "  Phone: " << r.contact.phone << endl;
      cout << "  Email: " << r.contact.email << endl;
  }

  void displaySummary(Resident residents[], int count) {
      cout << "\n=== RESIDENT SUMMARY ===" << endl;
      cout << left << setw(5) << "ID" 
           << setw(20) << "Name" 
           << setw(5) << "Age" 
           << setw(15) << "Barangay" << endl;
      cout << string(45, '-') << endl;
      
      for (int i = 0; i < count; i++) {
          cout << left << setw(5) << residents[i].id
               << setw(20) << residents[i].name
               << setw(5) << residents[i].age
               << setw(15) << residents[i].address.barangay << endl;
      }
  }

  int main() {
      const int MAX_RESIDENTS = 10;
      Resident residents[MAX_RESIDENTS];
      int count = 0;
      
      cout << "=== BARANGAY DATABASE SYSTEM ===" << endl;
      
      char addMore = 'y';
      while (addMore == 'y' && count < MAX_RESIDENTS) {
          cout << "\n--- Register Resident " << (count + 1) << " ---" << endl;
          
          residents[count].id = count + 1;
          
          cin.ignore();
          cout << "Name: ";
          getline(cin, residents[count].name);
          
          cout << "Age: ";
          cin >> residents[count].age;
          
          cin.ignore();
          cout << "Street: ";
          getline(cin, residents[count].address.street);
          
          cout << "Barangay: ";
          getline(cin, residents[count].address.barangay);
          
          cout << "City: ";
          getline(cin, residents[count].address.city);
          
          cout << "Province: ";
          getline(cin, residents[count].address.province);
          
          cout << "Zip Code: ";
          getline(cin, residents[count].address.zipCode);
          
          cout << "Phone: ";
          getline(cin, residents[count].contact.phone);
          
          cout << "Email: ";
          getline(cin, residents[count].contact.email);
          
          count++;
          
          if (count < MAX_RESIDENTS) {
              cout << "\nAdd another resident? (y/n): ";
              cin >> addMore;
          }
      }
      
      displaySummary(residents, count);
      
      cout << "\n\nView detailed info? Enter ID (0 to skip): ";
      int viewID;
      cin >> viewID;
      
      if (viewID > 0 && viewID <= count) {
          displayResident(residents[viewID - 1]);
      }
      
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Nested Struct Guide</strong></summary>

**Syntax:**
```cpp
struct Inner {
    type1 field1;
};

struct Outer {
    type2 field2;
    Inner nested;  // Contains another struct
};

Outer obj;
obj.nested.field1 = value;  // Access with dot notation
```

**Benefits:**
1. **Organization:** Group related data logically
2. **Reusability:** Use `Address` struct in `Resident`, `Business`, `School`
3. **Maintainability:** Change `Address` once, affects all users
4. **Clarity:** `resident.address.street` is self-documenting

**Comparison:**

**Before (Flat Structure - Messy):**
```cpp
struct Resident {
    string name;
    string street;
    string barangay;
    string city;
    string phone;
    string email;
    // 20+ fields...
};
```

**After (Nested Structure - Clean):**
```cpp
struct Address {
    string street;
    string barangay;
    string city;
};

struct Contact {
    string phone;
    string email;
};

struct Resident {
    string name;
    Address address;
    Contact contact;
};
```

**Access Levels:**
```cpp
Resident r;
r.name                     // Level 1
r.address.street          // Level 2
r.address.barangay        // Level 2
r.contact.phone           // Level 2
```

**Initialization:**
```cpp
// Nested initialization
Resident r = {
    "Juan",
    {"123 St", "Poblacion", "Iloilo"},
    {"0917", "email"}
};
```

**Real-World Examples:**
- Person → Address → GPS Coordinates
- Order → Customer → Payment Info
- Employee → Department → Company
- Student → Grades → Subjects

</details>

---

**Nested structs model the real world!** Everything has hierarchy—master this before moving to classes!
