# Fetch API and Async/Await Activity

## Initial Code

```js
// Task 1: Fetch Data with Async/Await
async function fetchUserData(userId) {
  // Add your code here
}

// Task 2: Fetch with Promise Chaining
function fetchPostTitle(postId) {
  // Add your code here
}

// Task 3: Fetch Multiple Resources
async function fetchUserAndPosts(userId) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: Fetch API, Promises, `async/await`, `.then()` Chaining, `Promise.all`, Error Handling

---

### Task 1: Fetch Data with Async/Await

Create an async function that fetches user data from a JSON placeholder API. Use `async/await` syntax, check if the response is ok, parse the JSON, and return the user object. Handle errors with try/catch.

```js
async function fetchUserData(userId) {
  try {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/users/${userId}`
    );

    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const user = await response.json();
    return user;
  } catch (error) {
    console.error("Failed to fetch user:", error.message);
    throw error;
  }
}
```

---

### Task 2: Fetch with Promise Chaining

Create a function that fetches a post and returns only its title. Use Promise chaining with `.then()` instead of async/await. Handle errors with `.catch()`.

```js
function fetchPostTitle(postId) {
  return fetch(`https://jsonplaceholder.typicode.com/posts/${postId}`)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.json();
    })
    .then((post) => post.title)
    .catch((error) => {
      console.error("Failed to fetch post:", error.message);
      throw error;
    });
}
```

---

### Task 3: Fetch Multiple Resources

Create an async function that fetches both a user and their posts simultaneously using `Promise.all`. Return an object containing the user data and their posts array.

```js
async function fetchUserAndPosts(userId) {
  try {
    const [user, posts] = await Promise.all([
      fetch(`https://jsonplaceholder.typicode.com/users/${userId}`).then(
        (res) => res.json()
      ),
      fetch(`https://jsonplaceholder.typicode.com/posts?userId=${userId}`).then(
        (res) => res.json()
      ),
    ]);

    return {
      user: user,
      posts: posts,
    };
  } catch (error) {
    console.error("Failed to fetch data:", error.message);
    throw error;
  }
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `userId`: A parameter identifying which user to fetch. Used in the API URL path.

- `postId`: A parameter identifying which post to fetch.

- `response`: The Response object returned by `fetch()`. Contains status, headers, and methods to read the body.

- `user`: The JavaScript object parsed from the JSON response containing user data.

- `post`: The JavaScript object containing post data including title, body, etc.

- `posts`: An array of post objects belonging to a specific user.

**Key Concepts:**

- Fetch API:
  A modern API for making HTTP requests. Returns a Promise that resolves to a Response object. Use `response.json()` to parse JSON data.

- Promises:
  Objects representing eventual completion (or failure) of an async operation. Can be chained with `.then()` and handle errors with `.catch()`.

- `async/await`:
  Syntactic sugar for Promises. `async` functions return Promises. `await` pauses execution until a Promise resolves. Makes async code look synchronous.

- Response Handling:
  Always check `response.ok` (true for status 200-299) before parsing. Throw errors for failed requests to trigger error handling.

- `.then()` Chaining:
  Each `.then()` returns a new Promise, allowing you to chain multiple operations. Return values are passed to the next `.then()`.

- `Promise.all`:
  Takes an array of Promises and returns a single Promise that resolves when all input Promises resolve. Results are returned as an array in the same order.

- Error Handling:
  Use `try/catch` with async/await or `.catch()` with Promise chains. Always handle potential network failures and HTTP errors.

**Key Functions:**

- `fetchUserData(userId)`:
  Demonstrates async/await with proper error handling. Shows the pattern of checking response status before parsing JSON.

- `fetchPostTitle(postId)`:
  Shows Promise chaining as an alternative to async/await. Demonstrates extracting a single property from the response.

- `fetchUserAndPosts(userId)`:
  Uses `Promise.all` to fetch multiple resources in parallel, improving performance over sequential fetches.
