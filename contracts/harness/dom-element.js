"use strict";

/**
 * One mock DOM element, and the selector matching that finds it.
 *
 * Split out of `dom-mock.js` to keep each file under the repo's size limit:
 * this owns what an *element* is, `dom-mock.js` owns the `document` and the
 * storage built on top of it.
 *
 * Deliberately not a DOM implementation — it is the surface ch05/ch06 lessons
 * actually touch, and nothing more. Host-independent ES2020 so Node and QuickJS
 * behave identically.
 */

/** Events whose default action a handler may cancel. */
const CANCELABLE = ["submit", "click", "keydown", "keypress"];

/** Build the `classList` API over an element's `className`. */
function createClassList(element) {
  const list = () => element.className.split(/\s+/).filter(Boolean);
  const write = (names) => {
    element.className = names.join(" ");
  };
  return {
    add(...names) {
      const next = list();
      for (const name of names) if (!next.includes(name)) next.push(name);
      write(next);
    },
    remove(...names) {
      write(list().filter((name) => !names.includes(name)));
    },
    toggle(name) {
      const has = list().includes(name);
      if (has) this.remove(name);
      else this.add(name);
      return !has;
    },
    contains(name) {
      return list().includes(name);
    },
  };
}

/**
 * Create one detached element.
 *
 * @param tagName - Upper-cased on the element, as a browser reports it.
 * @param selector - The selector it answers to, for readable failure messages.
 */
function createElement(tagName, selector) {
  const listeners = new Map();

  const element = {
    tagName: String(tagName || "div").toUpperCase(),
    selector: selector || "",
    id: "",
    draggable: false,
    innerText: "",
    textContent: "",
    innerHTML: "",
    value: "",
    checked: false,
    disabled: false,
    className: "",
    style: {},
    dataset: {},
    attributes: {},
    children: [],
    parentNode: null,

    setAttribute(name, value) {
      this.attributes[name] = String(value);
    },
    getAttribute(name) {
      return Object.hasOwn(this.attributes, name) ? this.attributes[name] : null;
    },
    removeAttribute(name) {
      delete this.attributes[name];
    },

    addEventListener(type, handler) {
      if (typeof handler !== "function") return;
      if (!listeners.has(type)) listeners.set(type, []);
      listeners.get(type).push(handler);
    },
    removeEventListener(type, handler) {
      const bucket = listeners.get(type);
      if (!bucket) return;
      const at = bucket.indexOf(handler);
      if (at !== -1) bucket.splice(at, 1);
    },
    /** Handler types registered on this element, for assertions. */
    listenerTypes() {
      return [...listeners.keys()];
    },

    appendChild(child) {
      this.children.push(child);
      if (child) child.parentNode = this;
      return child;
    },
    removeChild(child) {
      const at = this.children.indexOf(child);
      if (at !== -1) this.children.splice(at, 1);
      return child;
    },
    remove() {
      if (this.parentNode) this.parentNode.removeChild(this);
    },
    focus() {},
    blur() {},

    /**
     * First descendant matching `selector`, or `null`.
     *
     * Scoped to this element's subtree, unlike `document.querySelector` — a
     * lesson that removes a card from *its* container must not reach one
     * elsewhere on the page.
     */
    querySelector(selector) {
      return descendants(this).find((node) => matches(node, selector)) || null;
    },
    /** Every descendant matching `selector`. */
    querySelectorAll(selector) {
      return descendants(this).filter((node) => matches(node, selector));
    },
    /** Nearest self-or-ancestor matching `selector`, as the DOM defines it. */
    closest(selector) {
      let node = this;
      while (node) {
        if (matches(node, selector)) return node;
        node = node.parentNode;
      }
      return null;
    },

    /**
     * Run every handler registered for `event.type`.
     *
     * @returns False when a handler called `preventDefault`, mirroring the DOM
     *   so a test can prove a form submit was actually intercepted.
     */
    dispatchEvent(event) {
      let defaultPrevented = false;
      const detail = {
        ...event,
        target: this,
        currentTarget: this,
        preventDefault() {
          defaultPrevented = true;
        },
        stopPropagation() {},
      };
      for (const handler of listeners.get(event.type) || []) {
        handler.call(this, detail);
      }
      return !defaultPrevented;
    },
  };

  element.classList = createClassList(element);
  return element;
}

/**
 * Whether an element matches a simple selector.
 *
 * Supports the four forms these lessons use — `[attr="value"]`, `#id`,
 * `.class` and a bare tag. Anything more is not silently "no match": it is not
 * supported, and a lesson needing it should extend this deliberately.
 */
function matches(element, selector) {
  const query = String(selector).trim();

  const attribute = /^\[([\w-]+)=["']?([^\]"']*)["']?\]$/.exec(query);
  if (attribute) {
    const [, name, value] = attribute;
    const dataKey = name.startsWith("data-") ? name.slice(5) : null;
    const actual =
      element.getAttribute(name) ??
      (dataKey && Object.hasOwn(element.dataset, dataKey)
        ? element.dataset[dataKey]
        : null);
    return actual === value;
  }
  if (query.startsWith("#")) {
    const id = query.slice(1);
    return element.id === id || element.getAttribute("id") === id;
  }
  if (query.startsWith(".")) return element.classList.contains(query.slice(1));
  return element.tagName === query.toUpperCase();
}

/** Depth-first walk of an element's descendants. */
function descendants(element) {
  const out = [];
  for (const child of element.children) {
    out.push(child, ...descendants(child));
  }
  return out;
}

/** Guess a tag from a selector, so `input#email` reports as an INPUT. */
function tagFor(selector) {
  const match = /^([a-zA-Z]+)/.exec(String(selector));
  return match ? match[1] : "div";
}

module.exports = { CANCELABLE, createElement, descendants, matches, tagFor };
