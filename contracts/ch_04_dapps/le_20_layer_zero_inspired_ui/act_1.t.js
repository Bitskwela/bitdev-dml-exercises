// Hidden grading test for le-20-layer-zero-inspired-ui.

/** Enter an amount, press Bridge, then confirm. */
async function bridge(ui, amount = "1.5") {
  await ui.type(amount);
  await ui.click("Bridge");
  await ui.click("Yes");
  return ui;
}

describe("Lesson 20: Layer Zero Inspired UI", () => {
  it("Task 4: keeps Bridge disabled until a positive amount is entered", async () => {
    const ui = await render(Submission, { props: { onLocked: spy() } });

    expect(Boolean(ui.find("button", "Bridge").props.disabled)).to.equal(
      true,
      "Bridging nothing should not be possible — disable Bridge while the amount is empty or non-positive.",
    );
  });

  it("Task 4: asks for confirmation before signing anything", async () => {
    const ui = await render(Submission, { props: { onLocked: spy() } });
    await ui.type("1.5");
    await ui.click("Bridge");

    expect(ui.called("contract.lockTokens")).to.equal(
      false,
      "Pressing Bridge should open a confirmation step, not send the transaction straight away.",
    );
    expect(ui.text()).to.match(/1\.5/, `The confirmation should restate the amount. Rendered: "${ui.text()}"`);
  });

  it("Task 1: connects the wallet and awaits a signer before locking", async () => {
    const ui = await render(Submission, { props: { onLocked: spy() } });
    await bridge(ui);

    expect(ui.calls("window.ethereum.request").map(([m]) => m)).to.contain(
      "eth_requestAccounts",
      "Ask for the account before sending value.",
    );
    expect(ui.called("provider.getSigner")).to.equal(
      true,
      "A payable call must be signed — await provider.getSigner().",
    );
  });

  it("Task 2: sends the amount as ETH value, converted to wei", async () => {
    const ui = await render(Submission, { props: { onLocked: spy() } });
    await bridge(ui, "1.5");

    const calls = ui.calls("contract.lockTokens");
    expect(calls.length).to.not.equal(0, "Call lockTokens().");
    const overrides = calls[0][0];
    expect(Boolean(overrides && overrides.value !== undefined)).to.equal(
      true,
      "lockTokens() is payable — the ETH goes in the overrides object as { value }.",
    );
    expect(String(overrides.value)).to.equal(
      "1500000000000000000",
      `1.5 ETH is 1500000000000000000 wei — use ethers.parseEther. Got ${String(overrides.value)}.`,
    );
  });

  it("Task 3: waits for the receipt", async () => {
    const ui = await render(Submission, { props: { onLocked: spy() } });
    await bridge(ui);

    expect(ui.called("tx.wait")).to.equal(true, "Await tx.wait() — the lock is not final until mined.");
  });

  it("Task 3: reads the transfer id out of the Locked event", async () => {
    const onLocked = spy();
    const ui = await render(Submission, { props: { onLocked } });
    await bridge(ui);

    expect(onLocked.called()).to.equal(
      true,
      "Call onLocked(id, amount) once the lock confirms, so the next chain can be watched.",
    );
    expect(Number(onLocked.calls[0][0])).to.equal(
      42,
      `The id comes from the Locked event in the receipt's logs, expected 42 and got ${onLocked.calls[0][0]}.`,
    );
  });

  it("Task 4: returns to idle after a successful lock", async () => {
    const ui = await render(Submission, { props: { onLocked: spy() } });
    await bridge(ui);

    expect(ui.text()).to.not.match(
      /locking on chain/i,
      `Once the lock confirms the pending state should clear. Rendered: "${ui.text()}"`,
    );
  });
});
