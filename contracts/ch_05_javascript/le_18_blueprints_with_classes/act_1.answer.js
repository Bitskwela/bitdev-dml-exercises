// Task 1: Create a Product Class
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
