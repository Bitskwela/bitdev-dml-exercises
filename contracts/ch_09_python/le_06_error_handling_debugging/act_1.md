# Error Handling and Debugging Activity

Now that you understand error handling, let's practice writing robust code that gracefully handles failures.

## Defensive Programming Challenge

Robust code anticipates and handles errors elegantly.

### Task 1: Safe Integer Parsing

Wrap **integer parsing** with graceful fallback for invalid input.

**Your Code:**
```python
def parse_age(user_input):
    """
    Safely parse age from user input.
    
    Args:
        user_input: String from user (might not be valid)
    
    Returns:
        Integer age, or None if invalid
    """
    # Your code here with try/except:
    
    
    
    

# Test cases
print(parse_age("18"))      # Should return 18
print(parse_age("twenty"))  # Should return None (or default value)
print(parse_age(""))         # Should return None
print(parse_age("18.5"))    # Should return None (not a valid int)
```

**What exception type should you catch?**
_[Your answer]_

**Should you log the error? Why or why not?**
_[Your answer]_

---

### Task 2: Custom Exception

Create a **custom exception** for duplicate resident ID scenario.

**Your Code:**
```python
class DuplicateResidentError(Exception):
    """Raised when attempting to add resident with existing ID."""
    # Your custom exception here
    pass

def add_resident(resident_id, residents_db):
    """
    Add resident to database.
    
    Args:
        resident_id: Unique resident identifier
        residents_db: Dictionary of existing residents
    
    Raises:
        DuplicateResidentError: If resident_id already exists
    """
    # Your code here:
    # Check if resident_id exists
    # If yes, raise DuplicateResidentError with helpful message
    # If no, add to residents_db
    
    
    

# Test it
db = {101: "Ana", 102: "Ben"}
try:
    add_resident(103, db)  # Should succeed
    add_resident(101, db)  # Should raise DuplicateResidentError
except DuplicateResidentError as e:
    print(f"Error caught: {e}")
```

**Why create custom exceptions?**
_[Explain clarity and specific error handling]_

---

### Task 3: Execution Time Logging

Add **logging** around a function to measure execution time.

**Your Code:**
```python
import logging
import time

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def process_applications(applications):
    """Simulate processing applications (might be slow)."""
    time.sleep(2)  # Simulate slow operation
    return len(applications)

def logged_process(applications):
    """
    Wrapper that logs execution time.
    """
    # Your code here:
    # Log start time
    # Call process_applications
    # Log end time and duration
    # Handle any exceptions
    
    
    
    

# Test it
applications = [{"name": f"Applicant {i}"} for i in range(100)]
logged_process(applications)
```

**Expected Output:**
```
INFO: Processing started...
INFO: Processed 100 applications in 2.01 seconds
```

---

### Task 4: Finally Block for Resource Cleanup

Demonstrate `finally` closing a resource even after an exception.

**Your Code:**
```python
def read_resident_data(filename):
    """
    Read resident data from file, ensuring file is always closed.
    """
    file_handle = None
    try:
        # Your code here:
        # Open file
        # Read data (might raise exception)
        # Return data
        pass
    
    except FileNotFoundError:
        # Handle missing file
        pass
    
    except PermissionError:
        # Handle permission denied
        pass
    
    finally:
        # Your cleanup code here:
        # Always close file if it was opened
        # Log completion
        pass

# Test with non-existent file
data = read_resident_data("nonexistent.txt")
```

**Why is finally important?**
_[Explain resource cleanup and preventing resource leaks]_

---

## Reflection Questions

**Describe the difference between catching broad `Exception` vs specific types:**

**Broad Exception Catching** (`except Exception:`)

Pros:
1. _[Pro 1]_
2. _[Pro 2]_

Cons:
1. _[Con 1]_
2. _[Con 2]_

**Specific Exception Catching** (`except ValueError:`, `except KeyError:`)

Pros:
1. _[Pro 1]_
2. _[Pro 2]_

Cons:
1. _[Con 1]_
2. _[Con 2]_

**Which approach do you prefer and why?**
_[Your answer]_

---

## What You've Learned

Through this activity, you've practiced:
- Safe input parsing with exception handling
- Creating custom exceptions for domain errors
- Using logging for debugging and monitoring
- Ensuring resource cleanup with finally blocks
- Understanding exception handling trade-offs
Next, you'll learn Python syntax, indentation, and code style!

<details>
<summary><strong>Answer Key</strong></summary>
### Task 1: Safe Parse Age
```python
def safe_parse_age(age_str):
    try:
        age = int(age_str)
        if not (16 <= age <= 25):
            raise ValueError(f"Age {age} out of range (16-25)")
        return age
    except ValueError as e:
        print(f"Invalid age: {e}")
        return None

print(safe_parse_age("20"))    # 20
print(safe_parse_age("abc"))   # None
print(safe_parse_age("30"))    # None
```

### Task 2: Custom Exception
```python
class DuplicateApplicationError(Exception):
    def __init__(self, applicant_id, scholarship_id):
        self.applicant_id = applicant_id
        self.scholarship_id = scholarship_id
        super().__init__(f"Applicant {applicant_id} already applied to {scholarship_id}")

applications = set()

def submit_application(applicant_id, scholarship_id):
    key = (applicant_id, scholarship_id)
    if key in applications:
        raise DuplicateApplicationError(applicant_id, scholarship_id)
    applications.add(key)
    return True

try:
    submit_application(101, 1)
    submit_application(101, 1)  # Raises exception
except DuplicateApplicationError as e:
    print(f"Error: {e}")
```

### Task 3: Execution Time Logging
```python
import logging
import time

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def process_applications(applications):
    time.sleep(2)
    return len(applications)

def logged_process(applications):
    logger.info("Processing started...")
    start_time = time.time()
    
    try:
        result = process_applications(applications)
        duration = time.time() - start_time
        logger.info(f"Processed {result} applications in {duration:.2f} seconds")
        return result
    except Exception as e:
        logger.error(f"Processing failed: {e}")
        raise

applications = [{"name": f"Applicant {i}"} for i in range(100)]
logged_process(applications)
```

### Task 4: Finally Block
```python
def read_resident_data(filename):
    file_handle = None
    try:
        file_handle = open(filename, "r")
        data = file_handle.read()
        return data
    
    except FileNotFoundError:
        print(f"File {filename} not found")
        return None
    
    except PermissionError:
        print(f"Permission denied: {filename}")
        return None
    
    finally:
        if file_handle:
            file_handle.close()
            print("File closed")

data = read_resident_data("nonexistent.txt")
```
**Why finally important:** Ensures resources (files, connections) are always cleaned up, preventing leaks

### Reflection
**Broad vs Specific Exceptions:**
- **Broad:** Catches all errors (pro: simple; con: hides bugs)
- **Specific:** Catches expected errors (pro: precise handling; con: more code)
- **Prefer specific** for known errors, broad only as last resort

</details>
