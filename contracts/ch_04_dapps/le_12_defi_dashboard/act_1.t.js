// Hidden grading test for le-12-defi-dashboard.

const RESERVE0 = 120000000000000000000n;
const RESERVE1 = 45000000000n;
const SUPPLY = 7350000000000000000n;
/** Raw base units, or scaled by a common token decimals count (6, 8 or 18). */
const DECIMALS = [0, 6, 8, 18];

/**
 * Whether `text` shows `amount` exactly, raw or scaled by one of `decimals`.
 *
 * Every number on the page is parsed and compared as an exact decimal, so
 * "120000000000000000000" and ethers.formatEther's "120.0" both pass, while a
 * wrong or rounded-away value does not.
 */
function showsAmount(text, amount, decimals) {
  const tokens = String(text).match(/\d[\d,]*(?:\.\d+)?/g) || [];
  return tokens.some((token) => {
    const [whole, frac = ""] = token.replace(/,/g, "").split(".");
    return decimals.some((d) => {
      if (frac.replace(/0+$/, "").length > d) return false;
      const scaled = BigInt(whole) * 10n ** BigInt(d) + BigInt((frac + "0".repeat(d)).slice(0, d) || "0");
      return scaled === amount;
    });
  });
}

describe("Lesson 12: DeFi Dashboard", () => {
  it("Task 1: refuses to read from an invalid LP address", async () => {
    const original = process.env.REACT_APP_LP_ADDRESS;
    process.env.REACT_APP_LP_ADDRESS = "not-an-address";
    try {
      const ui = await render(Submission);

      expect(ui.called("contract.getReserves")).to.equal(
        false,
        "Check the address with ethers.isAddress before building the contract — a bad address should never reach the chain.",
      );
      expect(ui.text()).to.not.match(
        /loading/i,
        `An invalid address should end in an error message, not an endless Loading. Rendered: "${ui.text()}"`,
      );
    } finally {
      process.env.REACT_APP_LP_ADDRESS = original;
    }
  });

  it("Task 2: uses a read-only provider", async () => {
    const ui = await render(Submission);
    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "Pool stats are public — build an ethers.JsonRpcProvider, not a wallet provider.",
    );
  });

  it("Task 3: reads both reserves and the total supply", async () => {
    const ui = await render(Submission);
    expect(ui.called("contract.getReserves")).to.equal(true, "Call getReserves().");
    expect(ui.called("contract.getTotalSupply")).to.equal(true, "Call getTotalSupply().");
  });

  it("Task 3: unpacks the reserves tuple into both values", async () => {
    const ui = await render(Submission);

    expect(showsAmount(ui.text(), RESERVE0, DECIMALS)).to.equal(
      true,
      `Reserve0 missing (120000000000000000000, or 120.0 formatted with 18 decimals). Rendered: "${ui.text()}"`,
    );
    expect(showsAmount(ui.text(), RESERVE1, DECIMALS)).to.equal(
      true,
      `Reserve1 missing — getReserves() returns a pair; destructure both. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: renders the total supply", async () => {
    const ui = await render(Submission);
    expect(showsAmount(ui.text(), SUPPLY, DECIMALS)).to.equal(
      true,
      `Total supply missing (7350000000000000000, or 7.35 formatted with 18 decimals). Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: clears the loading state once the data arrives", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.not.match(/loading/i, `Rendered: "${ui.text()}"`);
  });
});
