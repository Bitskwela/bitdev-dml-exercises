/**
 * Hidden test for le_14_fetch_the_future.
 *
 * Grading is offline, so `spec.http` declares the responses each URL returns.
 * A URL the spec does not name rejects — which is exactly how the unhappy path
 * below is produced, without needing a network or a flaky server.
 *
 * Every case is awaited: a function that forgets to return its promise resolves
 * to `undefined` and fails here rather than passing by accident.
 */

describe("le_14_fetch_the_future", () => {
  it("resolves a user from the API", async () => {
    const user = await Submission.fetchUserData(1);
    expect(user && user.name, "user name").equal("Neri Gonzales");
    expect(user && user.id, "user id").equal(1);
  });

  it("resolves just the title of a post", async () => {
    const title = await Submission.fetchPostTitle(1);
    expect(title, "post title").equal(
      "Ang Unang Hakbang",
      "fetchPostTitle should resolve the title string, not the whole post",
    );
  });

  it("fetches the user and their posts together", async () => {
    const result = await Submission.fetchUserAndPosts(1);
    expect(result && result.user && result.user.name, "user").equal(
      "Neri Gonzales",
    );
    expect(Array.isArray(result && result.posts), "posts is an array").true();
    expect(result.posts.length, "post count").equal(2);
    expect(result.posts[0].title, "first post").equal("Ang Unang Hakbang");
  });

  it("reports a failure instead of resolving with a broken value", async () => {
    let threw = false;
    const before = logs("error").length;
    try {
      // No response is declared for user 99, so the fetch rejects.
      await Submission.fetchUserData(99);
    } catch {
      threw = true;
    }
    expect(threw, "rejected").true(
      "a failed request must reject rather than resolve to undefined",
    );
    expect(logs("error").length > before, "reported the failure").true(
      "the caught error should be reported before it is re-thrown",
    );
  });
});
