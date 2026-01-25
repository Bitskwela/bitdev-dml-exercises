# Lesson 5 Activities: Dev Tools & Editors

## Mastering Your Development Environment

Professional developers rely on powerful tools. These activities help you set up and master VS Code and Browser DevTools!

---

## Activity 1: Install and Configure VS Code

**Goal:** Set up your professional coding environment.

**Instructions:**

1. Download VS Code from `code.visualstudio.com`
2. Install on your computer
3. Open VS Code
4. Explore the interface: File Explorer, Editor, Terminal, Extensions

**Configure:**

- Set theme (File → Preferences → Color Theme)
- Set font size (File → Preferences → Settings → search "font size")
- Enable Auto Save (File → Auto Save)

**Questions:**

1. What theme did you choose?
2. What's the default font size?
3. Where is the integrated terminal? (View → Terminal)

---

## Activity 2: Essential Extensions Setup

**Goal:** Install must-have VS Code extensions.

**Install these extensions** (Ctrl+Shift+X):

| Extension         | Purpose                 | Required?      |
| ----------------- | ----------------------- | -------------- |
| Live Server       | Preview HTML in browser | ✅ Yes         |
| Prettier          | Code formatting         | ✅ Yes         |
| HTML CSS Support  | Autocomplete            | ✅ Yes         |
| Auto Rename Tag   | Rename paired tags      | ⭐ Recommended |
| Path Intellisense | File path autocomplete  | ⭐ Recommended |
| Indent Rainbow    | Visual indentation      | Optional       |

**Test Live Server:**

1. Create `test.html`
2. Right-click → "Open with Live Server"
3. Browser should open automatically

**Questions:**

1. How many extensions did you install?
2. Does Live Server work?
3. What port does Live Server use? (usually 5500)

---

## Activity 3: Keyboard Shortcuts Mastery

**Goal:** Learn essential shortcuts for faster coding.

**Practice these shortcuts:**

| Action          | Windows/Linux | What it does        |
| --------------- | ------------- | ------------------- |
| Command Palette | Ctrl+Shift+P  | Access all commands |
| Quick Open      | Ctrl+P        | Open files quickly  |
| Toggle Terminal | Ctrl+`        | Show/hide terminal  |
| Multi-cursor    | Alt+Click     | Edit multiple lines |
| Duplicate Line  | Shift+Alt+↓   | Copy line down      |
| Delete Line     | Ctrl+Shift+K  | Remove line         |
| Find            | Ctrl+F        | Search in file      |
| Replace         | Ctrl+H        | Find and replace    |
| Comment         | Ctrl+/        | Toggle comment      |

**Challenge:**
Create a file with 5 lines of text. Use shortcuts to:

- Duplicate line 2
- Delete line 4
- Add multi-cursor to lines 1, 3, 5
- Comment all lines

---

## Activity 4: Chrome DevTools Exploration

**Goal:** Master the browser's developer tools.

**Instructions:**

1. Open any website in Chrome
2. Press F12 (or right-click → Inspect)
3. Explore each tab

**DevTools Tabs:**

| Tab             | Purpose          | Try This                      |
| --------------- | ---------------- | ----------------------------- |
| **Elements**    | Inspect HTML/CSS | Change a heading's text       |
| **Console**     | Run JavaScript   | Type: `console.log("Hello!")` |
| **Network**     | Monitor requests | Refresh page, see all files   |
| **Sources**     | Debug JavaScript | View source files             |
| **Application** | Storage, cookies | Check localStorage            |
| **Performance** | Analyze speed    | Record page load              |
| **Lighthouse**  | Audit site       | Run performance test          |

**Tasks:**

1. Find the `<body>` tag in Elements tab
2. Edit text directly in Elements (temporary)
3. Run JavaScript in Console: `alert("Test")`
4. Check Network tab — how many requests?

---

## Activity 5: Live HTML/CSS Editing

**Goal:** Edit websites in real-time using DevTools.

**Instructions:**

1. Visit any website (e.g., `google.com`)
2. Open DevTools (F12)
3. Elements tab → Find any heading
4. Double-click the text → Edit it
5. Styles panel → Change colors/fonts

**Experiments:**

- Change Google logo text
- Make all text red
- Hide images (`display: none`)
- Change background color

**Questions:**

1. Are changes permanent? (No — refresh restores)
2. Can you edit CSS the same way? (Yes, in Styles panel)
3. What happens if you delete the `<body>` tag?

---

## Activity 6: Emmet Abbreviations

**Goal:** Write HTML faster with Emmet shortcuts.

**Emmet in VS Code** (built-in):

Type this, then press **Tab**:

```
div.container>h1{Hello}+p{Text}
```

Expands to:

```html
<div class="container">
  <h1>Hello</h1>
  <p>Text</p>
</div>
```

**Practice:**

| Type          | Press Tab | Result                      |
| ------------- | --------- | --------------------------- |
| `!`           | Tab       | Full HTML template          |
| `ul>li*5`     | Tab       | `<ul>` with 5 `<li>` items  |
| `div.box`     | Tab       | `<div class="box">`         |
| `a[href="#"]` | Tab       | `<a href="#">`              |
| `img:z`       | Tab       | `<img>` with all attributes |

**Challenge:**
Use Emmet to create:

- Navigation with 4 links
- List with 10 items
- Form with 3 text inputs

---

## Activity 7: Project Workspace Setup

**Goal:** Organize a real project structure.

**Create this folder structure:**

```
barangay-website/
├── index.html
├── about.html
├── contact.html
├── css/
│   └── style.css
├── js/
│   └── script.js
├── images/
│   └── logo.png
└── README.md
```

**In VS Code:**

1. File → Open Folder → Create/select `barangay-website`
2. Use Explorer panel to create folders
3. Create files inside each folder
4. Install Live Server and test

**Questions:**

1. Can you see the folder tree in VS Code?
2. Does Live Server hot-reload when you save?
3. Can you open terminal in VS Code? (Ctrl+`)

---

**Excellent! You're now set up like a professional developer!**

VS Code configured. Extensions installed. DevTools mastered and project structure organized.

**Next:** HTML document structure!
