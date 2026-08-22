"use strict";

/**
 * Mounting a student's component and querying what it rendered.
 *
 * Split from `index.js` so the render loop and the query surface are one
 * responsibility, separate from assembling the sandbox globals.
 */

const react = require("./react-shim");

/** Microtask drains per settle. Enough for chained awaits, bounded so a never-
 *  resolving promise fails the test instead of hanging the grader. */
const SETTLE_TICKS = 25;

/** Let queued promise callbacks run. */
async function drainMicrotasks() {
  for (let i = 0; i < SETTLE_TICKS; i += 1) await Promise.resolve();
}

/** Concatenate every text node in a rendered tree. */
function textOf(node) {
  if (!node) return "";
  if (node.text !== undefined) return node.text;
  return (node.children || []).map(textOf).join("");
}

/** Depth-first walk yielding every host node. */
function* walk(node) {
  if (!node || node.text !== undefined) return;
  yield node;
  for (const child of node.children || []) yield* walk(child);
}

/** True when `node`'s own rendered text contains `label`. */
function hasLabel(node, label) {
  return textOf(node).toLowerCase().includes(String(label).toLowerCase());
}

/**
 * Mount a component and return a queryable handle.
 *
 * @param Component - The student's default export.
 * @param options.props - Props the exercise supplies (from `spec.props`).
 * @param options.chain - The `{ ethers, ethereum, recorder }` triple in play.
 * @returns A handle exposing the rendered tree and the recorded chain calls.
 */
async function mount(Component, { props = {}, chain }) {
  react.resetRuntime();
  let tree = null;

  /** Render, run effects, and keep going while state keeps changing. */
  async function settle() {
    for (let pass = 0; pass < react.MAX_RENDER_PASSES; pass += 1) {
      react.clearDirty();
      tree = react.renderNode(react.createElement(Component, props), "root");
      react.runPendingEffects();
      await drainMicrotasks();
      if (!react.isDirty()) return;
    }
    throw new Error(
      "Component kept re-rendering — check for a setState that runs on every render.",
    );
  }

  await settle();

  const ui = {
    /** All visible text, whitespace-collapsed. */
    text() {
      return textOf(tree).replace(/\s+/g, " ").trim();
    },
    /** The raw tree, for debugging a failing assertion. */
    tree() {
      return tree;
    },
    /** Host nodes of the given tag, e.g. `button`. */
    all(tag) {
      return [...walk(tree)].filter((n) => n.tag === tag);
    },
    /** First node of `tag` whose text contains `label`. */
    find(tag, label) {
      return this.all(tag).find((n) =>
        label === undefined ? true : hasLabel(n, label),
      );
    },
    /**
     * Click a control by its visible text.
     *
     * Throws when nothing matches, so a renamed button fails the test loudly
     * rather than passing silently.
     */
    async click(label) {
      const clickable = [...walk(tree)].find(
        (n) =>
          n.props && typeof n.props.onClick === "function" && hasLabel(n, label),
      );
      if (!clickable) {
        throw new Error(
          `No clickable element containing ${JSON.stringify(label)}. Rendered: ${ui.text() || "(nothing)"}`,
        );
      }
      if (clickable.props.disabled) {
        throw new Error(`The control ${JSON.stringify(label)} is disabled.`);
      }
      await clickable.props.onClick({
        preventDefault() {},
        stopPropagation() {},
      });
      await settle();
      return ui;
    },
    /**
     * Submit a form, firing its `onSubmit` with a preventable event.
     *
     * Separate from {@link click} because a `<button type="submit">` carries no
     * `onClick` — the handler lives on the enclosing `<form>`.
     *
     * @param index - Which form, when a lesson renders more than one.
     */
    async submit(index = 0) {
      const forms = [...walk(tree)].filter(
        (n) => n.props && typeof n.props.onSubmit === "function",
      );
      if (!forms[index]) {
        throw new Error(
          `No <form> with an onSubmit handler at index ${index}. Rendered: ${ui.text() || "(nothing)"}`,
        );
      }
      let defaultPrevented = false;
      await forms[index].props.onSubmit({
        preventDefault() {
          defaultPrevented = true;
        },
        stopPropagation() {},
      });
      await settle();
      // Surfaced so a lesson can assert the page would not have reloaded.
      ui.lastSubmitPrevented = defaultPrevented;
      return ui;
    },
    /**
     * Type into a field, firing its `onChange`.
     *
     * @param value - The new value.
     * @param tag - Element tag, default `input`.
     * @param index - Which matching field, when a form has several.
     */
    async type(value, tag = "input", index = 0) {
      const fields = ui.all(tag).filter((n) => typeof n.props?.onChange === "function");
      const field = fields[index];
      if (!field) {
        throw new Error(
          `No <${tag}> with an onChange handler at index ${index} (found ${fields.length}).`,
        );
      }
      await field.props.onChange({ target: { value } });
      await settle();
      return ui;
    },
    /**
     * Type into the field whose `placeholder` contains `hint`.
     *
     * Clearer than an index when a form has several inputs, and it survives the
     * student reordering them.
     */
    async fill(hint, value) {
      const field = [...walk(tree)].find(
        (n) =>
          typeof n.props?.onChange === "function" &&
          String(n.props.placeholder ?? "")
            .toLowerCase()
            .includes(String(hint).toLowerCase()),
      );
      if (!field) {
        const seen = [...walk(tree)]
          .filter((n) => n.props?.onChange)
          .map((n) => JSON.stringify(n.props.placeholder ?? ""));
        throw new Error(
          `No field whose placeholder contains ${JSON.stringify(hint)}. Placeholders found: ${seen.join(", ") || "(none)"}`,
        );
      }
      await field.props.onChange({ target: { value } });
      await settle();
      return ui;
    },
    /** Fire a wallet event (e.g. `accountsChanged`) at the component. */
    async emit(event, ...args) {
      chain.ethereum.__emit(event, ...args);
      await settle();
      return ui;
    },
    /**
     * Fire a contract event at whatever the component subscribed with
     * `contract.on(...)`, then re-render.
     *
     * @returns The number of contract instances that received it; `0` proves
     * the component never subscribed.
     */
    async emitContract(event, ...args) {
      const delivered = chain.emitContract(event, ...args);
      await settle();
      return delivered;
    },
    /** Arguments of every recorded call to `target`, in order. */
    calls(target) {
      return chain.recorder.of(target);
    },
    /** Every recorded call target, in order. */
    callTargets() {
      return chain.recorder.targets();
    },
    /** True when `target` was called at least once. */
    called(target) {
      return chain.recorder.targets().includes(target);
    },
    /** Re-render after out-of-band state changes. */
    settle,
    /** Run effect cleanups, as unmounting would. */
    unmount() {
      react.runAllCleanups();
    },
  };

  return ui;
}

module.exports = { SETTLE_TICKS, drainMicrotasks, hasLabel, mount, textOf, walk };
