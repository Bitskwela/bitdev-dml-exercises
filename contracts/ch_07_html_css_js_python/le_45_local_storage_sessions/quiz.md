# Quiz: Lesson 45 - Using Local Storage and Sessions

---

# Quiz 1

### Question 1
**What is the main difference between localStorage and sessionStorage?**
- A) localStorage is faster
- B) localStorage persists until cleared, sessionStorage until tab closed
- C) sessionStorage has more capacity
- D) They are the same

**Answer:** B) localStorage persists until cleared, sessionStorage until tab closed

---

### Question 2
**What is the storage capacity of localStorage?**
- A) ~4KB
- B) ~500KB
- C) ~5-10MB
- D) Unlimited

**Answer:** C) ~5-10MB

---

### Question 3
**How do you store data in localStorage?**
- A) `localStorage.store('key', 'value')`
- B) `localStorage.setItem('key', 'value')`
- C) `localStorage.add('key', 'value')`
- D) `localStorage.save('key', 'value')`

**Answer:** B) `localStorage.setItem('key', 'value')`

---

### Question 4
**How do you retrieve data from localStorage?**
- A) `localStorage.get('key')`
- B) `localStorage.retrieve('key')`
- C) `localStorage.getItem('key')`
- D) `localStorage.fetch('key')`

**Answer:** C) `localStorage.getItem('key')`

---

### Question 5
**What data types can localStorage store directly?**
- A) Only strings
- B) Any data type
- C) Only numbers
- D) Only objects

**Answer:** A) Only strings

---

### Question 6
**How do you store an object in localStorage?**
- A) `localStorage.setItem('key', object)`
- B) `localStorage.setItem('key', JSON.stringify(object))`
- C) `localStorage.setObject('key', object)`
- D) `localStorage.store('key', object)`

**Answer:** B) `localStorage.setItem('key', JSON.stringify(object))`

---

### Question 7
**How do you clear all localStorage data?**
- A) `localStorage.deleteAll()`
- B) `localStorage.remove()`
- C) `localStorage.clear()`
- D) `localStorage.reset()`

**Answer:** C) `localStorage.clear()`

---

# Quiz 2

### Question 8
**What should you NEVER store in localStorage?**
- A) User preferences
- B) Passwords and auth tokens
- C) Theme settings
- D) Recent searches

**Answer:** B) Passwords and auth tokens

---

### Question 9
**When should you use sessionStorage instead of localStorage?**
- A) For permanent data
- B) For temporary data that should disappear when tab closes
- C) For large files
- D) For sensitive data

**Answer:** B) For temporary data that should disappear when tab closes

---

### Question 10
**How do you remove a specific item from localStorage?**
- A) `localStorage.delete('key')`
- B) `localStorage.removeItem('key')`
- C) `localStorage.clear('key')`
- D) `localStorage.erase('key')`

**Answer:** B) `localStorage.removeItem('key')`

---

### Question 11
**What happens when localStorage quota is exceeded?**
- A) Old data is automatically deleted
- B) A QuotaExceededError is thrown
- C) The browser crashes
- D) New data overwrites old data

**Answer:** B) A QuotaExceededError is thrown

---

### Question 12
**Which DevTools tab shows localStorage data in Chrome?**
- A) Console
- B) Network
- C) Application
- D) Sources

**Answer:** C) Application

---

### Question 13
**What event fires when localStorage changes in another tab?**
- A) `change`
- B) `storage`
- C) `update`
- D) `localstorage`

**Answer:** B) `storage`

---

### Question 14
**What is a good use case for localStorage?**
- A) Storing passwords
- B) Storing theme preferences
- C) Storing credit card numbers
- D) Storing session tokens

**Answer:** B) Storing theme preferences

---

### Question 15
**How do you check if a key exists in localStorage?**
- A) `localStorage.exists('key')`
- B) `localStorage.has('key')`
- C) `localStorage.getItem('key') !== null`
- D) `localStorage.contains('key')`

**Answer:** C) `localStorage.getItem('key') !== null`
