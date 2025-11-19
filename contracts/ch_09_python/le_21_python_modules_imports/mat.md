## Lesson 21: Python Modules and Imports

Story: Tian's script grows to 500 lines. Rhea Joy suggests splitting into modules: "Organize by concern, import what you need."

### 1. What Is a Module?
Any .py file is a module. Contains functions, classes, variables.

### 2. Basic Import
```python
import math
print(math.sqrt(16))
```

### 3. Import Specific
```python
from math import sqrt, pi
print(sqrt(16), pi)
```

### 4. Alias
```python
import pandas as pd
import numpy as np
```

### 5. Import All (Discouraged)
```python
from math import *
# pollutes namespace
```

### 6. Creating Your Module
File: utils.py
```python
def greet(name):
    return f"Hello {name}"
```
Main script:
```python
import utils
print(utils.greet("Ana"))
```

### 7. Package (Directory with __init__.py)
```
my_package/
    __init__.py
    module_a.py
    module_b.py
```
Import:
```python
from my_package import module_a
```

### 8. Relative Imports (Within Package)
```python
from . import sibling_module
from .. import parent_module
```

### 9. Standard Library Highlights
- os, sys: system interaction
- datetime: date/time handling
- json, csv: data formats
- random: random numbers
- re: regular expressions
- pathlib: modern path handling

### 10. Third-Party Packages (pip)
```bash
pip install requests pandas flask
```

### 11. if __name__ == "__main__":
```python
def main():
    print("Running as script")

if __name__ == "__main__":
    main()
```
Runs only when script executed directly.

### 12. Story Thread
Refactor: validation.py, data_loader.py, report.py; main.py imports and orchestrates.

### 13. Practice Prompts
1. Import datetime; print current date.
2. Create helper.py with utility function; import in main.
3. Use alias for long module name.
4. Demonstrate __name__ == "__main__" pattern.

### 14. Reflection
Two benefits of modular code organization.

**Next:** Quiz then exercises.