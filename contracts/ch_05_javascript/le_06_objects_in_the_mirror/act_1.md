# Objects Activity

## Initial Code

```js
// Task 1: Create and Access Student Object
function getStudentSummary(student) {
  // Add your code here
}

// Task 2: Build Object with Bracket Notation
function createProfile(keys, values) {
  // Add your code here
}

// Task 3: Access Nested Object Data
function getTeacherEmail(classInfo) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Object Literals, Dot Notation, Bracket Notation, Nested Objects, Accessing Object Properties

---

### Task 1: Create and Access Student Object

Create a function that receives a student object with `name`, `age`, `course`, and `year` properties. Return a formatted string using dot notation: "[name] is [age] years old, studying [course] in year [year]."

```js
function getStudentSummary(student) {
  return `${student.name} is ${student.age} years old, studying ${student.course} in year ${student.year}.`;
}
```

---

### Task 2: Build Object with Bracket Notation

Create a function that takes two arrays: `keys` and `values`. Build and return an object where each key from the `keys` array is paired with the corresponding value from the `values` array. Use bracket notation to dynamically assign properties.

```js
function createProfile(keys, values) {
  let profile = {};

  for (let i = 0; i < keys.length; i++) {
    profile[keys[i]] = values[i];
  }

  return profile;
}
```

---

### Task 3: Access Nested Object Data

Create a function that receives a `classInfo` object containing nested data. The object has a `teacher` property which is an object with `name` and `email`. Return the teacher's email address using dot notation.

```js
function getTeacherEmail(classInfo) {
  return classInfo.teacher.email;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `student`: An object parameter containing properties like `name`, `age`, `course`, and `year`. Accessed using dot notation (e.g., `student.name`).

- `keys`: An array of strings representing property names to be used as object keys.

- `values`: An array of values corresponding to each key in the `keys` array.

- `profile`: An empty object `{}` that gets populated dynamically using bracket notation inside a loop.

- `classInfo`: An object parameter containing nested objects. Has a `teacher` property which itself is an object with `name` and `email` properties.

**Key Concepts:**

- Object Literals:
  Objects are created using curly braces `{}` with key-value pairs separated by colons. Example: `{ name: "Odessa", age: 20 }`

- Dot Notation:
  The most common way to access object properties. Use the object name followed by a dot and the property name. Example: `student.name` returns the value of the `name` property.

- Bracket Notation:
  Access properties using square brackets with the property name as a string. Example: `student["name"]`. Essential when property names are dynamic (stored in variables) or contain special characters.

- Dynamic Property Assignment:
  Using bracket notation with a variable allows you to set property names dynamically. Example: `obj[keyVariable] = value` where `keyVariable` holds the property name.

- Nested Objects:
  Objects can contain other objects as property values. Access nested properties by chaining dot notation. Example: `classInfo.teacher.email` accesses the `email` property inside the `teacher` object.

- Template Literals with Objects:
  Combine template literals with object properties for formatted strings. Example: `` `${student.name} is ${student.age}` ``

**Key Functions:**

- `getStudentSummary(student)`:
  Demonstrates accessing multiple properties of an object using dot notation and combining them into a formatted string using template literals.

- `createProfile(keys, values)`:
  Shows how to dynamically build an object using bracket notation. Loops through arrays and assigns key-value pairs to an initially empty object.

- `getTeacherEmail(classInfo)`:
  Demonstrates accessing nested object properties using chained dot notation. Navigates through multiple levels of object nesting.
