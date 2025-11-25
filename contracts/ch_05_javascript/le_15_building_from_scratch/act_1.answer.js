// Task 1: Create an Element
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

// Task 2: Append Multiple Elements
function createList(items) {
  const ul = document.createElement("ul");

  for (let i = 0; i < items.length; i++) {
    const li = document.createElement("li");
    li.textContent = items[i];
    ul.appendChild(li);
  }

  return ul;
}

// Task 3: Remove an Element
function removeCardById(id, container) {
  const card = container.querySelector(`[data-id="${id}"]`);

  if (card) {
    container.removeChild(card);
    return true;
  }

  return false;
}
