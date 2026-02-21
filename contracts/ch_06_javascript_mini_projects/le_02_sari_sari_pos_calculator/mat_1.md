## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_6/C6+2.0+-+COVER.png)

Every afternoon, Odessa visits Paula’s neighborhood sari-sari store in Quezon City. The narrow aisle is crammed with canned goods, sticks of chichirya, bottles of Yakult, and stacks of instant noodles. Paula’s Tita Baby often buys corned beef, two Yakults, and five piattos—sometimes on utang (credit)—and Paula scribbles everything in a worn notebook. By closing time, the “utang list” is a tangled mess of crossed-out items and forgotten totals.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_6/C6+2.1.png)

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

## Closing Story

With SariPOS live on Paula’s monitor, each purchase is now clear as daylight. Tita Baby’s utang list resets with a single click, and Mang Toto can’t stop praising the “fancy code” that computes totals instantly. Odessa feels a rush of pride—she’s turning everyday Filipino life into clean, reliable software.

But Paula asks, “How do we keep this data even if the store’s power blinks?” Odessa smiles, eyes sparkling: **“Next lesson: we’ll explore LocalStorage and persist our cart between visits.”** And just like that, their journey continues—one feature at a time. 🚀
