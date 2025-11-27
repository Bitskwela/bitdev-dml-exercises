```markdown
## Background Story

It was a humid morning in Pasay City and the logistics office was already humming with activity—vans loading packages, dispatchers talking on headsets, and the big screen showing Metro Manila traffic maps 🚚🚦. Odessa sat at her desk, now a full-time developer for a fast-growing logistics tech firm. Her boss, Ate Liway, tapped her keyboard:

“Ods, we need live traffic updates from MMDA and weather data from PAGASA. Integrate them into our routing dashboard so our drivers avoid gridlock and typhoons. You got this?”

Odessa took a deep breath. Fetching data from real APIs? This felt like leveling up from simple date tricks to real-world data magic. She opened her terminal and typed:
```

npm install node-fetch

````

Then in her editor, she wrote:

```js
import fetch from "node-fetch";
````

Her first task: call the MMDA traffic API. She sent a request:

```js
const res = await fetch("https://api.mmda.gov.ph/traffic/metro-manila");
const data = await res.json();
console.log(data.congestionLevel);
```

She saw an array of congested roads—EDSA at yellow, Roxas Boulevard at red. Next, she fetched PAGASA’s weather endpoint:

```js
const weatherRes = await fetch(
  "https://api.pagasa.gov.ph/weather/metro-manila"
);
const weather = await weatherRes.json();
console.log(weather.temperature);
```

Now she had temperature, humidity, chance of rain. Odessa combined both into a dashboard: traffic bars and weather badges in a clean table. When Quezon Avenue lit up red at 5 PM, her code popped up an alert: “Heavy traffic ahead—rerouting!” 🤖🗺️

Her teammates were impressed. The logistics manager, Sir Liway, said, “Odessa, our vans saved two hours today. You bent time and data with code!”

She leaned back, sipping her cold brew, imagining her next feature: predictive ETAs and SMS alerts. But for now, she basked in the glow of live data—fresh from MMDA and PAGASA—bringing her dashboard to life.

---

## Theory & Lecture Content

In this lesson, we learn how to fetch remote data, handle Promises, use async/await, and parse JSON.

1. The Fetch API
2. Working with Promises
3. Async/Await Syntax
4. JSON Parsing and Error Handling

### 1. The Fetch API

The Fetch API lets you make HTTP requests in JavaScript.  
Basic usage:

```js
fetch(url)
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.json();
  })
  .then((data) => console.log(data))
  .catch((err) => console.error("Fetch error:", err));
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch

### 2. Working with Promises

A Promise represents a value that may be available now, later, or never.

```js
const p = new Promise((resolve, reject) => {
  // async work…
  if (success) resolve(result);
  else reject(error);
});

p.then((value) => console.log(value)).catch((err) => console.error(err));
```

Chaining Promises:

```js
fetch(url)
  .then((res) => res.json())
  .then((data) => process(data))
  .catch((err) => console.error(err));
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise

### 3. Async/Await Syntax

`async` functions return a Promise. Use `await` to pause until a Promise resolves.

```js
async function getData() {
  try {
    const res = await fetch(url);
    if (!res.ok) throw new Error(res.statusText);
    const json = await res.json();
    return json;
  } catch (err) {
    console.error("Error:", err);
    throw err;
  }
}
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function

### 4. JSON Parsing and Error Handling

- Always check `response.ok` before parsing.
- Use `response.json()` to convert response body into JS object.
- Wrap in `try/catch` when using `await`.

---


## Closing Story

As the dashboard sprang to life on her screen—live MMDA traffic maps and PAGASA weather updates—Odessa felt the thrill of real-time data pulsing through her code. Drivers avoided bottlenecks on EDSA, and dispatchers rerouted vans before the rain poured in. With Promises and async/await, she had made distant APIs feel as close as her own database.

Ate Liway pinged her on Slack with a thumbs-up emoji 👍: “This is gold, Ods! Next up: chart libraries and real-time sockets.”

Odessa grinned. Fetching data was only the beginning—visualizing trends and building live maps would be her next frontier. Her code had given life to data, and now the future looked bright, one dashboard at a time. 🚀

```

```
