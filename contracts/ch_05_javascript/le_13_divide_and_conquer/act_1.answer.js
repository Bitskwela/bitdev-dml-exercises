// utils/mathUtils.js
// ES6 MODULES: Organize code into reusable files
// 'export' makes functions/variables available to other files

// NAMED EXPORT: Export specific functions by name
export function add(a, b) {
  return a + b;
}

export function multiply(a, b) {
  return a * b;
}

// These can be imported individually:
// import { add, multiply } from './mathUtils.js';
// Or all at once:
// import * as math from './mathUtils.js';

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
