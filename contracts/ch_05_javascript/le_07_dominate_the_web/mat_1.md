## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+7.0+-+COVER.png)

Odessa's journey into the world of web development takes an exciting turn as she learns to connect her JavaScript logic to a webpage. By integrating her script with the Document Object Model (DOM), Odessa can now manipulate the content live on the screen, bringing her applications to life.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+7.1.png)

One of the first tasks Odessa takes on is updating her organization's online bulletin board. With the power of JavaScript and the DOM, she can ensure that the bulletin board updates automatically with new information, making the website more dynamic and engaging for users.

As Odessa witnesses her script interact with the browser, changing text, styles, and even adding new elements to the webpage, she is amazed by the potential of this technology. This hands-on experience of bridging the gap between code and visual output empowers her to create impactful web solutions that resonate with users.

With topics like `document.querySelector`, `innerText`, and DOM events under her belt, Odessa is ready to DOM-inate the web and unlock a new level of creativity in her web development journey.

## Theory & Lecture Content

The **Document Object Model (DOM)** is the browser's live, in-memory representation of an HTML page. The browser parses your HTML into a tree of objects (nodes), and JavaScript can read and rewrite that tree on the fly. Change a node, and the page updates instantly. This is what turns a static document into an *application*.

```
document
 └── html
      └── body
           ├── h1#welcome
           ├── button#alertBtn
           └── div#status
```

### Selecting Elements

Before you can change something, you have to grab it. Modern code uses two methods that accept any CSS selector:

```js
// querySelector returns the FIRST match (or null if none)
const heading = document.querySelector("h1"); // by tag
const welcome = document.querySelector("#welcome"); // by id
const firstCard = document.querySelector(".card"); // by class

// querySelectorAll returns ALL matches as a NodeList
const allCards = document.querySelectorAll(".card");
allCards.forEach((card) => console.log(card.innerText));
```

`querySelector` always returns either an element or `null`, so guard against `null` when an element might not exist:

```js
const banner = document.querySelector("#banner");
if (banner) {
  banner.innerText = "Welcome back!";
}
```

### Reading and Changing Content

Once you hold an element, three properties cover most needs:

```js
const status = document.querySelector("#status");

status.innerText = "Saved!"; // visible text only (respects styling)
status.textContent = "Saved!"; // raw text, faster, ignores CSS visibility
status.innerHTML = "<strong>Saved!</strong>"; // parses HTML — use with care
```

Prefer `innerText`/`textContent` for plain text. Only use `innerHTML` when you intentionally need markup, because injecting untrusted strings as HTML opens the door to cross-site scripting (XSS).

### Changing Styles and Attributes

```js
const box = document.querySelector("#box");

box.style.display = "none"; // hide it
box.style.backgroundColor = "tomato"; // note: camelCase, not background-color
box.classList.add("active"); // add a CSS class
box.classList.toggle("open"); // flip it on/off
box.setAttribute("data-id", "42"); // any attribute
```

Reaching for `classList` and a CSS class is usually cleaner than setting many inline `style` properties one by one.

### DOM Events

An **event** is something that happens on the page — a click, a keypress, a form submit. `addEventListener` lets your code react to it:

```js
const button = document.querySelector("#alertBtn");

button.addEventListener("click", function () {
  document.querySelector("#status").innerText = "Button was clicked!";
});
```

The function you pass is the *handler* (or callback). It runs every time the event fires. You can read details from the `event` object the browser hands you:

```js
button.addEventListener("click", function (event) {
  console.log(event.target); // the element that was clicked
  event.preventDefault(); // stop the default browser behavior
});
```

For more, see the [MDN documentation on the Document Object Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model).

### Common Beginner Mistakes ⚠️

**1. Running your script before the HTML exists**

```js
// ❌ If this <script> runs in <head>, #welcome isn't on the page yet → null
const el = document.querySelector("#welcome");
el.innerText = "Hi"; // TypeError: Cannot set properties of null

// ✅ Put the script at the end of <body>, or wait for the DOM to load
document.addEventListener("DOMContentLoaded", () => {
  document.querySelector("#welcome").innerText = "Hi";
});
```

**2. Forgetting the `#` or `.` in a selector**

```js
document.querySelector("welcome"); // ❌ looks for a <welcome> tag
document.querySelector("#welcome"); // ✅ looks for id="welcome"
```

**3. Confusing `innerText` with `value`**

```js
const input = document.querySelector("#name");
console.log(input.innerText); // ❌ empty for form fields
console.log(input.value); // ✅ inputs store their content in .value
```

**4. Calling the handler instead of passing it**

```js
button.addEventListener("click", handleClick()); // ❌ runs NOW, passes its return value
button.addEventListener("click", handleClick); // ✅ pass the function itself
```

**5. Using `=` to add a class and wiping the rest**

```js
box.className = "active"; // ❌ erases every other class on the element
box.classList.add("active"); // ✅ adds without removing the others
```

## Closing Story

Odessa's exploration of the Document Object Model (DOM) opens up a whole new dimension in her web development journey. By connecting her JavaScript logic to the webpage, she can now create dynamic and interactive experiences for users, like the automatic update feature on her organization's bulletin board.

With the ability to target and modify elements on the webpage using methods like `document.querySelector` and properties like `innerText`, Odessa realizes the power of code in shaping the user experience. The thrill of seeing her script come to life on the screen fuels her passion for web development even more.

Join Odessa in the next lesson as she dives into more advanced topics like handling form submissions, manipulating styles with JavaScript, and implementing AJAX requests. As she continues to hone her skills, the possibilities of what she can achieve on the web become even more exciting.
