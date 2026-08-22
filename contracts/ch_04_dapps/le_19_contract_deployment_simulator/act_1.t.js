// Hidden grading test for le-19-contract-deployment-simulator.

const DEPLOYED = "0xDe910eD910eD910eD910eD910eD910eD910eD910";

/** Type a greeting and press Deploy. */
async function deploy(ui, greeting = "Kumusta, mundo!") {
  await ui.type(greeting);
  await ui.click("Deploy");
  return ui;
}

describe("Lesson 19: Contract Deployment Simulator", () => {
  it("Task 4: disables Deploy until a greeting has been entered", async () => {
    const ui = await render(Submission, { props: { onDeployed: spy() } });
    const button = ui.find("button", "Deploy");

    expect(Boolean(button.props.disabled)).to.equal(
      true,
      "Deploying with an empty greeting wastes gas — disable the button until there is one.",
    );
  });

  it("Task 1: connects the wallet and awaits a signer", async () => {
    const ui = await render(Submission, { props: { onDeployed: spy() } });
    await deploy(ui);

    const methods = ui.calls("window.ethereum.request").map(([m]) => m);
    expect(methods).to.contain("eth_requestAccounts", "Ask for the account before deploying.");
    expect(ui.called("provider.getSigner")).to.equal(
      true,
      "Deployment is a transaction — it needs the wallet's signer (await provider.getSigner()).",
    );
  });

  it("Task 2: builds a factory from the artifact's abi and bytecode", async () => {
    const ui = await render(Submission, { props: { onDeployed: spy() } });
    await deploy(ui);

    const built = ui.calls("new ethers.ContractFactory");
    expect(built.length).to.not.equal(0, "Create an ethers.ContractFactory.");
    const [hasAbi, hasBytecode, hasSigner] = built[0];
    expect(hasAbi).to.equal(true, "The factory needs the artifact's abi.");
    expect(hasBytecode).to.equal(true, "The factory needs the artifact's bytecode, not just the abi.");
    expect(hasSigner).to.equal(true, "The factory needs a signer to send the deployment.");
  });

  it("Task 3: passes the greeting to the constructor", async () => {
    const ui = await render(Submission, { props: { onDeployed: spy() } });
    await deploy(ui, "Mabuhay!");

    const deployed = ui.calls("factory.deploy");
    expect(deployed.length).to.not.equal(0, "Call factory.deploy(greeting).");
    expect(deployed[0][0]).to.equal(
      "Mabuhay!",
      `The constructor argument should be the greeting, got ${JSON.stringify(deployed[0][0])}.`,
    );
  });

  it("Task 3: waits for the deployment to be mined", async () => {
    const ui = await render(Submission, { props: { onDeployed: spy() } });
    await deploy(ui);

    expect(ui.called("contract.waitForDeployment")).to.equal(
      true,
      "The address is not usable until the deployment is mined — await contract.waitForDeployment().",
    );
  });

  it("Task 3: hands the deployed address to onDeployed", async () => {
    const onDeployed = spy();
    const ui = await render(Submission, { props: { onDeployed } });
    await deploy(ui);

    expect(onDeployed.called()).to.equal(true, "Call onDeployed(address) once the contract is live.");
    expect(String(onDeployed.calls[0][0])).to.equal(
      DEPLOYED,
      `onDeployed should receive the deployed address, got ${JSON.stringify(onDeployed.calls[0][0])}.`,
    );
  });
});
