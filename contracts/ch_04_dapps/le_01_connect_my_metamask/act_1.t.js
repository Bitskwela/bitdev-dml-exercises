// Hidden grading test for le-01-connect-my-metamask.
// Asserts behaviour against the mocked wallet, never source text: any correct
// implementation passes, whatever it names its variables.

/** A rendered node's visible text. */
function labelOf(node) {
  if (!node) return "";
  if (node.text !== undefined) return String(node.text);
  return (node.children || []).map(labelOf).join("");
}

/**
 * Buttons that offer to connect. `\bconnect` matches "Connect" and "Connect
 * Wallet" but not "Disconnect", which a connected UI may legitimately show.
 */
function connectButtons(ui) {
  return ui.all("button").filter((b) => /\bconnect/i.test(labelOf(b)));
}

describe("Lesson 01: Connect My MetaMask", () => {
  it("Task 1: prompts the visitor to install MetaMask when no wallet is present", async () => {
    const ui = await render(Submission, { wallet: "absent" });
    expect(ui.text()).to.match(
      /install.*metamask/i,
      `Without a wallet the component should ask the visitor to install MetaMask. It rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: offers a Connect button when a wallet is present but not connected", async () => {
    const ui = await render(Submission);
    expect(connectButtons(ui).length).to.not.equal(
      0,
      `With a wallet installed and no account connected, render a Connect button. It rendered: "${ui.text()}"`,
    );
  });

  it("Task 2: requests accounts from the wallet when Connect is clicked", async () => {
    const ui = await render(Submission);
    await ui.click("Connect");

    const methods = ui.calls("window.ethereum.request").map(([method]) => method);
    expect(methods).to.contain(
      "eth_requestAccounts",
      `Clicking Connect should call window.ethereum.request({ method: "eth_requestAccounts" }). Methods requested: ${JSON.stringify(methods)}`,
    );
  });

  it("Task 2: stores the returned account and shows it once connected", async () => {
    const ui = await render(Submission);
    await ui.click("Connect");

    expect(ui.text()).to.contain(
      "0x1234567890123456789012345678901234567890",
      `After a successful connection the component should display the connected address. It rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: replaces the Connect button once an account is connected", async () => {
    const ui = await render(Submission);
    await ui.click("Connect");

    expect(connectButtons(ui).length).to.equal(
      0,
      "Once connected, the Connect button should no longer render — show the address instead.",
    );
  });
});
