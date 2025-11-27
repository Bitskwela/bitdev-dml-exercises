// utils/mathUtils.js
export function add(a, b) {
  return a + b;
}

export function multiply(a, b) {
  return a * b;
}

// calculator.js
import { add, multiply } from "./utils/mathUtils.js";

export function calculate(a, b) {
  return {
    sum: add(a, b),
    product: multiply(a, b),
  };
}

// config.js
const config = {
  appName: "MyApp",
  version: "1.0.0",
  environment: "development",
};

export default config;

// app.js (using the default export)
import config from "./config.js";

console.log(config.appName); // "MyApp"
