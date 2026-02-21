// Task 1: Fetch Data with Async/Await
// ASYNC/AWAIT: Modern way to handle asynchronous operations
// 'async' keyword makes function return a Promise
async function fetchUserData(userId) {
  try {
    // TRY/CATCH: Handle errors that might occur

    // fetch() sends HTTP request, returns a Promise
    // 'await' pauses execution until Promise resolves
    // Without await: response would be a Promise, not the actual data
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/users/${userId}`,
    );

    // Check if request was successful (status 200-299)
    // response.ok is true for successful requests
    if (!response.ok) {
      // throw stops execution and jumps to catch block
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    // .json() parses response body as JSON
    // Also returns a Promise, so we await it
    const user = await response.json();
    return user;
  } catch (error) {
    // Catch block runs if any error occurs in try block
    console.error("Failed to fetch user:", error.message);
    throw error; // Re-throw to let caller handle it
  }

  // WHY ASYNC/AWAIT?
  // - Cleaner than .then() chains
  // - Reads like synchronous code (top to bottom)
  // - try/catch works like normal error handling
}

// Task 2: Fetch with Promise Chaining
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

// Task 3: Fetch Multiple Resources
async function fetchUserAndPosts(userId) {
  try {
    const [user, posts] = await Promise.all([
      fetch(`https://jsonplaceholder.typicode.com/users/${userId}`).then(
        (res) => res.json(),
      ),
      fetch(`https://jsonplaceholder.typicode.com/posts?userId=${userId}`).then(
        (res) => res.json(),
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
