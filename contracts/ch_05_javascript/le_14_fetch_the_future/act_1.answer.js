// Task 1: Fetch Data with Async/Await
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
