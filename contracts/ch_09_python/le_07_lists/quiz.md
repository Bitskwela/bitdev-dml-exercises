# Quiz: Lists

---

# Quiz 1

## Scenario

Tian is building a grade management system and inventory tracker. Kuya Miguel tests his understanding of Python lists.

---

## Question 1

What's the output?

```python
fruits = ["apple", "banana", "mango"]
print(fruits[1])
```

**Choices:**
- A) apple
- B) banana
- C) mango
- D) 1

**Correct Answer:** B

**Explanation:**
Lists use zero-based indexing:
- Index 0: "apple"
- Index 1: "banana"
- Index 2: "mango"

`fruits[1]` accesses the second element: "banana".

---

## Question 2

Tian wants the last item. Which is correct?

```python
numbers = [10, 20, 30, 40, 50]
```

**Choices:**
- A) `numbers[5]`
- B) `numbers[4]`
- C) `numbers[-1]`
- D) Both B and C

**Correct Answer:** D

**Explanation:**
Two ways to get the last item:
- `numbers[4]` - positive index (length - 1)
- `numbers[-1]` - negative index (counts from end)

`numbers[5]` would cause IndexError (out of range).

---

## Question 3

What's the output?

```python
grades = [85, 90, 78]
grades.append(92)
print(len(grades))
```

**Choices:**
- A) 3
- B) 4
- C) 92
- D) [85, 90, 78, 92]

**Correct Answer:** B

**Explanation:**
`append()` adds an element to the end of the list. The list becomes `[85, 90, 78, 92]`, which has 4 elements. `len()` returns the number of items: 4.

---

## Question 4

What happens here?

```python
numbers = [1, 2, 3, 4, 5]
numbers.remove(3)
print(numbers)
```

**Choices:**
- A) [1, 2, 4, 5]
- B) [1, 2, 3, 4]
- C) [1, 2, 5]
- D) [1, 2, 3, 4, 5, 3]

**Correct Answer:** A

**Explanation:**
`remove(value)` removes the first occurrence of the specified value (not index). It searches for the number 3 and removes it, leaving `[1, 2, 4, 5]`.

---

## Question 5

What's the output?

```python
numbers = [1, 2, 3]
popped = numbers.pop()
print(popped)
print(numbers)
```

**Choices:**
- A) 3, [1, 2, 3]
- B) 1, [2, 3]
- C) 3, [1, 2]
- D) 2, [1, 3]

**Correct Answer:** C

**Explanation:**
`pop()` without an argument removes and returns the last element:
- Returns: 3
- List becomes: `[1, 2]`

To remove from a specific index: `pop(index)`.

---

## Question 6

What's the output?

```python
numbers = [5, 2, 8, 1, 9]
numbers.sort()
print(numbers)
```

**Choices:**
- A) [5, 2, 8, 1, 9] (unchanged)
- B) [1, 2, 5, 8, 9] (sorted)
- C) [9, 8, 5, 2, 1] (reverse)
- D) None

**Correct Answer:** B

**Explanation:**
`sort()` sorts the list in place (modifies the original list) in ascending order: `[1, 2, 5, 8, 9]`. For descending order, use `sort(reverse=True)`.

---

## Question 7

Tian slices a list. What's the output?

```python
numbers = [0, 1, 2, 3, 4, 5]
print(numbers[1:4])
```

**Choices:**
- A) [1, 2, 3]
- B) [1, 2, 3, 4]
- C) [0, 1, 2, 3]
- D) [2, 3, 4]

**Correct Answer:** A

**Explanation:**
Slicing syntax: `list[start:end]` (end not included)
- Start at index 1: 1
- Stop before index 4: stop at 3

Result: `[1, 2, 3]`

---

## Question 8

What's the output?

```python
numbers = [1, 2, 3, 4, 5]
print(numbers[::-1])
```

**Choices:**
- A) [1, 2, 3, 4, 5]
- B) [5, 4, 3, 2, 1]
- C) [2, 3, 4, 5]
- D) Error: invalid syntax

**Correct Answer:** B

**Explanation:**
`[::-1]` is a slice with step -1, which reverses the list: `[5, 4, 3, 2, 1]`. This is a common Python trick for reversing sequences without using `reverse()`.

---

# Quiz 2

## Scenario

Tian continues learning about lists with more advanced operations. Kuya Miguel tests his mastery of list manipulation.

---

## Question 1

What's the output?

```python
grades = [85, 90, 78, 85, 92]
count = grades.count(85)
print(count)
```

**Choices:**
- A) 0
- B) 1
- C) 2
- D) 5

**Correct Answer:** C

**Explanation:**
`count(value)` returns how many times a value appears in the list. The number 85 appears twice (at indices 0 and 3), so the count is 2.

---

## Question 10

Tian creates a list comprehension. What's the output?

```python
squares = [x**2 for x in range(1, 6)]
print(squares)
```

**Choices:**
- A) [1, 2, 3, 4, 5]
- B) [1, 4, 9, 16, 25]
- C) [2, 4, 6, 8, 10]
- D) [0, 1, 4, 9, 16]

**Correct Answer:** B

**Explanation:**
List comprehension creates a new list by applying an expression to each item:
- x=1: 1² = 1
- x=2: 2² = 4
- x=3: 3² = 9
- x=4: 4² = 16
- x=5: 5² = 25

Result: `[1, 4, 9, 16, 25]`

---

## Question 11

What's the output?

```python
numbers = [1, 2, 3, 4, 5, 6]
evens = [x for x in numbers if x % 2 == 0]
print(evens)
```

**Choices:**
- A) [1, 3, 5]
- B) [2, 4, 6]
- C) [1, 2, 3, 4, 5, 6]
- D) []

**Correct Answer:** B

**Explanation:**
List comprehension with condition: `[expression for item in list if condition]`

Only includes items where `x % 2 == 0` (even numbers): `[2, 4, 6]`

---

## Question 12

What happens here?

```python
list1 = [1, 2, 3]
list2 = list1
list2.append(4)
print(list1)
```

**Choices:**
- A) [1, 2, 3]
- B) [1, 2, 3, 4]
- C) [4]
- D) Error

**Correct Answer:** B

**Explanation:**
`list2 = list1` doesn't create a copy - both variables point to the same list in memory! When you modify list2, list1 changes too.

To create a true copy: `list2 = list1.copy()` or `list2 = list1[:]`

---

## Question 13

Tian loops with index. What's the output?

```python
fruits = ["apple", "banana", "mango"]
for i, fruit in enumerate(fruits):
    print(f"{i}: {fruit}")
```

**Choices:**
- A) 0: apple, 0: banana, 0: mango
- B) 1: apple, 2: banana, 3: mango
- C) 0: apple, 1: banana, 2: mango
- D) apple: 0, banana: 1, mango: 2

**Correct Answer:** C

**Explanation:**
`enumerate()` returns both index and value:
```
0: apple
1: banana
2: mango
```

To start from 1: `enumerate(fruits, start=1)`

---

## Question 14

What's the output?

```python
numbers = [1, 2, 3]
numbers.extend([4, 5])
print(numbers)
```

**Choices:**
- A) [1, 2, 3, [4, 5]]
- B) [1, 2, 3, 4, 5]
- C) [[1, 2, 3], [4, 5]]
- D) [4, 5]

**Correct Answer:** B

**Explanation:**
`extend()` adds multiple elements from an iterable to the end:
- `append([4, 5])` would add the list as a single element: `[1, 2, 3, [4, 5]]`
- `extend([4, 5])` adds each element individually: `[1, 2, 3, 4, 5]`

---

## Question 15

What's the output?

```python
numbers = [3, 1, 4, 1, 5]
result = numbers.index(1)
print(result)
```

**Choices:**
- A) 1
- B) 2
- C) [1, 3]
- D) 3

**Correct Answer:** A

**Explanation:**
`index(value)` returns the index of the FIRST occurrence of the value. The number 1 first appears at index 1, so the result is 1.

If the value isn't found, it raises a ValueError.

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- Zero-based indexing (`list[0]` is first)
- Negative indexing (`list[-1]` is last)
- `append()` adds to end
- `remove()` removes by value
- `pop()` removes by index and returns value
- `sort()` sorts in place
- Slicing: `list[start:end:step]`
- `[::-1]` reverses list

**Quiz 2:**
- `count()` counts occurrences
- `index()` finds first occurrence
- List comprehension: `[expression for item in list if condition]`
- Assignment creates reference, not copy
- `enumerate()` for index and value
- `extend()` adds multiple elements (vs `append()` for single element)

Great job! Lists are one of Python's most important data structures. Ready to learn about functions next?
