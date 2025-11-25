// Task 1: Create and Access Student Object
function getStudentSummary(student) {
  return `${student.name} is ${student.age} years old, studying ${student.course} in year ${student.year}.`;
}

// Task 2: Build Object with Bracket Notation
function createProfile(keys, values) {
  let profile = {};

  for (let i = 0; i < keys.length; i++) {
    profile[keys[i]] = values[i];
  }

  return profile;
}

// Task 3: Access Nested Object Data
function getTeacherEmail(classInfo) {
  return classInfo.teacher.email;
}
