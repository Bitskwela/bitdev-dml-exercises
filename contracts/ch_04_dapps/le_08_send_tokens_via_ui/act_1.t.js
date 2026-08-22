// Hidden grading test for le-08-send-tokens-via-ui.

const VALID = "0xAbCdAbCdAbCdAbCdAbCdAbCdAbCdAbCdAbCdAbCd";

/** Fill both fields and submit the form. */
async function transfer(ui, { to = VALID, amount = "2.5" } = {}) {
  await ui.fill("Recipient", to);
  await ui.fill("Amount", amount);
  await ui.submit();
  return ui;
}

describe("Lesson 08: Send Tokens via UI", () => {
  it("Task 4: renders a recipient field, an amount field and a submit button", async () => {
    const ui = await render(Submission);
    expect(ui.all("input").length).to.not.equal(0, "Render the recipient and amount inputs.");
    expect(ui.text()).to.match(/send/i, `Rendered: "${ui.text()}"`);
  });

  it("Task 1: refuses to send to an invalid address", async () => {
    const ui = await render(Submission);
    await transfer(ui, { to: "not-an-address" });

    expect(ui.called("contract.transfer")).to.equal(
      false,
      "Validate with ethers.isAddress before sending — a bad address burns gas for nothing.",
    );
  });

  it("Task 1: refuses to send a zero or negative amount", async () => {
    const ui = await render(Submission);
    await transfer(ui, { amount: "0" });

    expect(ui.called("contract.transfer")).to.equal(
      false,
      "Reject a non-positive amount before sending.",
    );
  });

  it("Task 3: reads decimals and scales the amount before transferring", async () => {
    const ui = await render(Submission);
    await transfer(ui);

    expect(ui.called("contract.decimals")).to.equal(
      true,
      "Read decimals() — 2.5 tokens is not 2.5 base units.",
    );
    const [[to, value]] = ui.calls("contract.transfer");
    expect(to).to.equal(VALID, "transfer() should receive the recipient address.");
    expect(String(value)).to.equal(
      "2500000000000000000",
      `2.5 at 18 decimals is 2500000000000000000. transfer() got ${String(value)} — use ethers.parseUnits(amount, decimals).`,
    );
  });

  it("Task 3: waits for the receipt and reports success", async () => {
    const ui = await render(Submission);
    await transfer(ui);

    expect(ui.called("tx.wait")).to.equal(true, "Await tx.wait() before calling it a success.");
    expect(ui.text()).to.match(/success/i, `Tell the user it worked. Rendered: "${ui.text()}"`);
  });

  it("Task 3: shows the transaction hash", async () => {
    const ui = await render(Submission);
    await transfer(ui);

    expect(ui.text()).to.contain(
      "0xdeadbeef",
      `Show the tx hash so the user can follow it on a explorer. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 1: stops the form from reloading the page", async () => {
    const ui = await render(Submission);
    await transfer(ui);

    expect(ui.lastSubmitPrevented).to.equal(
      true,
      "Call e.preventDefault() — a native form submit reloads the page and loses the transaction.",
    );
  });
});
