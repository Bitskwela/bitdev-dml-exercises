const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

// Mocking browser and React environment for DApp testing
const setupMockEnv = (code) => {
  const window = {
    ethereum: {
      request: async ({ method }) => {
        if (method === "eth_requestAccounts") {
          return ["0x1234567890123456789012345678901234567890"];
        }
        return [];
      },
    },
    alert: (msg) => {
      console.log("Alert:", msg);
    },
  };

  const React = {
    useState: (initial) => [
      initial,
      (val) => {
        initial = val;
      },
    ],
    useEffect: (fn) => fn(),
  };

  // Strip imports and exports to make it eval-able in CommonJS
  const executableCode = code
    .replace(/import .* from .*/g, "")
    .replace(/export default function/, "function")
    .trim();

  // Create a function that returns the component function
  return new Function(
    "window",
    "React",
    "useState",
    `${executableCode}; return WalletConnector;`,
  )(window, React, React.useState);
};

describe("Lesson 01: Connect MetaMask", function () {
  let WalletConnector;
  let code;

  before(function () {
    const filePath = path.join(__dirname, "act_1.answer.js");
    code = fs.readFileSync(filePath, "utf8");
    // Basic JSX to JS conversion for simple tags (very basic)
    const simplifiedCode = code.replace(
      /<(\w+)>(.*?)<\/\1>/g,
      "React.createElement('$1', null, '$2')",
    );
    // This is still very limited, but for "accuracy" checks of the logic, it might work
    // or we just check the logic variables.
  });

  it("Task 1: Should correctly detect MetaMask (hasWallet)", function () {
    expect(code).to.contain("Boolean(window.ethereum)");
    expect(code).to.match(/const hasWallet\s*=\s*/);
  });

  it("Task 2: Should implement connectWallet with eth_requestAccounts", function () {
    expect(code).to.contain("eth_requestAccounts");
    expect(code).to.contain("window.ethereum.request");
  });

  it("Task 3: Should handle conditional rendering based on account", function () {
    expect(code).to.contain("account ?");
    expect(code).to.contain("Connect MetaMask");
  });
});
