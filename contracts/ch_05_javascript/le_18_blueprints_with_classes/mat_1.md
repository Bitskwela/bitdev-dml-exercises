## Background Story

It was a humid afternoon in Makati when Odessa realized her code was starting to look like scribbles on a jeepney window during rush hour—messy and hard to read. She was building an e-commerce dashboard for her logistics firm, defining products, user profiles, and inventory items. Every time she needed a new kind of object, she’d copy-paste code, change a few names, and pray nothing else broke.

Her mentor, Kuya Ronnie, dropped a pull request with a comment: “Why not use **classes**? Think of them as blueprints—architectural plans for your data.” He showed her how one `class Product` could hold all product logic—constructor, methods like `applyDiscount()`, and shared defaults.

Odessa remembered her college days in Quezon City, sketching building blueprints in her IT drawing class—lines, measurements, labels. Classes felt the same: define a template once, then **instantiate** (`new`) as many as needed. No more repetitive code!

She opened her editor and wrote:

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
}
```

She created two products, applied discounts, and saw the correct prices log out. Next, Kuya Ronnie introduced inheritance. A `class Admin extends UserProfile` could reuse user logic and add permissions. Her codebase shrank—no more copy-paste monsters.

By evening, Odessa had transformed her spaghetti functions into neat blueprints. She felt like a systems architect designing reusable components for her firm’s growing codebase. She imagined scaling this pattern to orders, shipments, and customer reviews—all with clean, testable classes.

With blueprints in place, Odessa was ready to build robust, scalable apps. Tomorrow, she’d learn about event-driven patterns—how to fire and listen for events, making her UIs and data models interact seamlessly. But for now, she savored the clarity that **classes** bring: one blueprint at a time. 🏗️✨

---

## Theory & Lecture Content

JavaScript classes (ES6) let you define blueprints for objects. They wrap constructor logic, methods, and inheritance in a clear syntax.

### 1. Defining a Class

```js
class Product {
  constructor(id, name, price) {
    this.id = id; // instance property
    this.name = name;
    this.price = price;
  }

  applyDiscount(percent) {
    // instance method
    this.price *= 1 - percent / 100;
  }

  toString() {
    return `${this.name} (₱${this.price.toFixed(2)})`;
  }
}
```

- **`constructor(...)`**  
  Called when you do `new Product(...)`.
- **`this`**  
  Refers to the new instance.
- **Instance methods**  
  Defined inside class body.

Reference:  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes

### 2. Instantiation

```js
const p1 = new Product("P001", "Rice Cooker", 2500);
const p2 = new Product("P002", "Kettle", 1200);
p1.applyDiscount(10);
console.log(p1.toString()); // "Rice Cooker (₱2250.00)"
```

### 3. Static Members

Static methods or properties belong to the class, not instances.

```js
class InventoryItem {
  static count = 0;

  constructor(name, qty) {
    this.name = name;
    this.qty = qty;
    InventoryItem.count++;
  }

  dispose() {
    InventoryItem.count--;
  }

  static getCount() {
    return InventoryItem.count;
  }
}

console.log(InventoryItem.getCount()); // 0
new InventoryItem("Box", 5);
console.log(InventoryItem.getCount()); // 1
```

### 4. Inheritance (`extends` & `super`)

```js
class UserProfile {
  constructor(username, email) {
    this.username = username;
    this.email = email;
  }

  greet() {
    return `Hello, ${this.username}!`;
  }
}

class Admin extends UserProfile {
  constructor(username, email, permissions = []) {
    super(username, email); // call parent constructor
    this.permissions = permissions;
  }

  addPermission(perm) {
    this.permissions.push(perm);
  }
}

const admin = new Admin("ods", "ods@example.com");
console.log(admin.greet()); // "Hello, ods!"
admin.addPermission("EDIT_USERS");
```

---

## Closing Story

With classes and constructors under her belt, Odessa’s code felt as sturdy as a steel-reinforced building. Products, users, inventory items, and admins all had clear blueprints. No more scattered functions—just reusable, testable models. Her logistics dashboard could now scale to thousands of SKUs without rewriting logic.

Kuya Ronnie sent a message: “Next up—event-driven architecture. You’ll learn how to fire and catch events between modules, making your classes interact in real time.”

Odessa closed her laptop with a grin. She had mastered **blueprints with classes**—and was ready to bring her app to life with events. The next chapter awaited, and she couldn’t wait to build it. 🚀
