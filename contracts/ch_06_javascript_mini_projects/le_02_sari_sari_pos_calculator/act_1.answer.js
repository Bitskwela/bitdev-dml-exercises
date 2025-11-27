// Task 1: Create the Item Class
class Item {
  constructor(name, price) {
    this.name = name;
    this.price = price;
  }

  toHTML() {
    return `<li>${this.name} — ₱${this.price.toFixed(2)}</li>`;
  }
}

// Task 2: Create the Cart Class
class Cart {
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
    return this.items.reduce(function (sum, item) {
      return sum + item.price;
    }, 0);
  }

  render(listEl, totalEl) {
    const html = this.items
      .map(function (item) {
        return item.toHTML();
      })
      .join("");

    listEl.innerHTML = html;
    totalEl.textContent = this.getTotal().toFixed(2);
  }
}

// Task 3: Wire Up the Form
function setupPOS() {
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

    if (!name || isNaN(price) || price < 0) {
      alert("Enter valid name and price.");
      return;
    }

    const item = new Item(name, price);
    cart.addItem(item);
    cart.render(cartList, cartTotal);

    nameInput.value = "";
    priceInput.value = "";
    nameInput.focus();
  });

  clearBtn.addEventListener("click", function () {
    cart.clearCart();
    cart.render(cartList, cartTotal);
  });
}

document.addEventListener("DOMContentLoaded", setupPOS);
