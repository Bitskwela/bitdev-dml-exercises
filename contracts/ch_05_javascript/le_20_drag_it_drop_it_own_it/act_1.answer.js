// Task 1: Core Drag and Drop Functions
// DRAG AND DROP API: HTML5 feature for draggable elements

function allowDrop(evt) {
  // preventDefault() is REQUIRED to allow dropping
  // By default, browsers don't allow dropping on most elements
  evt.preventDefault();
}

function drag(evt) {
  // DRAG START: User begins dragging an element

  // dataTransfer stores data during drag operation
  // setData(format, data) stores the dragged element's ID
  evt.dataTransfer.setData("text/plain", evt.target.id);

  // Add visual feedback: element is being dragged
  evt.target.classList.add("dragging");
}

function drop(evt) {
  // DROP: User releases the dragged element

  evt.preventDefault(); // Prevent default action (e.g., opening link)

  // getData() retrieves the ID we stored in drag()
  const id = evt.dataTransfer.getData("text/plain");

  // Find the dragged element by ID
  const card = document.getElementById(id);

  // Find the drop target column
  // closest() searches up the DOM tree for matching element
  const column = evt.target.closest(".column");

  // Move the card to the new column
  column.appendChild(card);

  // Remove dragging visual feedback
  card.classList.remove("dragging");
}

function dragEnd(evt) {
  // DRAG END: Drag operation finished (whether dropped or cancelled)
  evt.target.classList.remove("dragging");
}

// Task 2: Create a Draggable Task Card
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

// Task 3: Wire Up Drag Events to Columns
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

// Initialize on page load
document.addEventListener("DOMContentLoaded", function () {
  setupDragAndDrop();

  // Example: Add a new task card
  const todoColumn = document.querySelector("#todo");
  const newCard = createTaskCard("task3", "New Task");
  todoColumn.appendChild(newCard);
});
