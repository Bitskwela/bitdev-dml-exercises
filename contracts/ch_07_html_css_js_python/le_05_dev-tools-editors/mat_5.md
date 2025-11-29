# Lesson 5: Developer Tools and Editors

## Background Story

In the final session before Tian starts actual coding, he was super excited. "Kuya, I'm ready! How do I start? What tools should I use?"

Kuya Miguel laughed. "Perfect timing! Now I'll teach you the tools of professional developers. You don't need expensive software — everything I'll teach you is FREE! Welcome to the world of VS Code and DevTools — the bread and butter of every web developer!"

Kuya Miguel screen shared again. "First, let's download VS Code. Then I'll teach you how to set it up. Ready?"

## Part 1: Text Editors — Where Code is Written

### What is a Text Editor?

A **text editor** (or **code editor**) is specialized software for writing and editing code. Think of it as Microsoft Word, but specifically designed for programmers.

**Why not use Notepad or Word?**

**Notepad:**
- No syntax highlighting (all black text)
- No auto-completion
- No error detection
- No file explorer

**Microsoft Word:**
- Adds formatting (bold, italics) that's not compatible with code
- Saves as .docx, not plain text
- Not designed for programming

**Code Editors:**
- Syntax highlighting (colors for different code parts)
- Auto-completion (IntelliSense)
- Error detection (squiggly lines under mistakes)
- Extensions (superpowers!)
- Integrated terminal
- Git integration
- Multi-cursor editing

### Popular Code Editors

#### 1. Visual Studio Code (VS Code) [STAR] RECOMMENDED

**Pros:**
- FREE at open-source
- Lightning fast
- Thousands of extensions
- Integrated terminal
- Git built-in
- IntelliSense (smart auto-complete)
- Works on Windows, Mac, Linux
- Most popular (used by millions)

**Cons:**
- Can be overwhelming for absolute beginners (so many features)
- Eats RAM when there are many extensions

**Best for:** Everyone! Beginners to professionals

**Download:** https://code.visualstudio.com

---

#### 2. Sublime Text

**Pros:**
- Super fast and lightweight
- Clean, minimal interface
- Multi-cursor editing

**Cons:**
- Paid license ($99) pero may unlimited free trial
- Fewer extensions than VS Code
- Less active development

**Best for:** Speed-focused developers

---

#### 3. Atom

**Pros:**
- Free and open-source
- GitHub integration (made by GitHub)
- Customizable

**Cons:**
- SLOW (especially on older computers)
- High memory usage
- Development slowed down (GitHub focused on VS Code)

**Best for:** GitHub enthusiasts (but VS Code is better)

---

#### 4. Notepad++

**Pros:**
- Super lightweight
- Fast startup
- Windows classic

**Cons:**
- Windows only
- Basic features compared to VS Code
- Limited extensions

**Best for:** Quick edits, lightweight tasks

---

### Our Choice: VS Code

For this course, we'll use **VS Code** because:
- It's free
- It's powerful
- It's industry standard
- It works great for web development
- Lots of tutorials available

## Part 2: VS Code Setup Guide (Step-by-Step)

### Installation

**Step 1:** Visit https://code.visualstudio.com

**Step 2:** Click "Download for Windows" (or your OS)

**Step 3:** Run the installer (.exe file)

**Step 4:** Follow installation wizard:
- Accept license agreement
- Choose installation location (default is fine)
- **IMPORTANT:** Check these options:
  - ☑ Add "Open with Code" to context menu
  - ☑ Add to PATH
  - ☑ Register Code as editor for supported files

**Step 5:** Click Install and wait

**Step 6:** Launch VS Code!

---

### First Launch: Interface Tour

When you first open VS Code, you'll see:

**1. Activity Bar (Left side):**
- Explorer (file browser)
- Search (find in files)
- Source Control (Git)
- Run and Debug
- Extensions

**2. Side Bar (Next to Activity Bar):**
- Shows content based on Activity Bar selection
- Usually shows your project files

**3. Editor Area (Center):**
- Where you write code
- Can have multiple tabs open
- Split screen available

**4. Panel (Bottom):**
- Terminal
- Output
- Problems (errors/warnings)
- Debug Console

**5. Status Bar (Very bottom):**
- Shows file info (language, encoding, line number)
- Git branch
- Errors/warnings count

---

### Essential Extensions for Web Development

Extensions add superpowers to VS Code!

**How to install extensions:**
1. Click Extensions icon (left sidebar) or press `Ctrl+Shift+X`
2. Search for extension name
3. Click Install

---

#### Must-Have Extensions:

**1. Live Server**
- **What it does:** Launches local server, auto-reloads browser on save
- **Why:** No need to manually refresh browser
- **Install:** Search "Live Server" by Ritwick Dey

**2. Prettier - Code Formatter**
- **What it does:** Auto-formats your code beautifully
- **Why:** Consistent formatting, saves time
- **Install:** Search "Prettier"

**3. Auto Rename Tag**
- **What it does:** When you rename opening tag, closing tag auto-updates
- **Why:** Prevents mismatch errors
- **Install:** Search "Auto Rename Tag"

**4. HTML CSS Support**
- **What it does:** Better IntelliSense for HTML/CSS
- **Why:** Faster coding with suggestions
- **Install:** Search "HTML CSS Support"

**5. Path Intellisense**
- **What it does:** Auto-completes file paths
- **Why:** No more typos in file links
- **Install:** Search "Path Intellisense"

---

#### Nice-to-Have Extensions:

**6. Material Icon Theme**
- Beautiful file icons
- Makes files easier to identify

**7. Bracket Pair Colorizer 2** (or built-in now in VS Code)
- Colors matching brackets
- Easier to see code structure

**8. ESLint** (for JavaScript)
- Detects errors and bad practices
- Industry standard for JS

**9. GitLens** (for Git)
- Supercharged Git capabilities
- See who edited what, when

**10. indent-rainbow**
- Colorizes indentation
- Easier to read nested code

---

### VS Code Settings Tweaks

Let's customize VS Code for better experience!

**Open Settings:**
- `Ctrl + ,` (comma) or File → Preferences → Settings

**Recommended settings:**

1. **Auto Save:**
   - Search "auto save"
   - Change to "afterDelay"
   - Never lose work again!

2. **Font Size:**
   - Search "font size"
   - Default is 14, try 16 or 18 pag malayo ka sa screen

3. **Word Wrap:**
   - Search "word wrap"
   - Change to "on"
   - Long lines will wrap instead of horizontal scroll

4. **Format On Save:**
   - Search "format on save"
   - Check it!
   - Auto-formats code every save (needs Prettier installed)

5. **Tab Size:**
   - Search "tab size"
   - Set to 2 (for HTML/CSS/JS standard)

---

### Keyboard Shortcuts (Essential)

What you should memorize:

| Shortcut | Action |
|----------|--------|
| `Ctrl + S` | Save file |
| `Ctrl + O` | Open file |
| `Ctrl + N` | New file |
| `Ctrl + W` | Close tab |
| `Ctrl + Shift + P` | Command Palette (access all features) |
| `Ctrl + /` | Toggle comment |
| `Ctrl + F` | Find in file |
| `Ctrl + H` | Find and replace |
| `Alt + Up/Down` | Move line up/down |
| `Ctrl + D` | Select next occurrence |
| `Ctrl + Shift + K` | Delete line |
| `Ctrl + \`` | Toggle terminal |

**Pro tip:** Print this and keep it visible while you're coding!

---

## Part 3: Browser DevTools Deep Dive

### Opening DevTools (Review)

**Method 1:** Right-click → Inspect  
**Method 2:** F12  
**Method 3:** Ctrl+Shift+I

---

### Elements Tab (In-Depth)

**What it shows:**
- Live DOM tree (not the source code!)
- Applied styles
- Layout (box model)

**Common uses:**

1. **Inspect HTML structure:**
   - Click element selector tool
   - Hover over page elements
   - See HTML in Elements tab

2. **Edit HTML live:**
   - Right-click element → Edit as HTML
   - Make changes
   - See instant results

3. **Modify CSS:**
   - Click element
   - See Styles panel on right
   - Edit, add, or remove styles
   - Changes reflect immediately

4. **Check Box Model:**
   - Select element
   - Scroll down in Styles panel
   - See visual box model diagram
   - Shows margin, border, padding, content

5. **Find which CSS file:**
   - See file:line-number next to each style rule
   - Click to jump to source file

---

### Console Tab (In-Depth)

**What it's for:**
- Run JavaScript commands
- See errors, warnings, logs
- Test code snippets
- Debug issues

**Common uses:**

1. **Basic calculations:**
```javascript
2 + 2  // 4
10 * 5  // 50
```

2. **Test JavaScript:**
```javascript
alert('Hello!');
document.title = 'I changed this!';
```

3. **Log messages (from your code):**
```javascript
console.log('Debug message');
console.error('Error message');
console.warn('Warning message');
```

4. **Inspect variables:**
```javascript
let user = { name: 'Tian', age: 16 };
console.log(user);
```

5. **Access DOM elements:**
```javascript
let heading = document.querySelector('h1');
heading.style.color = 'red';
```

**Pro tip:** Console is your best debugging friend!

---

### Network Tab (In-Depth)

**What it shows:**
- Every request the page makes
- Response status, size, timing
- Request/response headers
- Request payload

**Common uses:**

1. **Check load performance:**
   - See which files are slow
   - Identify bottlenecks
   - Total size transferred

2. **Debug API calls:**
   - See request data sent
   - See response data received
   - Check status codes (200, 404, 500)

3. **Inspect images:**
   - See image file sizes
   - Check if images are optimized

4. **Monitor real-time:**
   - Watch AJAX requests as they happen
   - See WebSocket connections

**Columns explained:**
- **Name:** File name
- **Status:** HTTP status code (200 = OK, 404 = Not Found)
- **Type:** File type (document, stylesheet, script, image)
- **Initiator:** What triggered this request
- **Size:** File size
- **Time:** How long it took
- **Waterfall:** Visual timeline

---

### Application Tab

**What it shows:**
- Storage (cookies, localStorage, sessionStorage)
- Cache
- Service Workers
- Manifest

**Common uses:**

1. **View cookies:**
   - See all cookies stored by website
   - Useful for debugging login issues

2. **Clear storage:**
   - Delete cookies, cache, localStorage
   - Fixes weird issues sometimes

3. **Inspect localStorage:**
   - See key-value pairs stored locally
   - Common for saving user preferences

---

### Performance Tab

**What it's for:**
- Record and analyze page performance
- Find slow parts of your site
- Optimize rendering

**Basic usage:**
1. Click Record (circle icon)
2. Interact with page (scroll, click)
3. Stop recording
4. Analyze timeline

**Look for:**
- Long tasks (red triangles)
- Reflow/repaint operations
- JavaScript execution time
- Frame rate drops

---

### Sources Tab

**What it shows:**
- All files (HTML, CSS, JS) loaded by page
- Allows setting breakpoints
- Step-through debugging

**Common uses:**

1. **View source files:**
   - See actual code of any file
   - Minified or prettified

2. **Debug JavaScript:**
   - Set breakpoints (click line number)
   - Pause execution
   - Inspect variable values

3. **Search across files:**
   - Ctrl+Shift+F in Sources
   - Search entire codebase

---

## Part 4: Online Alternatives (No Installation Needed)

Pag walang laptop or limited storage, may alternatives!

### 1. CodePen (codepen.io)

**Best for:**
- Quick HTML/CSS/JS experiments
- Sharing code snippets
- Learning from others' code

**Pros:**
- No setup needed
- Live preview
- Share via link
- Free

**Cons:**
- Only for frontend (no backend)
- Can't create full projects with multiple pages

---

### 2. Replit (replit.com)

**Best for:**
- Full projects (frontend + backend)
- Collaboration (pair programming)
- Learning multiple languages

**Pros:**
- Supports many languages
- Has terminal
- Can run servers
- Collaborative

**Cons:**
- Free tier has limitations
- Can be slow sometimes

---

### 3. JSFiddle (jsfiddle.net)

**Best for:**
- Quick prototypes
- Testing code

**Similar to CodePen**, pero less popular.

---

### 4. StackBlitz (stackblitz.com)

**Best for:**
- Full framework projects (React, Vue, Angular)
- Runs VS Code in browser!

**Pros:**
- Most powerful online IDE
- Real VS Code experience
- NPM packages supported

**Cons:**
- Requires good internet
- Can be slow on weak devices

---

## Part 5: Workflow — Putting It All Together

### Typical Web Development Workflow:

**Step 1:** Open VS Code

**Step 2:** Create project folder:
```
my-website/
  - index.html
  - style.css
  - script.js
```

**Step 3:** Write code in VS Code

**Step 4:** Right-click `index.html` → "Open with Live Server"

**Step 5:** Browser opens with your page

**Step 6:** Make changes in VS Code

**Step 7:** Save (Ctrl+S)

**Step 8:** Browser auto-refreshes! (thanks to Live Server)

**Step 9:** Use DevTools to inspect, debug, optimize

**Step 10:** Repeat steps 6-9 until satisfied!

---

## Pro Tips for Students

**TIP:** Keep DevTools open ALWAYS while developing. You'll see errors right away.

**TIP:** Learn keyboard shortcuts! You'll code faster when you don't use the mouse often.

**TIP:** Use Ctrl+Shift+P (Command Palette) in VS Code to discover features. Type anything!

**TIP:** Install only extensions you actually need. Too many = slow VS Code.

**TIP:** Customize your VS Code theme! You'll be staring at it for hours, make it comfortable. (File → Preferences → Color Theme)

**TIP:** Practice using DevTools on your favorite websites. Inspect Facebook, YouTube, Shopee — learn from professionals!

**TIP:** Back up your code! Use GitHub (free) or flash drive. Don't lose your work!

**TIP:** In the Philippines, internet can be unstable. Use offline tools (VS Code) as much as possible. Online IDEs need stable connection.

---

## Common Beginner Mistakes

### [WRONG] Mistake 1: Not saving files
**Solution:** Enable Auto Save in VS Code settings

### [WRONG] Mistake 2: Opening HTML file directly (file:///)
**Solution:** Use Live Server extension. Direct opening may cause issues with some features.

### [WRONG] Mistake 3: Editing code in DevTools thinking it saves
**Solution:** DevTools is TEMPORARY. Always edit in VS Code (your actual files).

### [WRONG] Mistake 4: Ignoring Console errors
**Solution:** Red errors in Console? Fix them! They're there for a reason.

### [WRONG] Mistake 5: Not using Prettier/formatter
**Solution:** Consistent formatting makes code readable. Install Prettier!

---

## Summary

**Text Editor: VS Code**
- Free, powerful, industry standard
- Install essential extensions (Live Server, Prettier, etc.)
- Learn keyboard shortcuts
- Customize for comfort

**Browser DevTools:**
- Elements: Inspect/edit HTML/CSS
- Console: Run JavaScript, see errors
- Network: Analyze requests
- Performance: Optimize speed
- Always keep open during development!

**Workflow:**
- Write code in VS Code
- Preview with Live Server
- Debug with DevTools
- Repeat until perfect!

**Online alternatives:**
- CodePen (quick experiments)
- Replit (full projects)
- StackBlitz (advanced projects)

You're now fully equipped with professional tools! Next step: START CODING! HTML, CSS, JavaScript — here we come!

Congrats Tian (and you!) on completing Digital Bayan Chapter 7! You now understand the web from the ground up. Time to build!

---

## Closing Story

Tian finished installing VS Code and stared at the clean, dark interface. Extensions loaded. Settings configured. Workspace ready.

"This is it," Tian whispered. "My developer setup. My tools. My craft."

Kuya Miguel sent a final message: "Remember�tools don't make you a developer. Problem-solving does. But good tools make the journey smoother. Now go build something."

Tian created a new folder: arangay-portal. Inside, a single file: index.html. Empty for now. But not for long.

The cursor blinked on line 1, waiting. Tian's fingers hovered over the keyboard, heart racing with excitement. This was the momentthe transition from learner to builder, from student to creator.

Outside, the neighborhood slept. Inside, a new developer was born.

Tian typed the first line:

``html
<!DOCTYPE html>
``   

And just like that, the journey began.

_Next up: Chapter 2Tala ng HTML: Building the First Bahay!_