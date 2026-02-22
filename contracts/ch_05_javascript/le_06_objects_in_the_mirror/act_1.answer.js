// Task 1: Create and Access Student Object
function getStudentSummary(student) {
  // This demonstrates OBJECT PROPERTY ACCESS using dot notation
  // We're accessing multiple properties of the student object
  // Template literals (backticks) allow embedding expressions with ${}

  return `${student.name} is ${student.age} years old, studying ${student.course} in year ${student.year}.`;

  // Four property accesses:
  // - student.name → gets the name property
  // - student.age → gets the age property
  // - student.course → gets the course property
  // - student.year → gets the year property

  // Why use template literals?
  // - Cleaner than string concatenation: `text ${variable}`
  // - vs "text " + variable + " more text"
}

// Task 2: Build Object with Bracket Notation
function createProfile(keys, values) {
  // This demonstrates DYNAMIC PROPERTY CREATION using bracket notation
  // We're building an object when property names come from an array

  let profile = {}; // Start with empty object

  // Loop through both arrays simultaneously
  for (let i = 0; i < keys.length; i++) {
    // BRACKET NOTATION is required here because:
    // - keys[i] is a VARIABLE containing the property name
    // - Dot notation doesn't work with variables
    // - profile.keys[i] would literally look for a property called "keys"

    profile[keys[i]] = values[i];

    // Example iteration:
    // If keys = ["name", "age"] and values = ["Juan", 25]
    // i=0: profile["name"] = "Juan"  → profile = { name: "Juan" }
    // i=1: profile["age"] = 25       → profile = { name: "Juan", age: 25 }
  }

  return profile;

  // REAL-WORLD USE CASE:
  // This pattern is common when converting data from one format to another
  // E.g., CSV to JSON, form data to object, API responses to local objects
}

// Task 3: Access Nested Object Data
function getTeacherEmail(classInfo) {
  // This demonstrates NESTED OBJECT ACCESS
  // We're navigating multiple levels deep: classInfo → teacher → email

  return classInfo.teacher.email;

  // BREAKDOWN of the chain:
  // 1. classInfo is the parameter (an object)
  // 2. .teacher accesses the teacher property (which is itself an object)
  // 3. .email accesses the email property inside the teacher object

  // EXAMPLE DATA STRUCTURE:
  // classInfo = {
  //   className: "IT-101",
  //   teacher: {
  //     name: "Prof. Santos",
  //     email: "santos@school.edu.ph"  ← We want this
  //   }
  // }

  // COMMON BUG: What if teacher or email doesn't exist?
  // classInfo.teacher.email would throw an error if teacher is undefined

  // SAFER VERSION (optional chaining - ES2020):
  // return classInfo?.teacher?.email;
  // Returns undefined instead of throwing an error if any property is missing
}
