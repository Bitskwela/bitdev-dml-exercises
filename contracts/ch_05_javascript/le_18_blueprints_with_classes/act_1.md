# JavaScript Classes Activity

## Initial Code

```js
// Task 1: Create a Product Class
class Product {
  constructor(id, name, price) {
    // Add your code here
  }

  applyDiscount(percent) {
    // Add your code here
  }

  toString() {
    // Add your code here
  }
}

// Task 2: Create a User Class
class User {
  constructor(username, email) {
    // Add your code here
  }

  greet() {
    // Add your code here
  }

  updateEmail(newEmail) {
    // Add your code here
  }
}

// Task 3: Create a Class with Static Members
class Counter {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Class Declaration, Constructor, Instance Properties, Instance Methods, `this` Keyword, Static Properties, Static Methods

---

### Task 1: Create a Product Class

Create a `Product` class with a constructor that accepts `id`, `name`, and `price`. Add an `applyDiscount(percent)` method that reduces the price by the given percentage, and a `toString()` method that returns the product info formatted as "name (₱price)".

```js
class Product {
  constructor(id, name, price) {
    this.id = id;
    this.name = name;
    this.price = price;
  }

  applyDiscount(percent) {
    this.price = this.price * (1 - percent / 100);
  }

  toString() {
    return `${this.name} (₱${this.price.toFixed(2)})`;
  }
}
```

---

### Task 2: Create a User Class

Create a `User` class with a constructor that accepts `username` and `email`. Add a `greet()` method that returns "Hello, [username]!" and an `updateEmail(newEmail)` method that updates the email property.

```js
class User {
  constructor(username, email) {
    this.username = username;
    this.email = email;
  }

  greet() {
    return `Hello, ${this.username}!`;
  }

  updateEmail(newEmail) {
    this.email = newEmail;
  }
}
```

---

### Task 3: Create a Class with Static Members

Create a `Counter` class that tracks how many instances have been created. Use a static property `count` and a static method `getCount()`. The constructor should increment the count, and add a `dispose()` method that decrements it.

```js
class Counter {
  static count = 0;

  constructor(name) {
    this.name = name;
    Counter.count++;
  }

  dispose() {
    Counter.count--;
  }

  static getCount() {
    return Counter.count;
  }
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `id`: A unique identifier for the product, stored as an instance property.

- `name`: The product or user name, stored as an instance property using `this.name`.

- `price`: The product's price as a number. Modified by the `applyDiscount` method.

- `percent`: A numeric parameter representing the discount percentage (e.g., 10 for 10%).

- `username`: The user's display name, used in the greeting method.

- `email`: The user's email address, can be updated via the `updateEmail` method.

- `count`: A static property that belongs to the class itself, not individual instances. Tracks total instances.

**Key Concepts:**

- Class Declaration:
  Use `class ClassName { }` to define a blueprint for objects. Classes encapsulate data (properties) and behavior (methods).

- Constructor:
  The `constructor()` method is called automatically when you create a new instance with `new ClassName()`. Used to initialize instance properties.

- `this` Keyword:
  Inside a class, `this` refers to the current instance. Use `this.propertyName` to access or set instance properties.

- Instance Properties:
  Data that belongs to each individual instance. Created by assigning values to `this.propertyName` in the constructor.

- Instance Methods:
  Functions defined in the class body that operate on instance data. Can access `this` to read/modify properties.

- Static Properties:
  Properties that belong to the class itself, not instances. Declared with `static propertyName`. Accessed via `ClassName.propertyName`.

- Static Methods:
  Methods that belong to the class, not instances. Declared with `static methodName()`. Cannot access `this` (instance data).

- `toFixed(decimals)`:
  Number method that formats a number with a specified number of decimal places. Returns a string.

**Key Functions:**

- `Product.applyDiscount(percent)`:
  Demonstrates modifying instance properties through methods. Calculates new price based on percentage discount.

- `Product.toString()`:
  Shows how to create a string representation of an object using template literals and number formatting.

- `User.greet()`:
  Simple instance method that returns a formatted string using instance properties.

- `Counter.getCount()`:
  Static method demonstrating how to access static properties from within the class.
