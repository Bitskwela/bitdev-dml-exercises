// Hidden grading test for le-07-sining-chain.

describe("Lesson 07: SiningChain NFT Gallery", () => {
  it("Task 2: reads tokenURI for the requested token", async () => {
    const ui = await render(Submission);
    await ui.type("1");
    await ui.click("Load NFT");

    expect(ui.called("contract.tokenURI")).to.equal(
      true,
      "Loading a single NFT should call contract.tokenURI(tokenId).",
    );
  });

  it("Task 1: converts the ipfs:// URI to a gateway URL before fetching", async () => {
    const ui = await render(Submission);
    await ui.type("1");
    await ui.click("Load NFT");

    const fetched = ui.calls("fetch").map(([url]) => url);
    expect(fetched.length).to.not.equal(0, "The metadata JSON at the tokenURI should be fetched.");
    expect(fetched[0]).to.contain(
      "https://ipfs.io/ipfs/",
      `An ipfs:// URI cannot be fetched directly — rewrite it to a gateway URL. Fetched: ${JSON.stringify(fetched[0])}`,
    );
  });

  it("Task 2: renders the metadata it fetched", async () => {
    const ui = await render(Submission);
    await ui.type("1");
    await ui.click("Load NFT");

    expect(ui.text()).to.contain(
      "Sarimanok sa Umaga",
      `The NFT's name should render. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 3: walks the owner's tokens via balanceOf and tokenOfOwnerByIndex", async () => {
    const ui = await render(Submission);
    await ui.click("Load My NFTs");

    expect(ui.called("contract.balanceOf")).to.equal(true, "Read balanceOf(account) to size the collection.");
    expect(ui.calls("contract.tokenOfOwnerByIndex").length).to.equal(
      2,
      `A balance of 2 means two tokenOfOwnerByIndex reads, got ${ui.calls("contract.tokenOfOwnerByIndex").length}.`,
    );
  });

  it("Task 3: renders every owned NFT", async () => {
    const ui = await render(Submission);
    await ui.click("Load My NFTs");

    expect(ui.text()).to.contain("Sarimanok sa Umaga", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("Jeepney Barok", `Rendered: "${ui.text()}"`);
  });

  it("Task 4: shows an empty state before anything is loaded", async () => {
    const ui = await render(Submission);
    expect(ui.text()).to.match(
      /no nfts|empty|collection/i,
      `Say something before the collection loads. Rendered: "${ui.text()}"`,
    );
  });
});
