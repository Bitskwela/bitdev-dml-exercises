const { validateSolution } = require("../../ch_05_javascript/test-helper.js");
const path = require("path");

describe("Le 02: Sari-Sari POS Calculator", () => {
  const codePath = path.join(__dirname, "act_1.answer.js");

  test("Item class should have name, price and toHTML() method", () => {
    validateSolution(codePath, (context) => {
      const { Item } = context.global;
      const item = new Item("Coke", 20);
      expect(item.name).toBe("Coke");
      expect(item.price).toBe(20);
      expect(item.toHTML()).toContain("Coke");
      expect(item.toHTML()).toContain("20.00");
    });
  });

  test("Cart class should add items and calculate total", () => {
    validateSolution(codePath, (context) => {
      const { Cart, Item } = context.global;
      const cart = new Cart();
      cart.addItem(new Item("Bread", 12.5));
      cart.addItem(new Item("Egg", 7.0));

      expect(cart.items.length).toBe(2);
      expect(cart.getTotal()).toBe(19.5);

      cart.clearCart();
      expect(cart.items.length).toBe(0);
      expect(cart.getTotal()).toBe(0);
    });
  });

  test("Cart render should update list and total elements", () => {
    validateSolution(codePath, (context) => {
      const { Cart, Item } = context.global;
      const cart = new Cart();
      const mockList = { innerHTML: "" };
      const mockTotal = { textContent: "" };

      cart.addItem(new Item("Kandila", 5));
      cart.render(mockList, mockTotal);

      expect(mockList.innerHTML).toContain("Kandila");
      expect(mockTotal.textContent).toBe("5.00");
    });
  });
});
