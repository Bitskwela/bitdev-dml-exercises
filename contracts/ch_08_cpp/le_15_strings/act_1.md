# Lesson 15 Activities: Strings

## Text is Data Too

Every app needs text: usernames, messages, addresses, commands. In C++, you have **two choices:**

1. **C-strings:** `char name[50];` - Character arrays with null terminator `\0`
2. **C++ strings:** `string name;` - Modern, safer, easier

**This lesson uses both.** Legacy code uses C-strings. Modern code uses `string` class. You need to master both!

---

## Task 1: C-String Basics

**Context:** Understanding character arrays with null terminators.

**Starter Code:**
```cpp
#include <iostream>
#include <cstring>
using namespace std;

int main() {
    // C-string: array of characters ending with '\0'
    char name[50] = "Juan Dela Cruz";
    
    // String functions from <cstring>
    cout << "Name: " << name << endl;
    cout << "Length: " << strlen(name) << endl;
    
    // Copy string
    char copy[50];
    strcpy(copy, name);
    cout << "Copy: " << copy << endl;
    
    // Concatenate
    strcat(name, " Jr.");
    cout << "With suffix: " << name << endl;
    
    return 0;
}
```

**Task:** Create a C-string for your barangay address. Print its length.

---

## Task 2: C++ String Class

**Context:** Modern, safer string handling.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // C++ string (no size limit!)
    string firstName = "Juan";
    string lastName = "Dela Cruz";
    
    // Concatenation is easy
    string fullName = firstName + " " + lastName;
    cout << "Full name: " << fullName << endl;
    
    // Length method
    cout << "Length: " << fullName.length() << endl;
    
    // Substring
    string initials = fullName.substr(0, 1) + lastName.substr(0, 1);
    cout << "Initials: " << initials << endl;
    
    return 0;
}
```

**Task:** Create first and last name strings. Concatenate them with a space.

---

## Task 3: String Input with Spaces

**Context:** `cin >>` stops at whitespace. Use `getline()` for full sentences.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name, address;
    
    cout << "Enter your full name: ";
    getline(cin, name);  // Reads entire line including spaces
    
    cout << "Enter your address: ";
    getline(cin, address);
    
    cout << "\n=== REGISTRATION ===" << endl;
    cout << "Name: " << name << endl;
    cout << "Address: " << address << endl;
    
    return 0;
}
```

**Test:** Enter "Juan Dela Cruz" and "123 Main St, Iloilo City"

---

## Task 4: String Comparison

**Context:** Compare strings alphabetically or for equality.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string username = "admin";
    string password = "pass123";
    
    string inputUser, inputPass;
    
    cout << "Username: ";
    cin >> inputUser;
    cout << "Password: ";
    cin >> inputPass;
    
    if (inputUser == username && inputPass == password) {
        cout << "Login successful!" << endl;
    } else {
        cout << "Invalid credentials!" << endl;
    }
    
    return 0;
}
```

**Task:** Test with correct and incorrect credentials.

---

## Task 5: String Searching

**Context:** Find substrings within strings.

**Challenge:** Check if email contains "@" and ".com"

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string email;
    
    cout << "Enter email: ";
    cin >> email;
    
    // find() returns position or string::npos if not found
    if (email.find("@") != string::npos && email.find(".com") != string::npos) {
        cout << "Valid email format!" << endl;
    } else {
        cout << "Invalid email format!" << endl;
    }
    
    return 0;
}
```

**Test:** juan@gmail.com (valid), juangmail.com (invalid)

---

## Task 6: String Manipulation

**Context:** Modify strings with methods.

**Challenge:** Convert name to uppercase, extract initials.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int main() {
    string name;
    
    cout << "Enter full name: ";
    getline(cin, name);
    
    // Convert to uppercase
    string upperName = name;
    for (int i = 0; i < upperName.length(); i++) {
        upperName[i] = toupper(upperName[i]);
    }
    
    cout << "Uppercase: " << upperName << endl;
    
    // Extract initials (first letter + letter after space)
    string initials = "";
    initials += toupper(name[0]);
    for (int i = 0; i < name.length(); i++) {
        if (name[i] == ' ' && i + 1 < name.length()) {
            initials += toupper(name[i + 1]);
        }
    }
    
    cout << "Initials: " << initials << endl;
    
    return 0;
}
```

**Test:** "Juan Dela Cruz" → "JUAN DELA CRUZ" and "JDC"

---

## Task 7: Barangay ID Generator

**Context:** Real-world application—generate unique IDs from resident data.

**Challenge:** Create barangay ID format: BRGY-[Initials]-[Year]

**Starter Code:**
```cpp
#include <iostream>
#include <string>
#include <cctype>
using namespace std;

string extractInitials(string fullName) {
    string initials = "";
    initials += toupper(fullName[0]);
    
    for (int i = 0; i < fullName.length(); i++) {
        if (fullName[i] == ' ' && i + 1 < fullName.length()) {
            initials += toupper(fullName[i + 1]);
        }
    }
    
    return initials;
}

string generateBarangayID(string name, int year) {
    string initials = extractInitials(name);
    return "BRGY-" + initials + "-" + to_string(year);
}

int main() {
    string name;
    int year;
    
    cout << "Enter full name: ";
    getline(cin, name);
    
    cout << "Enter registration year: ";
    cin >> year;
    
    string barangayID = generateBarangayID(name, year);
    
    cout << "\n=== BARANGAY ID ===" << endl;
    cout << "Name: " << name << endl;
    cout << "ID: " << barangayID << endl;
    
    return 0;
}
```

**Test:** "Maria Santos" + 2024 → "BRGY-MS-2024"

---

<details>
<summary><strong>📝 String Reference</strong></summary>

**C-Strings (char arrays):**
```cpp
#include <cstring>
char str[50] = "Hello";
strlen(str);           // Length
strcpy(dest, src);     // Copy
strcat(str, " World"); // Concatenate
strcmp(str1, str2);    // Compare (0 = equal)
```

**C++ Strings:**
```cpp
#include <string>
string str = "Hello";
str.length() / str.size();  // Length
str + " World";              // Concatenate
str.substr(0, 5);            // Extract substring
str.find("lo");              // Find position (returns string::npos if not found)
str[0];                      // Access character
str.compare(other);          // Compare
str.empty();                 // Check if empty
```

**Input:**
- `cin >> str;` - Reads until whitespace
- `getline(cin, str);` - Reads entire line

**Character Functions (`<cctype>`):**
- `toupper(ch)` - Convert to uppercase
- `tolower(ch)` - Convert to lowercase
- `isdigit(ch)` - Check if digit
- `isalpha(ch)` - Check if letter

**Why C++ strings?**
- No buffer overflow (auto-resize)
- Easier concatenation
- Rich methods
- Still fast!

</details>

---

**Remember:** Use C++ `string` class for new code. Learn C-strings to understand legacy code!
