# Chapter 9 Quiz: Python Fundamentals to Database Applications

```json
[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A compiled language for web development" },
      { "id": "b", "text": "An interpreted, high-level programming language" },
      { "id": "c", "text": "A markup language like HTML" },
      { "id": "d", "text": "A database management system" }
    ],
    "question": "What is Python?"
  },
  {
    "id": 2,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Indentation" },
      { "id": "b", "text": "Curly braces" },
      { "id": "c", "text": "Semicolons" },
      { "id": "d", "text": "Parentheses" }
    ],
    "question": "What is used to define code blocks in Python?"
  },
  {
    "id": 3,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Comments in Python start with the # symbol."
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "int, float, string" },
      { "id": "b", "text": "bool, list, dict" },
      { "id": "c", "text": "tuple, set, None" },
      { "id": "d", "text": "All of the above" }
    ],
    "question": "Which are valid Python data types?"
  },
  {
    "id": 5,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A collection that is mutable and ordered" },
      { "id": "b", "text": "A collection that is immutable and ordered" },
      { "id": "c", "text": "A collection that is mutable and unordered" },
      { "id": "d", "text": "A collection that stores key-value pairs" }
    ],
    "question": "What is a tuple in Python?"
  },
  {
    "id": 6,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "An unordered collection of unique elements" },
      { "id": "b", "text": "An ordered collection of elements" },
      { "id": "c", "text": "A mutable collection of key-value pairs" },
      { "id": "d", "text": "A fixed-size array" }
    ],
    "question": "What is a set in Python?"
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "list[0]" },
      { "id": "b", "text": "list.get(0)" },
      { "id": "c", "text": "Both A is correct method" },
      { "id": "d", "text": "list[1]" }
    ],
    "question": "How do you access the first element of a list?"
  },
  {
    "id": 8,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "dictionary[key] = value" },
      { "id": "b", "text": "Both A and key can be assigned directly" },
      { "id": "c", "text": "dictionary.add(key, value)" },
      { "id": "d", "text": "dictionary.set(key) = value" }
    ],
    "question": "How do you add a key-value pair to a dictionary in Python?"
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "def functionName():" },
      { "id": "b", "text": "function functionName():" },
      { "id": "c", "text": "func functionName():" },
      { "id": "d", "text": "define functionName():" }
    ],
    "question": "What is the correct syntax to define a function in Python?"
  },
  {
    "id": 10,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "A function can return multiple values using a tuple."
  },
  {
    "id": 11,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "catch exception:" },
      { "id": "b", "text": "except Exception:" },
      { "id": "c", "text": "handle error:" },
      { "id": "d", "text": "trap exception:" }
    ],
    "question": "What is the correct syntax for exception handling in Python?"
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "if, elif, else" },
      { "id": "b", "text": "if, else if, else" },
      { "id": "c", "text": "if, then, else" },
      { "id": "d", "text": "if, otherwise, else" }
    ],
    "question": "What keywords are used for conditional statements in Python?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "for i in range(5): loops 1 to 5" },
      { "id": "b", "text": "for i in range(5): loops 1 to 4" },
      { "id": "c", "text": "for i in range(5): loops 0 to 4" },
      { "id": "d", "text": "for i in range(5): loops 5 times starting at 1" }
    ],
    "question": "What does 'for i in range(5):' do?"
  },
  {
    "id": 14,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "A while loop executes a fixed number of times determined by range()."
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "name.uppercase()" },
      { "id": "b", "text": "name.upper()" },
      { "id": "c", "text": "name.toUpper()" },
      { "id": "d", "text": "upper(name)" }
    ],
    "question": "How do you convert a string to uppercase in Python?"
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "f\"Hello {name}\"" },
      { "id": "b", "text": "\"Hello \" + name" },
      { "id": "c", "text": "\"%s\" % name" },
      { "id": "d", "text": "All of the above are valid" }
    ],
    "question": "What is the modern way to format strings in Python?"
  },
  {
    "id": 17,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "open(\"file.txt\", \"r\")" },
      { "id": "b", "text": "Both A and reading mode" },
      { "id": "c", "text": "read_file(\"file.txt\")" },
      { "id": "d", "text": "file_open(\"file.txt\")" }
    ],
    "question": "How do you open a file for reading in Python?"
  },
  {
    "id": 18,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "CSV stands for Comma-Separated Values and is a common data format."
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "JavaScript Object Notation" },
      { "id": "b", "text": "Just Object Notation" },
      { "id": "c", "text": "JavaScript Object Notation (correct)" },
      { "id": "d", "text": "Java Serialized Object Notation" }
    ],
    "question": "What does JSON stand for?"
  },
  {
    "id": 20,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "import module_name" },
      { "id": "b", "text": "include module_name" },
      { "id": "c", "text": "use module_name" },
      { "id": "d", "text": "require module_name" }
    ],
    "question": "What is the correct syntax to import a module in Python?"
  },
  {
    "id": 21,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A mathematical computing library" },
      {
        "id": "b",
        "text": "A library for numerical computing with arrays and matrices"
      },
      { "id": "c", "text": "A web framework for building APIs" },
      { "id": "d", "text": "A database management system" }
    ],
    "question": "What is NumPy?"
  },
  {
    "id": 22,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A plotting library" },
      { "id": "b", "text": "A numerical computing library" },
      { "id": "c", "text": "A data manipulation library" },
      { "id": "d", "text": "All of the above for their respective purposes" }
    ],
    "question": "What is Pandas primarily used for?"
  },
  {
    "id": 23,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "A visualization library for creating plots and graphs"
      },
      { "id": "b", "text": "A data processing library" },
      { "id": "c", "text": "A database framework" },
      { "id": "d", "text": "A web framework" }
    ],
    "question": "What is Matplotlib used for?"
  },
  {
    "id": 24,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Statistics involves collecting, analyzing, and interpreting data."
  },
  {
    "id": 25,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The spread of data around the mode" },
      { "id": "b", "text": "The spread of data around the mean" },
      { "id": "c", "text": "The average value of a dataset" },
      { "id": "d", "text": "The frequency of the most common value" }
    ],
    "question": "What is standard deviation?"
  },
  {
    "id": 26,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Organized store of related data" },
      { "id": "b", "text": "A collection of files" },
      {
        "id": "c",
        "text": "An organized system for storing and retrieving data"
      },
      { "id": "d", "text": "A Python library" }
    ],
    "question": "What is a database?"
  },
  {
    "id": 27,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Structured Query Language for managing relational databases"
      },
      { "id": "b", "text": "Standard Query Language for all databases" },
      { "id": "c", "text": "Simple Query Language for data retrieval" },
      { "id": "d", "text": "Structured Query Logic for database design" }
    ],
    "question": "What is SQL?"
  },
  {
    "id": 28,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "SQL databases only" },
      {
        "id": "b",
        "text": "Both relational (SQL) and non-relational (NoSQL) databases"
      },
      { "id": "c", "text": "NoSQL databases only" },
      { "id": "d", "text": "File-based storage systems" }
    ],
    "question": "Which types of databases can Python connect to?"
  },
  {
    "id": 29,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "CREATE table_name {columns}" },
      { "id": "b", "text": "CREATE table_name (columns)" },
      { "id": "c", "text": "CREATE TABLE table_name (columns)" },
      { "id": "d", "text": "CREATE table table_name;" }
    ],
    "question": "What is the correct SQL syntax to create a table?"
  },
  {
    "id": 30,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "A primary key uniquely identifies each row in a database table."
  },
  {
    "id": 31,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "SELECT * FROM table_name" },
      { "id": "b", "text": "RETRIEVE * FROM table_name" },
      { "id": "c", "text": "GET table_name" },
      { "id": "d", "text": "FETCH FROM table_name" }
    ],
    "question": "What SQL query retrieves all data from a table?"
  },
  {
    "id": 32,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A web server framework" },
      {
        "id": "b",
        "text": "A Python micro web framework for building web applications"
      },
      { "id": "c", "text": "A database management tool" },
      { "id": "d", "text": "A data visualization library" }
    ],
    "question": "What is Flask?"
  },
  {
    "id": 33,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "@app.function" },
      { "id": "b", "text": "@route()" },
      { "id": "c", "text": "@app.route()" },
      { "id": "d", "text": "@app.path()" }
    ],
    "question": "What decorator is used to define routes in Flask?"
  },
  {
    "id": 34,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "GET requests are used to modify data on the server."
  },
  {
    "id": 35,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Representational State Transfer for building web APIs"
      },
      { "id": "b", "text": "Remote Execution Service Transfer" },
      { "id": "c", "text": "Rapid Excel Spreadsheet Technology" },
      { "id": "d", "text": "Regular Expression Syntax Table" }
    ],
    "question": "What does REST stand for?"
  },
  {
    "id": 36,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "GET (retrieve), PUT (update)" },
      { "id": "b", "text": "POST (create), DELETE (remove)" },
      { "id": "c", "text": "All of the above map to CRUD operations" },
      { "id": "d", "text": "PATCH (modify), HEAD (check)" }
    ],
    "question": "Which HTTP methods correspond to CRUD operations in REST?"
  },
  {
    "id": 37,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A type of variable in Python" },
      {
        "id": "b",
        "text": "A diagram showing relationships between entities in a database"
      },
      {
        "id": "c",
        "text": "A class definition in object-oriented programming"
      },
      { "id": "d", "text": "A Flask template for rendering HTML" }
    ],
    "question": "What is an Entity-Relationship (ER) diagram?"
  },
  {
    "id": 38,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "A technique to organize database tables to reduce redundancy"
      },
      { "id": "b", "text": "A method to encrypt database records" },
      { "id": "c", "text": "A way to index database tables" },
      { "id": "d", "text": "A process to backup database files" }
    ],
    "question": "What is database normalization?"
  },
  {
    "id": 39,
    "type": "FIB",
    "answer": "database",
    "points": 1,
    "question": "A ______ is an organized system of storing and managing data."
  },
  {
    "id": 40,
    "type": "FIB",
    "answer": "module",
    "points": 1,
    "question": "A Python ______ is a file containing Python code that can be imported and reused."
  }
]
```
