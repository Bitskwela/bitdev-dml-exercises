// Hidden grading test for le-11-real-time-gas-fee-tracker.

const FEE_WEI = 24000000000n;

/**
 * Whether `text` shows `wei` exactly, either as raw wei or scaled by one of
 * `decimals` (9 is gwei, what `ethers.formatUnits(fee, "gwei")` gives).
 *
 * Every number on the page is parsed and compared as an exact decimal, so
 * "24000000000", "24.0 gwei" and "24.00 gwei" pass while a wrong value such as
 * "2.4 gwei" or "240 gwei" does not.
 */
function showsAmount(text, wei, decimals) {
  const tokens = String(text).match(/\d[\d,]*(?:\.\d+)?/g) || [];
  return tokens.some((token) => {
    const [whole, frac = ""] = token.replace(/,/g, "").split(".");
    return decimals.some((d) => {
      if (frac.replace(/0+$/, "").length > d) return false;
      const scaled = BigInt(whole) * 10n ** BigInt(d) + BigInt((frac + "0".repeat(d)).slice(0, d) || "0");
      return scaled === wei;
    });
  });
}

describe("Lesson 11: Real-Time Gas Fee Tracker", () => {
  it("Task 1: uses a read-only provider — no wallet needed for public data", async () => {
    const ui = await render(Submission);
    expect(ui.called("new ethers.JsonRpcProvider")).to.equal(
      true,
      "Reading a public value needs no wallet: build an ethers.JsonRpcProvider.",
    );
  });

  it("Task 3: reads the base fee from the contract", async () => {
    const ui = await render(Submission);
    expect(ui.called("contract.getBaseFee")).to.equal(true, "Call getBaseFee() on mount.");
  });

  it("Task 4: renders the fee it read, in wei or in gwei", async () => {
    const ui = await render(Submission);
    expect(showsAmount(ui.text(), FEE_WEI, [0, 9])).to.equal(
      true,
      `The base fee is 24000000000 wei, which is 24 gwei — show either. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: does not leave the user staring at a loading state", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.not.match(
      /loading/i,
      `Once the fee has arrived the loading state should be gone. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 4: labels the value so the number means something", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /wei|gwei|fee/i,
      `A bare integer tells the user nothing — label the unit. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: shows an error instead of loading forever when the read fails", async () => {
    // Point the component at a tracker whose getBaseFee() reverts.
    const original = process.env.REACT_APP_GAS_TRACKER_ADDRESS;
    process.env.REACT_APP_GAS_TRACKER_ADDRESS = "0x3333333333333333333333333333333333330000";
    try {
      const ui = await render(Submission);

      expect(ui.called("contract.getBaseFee")).to.equal(true, "Call getBaseFee() on mount.");
      expect(ui.text()).to.not.match(
        /loading/i,
        `When the read fails, catch the error and show it — do not stay on Loading. Rendered: "${ui.text()}"`,
      );
      expect(ui.text()).to.match(
        /error|fail|revert|offline|could ?n.?t|unable|went wrong/i,
        `Tell the user the fee could not be read (e.g. show err.message). Rendered: "${ui.text()}"`,
      );
    } finally {
      process.env.REACT_APP_GAS_TRACKER_ADDRESS = original;
    }
  });
});
