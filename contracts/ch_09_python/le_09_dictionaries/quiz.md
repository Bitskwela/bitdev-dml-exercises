# Quiz: Dictionaries

---

# Quiz 1

## Scenario

Tian is building a student database and GCash account system using dictionaries to store key-value pairs. Kuya Miguel tests his understanding of this powerful data structure.

---

## Question 1

What's the output?

```python
student = {
    "name": "Tian",
    "age": 16,
    "grade": 85
}

print(student["name"])
```

**Choices:**
- A) name
- B) Tian
- C) 0
- D) Error

**Correct Answer:** B

**Explanation:**
Dictionaries use keys to access values. `student["name"]` returns the value associated with the key "name", which is "Tian".

---

## Question 2

What happens here?

```python
student = {"name": "Tian", "age": 16}
print(student["grade"])
```

**Choices:**
- A) None
- B) 0
- C) KeyError: 'grade'
- D) ""

**Correct Answer:** C

**Explanation:**
Accessing a non-existent key raises a KeyError. To avoid this, use `get()`:
```python
print(student.get("grade"))  # Returns None
print(student.get("grade", 0))  # Returns 0 (default)
```

---

## Question 3

What's the output?

```python
student = {"name": "Tian", "age": 16}
student["grade"] = 85
print(student)
```

**Choices:**
- A) {"name": "Tian", "age": 16}
- B) {"name": "Tian", "age": 16, "grade": 85}
- C) {"grade": 85}
- D) Error: cannot add new keys

**Correct Answer:** B

**Explanation:**
You can add new key-value pairs by simple assignment: `dict[new_key] = value`. The dictionary now contains three items.

---

## Question 4

What's the output?

```python
student = {"name": "Tian", "age": 16}
student["age"] = 17
print(student["age"])
```

**Choices:**
- A) 16
- B) 17
- C) [16, 17]
- D) Error: cannot modify

**Correct Answer:** B

**Explanation:**
Assigning to an existing key updates its value. `student["age"] = 17` replaces the old value (16) with the new value (17).

---

## Question 5

What's the output?

```python
prices = {"Coke": 25, "Chippy": 10, "Lucky Me": 15}
print(len(prices))
```

**Choices:**
- A) 3
- B) 50
- C) 25
- D) Error

**Correct Answer:** A

**Explanation:**
`len()` returns the number of key-value pairs in the dictionary. There are 3 items, so the output is 3.

---

## Question 6

What's the output?

```python
student = {"name": "Tian", "age": 16}
result = student.get("grade")
print(result)
```

**Choices:**
- A) 0
- B) None
- C) ""
- D) KeyError

**Correct Answer:** B

**Explanation:**
`get()` method returns the value if the key exists, or `None` if it doesn't (no error). To specify a different default: `student.get("grade", 0)` would return 0.

---

## Question 7

What's the output?

```python
account = {"name": "Tian", "balance": 1000}
del account["balance"]
print("balance" in account)
```

**Choices:**
- A) True
- B) False
- C) 1000
- D) Error

**Correct Answer:** B

**Explanation:**
`del` removes the key-value pair from the dictionary. After deletion, checking `"balance" in account` returns `False` because the key no longer exists.

---

## Question 8

What's the output?

```python
student = {"name": "Tian", "age": 16, "grade": 85}
keys = list(student.keys())
print(keys)
```

**Choices:**
- A) ["name", "age", "grade"]
- B) ["Tian", 16, 85]
- C) [("name", "Tian"), ("age", 16), ("grade", 85)]
- D) 3

**Correct Answer:** A

**Explanation:**
`keys()` returns a view of all keys in the dictionary. Converting to a list gives: `["name", "age", "grade"]`. For values, use `values()`. For key-value pairs, use `items()`.

---

# Quiz 2

## Scenario

Tian continues learning dictionaries with more advanced operations. Kuya Miguel tests his mastery of this data structure.

---

## Question 1

How many times does the loop run?

```python
student = {"name": "Tian", "age": 16, "grade": 85}

for key in student:
    print(key)
```

**Choices:**
- A) 0 times
- B) 1 time
- C) 3 times
- D) Infinite loop

**Correct Answer:** C

**Explanation:**
Looping through a dictionary iterates over its keys. There are 3 keys ("name", "age", "grade"), so the loop runs 3 times, printing each key.

---

## Question 10

What's the output?

```python
student = {"name": "Tian", "age": 16}

for key, value in student.items():
    print(f"{key}: {value}")
```

**Choices:**
- A) Prints keys only
- B) Prints values only
- C) Prints key: value pairs
- D) Error

**Correct Answer:** C

**Explanation:**
`items()` returns key-value pairs. The loop unpacks each pair:
```
name: Tian
age: 16
```

This is the most common way to loop through dictionaries.

---

## Question 11

What's the output?

```python
dict1 = {"a": 1, "b": 2}
dict2 = {"b": 3, "c": 4}

dict1.update(dict2)
print(dict1)
```

**Choices:**
- A) {"a": 1, "b": 2}
- B) {"a": 1, "b": 3, "c": 4}
- C) {"b": 3, "c": 4}
- D) Error: cannot merge

**Correct Answer:** B

**Explanation:**
`update()` merges dictionaries. If keys exist in both, the newer value (from dict2) wins:
- "a": 1 (only in dict1)
- "b": 3 (updated from 2 to 3)
- "c": 4 (added from dict2)

---

## Question 12

What's the output?

```python
students = {
    "2024001": {"name": "Tian", "grade": 85},
    "2024002": {"name": "Juan", "grade": 90}
}

print(students["2024001"]["name"])
```

**Choices:**
- A) 2024001
- B) Tian
- C) 85
- D) Error

**Correct Answer:** B

**Explanation:**
This is a nested dictionary. Access works from outer to inner:
1. `students["2024001"]` → `{"name": "Tian", "grade": 85}`
2. `["name"]` → "Tian"

---

## Question 13

What's the output?

```python
scores = {"Math": 85, "Science": 90, "English": 78}
result = scores.pop("Science")
print(result)
print(len(scores))
```

**Choices:**
- A) None and 3
- B) 90 and 2
- C) Science and 2
- D) 90 and 3

**Correct Answer:** B

**Explanation:**
`pop(key)` removes the key-value pair and returns the value:
- Returns: 90
- Dictionary now has 2 items left (Math and English)

---

## Question 14

What's the output?

```python
word_count = {}
word = "python"

if word in word_count:
    word_count[word] += 1
else:
    word_count[word] = 1

print(word_count)
```

**Choices:**
- A) {}
- B) {"python": 0}
- C) {"python": 1}
- D) Error

**Correct Answer:** C

**Explanation:**
Since "python" is not in the empty dictionary, the else block executes, setting `word_count["python"] = 1`.

This pattern is common for counting occurrences. Alternatively, use:
```python
word_count[word] = word_count.get(word, 0) + 1
```

---

## Question 15

What's the output?

```python
numbers = {1: "one", 2: "two", 3: "three"}
result = {value: key for key, value in numbers.items()}
print(result)
```

**Choices:**
- A) {1: "one", 2: "two", 3: "three"}
- B) {"one": 1, "two": 2, "three": 3}
- C) {(1, "one"), (2, "two"), (3, "three")}
- D) Error

**Correct Answer:** B

**Explanation:**
Dictionary comprehension creates a new dictionary by swapping keys and values:
- Original: 1→"one", 2→"two", 3→"three"
- Result: "one"→1, "two"→2, "three"→3

Syntax: `{new_key: new_value for key, value in dict.items()}`

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- Creating dictionaries: `{"key": value}`
- Accessing values: `dict[key]` (raises KeyError if missing)
- Safe access: `dict.get(key, default)`
- Adding/updating: `dict[key] = value`
- Deleting: `del dict[key]`
- Checking membership: `key in dict`
- Dictionary methods: `keys()`, `values()`, `items()`
- `len()` returns number of key-value pairs

**Quiz 2:**
- Looping through dictionaries: `for key in dict` or `for key, value in dict.items()`
- `update()` merges dictionaries
- Nested dictionaries: `dict[key1][key2]`
- `pop(key)` removes and returns value
- Counting pattern with `get()`
- Dictionary comprehension: `{k: v for k, v in ...}`
- Common patterns for dictionary manipulation

Excellent! Dictionaries are extremely powerful for structured data. Ready for the final lesson on file handling?
