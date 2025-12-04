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

| Extension | Purpose | Required? |
|-----------|---------|-----------|
| Live Server | Preview HTML in browser | ✅ Yes |
| Prettier | Code formatting | ✅ Yes |
| HTML CSS Support | Autocomplete | ✅ Yes |
| Auto Rename Tag | Rename paired tags | ⭐ Recommended |
| Path Intellisense | File path autocomplete | ⭐ Recommended |
| Indent Rainbow | Visual indentation | Optional |

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

| Action | Windows/Linux | What it does |
|--------|---------------|--------------|
| Command Palette | Ctrl+Shift+P | Access all commands |
| Quick Open | Ctrl+P | Open files quickly |
| Toggle Terminal | Ctrl+` | Show/hide terminal |
| Multi-cursor | Alt+Click | Edit multiple lines |
| Duplicate Line | Shift+Alt+↓ | Copy line down |
| Delete Line | Ctrl+Shift+K | Remove line |
| Find | Ctrl+F | Search in file |
| Replace | Ctrl+H | Find and replace |
| Comment | Ctrl+/ | Toggle comment |

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

| Tab | Purpose | Try This |
|-----|---------|----------|
| **Elements** | Inspect HTML/CSS | Change a heading's text |
| **Console** | Run JavaScript | Type: `console.log("Hello!")` |
| **Network** | Monitor requests | Refresh page, see all files |
| **Sources** | Debug JavaScript | View source files |
| **Application** | Storage, cookies | Check localStorage |
| **Performance** | Analyze speed | Record page load |
| **Lighthouse** | Audit site | Run performance test |

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

| Type | Press Tab | Result |
|------|-----------|--------|
| `!` | Tab | Full HTML template |
| `ul>li*5` | Tab | `<ul>` with 5 `<li>` items |
| `div.box` | Tab | `<div class="box">` |
| `a[href="#"]` | Tab | `<a href="#">` |
| `img:z` | Tab | `<img>` with all attributes |

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

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: VS Code Setup

**Download:** https://code.visualstudio.com/
**Install:** Follow installer prompts
**Interface:**
- Left sidebar: File Explorer (Ctrl+Shift+E)
- Main area: Editor
- Bottom: Terminal (Ctrl+`)
- Far left: Activity Bar (icons)

**Recommended settings:**
```json
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "files.autoSave": "afterDelay",
  "editor.wordWrap": "on",
  "editor.minimap.enabled": true
}
```

## Activity 2: Essential Extensions

**Installation:**
1. Click Extensions icon (or Ctrl+Shift+X)
2. Search extension name
3. Click Install

**Live Server test:**
- Creates local server (default port 5500)
- Auto-refreshes on save
- Right-click HTML → "Open with Live Server"
- URL: http://localhost:5500 or http://127.0.0.1:5500

**Extension IDs (for reference):**
- Live Server: `ritwickdey.LiveServer`
- Prettier: `esbenp.prettier-vscode`
- Auto Rename Tag: `formulahendry.auto-rename-tag`

## Activity 3: Keyboard Shortcuts

**Multi-cursor example:**
```html
<p>Line 1</p>
<p>Line 2</p>
<p>Line 3</p>
```
Hold Alt, click before "Line" on each line → Type "Hello " → All lines get "Hello " prefix

**Duplicate line:** Put cursor on line, press Shift+Alt+↓ (copies line below)

**Pro tips:**
- Ctrl+D: Select next occurrence of word
- Ctrl+Shift+L: Select all occurrences
- Alt+↑/↓: Move line up/down
- Ctrl+Enter: Insert line below (without breaking current)

## Activity 4: DevTools Exploration

**Elements Tab:**
- View DOM tree
- Edit HTML directly (temporary)
- Styles panel shows applied CSS
- Computed tab shows final values

**Console Tab:**
- JavaScript REPL (Read-Eval-Print Loop)
- View errors/warnings
- Test code snippets
- Access `document` object

**Network Tab:**
- Shows all HTTP requests
- Filter by type (XHR, JS, CSS, Img)
- Check response time
- View headers/response body

**Typical requests on simple page:** 10-50 files (HTML, CSS, JS, images, fonts)

## Activity 5: Live Editing

**Changes are temporary:**
- Stored in browser memory only
- Refresh page = changes lost
- Great for testing before editing actual files

**Common experiments:**
```javascript
// Console experiments
document.body.style.backgroundColor = 'pink';
document.querySelector('h1').textContent = 'HACKED!';
document.querySelectorAll('img').forEach(img => img.style.display = 'none');
```

**Editing CSS:**
- Elements tab → Styles panel
- Click any value to edit
- Add new properties with +
- Toggle checkbox to enable/disable

## Activity 6: Emmet Examples

**Common shortcuts:**

```
! → Full HTML5 template
ul>li*3 → <ul> with 3 <li>
nav>ul>li*4>a → Navigation structure
.container>h1+p → div.container with h1 and p
form>input:text*3+button:s → Form with 3 inputs and submit button
table>tr*3>td*4 → 3x4 table
```

**Advanced:**
```
div.container>header+main>section*3>h2+p+button
```
Generates:
```html
<div class="container">
    <header></header>
    <main>
        <section>
            <h2></h2>
            <p></p>
            <button></button>
        </section>
        <section>
            <h2></h2>
            <p></p>
            <button></button>
        </section>
        <section>
            <h2></h2>
            <p></p>
            <button></button>
        </section>
    </main>
</div>
```

## Activity 7: Project Structure

**Best practices:**
- Organize by file type (css/, js/, images/)
- Use lowercase, hyphens for file names
- Keep HTML in root
- README.md explains project

**VS Code Workspace:**
- File → Open Folder (not individual files)
- See entire project tree
- Quick file switching (Ctrl+P)
- Integrated Git

**Live Server features:**
- Hot reload (auto-refresh on save)
- Works with any HTML file
- Right-click file or click "Go Live" in status bar
- Stop with "Port: 5500" click

**Philippine Context:**
Typical barangay website structure:
```
barangay-stonino/
├── index.html (homepage)
├── officials.html
├── services.html
├── news.html
├── contact.html
├── css/
│   └── styles.css
├── js/
│   └── main.js
└── images/
    ├── logo.png
    ├── captain.jpg
    └── hall.jpg
```

</details>

---

**Excellent! You're now set up like a professional developer!** VS Code configured, extensions installed, DevTools mastered, and project structure organized.

**Next:** HTML document structure!
