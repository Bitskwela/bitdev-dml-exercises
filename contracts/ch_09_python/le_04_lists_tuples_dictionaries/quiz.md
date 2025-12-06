# Lesson 4 Quiz: Lists, Tuples, Dictionaries

---
# Quiz 1
## Scenario: Collection Cleanup
Tian stored resident IDs in a list and performs repeated membership checks every request. Optimize choices.

**Question 1:** Fastest membership test for large unique IDs?
A. List
B. Tuple
C. Dictionary keys
D. Repeated concatenated string

**Answer:** C  
**Explanation:** Dict key set offers O(1) membership average.

---

**Question 2:** Best structure for fixed `(latitude, longitude)` pair?
A. List
B. Tuple
C. Dictionary with numeric string keys
D. Set

**Answer:** B  
**Explanation:** Tuple signals immutability of fixed size.

---

**Question 3:** Attempting `tpl[0] = 5` on a tuple causes:
A. Silent update
B. Value coercion
C. TypeError
D. Creation of new element automatically

**Answer:** C  
**Explanation:** Tuples immutable → TypeError.

---

**Question 4:** Which dictionary key is INVALID?
A. 42
B. (1, 2, 3)
C. [1, 2, 3]
D. "barangay"

**Answer:** C  
**Explanation:** Lists unhashable.

---

**Question 5:** Shallow copy issue appears when:
A. Only primitive scalars present
B. Nested mutable objects exist
C. Using tuple of ints
D. Accessing dictionary values once

**Answer:** B  
**Explanation:** Shallow copy shares inner lists.

---
# Quiz 2
## Scenario: Avoiding Mutability Traps
Rhea Joy audits utility functions for hidden bugs.

**Question 6:** Problem with `def add_tag(tag, bucket=[]): bucket.append(tag)`?
A. Syntax error
B. Rebinding each call
C. Shared list persists across calls
D. Tag not appended

**Answer:** C  
**Explanation:** Default list reused between calls.

---

**Question 7:** Safe fix for mutable default parameter?
A. Remove parameter
B. Use `bucket=None` then create inside
C. Use global list
D. Convert to tuple and reassign

**Answer:** B  
**Explanation:** Use sentinel None then allocate per call.

---

**Question 8:** Building frequency counts from tags list uses which structure?
A. List of duplicates only
B. Tuple of counts
C. Dict mapping tag → count
D. String concatenation

**Answer:** C  
**Explanation:** Dict natural for aggregating counts.

---

**Question 9:** Converting list of `(id, name)` to dict comprehension pattern:
A. `{id: name for id, name in pairs}`
B. `{(id, name): id for pairs}`
C. `{pairs: id for name}`
D. `dict[id] = name for pairs`

**Answer:** A  
**Explanation:** Standard comprehension unpacking pairs.

---

**Question 10:** Benefit of tuple as dict key versus list?
A. Consumes more memory
B. Is hashable and immutable
C. Allows in-place item assignment
D. Sorts automatically

**Answer:** B  
**Explanation:** Hashable immutability allows key usage safely.  

---
**Next:** Proceed to Lesson 4 exercises.
