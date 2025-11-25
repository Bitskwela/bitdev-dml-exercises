// Task 1: Core Drag and Drop Functions
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
