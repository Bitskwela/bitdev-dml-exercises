## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+17.0+-+COVER.png)

It was a cool evening in Quezon City when Odessa closed her laptop—only to remember she’d set her code editor to light mode by mistake. “Ay, sayang! I liked dark mode,” she sighed. The next morning, she found her teammates also toggling between light and dark themes every time they refreshed the page. Preferences were lost, scores in the intern coding game disappeared, and even the “welcome back” greeting forgot their names.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+17.1.png)

Her manager, Ate Liza, laughed and said, “Ods, make this app remember! Parang memory ng lolo natin—dapat di ka nakakalimot.” Odessa realized she needed a way to keep settings and small data across browser sessions. That’s when she discovered `localStorage`.

She imagined a small barangay hall website where residents choose light or dark theme, track their health scores, and come back days later with everything intact—even if they closed the browser. Odessa got excited. She started by saving a simple “theme” preference:

```js
localStorage.setItem("theme", "dark");
```

Then she read it back:

```js
const theme = localStorage.getItem("theme"); // "dark"
```

Soon she added JSON support—storing arrays of scores for the startup’s weekly game leaderboard:

```js
const scores = [85, 92, 78];
localStorage.setItem("scores", JSON.stringify(scores));
const saved = JSON.parse(localStorage.getItem("scores"));
```

Odessa tested it by refreshing her page again and again—the theme stayed, the scores remained. She even built a small toggle button:

```js
btn.addEventListener("click", () => {
  const next = theme === "light" ? "dark" : "light";
  localStorage.setItem("theme", next);
  applyTheme(next);
});
```

Her teammates cheered. No more lost preferences! Odessa felt proud—she’d made her app remember like a faithful lolo’s diary. As the sun set over QC’s skyline, she envisioned bigger apps saving cart items, draft forms, and more. But first, she’d teach you how to save memory with `localStorage`. 🚀

---

## Theory & Lecture Content

Browsers provide a simple key–value store called `localStorage` for persisting small data across sessions. Data survives page reloads and even browser restarts.

1. localStorage.setItem(key, value)

   - Stores a string `value` under `key`.
   - Example:
     ```js
     localStorage.setItem("username", "Odessa");
     ```

2. localStorage.getItem(key)

   - Retrieves the string value for `key`.
   - Returns `null` if the key doesn’t exist.
   - Example:
     ```js
     const name = localStorage.getItem("username"); // "Odessa"
     ```

3. JSON.stringify / JSON.parse

   - `localStorage` stores only strings. To store objects or arrays, convert them:
     ```js
     const prefs = { theme: "dark", fontSize: 14 };
     localStorage.setItem("prefs", JSON.stringify(prefs));
     // later…
     const saved = JSON.parse(localStorage.getItem("prefs"));
     ```

4. Removing and Clearing
   - `localStorage.removeItem(key)` deletes one item.
   - `localStorage.clear()` removes all.

Best Practices

- Namespace your keys: e.g., `"myApp-theme"` to avoid collisions.
- Check for `null` before parsing.
- Don’t store sensitive data—localStorage is not encrypted.

References:  
https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage


### Common Beginner Mistakes ⚠️

**1. Storing objects or arrays without stringifying**

```js
localStorage.setItem("scores", [100, 95]); // ❌ becomes the string "100,95"
localStorage.setItem("scores", JSON.stringify([100, 95])); // ✅ round-trips correctly
```

**2. Forgetting `getItem` returns `null` when missing**

```js
const theme = localStorage.getItem("theme").toUpperCase(); // ❌ TypeError if unset
const theme = (localStorage.getItem("theme") || "light").toUpperCase(); // ✅ default
```

**3. Calling `JSON.parse` on possibly-corrupt data without a guard**

```js
const data = JSON.parse(raw); // ❌ throws & crashes if `raw` isn't valid JSON
try { return JSON.parse(raw); } catch { return []; } // ✅ fail safe
```

**4. Expecting numbers/booleans back — everything is a string**

```js
localStorage.setItem("count", 5);
const c = localStorage.getItem("count"); // "5", a string
const c = Number(localStorage.getItem("count")); // ✅ convert when reading
```

**5. Not namespacing keys (collisions across features)**

```js
localStorage.setItem("theme", "dark"); // ❌ generic key, easy to clash
localStorage.setItem("bitskwela-theme", "dark"); // ✅ prefix per app/feature
```

---

## Closing Story

With her new `localStorage` skills, Odessa’s apps remembered everything—user themes, game scores, even draft notes—just like her lolo’s old diary. The logistics dashboard now stayed in dark mode if drivers preferred it, and the barangay tool kept residents’ preferences intact.

Later that night, Odessa reviewed her code and smiled. “Saving memory isn’t just tech; it’s about respecting users’ choices,” she thought. Her next challenge? Advanced storage with IndexedDB and syncing data across devices. But for now, her apps would never forget—and neither would she. 🚀
