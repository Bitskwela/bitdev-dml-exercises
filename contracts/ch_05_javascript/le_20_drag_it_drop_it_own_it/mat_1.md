## Background Story

It was a busy Monday morning at a co-working space in Bonifacio Global City. Odessa was sipping her kapeng barako ☕️ while watching freelancers shuffle sticky notes on whiteboards. One group had a Kanban board drawn on a roll of kraft paper—“To Do,” “In Progress,” “Done.” But every time someone moved a note, they had to peel and re-stick it, leaving glue marks like EDSA traffic jams.

Odessa thought, “What if I make this digital, drag-and-drop style, like Trello?” 🚀 She imagined tasks you could grab with a mouse, drag from column to column, and drop with a satisfying animation. This feature would delight clients and speed up workflows—perfect for her logistics startup’s internal tool.

She sketched the UI: three columns (`#todo`, `#inProgress`, `#done`), each a `<div>` with tasks inside. Each task card would be a `<div draggable="true">`. With JavaScript’s `dragstart`, `dragover`, `drop`, and `dragend` events, she could wire up the logic. For a smooth feel, she’d add a CSS class during dragging—cards would scale up slightly and cast a shadow.

By afternoon, her prototype was live. She dragged a “Pack orders” card from “To Do” into “In Progress,” watching it glide and snap into place. Fellow devs gathered around her laptop, applauding the smooth UX. Clients started talking about adopting her Kanban board—and Odessa realized this drag-and-drop feature might be the spark for her next startup pitch.

Today, you’ll learn how to build that interactive task board: handling drag events, combining CSS animations with JS, and creating reusable code. Let’s drag it, drop it, own it! 🎉

---

## Theory & Lecture Content

### 1. Drag Events Overview

- **dragstart**: Fires when dragging begins.
- **dragover**: Fires when a dragged element is over a drop target—you must `event.preventDefault()` to allow drop.
- **drop**: Fires when the dragged element is released over a target.
- **dragend**: Fires when dragging ends (useful for cleanup).

### 2. Basic HTML Structure

```html
<div class="column" id="todo">
  <h2>To Do</h2>
  <!-- task cards go here -->
</div>
<div class="column" id="inProgress">
  <h2>In Progress</h2>
</div>
<div class="column" id="done">
  <h2>Done</h2>
</div>
```

Each `.column` is a drop zone; each task card is `draggable`.

### 3. JavaScript APIs

#### allowDrop(event)

```js
function allowDrop(evt) {
  evt.preventDefault(); // enable dropping
}
```

#### drag(event)

```js
function drag(evt) {
  evt.dataTransfer.setData("text/plain", evt.target.id);
  // optional: add CSS class for visual cue
  evt.target.classList.add("dragging");
}
```

#### drop(event)

```js
function drop(evt) {
  evt.preventDefault();
  const id = evt.dataTransfer.getData("text/plain");
  const card = document.getElementById(id);
  evt.target.appendChild(card);
  card.classList.remove("dragging");
}
```

#### dragend(event)

```js
function dragEnd(evt) {
  evt.target.classList.remove("dragging");
}
```

### 4. CSS/Animation Combo

```css
.column {
  border: 2px dashed #ccc;
  padding: 10px;
  min-height: 200px;
  transition: background 0.3s;
}
.column.over {
  background: #f0f8ff;
}

.task-card {
  padding: 8px;
  margin: 5px 0;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
  transition: transform 0.2s, box-shadow 0.2s;
}

.task-card.dragging {
  opacity: 0.7;
  transform: scale(1.05);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}
```

### 5. Wiring It Up

```html
<script>
  const cols = document.querySelectorAll(".column");
  cols.forEach((col) => {
    col.addEventListener("dragover", allowDrop);
    col.addEventListener("drop", drop);
    col.addEventListener("dragenter", () => col.classList.add("over"));
    col.addEventListener("dragleave", () => col.classList.remove("over"));
  });

  const cards = document.querySelectorAll(".task-card");
  cards.forEach((card) => {
    card.addEventListener("dragstart", drag);
    card.addEventListener("dragend", dragEnd);
  });
</script>
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/API/HTML_Drag_and_Drop_API

---

## Closing Story

With drag-and-drop and slick animations, Odessa’s task board prototype felt as smooth as sliding sticky notes on glass. Investors at co-working spaces tapped their screens, imagining their own workflows transformed. The first draft of her pitch deck highlighted this interactive board—proof that a simple drag event could spark a whole startup.

Next up, Odessa will wire this board into a real backend: fetching and saving tasks via REST APIs with `fetch` and async/await. She’s building end-to-end features now—from front-end drag events to persistent data storage. The journey continues, one draggable card at a time! 🚀
