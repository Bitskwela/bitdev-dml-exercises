// Task 1: Create a Product Class
// CLASSES: ES6 syntax for creating objects with shared behavior
// Think of a class as a blueprint for creating objects

class Product {
  // constructor() runs when you create a new instance: new Product(...)
  // It initializes the object's properties
  constructor(id, name, price) {
    // 'this' refers to the new object being created
    // Setting properties on the instance
    this.id = id;
    this.name = name;
    this.price = price;
  }

  // INSTANCE METHOD: Function that operates on a specific instance
  // Can access instance data via 'this'
  applyDiscount(percent) {
    // Modify the instance's price property
    // percent = 10 means 10% off, so multiply by 0.9 (1 - 10/100)
    this.price = this.price * (1 - percent / 100);
  }

  // toString() is special: called when object is converted to string
  toString() {
    // toFixed(2) formats number to 2 decimal places: 99.5 → "99.50"
    return `${this.name} (₱${this.price.toFixed(2)})`;
  }
}

// USING THE CLASS:
// const item = new Product(1, "Rice", 50);
// item.applyDiscount(10);  // Price becomes 45
// console.log(item.toString());  // "Rice (₱50.00)"

// Task 2: Create a User Class
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

// Task 3: Create a Class with Static Members
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
