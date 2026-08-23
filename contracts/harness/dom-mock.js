"use strict";

/**
 * The `document`, Web Storage, and the test-facing helpers built on them.
 *
 * ch05/ch06 lessons manipulate the page directly — `document.querySelector`,
 * `element.innerText`, `addEventListener` — so without these globals their
 * answers throw before a single assertion runs.
 *
 * **Elements are created lazily and cached by selector.** A real page has the
 * markup already; here the first `querySelector("#status")` invents the element
 * and every later query — from the answer *or* the test — gets that same
 * object. Two consequences that matter: a lesson's `querySelector` never
 * returns `null` (which would throw and mask the real failure), and a test can
 * observe exactly what the submission mutated.
 *
 * What an element *is* lives in `dom-element.js`.
 */

const {
  CANCELABLE,
  createElement,
  matches,
  tagFor,
} = require("./dom-element");

function createDom(spec) {
  const bySelector = new Map();
  /** Elements the spec declared, which a query can return several of. */
  const fixture = [];

  /** The element a selector refers to, invented on first reference. */
  const el = (selector) => {
    const key = String(selector);
    // A declared element wins, so `el("#home")` in a test and
    // `querySelectorAll("section")` in the answer are the same object.
    const declared = fixture.find((node) => matches(node, key));
    if (declared) return declared;
    if (!bySelector.has(key)) {
      bySelector.set(key, createElement(tagFor(key), key));
    }
    return bySelector.get(key);
  };

  // `spec.dom.elements` exists for the lessons that need *several* distinct
  // elements behind one selector — `querySelectorAll("section")` over three
  // screens, say, which lazy creation cannot express. Lessons that only ever
  // query by id need declare nothing.
  for (const described of (spec && spec.dom && spec.dom.elements) || []) {
    const node = createElement(described.tag || "div", described.id ? `#${described.id}` : "");
    if (described.id) {
      node.id = described.id;
      node.setAttribute("id", described.id);
    }
    if (described.class) node.className = described.class;
    if (described.value !== undefined) node.value = described.value;
    if (described.text !== undefined) node.textContent = described.text;
    fixture.push(node);
  }

  /**
   * Make an element discoverable by id as soon as one is assigned.
   *
   * `id` becomes an accessor so the plain `card.id = "task3"` a lesson writes
   * is what registers it — no extra call for a student to forget.
   */
  const register = (node) => {
    let assigned = node.id;
    Object.defineProperty(node, "id", {
      enumerable: true,
      get: () => assigned,
      set(value) {
        assigned = String(value);
        node.setAttribute("id", assigned);
        if (!fixture.includes(node)) fixture.push(node);
      },
    });
    return node;
  };

  const queryAll = (selector) => {
    const hits = fixture.filter((node) => matches(node, selector));
    // No declared match: fall back to the lazily-created element, so a lesson
    // with no fixture behaves exactly as it did before fixtures existed.
    return hits.length > 0 ? hits : [el(selector)];
  };

  const document = {
    querySelector: (selector) => queryAll(selector)[0],
    querySelectorAll: (selector) => queryAll(selector),
    getElementById: (id) => el(`#${id}`),
    // An element becomes findable the moment it is given an id. A real DOM
    // requires it to be attached first, but a lesson that builds a card and
    // then looks it up by id is doing the normal thing, and failing that
    // lookup would report a confusing null rather than the real mistake.
    createElement: (tagName) => register(createElement(tagName, "")),
    addEventListener: () => {},
    removeEventListener: () => {},
    get body() {
      return el("body");
    },
  };

  /**
   * Dispatch an event at a selector's element.
   *
   * @param selector - Which element to fire at.
   * @param type - Event type, e.g. `"click"` or `"submit"`.
   * @param props - Extra event fields, e.g. `{ key: "Enter" }`.
   * @returns False when a handler prevented the default.
   */
  const fire = (selector, type, props = {}) =>
    el(selector).dispatchEvent({
      type,
      cancelable: CANCELABLE.includes(type),
      ...props,
    });

  const store = new Map();
  const localStorage = {
    // Absent keys read as `null`, not `undefined` — lessons branch on it.
    getItem: (key) => (store.has(String(key)) ? store.get(String(key)) : null),
    setItem: (key, value) => {
      store.set(String(key), String(value));
    },
    removeItem: (key) => {
      store.delete(String(key));
    },
    clear: () => {
      store.clear();
    },
    key: (index) => [...store.keys()][index] ?? null,
    get length() {
      return store.size;
    },
  };

  return { document, localStorage, el, fire };
}

module.exports = { createDom };
