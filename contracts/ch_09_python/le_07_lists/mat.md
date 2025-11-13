# Lesson 7: Lists

## Background Story

"Kuya, what if I need to store many items - like all my grades, or names of classmates?" Tian asked. "Do I need separate variables for each?"

"That's where **lists** come in!" Kuya Miguel explained. "Lists let you store multiple items in one variable. Think of it like a shopping list or a playlist - one container holding many items in order!"

## Creating Lists

### Basic Syntax

```python
list_name = [item1, item2, item3]
```

**Examples:**
```python
# List of numbers
grades = [85, 90, 78, 92, 88]

# List of strings
fruits = ["apple", "banana", "mango", "orange"]

# Mixed types (possible but not recommended)
mixed = [1, "hello", 3.14, True]

# Empty list
empty = []
```

## Accessing List Elements

### Indexing (Starts at 0!)

```python
fruits = ["apple", "banana", "mango", "orange"]

print(fruits[0])  # apple (first item)
print(fruits[1])  # banana
print(fruits[2])  # mango
print(fruits[3])  # orange
```

**Index diagram:**
```
["apple", "banana", "mango", "orange"]
    0        1        2        3      (positive indices)
   -4       -3       -2       -1      (negative indices)
```

### Negative Indexing

```python
fruits = ["apple", "banana", "mango", "orange"]

print(fruits[-1])  # orange (last item)
print(fruits[-2])  # mango (second to last)
print(fruits[-3])  # banana
print(fruits[-4])  # apple (first item)
```

### IndexError

**Be careful not to exceed list length!**

```python
fruits = ["apple", "banana"]

print(fruits[5])  # IndexError: list index out of range
```

**Check length first:**
```python
if len(fruits) > 5:
    print(fruits[5])
else:
    print("Index out of range")
```

## List Length

**Use `len()` function:**

```python
fruits = ["apple", "banana", "mango"]
print(len(fruits))  # 3

grades = [85, 90, 78, 92, 88]
print(len(grades))  # 5

empty = []
print(len(empty))  # 0
```

## Modifying Lists

### Change Element

```python
fruits = ["apple", "banana", "mango"]
print(fruits)  # ['apple', 'banana', 'mango']

fruits[1] = "orange"
print(fruits)  # ['apple', 'orange', 'mango']
```

### Add Elements

**`append()` - Add to end:**
```python
fruits = ["apple", "banana"]
fruits.append("mango")
print(fruits)  # ['apple', 'banana', 'mango']
```

**`insert()` - Add at specific position:**
```python
fruits = ["apple", "mango"]
fruits.insert(1, "banana")  # Insert at index 1
print(fruits)  # ['apple', 'banana', 'mango']
```

### Remove Elements

**`remove()` - Remove by value:**
```python
fruits = ["apple", "banana", "mango"]
fruits.remove("banana")
print(fruits)  # ['apple', 'mango']
```

**Note:** Removes first occurrence only
```python
numbers = [1, 2, 3, 2, 4]
numbers.remove(2)  # Removes first 2
print(numbers)  # [1, 3, 2, 4]
```

**`pop()` - Remove by index (returns removed item):**
```python
fruits = ["apple", "banana", "mango"]
removed = fruits.pop(1)  # Remove index 1
print(removed)  # banana
print(fruits)  # ['apple', 'mango']

# No index = remove last item
last = fruits.pop()
print(last)  # mango
print(fruits)  # ['apple']
```

**`del` - Delete by index:**
```python
fruits = ["apple", "banana", "mango"]
del fruits[1]
print(fruits)  # ['apple', 'mango']

# Delete entire list
del fruits
# print(fruits)  # NameError: fruits doesn't exist
```

**`clear()` - Remove all elements:**
```python
fruits = ["apple", "banana", "mango"]
fruits.clear()
print(fruits)  # []
```

## List Slicing

**Extract portion of list: `list[start:end]`** (end not included)

```python
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

print(numbers[2:5])  # [2, 3, 4]
print(numbers[0:3])  # [0, 1, 2]
print(numbers[5:])   # [5, 6, 7, 8, 9] (from 5 to end)
print(numbers[:4])   # [0, 1, 2, 3] (from start to 4)
print(numbers[:])    # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] (entire list)
```

**With step: `list[start:end:step]`**
```python
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

print(numbers[0:10:2])  # [0, 2, 4, 6, 8] (every 2nd)
print(numbers[::3])     # [0, 3, 6, 9] (every 3rd)
print(numbers[::-1])    # [9, 8, 7, 6, 5, 4, 3, 2, 1, 0] (reversed!)
```

## Useful List Methods

### `count()` - Count occurrences

```python
numbers = [1, 2, 3, 2, 4, 2, 5]
print(numbers.count(2))  # 3
```

### `index()` - Find first index of value

```python
fruits = ["apple", "banana", "mango"]
print(fruits.index("banana"))  # 1

# ValueError if not found
# print(fruits.index("grape"))  # ValueError!
```

**Check before finding:**
```python
if "grape" in fruits:
    print(fruits.index("grape"))
else:
    print("Not found")
```

### `sort()` - Sort in place

```python
numbers = [3, 1, 4, 1, 5, 9, 2]
numbers.sort()
print(numbers)  # [1, 1, 2, 3, 4, 5, 9]

# Reverse order
numbers.sort(reverse=True)
print(numbers)  # [9, 5, 4, 3, 2, 1, 1]
```

**Strings:**
```python
fruits = ["mango", "apple", "banana"]
fruits.sort()
print(fruits)  # ['apple', 'banana', 'mango']
```

### `sorted()` - Return sorted copy (doesn't modify original)

```python
numbers = [3, 1, 4, 1, 5]
sorted_nums = sorted(numbers)
print(numbers)      # [3, 1, 4, 1, 5] (unchanged)
print(sorted_nums)  # [1, 1, 3, 4, 5]
```

### `reverse()` - Reverse in place

```python
numbers = [1, 2, 3, 4, 5]
numbers.reverse()
print(numbers)  # [5, 4, 3, 2, 1]
```

### `extend()` - Add multiple elements

```python
fruits = ["apple", "banana"]
fruits.extend(["mango", "orange"])
print(fruits)  # ['apple', 'banana', 'mango', 'orange']

# Same as
fruits = fruits + ["mango", "orange"]
```

## Checking Membership

**`in` operator:**
```python
fruits = ["apple", "banana", "mango"]

if "banana" in fruits:
    print("We have bananas!")

if "grape" not in fruits:
    print("No grapes")
```

## Looping Through Lists

### Method 1: Loop through items

```python
fruits = ["apple", "banana", "mango"]

for fruit in fruits:
    print(fruit)

# Output:
# apple
# banana
# mango
```

### Method 2: Loop with index

```python
fruits = ["apple", "banana", "mango"]

for i in range(len(fruits)):
    print(f"{i}: {fruits[i]}")

# Output:
# 0: apple
# 1: banana
# 2: mango
```

### Method 3: Loop with enumerate

```python
fruits = ["apple", "banana", "mango"]

for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")

# Output:
# 0: apple
# 1: banana
# 2: mango
```

**Start counting from 1:**
```python
for index, fruit in enumerate(fruits, start=1):
    print(f"{index}: {fruit}")

# Output:
# 1: apple
# 2: banana
# 3: mango
```

## List Comprehension

**Create lists in one line - elegant and fast!**

**Syntax:** `[expression for item in iterable]`

**Traditional way:**
```python
squares = []
for i in range(1, 6):
    squares.append(i ** 2)
print(squares)  # [1, 4, 9, 16, 25]
```

**List comprehension:**
```python
squares = [i ** 2 for i in range(1, 6)]
print(squares)  # [1, 4, 9, 16, 25]
```

**More examples:**
```python
# Double each number
numbers = [1, 2, 3, 4, 5]
doubled = [n * 2 for n in numbers]
print(doubled)  # [2, 4, 6, 8, 10]

# Convert to uppercase
fruits = ["apple", "banana", "mango"]
upper_fruits = [fruit.upper() for fruit in fruits]
print(upper_fruits)  # ['APPLE', 'BANANA', 'MANGO']
```

### With Condition

**Syntax:** `[expression for item in iterable if condition]`

```python
# Even numbers only
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens = [n for n in numbers if n % 2 == 0]
print(evens)  # [2, 4, 6, 8, 10]

# Passing grades only
grades = [85, 60, 90, 55, 78, 92]
passing = [g for g in grades if g >= 75]
print(passing)  # [85, 90, 78, 92]
```

## Practical Examples

### Example 1: Grade Calculator

```python
print("Enter grades (type 'done' to finish):")
grades = []

while True:
    grade = input("Grade: ")
    if grade.lower() == "done":
        break
    grades.append(float(grade))

if len(grades) > 0:
    average = sum(grades) / len(grades)
    highest = max(grades)
    lowest = min(grades)
    
    print(f"\nTotal grades: {len(grades)}")
    print(f"Average: {average:.2f}")
    print(f"Highest: {highest}")
    print(f"Lowest: {lowest}")
    print(f"Passing: {sum(1 for g in grades if g >= 75)}")
else:
    print("No grades entered")
```

### Example 2: Shopping Cart

```python
cart = []
prices = []

print("=== Shopping Cart ===")
print("Commands: add, remove, view, total, checkout")

while True:
    command = input("\nCommand: ").lower()
    
    if command == "add":
        item = input("Item name: ")
        price = float(input("Price: "))
        cart.append(item)
        prices.append(price)
        print(f"Added {item}")
    
    elif command == "remove":
        item = input("Item to remove: ")
        if item in cart:
            index = cart.index(item)
            cart.pop(index)
            prices.pop(index)
            print(f"Removed {item}")
        else:
            print("Item not found")
    
    elif command == "view":
        if len(cart) == 0:
            print("Cart is empty")
        else:
            print("\n=== Your Cart ===")
            for i, item in enumerate(cart):
                print(f"{i+1}. {item} - ₱{prices[i]:.2f}")
    
    elif command == "total":
        total = sum(prices)
        print(f"Total: ₱{total:,.2f}")
    
    elif command == "checkout":
        if len(cart) == 0:
            print("Cart is empty")
        else:
            total = sum(prices)
            print("\n=== Receipt ===")
            for item, price in zip(cart, prices):
                print(f"{item}: ₱{price:.2f}")
            print(f"Total: ₱{total:,.2f}")
            break
```

### Example 3: To-Do List Manager

```python
tasks = []

print("=== To-Do List ===")

while True:
    print("\n1. Add task")
    print("2. View tasks")
    print("3. Complete task")
    print("4. Exit")
    
    choice = input("\nChoice: ")
    
    if choice == "1":
        task = input("Task: ")
        tasks.append(task)
        print("Task added!")
    
    elif choice == "2":
        if len(tasks) == 0:
            print("No tasks")
        else:
            print("\n=== Tasks ===")
            for i, task in enumerate(tasks, start=1):
                print(f"{i}. {task}")
    
    elif choice == "3":
        if len(tasks) == 0:
            print("No tasks to complete")
        else:
            for i, task in enumerate(tasks, start=1):
                print(f"{i}. {task}")
            num = int(input("Task number to complete: "))
            if 1 <= num <= len(tasks):
                completed = tasks.pop(num - 1)
                print(f"Completed: {completed}")
            else:
                print("Invalid number")
    
    elif choice == "4":
        print("Goodbye!")
        break
```

### Example 4: Sari-Sari Store Inventory

```python
items = ["Coke", "Chippy", "Lucky Me", "Tide", "Safeguard"]
stock = [50, 30, 40, 20, 15]
prices = [25, 10, 15, 12, 35]

print("=== Sari-Sari Store Inventory ===\n")

for i in range(len(items)):
    status = "LOW" if stock[i] < 20 else "OK"
    print(f"{items[i]:<15} Stock: {stock[i]:<5} ₱{prices[i]:<6.2f} [{status}]")

# Total inventory value
total_value = sum(stock[i] * prices[i] for i in range(len(items)))
print(f"\nTotal inventory value: ₱{total_value:,.2f}")

# Low stock items
low_stock = [items[i] for i in range(len(items)) if stock[i] < 20]
if low_stock:
    print(f"Low stock items: {', '.join(low_stock)}")
```

## Common List Operations Summary

```python
# Create
my_list = [1, 2, 3]

# Access
first = my_list[0]
last = my_list[-1]

# Modify
my_list[0] = 10

# Add
my_list.append(4)       # Add to end
my_list.insert(0, 0)    # Add at position
my_list.extend([5, 6])  # Add multiple

# Remove
my_list.remove(3)       # Remove by value
popped = my_list.pop()  # Remove last (or by index)
del my_list[0]          # Delete by index
my_list.clear()         # Remove all

# Info
length = len(my_list)
count = my_list.count(2)
index = my_list.index(3)

# Check
if 2 in my_list:
    print("Found")

# Sort
my_list.sort()
my_list.reverse()

# Loop
for item in my_list:
    print(item)
```

## Programming Exercises

### Exercise 1: Remove Duplicates

**Task:** Remove duplicate values from list.

**Solution:**
```python
numbers = [1, 2, 3, 2, 4, 3, 5, 1]
unique = []

for num in numbers:
    if num not in unique:
        unique.append(num)

print(unique)  # [1, 2, 3, 4, 5]

# OR using set
unique = list(set(numbers))
```

### Exercise 2: Find Second Largest

**Task:** Find second largest number.

**Solution:**
```python
numbers = [10, 30, 20, 50, 40]
numbers.sort(reverse=True)
second = numbers[1]
print(second)  # 40
```

### Exercise 3: List Intersection

**Task:** Find common elements in two lists.

**Solution:**
```python
list1 = [1, 2, 3, 4, 5]
list2 = [3, 4, 5, 6, 7]

common = [x for x in list1 if x in list2]
print(common)  # [3, 4, 5]
```

### Exercise 4: Rotate List

**Task:** Rotate list by n positions.

**Solution:**
```python
numbers = [1, 2, 3, 4, 5]
n = 2

rotated = numbers[n:] + numbers[:n]
print(rotated)  # [3, 4, 5, 1, 2]
```

## Common Mistakes

### Mistake 1: Modifying List While Looping

**Wrong:**
```python
numbers = [1, 2, 3, 4, 5]
for num in numbers:
    if num % 2 == 0:
        numbers.remove(num)  # Can cause issues!
```

**Correct:**
```python
numbers = [1, 2, 3, 4, 5]
numbers = [num for num in numbers if num % 2 != 0]
```

### Mistake 2: Copying Lists

**Wrong:**
```python
list1 = [1, 2, 3]
list2 = list1  # This doesn't copy!
list2.append(4)
print(list1)  # [1, 2, 3, 4] (also modified!)
```

**Correct:**
```python
list2 = list1.copy()  # OR list1[:]
```

### Mistake 3: Index Out of Range

**Wrong:**
```python
fruits = ["apple", "banana"]
print(fruits[2])  # IndexError!
```

**Correct:**
```python
if len(fruits) > 2:
    print(fruits[2])
```

## Summary

**Key Takeaways:**

1. **Create:** `my_list = [item1, item2, item3]`
2. **Access:** `my_list[0]` (zero-indexed), `my_list[-1]` (last)
3. **Modify:** `my_list[0] = new_value`
4. **Add:** `append()`, `insert()`, `extend()`
5. **Remove:** `remove()`, `pop()`, `del`, `clear()`
6. **Methods:** `sort()`, `reverse()`, `count()`, `index()`
7. **Slicing:** `my_list[start:end:step]`
8. **Comprehension:** `[expression for item in list if condition]`

**Next Lesson Preview:**
In Lesson 8, you'll learn about **functions** - how to organize your code into reusable blocks, pass parameters, and return values!

Ready to write cleaner, more organized code? Let's continue!
