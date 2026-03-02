const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 14: Fetch the Future", () => {
  // Setup fetch mock globally for these tests
  beforeAll(() => {
    global.fetch = jest.fn();
  });

  afterEach(() => {
    jest.resetAllMocks();
  });

  test("fetchUserData should fetch and return user data", async () => {
    const mockUser = { id: 1, name: "Juan" };
    global.fetch.mockResolvedValue({
      ok: true,
      json: jest.fn().mockResolvedValue(mockUser),
      status: 200,
    });

    validateSolution(codePath, async (context) => {
      const { fetchUserData } = context;
      const user = await fetchUserData(1);
      expect(user).toEqual(mockUser);
      expect(global.fetch).toHaveBeenCalledWith(
        "https://jsonplaceholder.typicode.com/users/1",
      );
    });
  });

  test("fetchPostTitle should fetch and return title of post", async () => {
    const mockPost = { id: 1, title: "Sample Post" };
    global.fetch.mockResolvedValue({
      ok: true,
      json: jest.fn().mockResolvedValue(mockPost),
      status: 200,
    });

    validateSolution(codePath, async (context) => {
      const { fetchPostTitle } = context;
      const title = await fetchPostTitle(1);
      expect(title).toBe("Sample Post");
      expect(global.fetch).toHaveBeenCalledWith(
        "https://jsonplaceholder.typicode.com/posts/1",
      );
    });
  });

  test("fetchUserAndPosts should return user and their posts using Promise.all", async () => {
    const mockUser = { id: 1, name: "Juan" };
    const mockPosts = [{ id: 1, title: "Post 1" }];

    global.fetch.mockImplementation((url) => {
      if (url.includes("/users/1")) {
        return Promise.resolve({
          ok: true,
          json: () => Promise.resolve(mockUser),
        });
      }
      if (url.includes("/posts?userId=1")) {
        return Promise.resolve({
          ok: true,
          json: () => Promise.resolve(mockPosts),
        });
      }
    });

    validateSolution(codePath, async (context) => {
      const { fetchUserAndPosts } = context;
      const result = await fetchUserAndPosts(1);
      expect(result).toEqual({ user: mockUser, posts: mockPosts });
    });
  });
});
