## Background Story

Every afternoon, Odessa visits Paula’s neighborhood sari-sari store in Quezon City. The narrow aisle is crammed with canned goods, sticks of chichirya, bottles of Yakult, and stacks of instant noodles. Paula’s Tita Baby often buys corned beef, two Yakults, and five piattos—sometimes on utang (credit)—and Paula scribbles everything in a worn notebook. By closing time, the “utang list” is a tangled mess of crossed-out items and forgotten totals.

One rainy Tuesday, Odessa arrives with her laptop under an umbrella. “Let’s bring some order to this chaos,” she says. Over cups of sweet salabat, she sketches a mini point-of-sale app—**SariPOS**—so that whenever Tita Baby adds items, the app instantly shows the cart contents and computes the total. There’s even a “Clear Cart” button for fresh starts.

With the jeepney traffic humming outside and the smell of freshly baked pandesal drifting in, Odessa opens her code editor. She plans to use **ES6 classes** to model `Item` and `Cart`, use `push()` to add items, `forEach()` to render them, and `reduce()` to calculate the total. Paula watches in awe as lines of JavaScript transform into a live calculator on her store’s old monitor.

When they finish, even Mang Toto the trisikad driver peeks in to try it out. He adds “5 sticks of labuyo” at ₱7 each, and the total pops up: ₱35. No more mangled notebooks, no more lost scribbles. The neighborhood kids cheer, and Paula beams—her utang list has never been clearer.

And Odessa? She’s already dreaming of SariPOS v2 with persistent storage and mobile notifications. But that adventure starts next. 🇵🇭💻

---

## Theory & Lecture Content

In this lesson, we’ll learn how to:

1. Define **ES6 classes** (`class`, `constructor`, `methods`).
2. Use `Array.push()` to add elements.
3. Iterate with `forEach()` to render items.
4. Calculate totals with `reduce()`.
5. Manipulate the DOM via `innerHTML`.

### 1. ES6 Classes

```js
// Define an Item class
class Item {
  constructor(name, price) {
    this.name = name;
    this.price = price;
  }

  // Method to return HTML representation
  toHTML() {
    return `
      <li>${this.name} — ₱${this.price.toFixed(2)}</li>
    `;
  }
}
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes

### 2. Push Items into an Array

```js
const cartItems = [];
const apple = new Item("Apple", 12);
cartItems.push(apple);
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push

### 3. Render with forEach()

```js
const cartList = document.querySelector("#cart-list");
cartItems.forEach((item) => {
  cartList.innerHTML += item.toHTML();
});
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach

### 4. Calculate Total with reduce()

```js
const total = cartItems.reduce((sum, item) => sum + item.price, 0);
console.log(total); // e.g., 12.00
```

Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/ reduce

### 5. Update innerHTML Efficiently

- Avoid repeated DOM writes inside loops; build a string first.
- Use `.join('')` to combine arrays of strings.

```js
let html = "";
cartItems.forEach((item) => {
  html += item.toHTML();
});
cartList.innerHTML = html;
```

---

## Exercises

### Exercise 1: Create the Item Class

**Problem Statement**  
Define an `Item` class with `name` and `price` properties, and a method `toHTML()` that returns an `<li>` template with the name and price.

**Todo List**

- [ ] Create `class Item {}`.
- [ ] Add a `constructor(name, price)`.
- [ ] Implement `toHTML()` returning template literal.

**Starter Code**

```js
// item.js
export class Item {
  // TODO: define constructor
  // TODO: add toHTML() method
}
```

**Full Solution**

```js
// item.js
export class Item {
  constructor(name, price) {
    this.name = name;
    this.price = price;
  }

  toHTML() {
    return `<li>${this.name} — ₱${this.price.toFixed(2)}</li>`;
  }
}
```

---

### Exercise 2: Build the Cart Class & Integrate with DOM

**Problem Statement**  
Create a `Cart` class that manages items and renders them. Then wire it to an HTML form:

```html
<!-- index.html -->
<form id="pos-form">
  <input id="item-name" placeholder="Item Name" />
  <input id="item-price" type="number" placeholder="Price" />
  <button type="submit">Add to Cart</button>
  <button id="clear-cart" type="button">Clear Cart</button>
</form>
<ul id="cart-list"></ul>
<p>Total: ₱<span id="cart-total">0.00</span></p>
```

**Todo List**

- [ ] Define `class Cart { constructor() { this.items = []; } }`.
- [ ] Add `addItem(item)` method to push into `this.items`.
- [ ] Add `clearCart()` to reset `this.items`.
- [ ] Add `getTotal()` returning sum via `reduce()`.
- [ ] Add `render()` to update `#cart-list` and `#cart-total`.
- [ ] In `script.js`, instantiate `Cart`, listen for `submit` and `click`, and call methods.

**Starter Code**

```js
// cart.js
export class Cart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    // TODO
  }

  clearCart() {
    // TODO
  }

  getTotal() {
    // TODO
  }

  render(listEl, totalEl) {
    // TODO
  }
}
```

```js
// script.js
import { Item } from "./item.js";
import { Cart } from "./cart.js";

const form = document.querySelector("#pos-form");
const nameInput = document.querySelector("#item-name");
const priceInput = document.querySelector("#item-price");
const clearBtn = document.querySelector("#clear-cart");
const cartList = document.querySelector("#cart-list");
const cartTotal = document.querySelector("#cart-total");

const cart = new Cart();

form.addEventListener("submit", function (e) {
  e.preventDefault();
  // TODO: create Item, add to cart, render, clear inputs
});

clearBtn.addEventListener("click", function () {
  // TODO: clear cart and render
});
```

**Full Solution**

```js
// cart.js
export class Cart {
  constructor() {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
  }

  clearCart() {
    this.items = [];
  }

  getTotal() {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  render(listEl, totalEl) {
    const html = this.items.map((item) => item.toHTML()).join("");
    listEl.innerHTML = html;
    totalEl.textContent = this.getTotal().toFixed(2);
  }
}
```

```js
// script.js
import { Item } from "./item.js";
import { Cart } from "./cart.js";

const form = document.querySelector("#pos-form");
const nameInput = document.querySelector("#item-name");
const priceInput = document.querySelector("#item-price");
const clearBtn = document.querySelector("#clear-cart");
const cartList = document.querySelector("#cart-list");
const cartTotal = document.querySelector("#cart-total");

const cart = new Cart();

form.addEventListener("submit", function (e) {
  e.preventDefault();
  const name = nameInput.value.trim();
  const price = parseFloat(priceInput.value);

  if (!name || isNaN(price)) {
    alert("Enter valid name and price.");
    return;
  }

  const item = new Item(name, price);
  cart.addItem(item);
  cart.render(cartList, cartTotal);

  nameInput.value = "";
  priceInput.value = "";
});

clearBtn.addEventListener("click", function () {
  cart.clearCart();
  cart.render(cartList, cartTotal);
});
```

---

### Exercise 3: Improve UX with Validation & Focus

**Problem Statement**  
Enhance the form so that:

1. If the user submits with empty fields or negative price, show an alert.
2. After adding an item, focus returns to the item name input.

**Todo List**

- [ ] In `submit` handler, check `price < 0` or empty `name`.
- [ ] Alert and do not add item on invalid input.
- [ ] After successful add, call `nameInput.focus()`.

**Starter Code**

```js
form.addEventListener("submit", function (e) {
  e.preventDefault();
  const name = nameInput.value.trim();
  const price = parseFloat(priceInput.value);

  // TODO: validate inputs

  const item = new Item(name, price);
  cart.addItem(item);
  cart.render(cartList, cartTotal);

  nameInput.value = "";
  priceInput.value = "";
  // TODO: set focus back to nameInput
});
```

**Full Solution**

```js
form.addEventListener("submit", function (e) {
  e.preventDefault();
  const name = nameInput.value.trim();
  const price = parseFloat(priceInput.value);

  if (!name || isNaN(price) || price < 0) {
    alert("Please enter a valid item name and non-negative price.");
    return;
  }

  const item = new Item(name, price);
  cart.addItem(item);
  cart.render(cartList, cartTotal);

  nameInput.value = "";
  priceInput.value = "";
  nameInput.focus();
});
```

---

## Test Cases

First, install Jest:

```bash
npm install --save-dev jest
```

Add to `package.json`:

```json
"scripts": {
  "test": "jest"
},
"jest": {
  "testEnvironment": "jsdom"
}
```

Create `item.js` and `cart.js` as ES modules (shown above). Then write tests:

```js
// item.test.js
import { Item } from "./item.js";

test("Item toHTML returns correct LI string", () => {
  const item = new Item("Sardines", 25);
  const html = item.toHTML();
  expect(html).toBe("<li>Sardines — ₱25.00</li>");
});
```

```js
// cart.test.js
import { Cart } from "./cart.js";
import { Item } from "./item.js";

let cart;
beforeEach(() => {
  cart = new Cart();
});

test("addItem adds items to cart", () => {
  const item = new Item("Yakult", 7);
  cart.addItem(item);
  expect(cart.items).toHaveLength(1);
  expect(cart.items[0]).toBe(item);
});

test("getTotal returns zero for empty cart", () => {
  expect(cart.getTotal()).toBe(0);
});

test("getTotal sums item prices", () => {
  cart.addItem(new Item("Corned Beef", 45));
  cart.addItem(new Item("Piattos", 5));
  expect(cart.getTotal()).toBe(50);
});

test("clearCart removes all items", () => {
  cart.addItem(new Item("Choc Nut", 10));
  cart.clearCart();
  expect(cart.items).toHaveLength(0);
});

test("render outputs correct HTML and total", () => {
  // Set up DOM elements
  document.body.innerHTML = `
    <ul id="cart-list"></ul>
    <span id="cart-total"></span>
  `;
  const listEl = document.querySelector("#cart-list");
  const totalEl = document.querySelector("#cart-total");

  cart.addItem(new Item("Choc Nut", 10));
  cart.addItem(new Item("Yakult", 7));

  cart.render(listEl, totalEl);

  expect(listEl.innerHTML).toContain("Choc Nut");
  expect(listEl.innerHTML).toContain("Yakult");
  expect(totalEl.textContent).toBe("17.00");
});
```

Run:

```bash
npm test
```

---

## Closing Story

With SariPOS live on Paula’s monitor, each purchase is now clear as daylight. Tita Baby’s utang list resets with a single click, and Mang Toto can’t stop praising the “fancy code” that computes totals instantly. Odessa feels a rush of pride—she’s turning everyday Filipino life into clean, reliable software.

But Paula asks, “How do we keep this data even if the store’s power blinks?” Odessa smiles, eyes sparkling: **“Next lesson: we’ll explore LocalStorage and persist our cart between visits.”** And just like that, their journey continues—one feature at a time. 🚀
