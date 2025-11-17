# Quiz: Lesson 14 - Arrays

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What is the index of the first element in an array?

A) 1  
B) 0  
C) -1  
D) Depends on the array

**Answer: B) 0**

**Explanation:**
C++ arrays use **zero-based indexing**. The first element is always at index `0`.

```cpp
int numbers[5] = {10, 20, 30, 40, 50};
//  Index:        0   1   2   3   4

cout << numbers[0];  // 10 (first element)
cout << numbers[4];  // 50 (last element)
```

---

### Question 2
What's the valid index range for an array of size 10?

A) 1 to 10  
B) 0 to 10  
C) 0 to 9  
D) 1 to 9

**Answer: C) 0 to 9**

**Explanation:**
For an array of size N, valid indices are `0` to `N-1`.

```cpp
int arr[10];  // Size 10
// Valid: arr[0], arr[1], ..., arr[9]
// Invalid: arr[10] (out of bounds!)
```

---

### Question 3
What's the output?
```cpp
int ages[3] = {25, 30, 28};
ages[1] = 35;
cout << ages[1];
```

A) `25`  
B) `30`  
C) `35`  
D) `28`

**Answer: C) `35`**

**Explanation:**
- Initially: `ages[1] = 30`
- After assignment: `ages[1] = 35`
- Output: `35`

---

### Question 4
What happens with this initialization?
```cpp
int numbers[5] = {10, 20};
```

A) Compilation error  
B) First 2 elements are 10 and 20, rest are 0  
C) All elements are 0  
D) Rest are undefined

**Answer: B) First 2 elements are 10 and 20, rest are 0**

**Explanation:**
Partially initialized arrays set remaining elements to `0`.

```cpp
int numbers[5] = {10, 20};
// Result: {10, 20, 0, 0, 0}
```

---

### Question 5
How do you get the number of elements in an array?

```cpp
int arr[10];
// What's the element count?
```

A) `sizeof(arr)`  
B) `sizeof(arr) / sizeof(arr[0])`  
C) `arr.size()`  
D) `length(arr)`

**Answer: B) `sizeof(arr) / sizeof(arr[0])`**

**Explanation:**
```cpp
int arr[10];
int size = sizeof(arr) / sizeof(arr[0]);
// sizeof(arr) = 40 bytes (10 elements × 4 bytes each)
// sizeof(arr[0]) = 4 bytes (one int)
// size = 40 / 4 = 10
```

---


# Quiz 2

### Question 6
What's wrong with this code?
```cpp
int scores[5] = {85, 90, 78, 92, 88};

for (int i = 0; i <= 5; i++) {
    cout << scores[i] << " ";
}
```

A) Nothing wrong  
B) Index 5 is out of bounds  
C) Should start at 1  
D) Wrong initialization

**Answer: B) Index 5 is out of bounds**

**Explanation:**
Valid indices: 0 to 4. The loop accesses `scores[5]`, which doesn't exist.

**Fix:**
```cpp
for (int i = 0; i < 5; i++) {  // i < 5, not i <= 5
    cout << scores[i] << " ";
}
```

---




### Question 7
What's the output?
```cpp
int numbers[] = {10, 20, 30, 40, 50};

int sum = 0;
for (int i = 0; i < 5; i++) {
    sum += numbers[i];
}

cout << sum;
```

A) `50`  
B) `150`  
C) `10`  
D) `0`

**Answer: B) `150`**

**Explanation:**
Sum = 10 + 20 + 30 + 40 + 50 = 150

---

### Question 8
How are arrays passed to functions?

A) Pass by value (copy)  
B) Pass by reference  
C) Cannot pass arrays  
D) Depends on the function

**Answer: B) Pass by reference**

**Explanation:**
Arrays are **always passed by reference** (as pointers). Changes in the function affect the original.

```cpp
void modify(int arr[], int size) {
    arr[0] = 999;  // Modifies original array
}

int main() {
    int numbers[3] = {1, 2, 3};
    modify(numbers, 3);
    cout << numbers[0];  // 999 (changed!)
    return 0;
}
```

---

### Question 9
Find the maximum value:
```cpp
int scores[4] = {85, 92, 78, 95};

int max = scores[0];
for (int i = 1; i < 4; i++) {
    if (scores[i] > max) {
        max = scores[i];
    }
}

cout << max;
```

What's the output?

A) `85`  
B) `92`  
C) `78`  
D) `95`

**Answer: D) `95`**

**Explanation:**
- Start: `max = 85`
- i=1: `92 > 85`, so `max = 92`
- i=2: `78 < 92`, no change
- i=3: `95 > 92`, so `max = 95`
- Output: `95`

---


# Quiz 1

### Question 10
A barangay system stores 100 resident IDs. Which is the best way?

```cpp
// Option A: Individual variables
int id1, id2, id3, ... id100;

// Option B: Array
int residentIDs[100];

// Option C: 100 separate programs
```

A) Option A  
B) Option B  
C) Option C  
D) All are equivalent

**Answer: B) Option B**

**Explanation:**
**Option B** is the only practical solution:
- **Option A:** Unmanageable! 100 variables, can't use loops.
- **Option B:** ✓ Clean, can loop through all IDs easily.
- **Option C:** Ridiculous!

```cpp
int residentIDs[100];

// Easy input
for (int i = 0; i < 100; i++) {
    cin >> residentIDs[i];
}

// Easy search
for (int i = 0; i < 100; i++) {
    if (residentIDs[i] == searchID) {
        cout << "Found at index " << i;
    }
}
```

**Arrays are designed for managing collections of related data.**

---

**Score yourself:**
- 10/10: Array Master! 🏆
- 8-9: Excellent grasp!
- 6-7: Good, review indexing and loops
- Below 6: Re-read array basics

**Key Concepts:**
1. Arrays use zero-based indexing (0 to size-1)
2. Partial initialization fills rest with 0
3. Use `sizeof(arr)/sizeof(arr[0])` for size
4. Arrays passed by reference to functions
5. Always check bounds (avoid out-of-bounds access)
