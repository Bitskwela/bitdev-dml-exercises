# Strings

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+15.0+-+COVER.png)

## Scene

Tian could store ages, balances, and counts easily, but the moment he needed to store a resident's name or address, he was stuck. "Kuya, every real application needs text -- usernames, messages, file names. How do I handle text in C++?"

Kuya Miguel nodded. "The answer is **strings** -- sequences of characters with built-in tools to manipulate them. C++ gives you two approaches: C-style strings, which are raw character arrays, and modern `std::string`, which is a high-level class with methods for concatenation, searching, and more."

"It's like comparing a manual transmission to an automatic," Kuya Miguel explained. "Both get you there, but `std::string` is easier for everyday use. Every search engine, chat app, and database relies on string manipulation. Let's master text handling!"

## C++ Topics: Strings

![15.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+15.1.png)

### The `string` Class

> Include `<string>` and declare with `string name = "Juan";`. Unlike C-style char arrays, `std::string` handles memory automatically and provides built-in methods.

### Concatenation

> Join strings with the `+` operator: `string full = first + " " + last;`. This creates a new string from the combined pieces.

### String Length

> Use `.length()` or `.size()` to get the number of characters in a string. Both return the same value.

### Character Access

> Access individual characters with bracket notation: `name[0]` gets the first character. You can also modify characters this way: `name[0] = 'R';`.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string firstName = "Juan";
    string lastName = "Dela Cruz";

    string fullName = firstName + " " + lastName;

    cout << "Full Name: " << fullName << endl;
    cout << "Length: " << fullName.length() << " characters" << endl;

    fullName[0] = 'R';
    cout << "Modified: " << fullName << endl;
    return 0;
}
```

The `+` operator concatenates strings. `.length()` returns the character count. Bracket notation accesses and modifies individual characters by index.
