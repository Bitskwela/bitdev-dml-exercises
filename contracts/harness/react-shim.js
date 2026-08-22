"use strict";

/**
 * Minimal React implementation for grading dApp exercises.
 *
 * Deliberately dependency-free ES2020: the same file runs under Node (content
 * authoring + CI golden gate) and under QuickJS (the `blockskwela-rs` grader).
 * Only the JSX transform differs by host — esbuild in Node, SWC in Rust.
 *
 * It is not React. It is the smallest thing that renders a function component,
 * runs its hooks, and exposes a queryable tree, which is all a lesson's
 * acceptance criteria ever need.
 */

/** Renders past which a state loop is treated as runaway rather than settling. */
const MAX_RENDER_PASSES = 50;

/** Hook slots per component path, surviving across render passes. */
let hookStore = new Map();
/** Path of the component currently rendering, and its hook cursor. */
let cursor = { path: "", index: 0 };
/** Effects queued by the pass in progress. */
let pendingEffects = [];
/** Set when a hook setter changes a value, so the tree is rendered again. */
let dirty = false;

/** Reset all module state. Called before each independent render. */
function resetRuntime() {
  hookStore = new Map();
  cursor = { path: "", index: 0 };
  pendingEffects = [];
  dirty = false;
}

/** Slots for the component currently rendering. */
function slots() {
  let list = hookStore.get(cursor.path);
  if (!list) {
    list = [];
    hookStore.set(cursor.path, list);
  }
  return list;
}

/** React.useState. The setter accepts a value or an updater, as React's does. */
function useState(initial) {
  const list = slots();
  const i = cursor.index++;
  if (list.length <= i) {
    list[i] = { value: typeof initial === "function" ? initial() : initial };
  }
  const slot = list[i];
  const setter = (next) => {
    const value = typeof next === "function" ? next(slot.value) : next;
    // Bail out on an unchanged value so a setState in an effect cannot spin.
    if (Object.is(value, slot.value)) return;
    slot.value = value;
    dirty = true;
  };
  return [slot.value, setter];
}

/** True when two dependency arrays should be considered equal. */
function sameDeps(a, b) {
  if (!a || !b || a.length !== b.length) return false;
  return a.every((dep, i) => Object.is(dep, b[i]));
}

/** React.useEffect. Cleanups run before the effect re-fires and on teardown. */
function useEffect(fn, deps) {
  const list = slots();
  const i = cursor.index++;
  const prev = list[i];
  if (prev && prev.kind === "effect" && sameDeps(prev.deps, deps)) return;

  const slot = { kind: "effect", deps, cleanup: prev && prev.cleanup };
  list[i] = slot;
  pendingEffects.push(slot, fn);
}

/** React.useMemo. */
function useMemo(fn, deps) {
  const list = slots();
  const i = cursor.index++;
  const prev = list[i];
  if (prev && prev.kind === "memo" && sameDeps(prev.deps, deps)) return prev.value;
  const value = fn();
  list[i] = { kind: "memo", deps, value };
  return value;
}

/** React.useCallback. */
function useCallback(fn, deps) {
  return useMemo(() => fn, deps);
}

/** React.useRef. */
function useRef(initial) {
  const list = slots();
  const i = cursor.index++;
  if (list.length <= i) list[i] = { current: initial };
  return list[i];
}

/** Marker type for `<>…</>`. */
const Fragment = { $$fragment: true };

/**
 * React.createElement.
 *
 * Children are flattened and stripped of the values JSX renders as nothing
 * (`null`, `undefined`, `true`, `false`) so `{cond && <p/>}` behaves as in React.
 */
function createElement(type, props, ...children) {
  const rest = props ? { ...props } : {};
  const nested = rest.children !== undefined ? [rest.children] : [];
  delete rest.children;
  const kids = [...children, ...nested]
    .flat(Infinity)
    .filter((c) => c !== null && c !== undefined && c !== false && c !== true);
  return { $$element: true, type, props: rest, children: kids };
}

/** True for a value produced by {@link createElement}. */
function isElement(node) {
  return Boolean(node) && node.$$element === true;
}

/**
 * Render a node to a host tree, invoking any function components it contains.
 *
 * `path` keys the hook store, so each component instance keeps its own state
 * across passes as long as the tree shape is stable — the same assumption
 * React's own reconciler makes.
 */
function renderNode(node, path) {
  if (node === null || node === undefined || typeof node === "boolean") return null;
  if (!isElement(node)) return { text: String(node) };

  if (typeof node.type === "function") {
    const previous = cursor;
    cursor = { path, index: 0 };
    let produced;
    try {
      produced = node.type({ ...node.props, children: node.children });
    } finally {
      cursor = previous;
    }
    return renderNode(produced, `${path}/fn`);
  }

  const tag = node.type === Fragment ? "#fragment" : String(node.type);
  const children = node.children
    .map((child, i) => renderNode(child, `${path}/${tag}:${i}`))
    .filter((c) => c !== null);
  return { tag, props: node.props, children };
}

/** Run every effect queued by the pass that just finished. */
function runPendingEffects() {
  const queued = pendingEffects;
  pendingEffects = [];
  for (let i = 0; i < queued.length; i += 2) {
    const slot = queued[i];
    const fn = queued[i + 1];
    if (typeof slot.cleanup === "function") {
      slot.cleanup();
      slot.cleanup = undefined;
    }
    const cleanup = fn();
    if (typeof cleanup === "function") slot.cleanup = cleanup;
  }
}

/** True when a state update landed since the last pass. */
function isDirty() {
  return dirty;
}

/** Clear the dirty flag ahead of another pass. */
function clearDirty() {
  dirty = false;
}

/** Run every registered effect cleanup, as an unmount would. */
function runAllCleanups() {
  for (const list of hookStore.values()) {
    for (const slot of list) {
      if (slot && typeof slot.cleanup === "function") slot.cleanup();
    }
  }
}

module.exports = {
  MAX_RENDER_PASSES,
  Fragment,
  clearDirty,
  createElement,
  isDirty,
  isElement,
  renderNode,
  resetRuntime,
  runAllCleanups,
  runPendingEffects,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
};
