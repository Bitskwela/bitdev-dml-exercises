# Lesson 15 Activities: Strings

---

## Challenge 1: Name Reverser

**Objective:** Manipulate strings to reverse word order.

**Task:** Input: "Juan Dela Cruz" → Output: "Cruz Dela Juan"

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
using namespace std;

int main() {
    string fullName;
    cout << "Enter full name: ";
    getline(cin, fullName);
    
    // Split into words
    vector<string> words;
    stringstream ss(fullName);
    string word;
    
    while (ss >> word) {
        words.push_back(word);
    }
    
    // Print in reverse
    cout << "Reversed: ";
    for (int i = words.size() - 1; i >= 0; i--) {
        cout << words[i];
        if (i > 0) cout << " ";
    }
    cout << endl;
    
    return 0;
}
```

</details>

---

## Challenge 2: Vowel Counter

**Objective:** Count vowels (a, e, i, o, u) in a string.

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string text;
    cout << "Enter text: ";
    getline(cin, text);
    
    int vowelCount = 0;
    string vowels = "aeiouAEIOU";
    
    for (char c : text) {
        if (vowels.find(c) != string::npos) {
            vowelCount++;
        }
    }
    
    cout << "Vowel count: " << vowelCount << endl;
    
    return 0;
}
```

</details>

---

## Challenge 3: Palindrome Checker

**Objective:** Check if string reads same forwards/backwards.

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

int main() {
    string word;
    cout << "Enter word: ";
    cin >> word;
    
    // Convert to lowercase
    transform(word.begin(), word.end(), word.begin(), ::tolower);
    
    // Check palindrome
    string reversed = word;
    reverse(reversed.begin(), reversed.end());
    
    if (word == reversed) {
        cout << word << " is a palindrome!" << endl;
    } else {
        cout << word << " is NOT a palindrome." << endl;
    }
    
    return 0;
}
```

</details>

---

## Challenge 4: Clearance Number Generator

**Objective:** Generate clearance codes from names.

**Task:** "Juan" → "CLR-JUA-1234"

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
using namespace std;

int main() {
    srand(time(0));  // Seed random
    
    string name;
    cout << "Enter resident name: ";
    getline(cin, name);
    
    // Extract first 3 letters
    string code = "CLR-";
    for (int i = 0; i < 3 && i < name.length(); i++) {
        code += toupper(name[i]);
    }
    
    // Add random number
    int randomNum = 1000 + rand() % 9000;
    code += "-" + to_string(randomNum);
    
    cout << "Clearance Code: " << code << endl;
    
    return 0;
}
```

</details>

---

## Key Takeaways

- Use C++ `string` class (not C-strings)
- `getline()` for input with spaces
- String operations: length, substr, find, replace
- Strings are mutable and dynamic

**Next:** Lesson 16 - Pointers (direct memory access!)
