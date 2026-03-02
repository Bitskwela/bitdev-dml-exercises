const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 18: Blueprints with Classes", () => {
  test("Product class should initialize and apply discount", () => {
    validateSolution(codePath, (context) => {
      const { Product } = context;
      const product = new Product(1, "Rice", 100);
      expect(product.id).toBe(1);
      expect(product.name).toBe("Rice");
      expect(product.price).toBe(100);

      product.applyDiscount(10);
      expect(product.price).toBe(90);

      expect(product.toString()).toBe("Rice (₱90.00)");
    });
  });

  test("User class should greet and update email", () => {
    validateSolution(codePath, (context) => {
      const { User } = context;
      const user = new User("Juan", "juan@email.com");
      expect(user.username).toBe("Juan");
      expect(user.email).toBe("juan@email.com");

      expect(user.greet()).toBe("Hello, Juan!");

      user.updateEmail("juan.updated@email.com");
      expect(user.email).toBe("juan.updated@email.com");
    });
  });

  test("Counter class should have static property and method for counting instances", () => {
    validateSolution(codePath, (context) => {
      const { Counter } = context;

      const c1 = new Counter("A");
      const c2 = new Counter("B");
      expect(Counter.getCount()).toBe(2);

      c1.dispose();
      expect(Counter.getCount()).toBe(1);
    });
  });
});
