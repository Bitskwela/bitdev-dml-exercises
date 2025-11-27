## Background Story

It was Odess a’s first week as a summer intern at **StoreStream PH**, a small startup in Marikina that helps sari-sari store owners digitize their inventories. 🌴 The hot Metro Manila sun beat down on her as she rode the jeepney from Katipunan to Cubao. Her heart raced—this was her chance to apply what she learned in class, plus impress her new teammates.

On Day 2, her mentor, Ate Marife, handed Odessa a spreadsheet of products from a sari-sari store in Pasig: items like _taho_, _kwek-kwek_, _choc-nut_, and _sachet shampoos_. But the spreadsheet was static and hard to analyze: which products were running low? Which items made the most money? Odessa needed to transform and summarize that data in seconds.

Inside StoreStream’s cozy office, with walls painted a warm _senyales green_ and a wall-mural of the Mayon Volcano, Odessa opened Chrome DevTools. She remembered her JavaScript professor’s tip from JRU: “Use the right array methods—`.map()`, `.filter()`, and `.reduce()`—to handle lists like a pro.” 🧑‍💻

Odessa’s first task: list all the product names in uppercase. Next, identify items with stock less than 10 so they could be reordered. Finally, calculate the total inventory value so the sari-sari store owner knows how much money is tied up in stock.

At 4 PM, she typed furiously:

```js
// TODO: Use map, filter, reduce…
```

She ran her code. It worked! The console printed:

```js
["TAHO", "KWEK-KWEK", "CHOCO-NUT", "SACHET SHAMPOO"]
[ { name: 'Kwek-kwek', stock: 5 }, … ]
₱3,750
```

Ate Marife beamed. “Galing mo, Odessa! You just automated what used to take me an hour of manual work.”

That afternoon over merienda of **halo-halo** at a nearby store, Odessa realized how powerful JavaScript array methods could be in real business logic. She wasn’t just writing code—she was solving real problems for Filipino sari-sari store owners. 🇵🇭 As the sun set, she prepared for tomorrow’s challenge: chaining these methods to build dashboards and reports.

---

## Theory

JavaScript provides three powerful array methods for transforming and summarizing data:

1. **`.map()`**

   - Transforms each element in an array and returns a new array.
   - Signature:
     ```js
     const newArr = oldArr.map((currentValue, index, array) => {
       /* return transformedValue */
     });
     ```
   - Best Practice: Pure functions (no side effects) and always return a value.
   - MDN Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map

   Example:

   ```js
   const products = [
     { name: "Taho", price: 10 },
     { name: "Choc-nut", price: 20 },
   ];
   const namesUpper = products.map((p) => p.name.toUpperCase());
   console.log(namesUpper); // ["TAHO", "CHOC-NUT"]
   ```

2. **`.filter()`**

   - Selects a subset of elements based on a condition. Returns a new array.
   - Signature:
     ```js
     const filteredArr = oldArr.filter((currentValue, index, array) => {
       /* return true or false */
     });
     ```
   - Edge Case: If callback doesn’t return `true` or `false`, the element is dropped.
   - MDN Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter

   Example:

   ```js
   const lowStock = products.filter((p) => p.stock < 10);
   console.log(lowStock);
   // [ { name: 'Choc-nut', price: 20, stock: 5 } ]
   ```

3. **`.reduce()`**

   - Reduces array to a single value. Great for sums, totals, or building objects.
   - Signature:
     ```js
     const result = oldArr.reduce((accumulator, currentValue, index, array) => {
       /* return updatedAccumulator */
     }, initialValue);
     ```
   - Always provide `initialValue` to avoid errors on empty arrays.
   - MDN Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce

   Example:

   ```js
   // Calculate total inventory value = sum of price * stock
   const totalValue = products.reduce((sum, p) => sum + p.price * p.stock, 0);
   console.log(totalValue); // e.g. 750
   ```

4. **Chaining**  
   You can combine them in one pipeline:
   ```js
   const reorderValue = products
     .filter((p) => p.stock < 10) // pick low stock
     .map((p) => p.price * p.stock) // value per item
     .reduce((sum, val) => sum + val, 0); // total reorder value
   console.log(reorderValue);
   ```

---

## Closing Story

As the sun dipped behind Marikina’s skyline, Odessa leaned back in her chair. She watched the console print out the results of her map, filter, and reduce functions—data transformed in milliseconds. In that moment, she realized these methods were more than “just code.” They were the building blocks for real dashboards, reorder alerts, and even automated order forms for sari-sari store owners across the Philippines.

She sipped her buko juice, excitement bubbling inside. Tomorrow, she would explore **asynchronous JavaScript**—fetching live data from APIs, handling promises, and updating the UI in real-time. Just as map, filter, and reduce empowered her to process arrays, async code would let her connect StoreStream PH’s frontend to real databases and cloud services.

Odessa closed her laptop with a confident smile. Her journey from student to startup developer was shining brighter than ever. 💡 Next stop: **“Async Adventures”**—where callbacks, promises, and `async/await` await. Are you ready to code with her?

Happy coding! 🚀
