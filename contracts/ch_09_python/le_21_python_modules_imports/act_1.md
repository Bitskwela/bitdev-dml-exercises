# Python Modules and Imports Activity

Practice organizing code with modules.

### Task 1: Import datetime
```python
# Your code: import datetime and print today's date
import datetime
today = datetime.date.today()
print(f"Today: {today}")
```

### Task 2: Create Custom Module
```python
# File: helper.py
def validate_age(age):
    # Your code
    return 16 <= age <= 25

# File: main.py
# Your code: import validate_age and test it
from helper import validate_age
print(validate_age(20))  # True
print(validate_age(30))  # False
```

### Task 3: Module Alias
```python
# Your code: import pandas as pd
import pandas as pd
df = pd.DataFrame({"name": ["Ana", "Ben"], "age": [20, 22]})
print(df)
```

### Task 4: __name__ Pattern
```python
def main():
    print("Running main function")

# Your code: add __name__ check
if __name__ == "__main__":
    main()
```

## Reflection
**Two benefits of modular code:**
1. _[Code reusability across projects]_
2. _[Easier testing and maintenance]_

<details>
<summary><strong>Answer Key</strong></summary>

```python
# Task 1
import datetime
today = datetime.date.today()
print(f"Today: {today}")

# Task 2
# helper.py
def validate_age(age):
    return 16 <= age <= 25

# main.py
from helper import validate_age

print(validate_age(20))  # True
print(validate_age(30))  # False

# Task 3
import pandas as pd
df = pd.DataFrame({"name": ["Ana", "Ben"], "age": [20, 22]})
print(df)

# Task 4
def main():
    print("Running main function")

if __name__ == "__main__":
    main()
```

**Reflection:** Modular code (1) Separates concerns, easier to debug, (2) Reusable functions across projects, (3) Team collaboration easier, (4) Testing isolated components

</details>
