# Drag and Drop Activity

## Initial Code

```js
// Task 1: Core Drag and Drop Functions
function allowDrop(evt) {
  // Add your code here
}

function drag(evt) {
  // Add your code here
}

function drop(evt) {
  // Add your code here
}

function dragEnd(evt) {
  // Add your code here
}

// Task 2: Create a Draggable Task Card
function createTaskCard(id, text) {
  // Add your code here
}

// Task 3: Wire Up Drag Events to Columns
function setupDragAndDrop() {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `dragstart`, `dragover`, `drop`, `dragend`, `dataTransfer`, `preventDefault()`, `classList`, `draggable` Attribute

---

### Task 1: Core Drag and Drop Functions

Implement the four core drag and drop event handler functions:

- `allowDrop(evt)` - prevents default to allow dropping
- `drag(evt)` - stores the dragged element's ID and adds a visual class
- `drop(evt)` - retrieves the dragged element and appends it to the drop target
- `dragEnd(evt)` - removes the visual dragging class

```js
function allowDrop(evt) {
  evt.preventDefault();
}

function drag(evt) {
  evt.dataTransfer.setData("text/plain", evt.target.id);
  evt.target.classList.add("dragging");
}

function drop(evt) {
  evt.preventDefault();
  const id = evt.dataTransfer.getData("text/plain");
  const card = document.getElementById(id);
  const column = evt.target.closest(".column");
  column.appendChild(card);
  card.classList.remove("dragging");
}

function dragEnd(evt) {
  evt.target.classList.remove("dragging");
}
```

---

### Task 2: Create a Draggable Task Card

Create a function that dynamically creates a task card element with drag event listeners attached. The card should be a `<div>` with class `task-card`, set to draggable, with the given id and text.

```js
function createTaskCard(id, text) {
  const card = document.createElement("div");
  card.className = "task-card";
  card.draggable = true;
  card.id = id;
  card.textContent = text;

  card.addEventListener("dragstart", drag);
  card.addEventListener("dragend", dragEnd);

  return card;
}
```

---

### Task 3: Wire Up Drag Events to Columns

Create a function that sets up drag and drop on all `.column` elements. Each column should listen for `dragover` and `drop` events. Also add visual feedback with `dragenter` and `dragleave` to toggle an `over` class.

```js
function setupDragAndDrop() {
  const columns = document.querySelectorAll(".column");

  columns.forEach(function (column) {
    column.addEventListener("dragover", allowDrop);
    column.addEventListener("drop", drop);

    column.addEventListener("dragenter", function () {
      column.classList.add("over");
    });

    column.addEventListener("dragleave", function () {
      column.classList.remove("over");
    });
  });
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `evt`: The event object passed to drag and drop event handlers. Contains information about the drag operation.

- `id`: A string storing the dragged element's ID, transferred via `dataTransfer`.

- `card`: The DOM element being dragged, retrieved using `document.getElementById()`.

- `column`: The drop target column element, found using `closest(".column")`.

- `text`: A string parameter for the task card's display text.

- `columns`: A NodeList of all column elements selected with `querySelectorAll`.

**Key Concepts:**

- Drag Events:

  - `dragstart`: Fires when drag begins. Store data about what's being dragged.
  - `dragover`: Fires continuously while dragging over a target. Must call `preventDefault()` to allow drop.
  - `drop`: Fires when the element is released. Move the element to the new location.
  - `dragend`: Fires when drag ends. Clean up visual states.

- `dataTransfer` API:
  Used to pass data between drag and drop events. `setData()` stores data, `getData()` retrieves it.

- `draggable` Attribute:
  HTML attribute that makes an element draggable. Set to `true` to enable dragging.

- `preventDefault()`:
  Must be called in `dragover` and `drop` handlers. The default behavior is to NOT allow drops.

- `closest()`:
  DOM method that finds the nearest ancestor matching a selector. Useful when dropping on child elements.

- Visual Feedback:
  Adding/removing CSS classes during drag provides user feedback. The `dragging` class on the card and `over` class on columns.

**Key Functions:**

- `allowDrop(evt)`:
  Prevents the default browser behavior to enable dropping. Without this, drop won't work.

- `drag(evt)`:
  Stores the dragged element's ID in dataTransfer and adds visual feedback class.

- `drop(evt)`:
  Retrieves the dragged element using stored ID and moves it to the drop target column.

- `dragEnd(evt)`:
  Cleanup function that removes the dragging visual class regardless of where the element was dropped.

- `createTaskCard(id, text)`:
  Factory function that creates fully configured draggable task cards with event listeners attached.

- `setupDragAndDrop()`:
  Initialization function that wires up all columns as drop zones with appropriate event handlers.
