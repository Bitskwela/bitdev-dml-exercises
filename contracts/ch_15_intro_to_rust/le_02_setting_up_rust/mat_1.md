## Dan's Story: The Three-Hour Install That Took Six Minutes

Tuesday night, 9 PM, dorm. Dan blocked three hours for this. His last toolchain setup — pandas, numpy, scikit-learn on a secondhand laptop — ate a full evening of version conflicts. He typed `rustup.rs` into the browser and braced for impact.

The page had one paragraph, one command, and one download button. That was the whole site.

> **Dan:** Kuya, nasa rustup.rs na ako. Saan yung installation guide? Yung dependency list?
>
> **Kuya JM:** That's it. That's the page. Download the .exe, run it, press Enter once. Tapos.

Dan ran `rustup-init.exe`, pressed Enter, and watched components roll in — `cargo`, `clippy`, `rust-docs`, `rust-std`, `rustc`, `rustfmt`. Mid-install, his phone buzzed. Tita Malou:

> **Tita Malou:** Anak, sabi ni JM may bago ka raw na project para sa carinderia. Libre ba yan? Hindi tayo magbabayad ng monthly?

Dan typed back: *Libre po, Ma. Forever. Walang monthly, walang ads, walang "premium." Promise.* He hit send, looked up, and the installer printed its last line: `Rust is installed now. Great!` Six minutes — *including* the download.

> **Dan:** Kuya, tapos na. May cargo na agad? Hindi ko pa siya na-install separately.
>
> **Kuya JM:** Walang separate. One installer, three tools. `rustup` is the supplier — nag-deliver ng equipment. `rustc` is the kawali — the thing that actually cooks. Pero si `cargo`? Cargo is the whole kitchen routine. Si cargo ang kasama mo araw-araw.

---

## The Concept: The Toolchain Trio

Installing Rust gives you three tools at once. Knowing which one does what — and which one you'll actually live in — is the whole lesson.

### Three Tools, One Install

| Tool | Its Job | How Often You'll Touch It |
|---|---|---|
| `rustup` | **Installer & version manager.** Installs Rust, updates it (`rustup update`), switches channels. Not Rust itself — the supplier that delivers and maintains Rust. | Rarely — install day, update day, `rustup doc`. |
| `rustc` | **The compiler.** Takes `.rs` source files and produces a standalone binary. The strict Ate that refused E0382 in Lesson 1. | Directly in Lesson 3; after that, cargo calls it *for* you. |
| `cargo` | **Build tool + package manager + project runner.** Creates, builds, runs, and tests projects; manages dependencies. | **Every single day. Your daily driver.** |

You will *meet* `rustc` but *work with* `cargo`. When you type `cargo run`, cargo quietly invokes `rustc` behind the scenes — the same way Tita Malou doesn't call her gas supplier every morning, she just cooks.

```text
rustup --installs & updates--> rustc + cargo
you type: cargo run --> cargo calls rustc --> one standalone binary
```

### The Stable Channel

Rust ships in three release channels:

| Channel | What It Is | Who It's For |
|---|---|---|
| **stable** | A new version every six weeks, thoroughly tested. | Everyone. **This entire course stays on stable.** |
| **beta** | The *next* stable, in final testing. | Release testers. |
| **nightly** | Built every night, experimental features on. | Language contributors and the adventurous. |

Stable is the menu, beta is the dish being taste-tested in the back, nightly is the experiment the cook won't serve yet. LutoCLI computes Tita Malou's money — it gets menu items only. Updating is one command: `rustup update`.

### Where the Binaries Live

All three tools install into a single folder in your home directory:

| OS | Location |
|---|---|
| Windows | `C:\Users\<you>\.cargo\bin` |
| macOS / Linux | `~/.cargo/bin` |

The installer adds this folder to your `PATH` — which is exactly why you need a **new** terminal after installing. Terminals read `PATH` when they open; a window opened *before* the install has never heard of `rustc`.

### Offline Docs: `rustup doc`

The toolchain ships with **complete offline documentation** — the full standard library reference *and* the official book, *The Rust Programming Language*. One command, `rustup doc`, opens it in your browser straight from your own disk. No internet required.

For Dan this isn't a nice-to-have. Dorm Wi-Fi is a coin flip, and the carinderia desktop has no internet at all. The language that runs anywhere also *teaches* anywhere.

---

## Key Takeaways

- **One installer, three tools, minutes not hours.** rustup.rs delivers the entire toolchain — no dependency hunting, no version conflicts. And as Dan told Tita Malou: libre, forever.
- **`rustup` manages, `rustc` compiles, `cargo` drives.** You'll meet rustc once, then live in cargo every single day.
- **This course lives on the stable channel.** New stable every six weeks; `rustup update` brings you current.
- **Everything lives in one folder on your `PATH`** — `~/.cargo/bin` (or `C:\Users\<you>\.cargo\bin`). New terminals see it; old ones don't.
- **The documentation is offline-first.** `rustup doc` opens the standard library reference and The Rust Book from disk — no Wi-Fi required.

---

## What's Next?

The kitchen is stocked: the supplier delivered, the kawali is on the stove, and the daily driver is parked in `.cargo/bin` — but Dan hasn't cooked anything yet. Tomorrow night he writes his first real Rust program, copies the binary onto a USB stick, and walks it across the carinderia to the ancient desktop with *nothing* installed on it.

**Next Lesson: Hello, World!** — one source file, one `rustc` command, one standalone binary, and the USB-stick walk that proves the promise from Lesson 1.
