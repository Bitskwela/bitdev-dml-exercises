// Hidden grading test for le-18-nft-minting-ui-with-image-preview.

describe("Lesson 18: NFT Minting UI with Image Preview", () => {
  it("Task 1: asks for an image when no file has been chosen", async () => {
    const ui = await render(Submission, { props: { file: null } });

    expect(ui.text()).to.match(
      /upload|choose|select/i,
      `With no file, prompt for one rather than rendering a broken image. Rendered: "${ui.text()}"`,
    );
  });

  it("Task 1: does not try to build a URL from a missing file", async () => {
    const ui = await render(Submission, { props: { file: null } });

    expect(ui.called("URL.createObjectURL")).to.equal(
      false,
      "Return early before calling URL.createObjectURL — it throws on null.",
    );
  });

  it("Task 2: turns the chosen file into a previewable URL", async () => {
    const ui = await render(Submission);

    expect(ui.called("URL.createObjectURL")).to.equal(
      true,
      "A File object cannot be used as an img src directly — call URL.createObjectURL(file).",
    );
  });

  it("Task 2: renders an image using that URL", async () => {
    const ui = await render(Submission);
    const images = ui.all("img");

    expect(images.length).to.not.equal(0, "Render an <img> preview of the chosen file.");
    expect(String(images[0].props.src)).to.contain(
      "blob:",
      `The <img> src should be the object URL, got ${JSON.stringify(images[0].props.src)}.`,
    );
  });

  it("Task 3: renders the title and description", async () => {
    const ui = await render(Submission);

    expect(ui.text()).to.contain("Sarimanok sa Umaga", `Rendered: "${ui.text()}"`);
    expect(ui.text()).to.contain("Woodblock print, Angono", `Rendered: "${ui.text()}"`);
  });

  it("Task 3: shows the metadata JSON with name, description and image", async () => {
    const ui = await render(Submission);
    const text = ui.text();

    for (const key of ["name", "description", "image"]) {
      expect(text).to.contain(
        key,
        `The metadata JSON should include "${key}". Rendered: "${text}"`,
      );
    }
  });

  it("Task 3: falls back to Untitled when no title is given", async () => {
    const ui = await render(Submission, { props: { title: "" } });

    expect(ui.text()).to.contain(
      "Untitled",
      `An empty title should read as "Untitled", not blank. Rendered: "${ui.text()}"`,
    );
  });
});
