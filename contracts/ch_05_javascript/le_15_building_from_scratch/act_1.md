# Dynamic DOM Creation Activity

## Initial Code

```js
// Task 1: Create an Element
function createCard(title, content) {
  // Add your code here
}

// Task 2: Append Multiple Elements
function createList(items) {
  // Add your code here
}

// Task 3: Remove an Element
function removeCardById(id, container) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `document.createElement`, `appendChild`, `removeChild`, `setAttribute`, `textContent`, `className`

---

### Task 1: Create an Element

Create a function that builds a card element with a title and content. The function should create a `<div>` with class "card", and inside it create an `<h3>` for the title and a `<p>` for the content. Return the card element.

```js
function createCard(title, content) {
  const card = document.createElement("div");
  card.className = "card";

  const titleElement = document.createElement("h3");
  titleElement.textContent = title;
  card.appendChild(titleElement);

  const contentElement = document.createElement("p");
  contentElement.textContent = content;
  card.appendChild(contentElement);

  return card;
}
```

---

### Task 2: Append Multiple Elements

Create a function that takes an array of strings and creates a `<ul>` list. For each item in the array, create an `<li>` element and append it to the list. Return the `<ul>` element.

```js
function createList(items) {
  const ul = document.createElement("ul");

  for (let i = 0; i < items.length; i++) {
    const li = document.createElement("li");
    li.textContent = items[i];
    ul.appendChild(li);
  }

  return ul;
}
```

---

### Task 3: Remove an Element

Create a function that removes a card element by its `data-id` attribute. The function takes an `id` and a `container` element. Find the card with the matching `data-id` and remove it from the container. Return `true` if removed, `false` if not found.

```js
function removeCardById(id, container) {
  const card = container.querySelector(`[data-id="${id}"]`);

  if (card) {
    container.removeChild(card);
    return true;
  }

  return false;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `title`: A string parameter representing the heading text for the card.

- `content`: A string parameter representing the body text for the card.

- `card`: A `<div>` element created to serve as the card container. Has class "card" applied.

- `titleElement`: An `<h3>` element created to display the card's title.

- `contentElement`: A `<p>` element created to display the card's content.

- `items`: An array of strings to be converted into list items.

- `ul`: A `<ul>` element that serves as the container for list items.

- `li`: A `<li>` element created for each item in the array.

- `id`: A string parameter used to find elements by their `data-id` attribute.

- `container`: An HTML element that contains the cards to be searched/modified.

**Key Concepts:**

- `document.createElement(tagName)`:
  Creates a new HTML element of the specified type. The element exists only in memory until appended to the document.

- `element.className`:
  Sets or gets the class attribute of an element. Replaces all existing classes. Use `classList.add()` to add without replacing.

- `element.textContent`:
  Sets or gets the text content of an element. Safer than `innerHTML` as it doesn't parse HTML, preventing XSS attacks.

- `element.appendChild(child)`:
  Adds a node as the last child of a parent element. The child is moved if it already exists elsewhere in the document.

- `element.removeChild(child)`:
  Removes a child node from its parent. The removed node still exists in memory and can be reinserted.

- `element.setAttribute(name, value)`:
  Sets a custom attribute on an element. Commonly used for `data-*` attributes like `data-id`.

- `element.querySelector(selector)`:
  Finds the first element matching a CSS selector within the element's descendants. Returns `null` if not found.

**Key Functions:**

- `createCard(title, content)`:
  Demonstrates creating nested elements dynamically. Shows the pattern of creating a container, adding children, and returning the result.

- `createList(items)`:
  Shows how to loop through data and create corresponding DOM elements. Demonstrates building a list structure programmatically.

- `removeCardById(id, container)`:
  Demonstrates finding elements by attribute selector and removing them from the DOM. Shows proper null checking before removal.
