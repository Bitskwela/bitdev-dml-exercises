// Task 1: Create an Element
function createCard(title, content) {
  // CREATING DOM ELEMENTS PROGRAMMATICALLY
  // document.createElement() creates a new HTML element (not yet in page)
  const card = document.createElement("div");

  //ClassName sets the CSS class (equivalent to class="card" in HTML)
  card.className = "card";

  // Create title element (h3)
  const titleElement = document.createElement("h3");
  // textContent sets the text inside the element (safe, no HTML parsing)
  titleElement.textContent = title;
  // appendChild() adds titleElement as a child of card
  card.appendChild(titleElement);

  // Create content element (p)
  const contentElement = document.createElement("p");
  contentElement.textContent = content;
  card.appendChild(contentElement);

  // Return the constructed element (caller can add it to the page)
  return card;

  // RESULTING STRUCTURE:
  // <div class="card">
  //   <h3>title</h3>
  //   <p>content</p>
  // </div>
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
