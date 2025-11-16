# Dev Tools & Code Editors Quiz

---

# Quiz 1

## Quiz: Complete Development Environment Setup and Workflow

**Scenario:**

Tian is a fresh Computer Science graduate starting his first job as a Junior Web Developer at a startup in BGC. On Day 1, he needs to setup his development environment and create his first feature: "User Profile Page" for their social media app.

**Tian's Task:**
- Setup VS Code with proper extensions
- Clone company's GitHub repository
- Create responsive profile page (HTML/CSS/JavaScript)
- Debug issues using DevTools
- Submit code for review

---

### Part 1: VS Code Setup Challenge

**Tian's Laptop (Brand new setup):**
```
Operating System: Windows 11
Installed: Nothing yet (fresh install)
Internet: PLDT Fibr 100 Mbps
```

**Team Requirements:**
```markdown
Required Tools:
1. ________ - Code editor (NOT Notepad!)
2. Git - Version control
3. Node.js - JavaScript runtime
4. Chrome - Browser with DevTools

VS Code Extensions Required:
1. ________ - Auto-reloads browser on save
2. Prettier - Code formatter
3. ESLint - JavaScript linter
4. Auto Rename Tag - HTML tag syncing
5. ________ - Better file icons
```

**Tian's First Code (index.html):**
```html
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="profile-container">
        <img src="avatar.jpg" alt="Profile Picture">
        <h1>Tian</h1>
        <p class="bio">Full-stack developer from Manila</p>
        <button onclick="editProfile()">Edit Profile</button>
    </div>
    
    <script src="script.js"></script>
</body>
</html>
```

---

### Part 2: Keyboard Shortcuts Challenge

**Senior Developer:** "Mark, you're using mouse too much. Learn shortcuts for 10x speed!"

**Common Tasks:**

```javascript
// Task 1: Rename all "userName" to "userEmail"
const userName = props.userName;
console.log(userName);
displayUser(userName);

// Need to select ALL 3 occurrences simultaneously
// Shortcut: Ctrl + ________ (Windows)
```

**Multiple Cursor Editing:**
```javascript
// Task 2: Add ; at end of each line
const firstName = "Juan"
const lastName = "Dela Cruz"
const age = 25
const city = "Manila"

// Place cursor at end of each line simultaneously
// Shortcut: Alt + Click (or Ctrl + Alt + ↓)
```

**Quick Actions:**
```
Common VS Code Shortcuts:
- Save file: Ctrl + ________
- Open command palette: Ctrl + Shift + ________
- Toggle comment: Ctrl + ________
- Format document: Shift + Alt + ________
- Find in files: Ctrl + Shift + ________
- Split editor: Ctrl + ________
- Open terminal: Ctrl + ________
```

---

### Part 3: Real Debugging Scenario

**Tian's Bug Report:**
```
Issue: Profile page not loading properly
Browser: Chrome
Errors visible: Yes (console shows red text)
```

**DevTools Investigation:**

**Console Tab Output:**
```javascript
Uncaught ReferenceError: editProfile is not defined
    at HTMLButtonElement.onclick (index.html:12)

Failed to load resource: the server responded with a status of 404 (Not Found)
    avatar.jpg
```

**Network Tab:**
```
Name          Status    Type        Size      Time
index.html    200 OK    document    1.2 KB    45ms  ✅
style.css     200 OK    stylesheet  2.4 KB    38ms  ✅
script.js     200 OK    script      892 B     32ms  ✅
avatar.jpg    404       image       -         120ms ❌
```

**Elements Tab (Inspecting):**
```html
<div class="profile-container">
  <img src="avatar.jpg" alt="Profile Picture">
  <!-- ↑ Red broken image icon -->
  <h1>Juan Dela Cruz</h1>
  ...
```

---

### Part 4: Live Server Workflow

**Without Live Server (Old way):**
```
1. Edit HTML in Notepad
2. Save file
3. Open Chrome
4. Find file in folders
5. Right-click → Open with Chrome
6. Make another change
7. Go back to browser
8. Press F5 to refresh
9. Repeat...
😰 So many steps!
```

**With Live Server (Modern way):**
```
1. Open project folder in VS Code
2. Install Live Server extension
3. Right-click index.html
4. Click "Open with Live Server"
5. Browser opens automatically at http://localhost:5500
6. Make changes in VS Code
7. Press Ctrl+S to save
8. Browser auto-refreshes instantly! ✨
9. See changes immediately
😊 So fast!
```

---

## Quiz Questions

**Tanong 1:** Anong code editor ang recommended para sa web development (modern, free, extensible)?

- A) Microsoft Word
- B) Notepad
- C) Visual Studio Code (VS Code)
- D) Photoshop

**Tanong 2:** Anong VS Code extension ang nag-a-auto reload ng browser when you save files?

- A) Prettier (code formatter)
- B) Live Server (live reload)
- C) ESLint (JavaScript linter)
- D) GitLens (git integration)

**Tanong 3:** Ano ang keyboard shortcut para mag-save ng file sa VS Code?

- A) Ctrl + C
- B) Ctrl + V
- C) Ctrl + S
- D) Ctrl + Z

---

# Quiz 2

**Tanong 4:** Paano mo i-select ang LAHAT ng occurrences ng isang word for simultaneous editing?

- A) Ctrl + F (Find)
- B) Ctrl + Shift + L (Select All Occurrences)
- C) Ctrl + C (Copy)
- D) Ctrl + X (Cut)

**Tanong 5:** Sa DevTools, saan mo makikita ang JavaScript errors?

- A) Elements Tab
- B) Console Tab
- C) Network Tab
- D) Application Tab

**Tanong 6:** Ang avatar.jpg ay 404 Not Found. Ano ang problema?

- A) Image file ay nasa wrong folder or hindi uploaded
- B) Browser issue lang
- C) Internet slow lang
- D) Kailangan ng special software

**Sagot:**
- **Tanong 1:** C) Visual Studio Code
- **Tanong 2:** B) Live Server
- **Tanong 3:** C) Ctrl + S
- **Tanong 4:** B) Ctrl + Shift + L
- **Tanong 5:** B) Console Tab
- **Tanong 6:** A) Image file ay nasa wrong folder

---

## Detailed Explanation

### Part 1: Why VS Code? (vs other editors)

**Notepad - Basic Text Editor**
```
Pros:
✅ Pre-installed sa Windows
✅ Super lightweight
✅ Opens instantly

Cons:
❌ No syntax highlighting (all black text)
❌ No auto-completion
❌ No error detection
❌ No extensions
❌ No file management
❌ No integrated terminal

Verdict: ❌ NOT for professional development
```

---

**Notepad++ - Better Text Editor**
```
Pros:
✅ Syntax highlighting (colorful code)
✅ Multiple tabs
✅ Line numbers
✅ Free

Cons:
❌ Windows only
❌ Limited extensions
❌ No integrated terminal
❌ Basic IntelliSense
❌ No Git integration

Verdict: ⚠️ Okay for beginners, pero limited
```

---

**Visual Studio Code - Modern Code Editor**
```
Pros:
✅ Syntax highlighting (beautiful colors)
✅ IntelliSense (smart auto-complete)
✅ Integrated terminal (no need to open separate CMD)
✅ Git integration (version control built-in)
✅ Extensions marketplace (50,000+ extensions)
✅ Multi-cursor editing
✅ Free and open-source
✅ Cross-platform (Windows, Mac, Linux)
✅ Very active community
✅ Regular updates

Cons:
❌ Uses more RAM than Notepad (pero worth it!)
❌ Initial setup needed (install extensions)

Verdict: ✅ Industry standard for web development!
```

---

**Sublime Text - Fast Text Editor**
```
Pros:
✅ Very fast performance
✅ Beautiful interface
✅ Multi-cursor editing

Cons:
❌ Paid ($99) - may free trial pero may nag-popup
❌ Fewer extensions vs VS Code
❌ Smaller community

Verdict: ⚠️ Good alternative, pero VS Code is better for beginners
```

---

### Part 2: Essential VS Code Extensions

**1. Live Server - Auto-reload browser**
```
Purpose: Automatically refresh browser when you save files

Installation:
1. Press Ctrl+Shift+X (Extensions)
2. Search "Live Server"
3. Click Install
4. Author: Ritwick Dey

Usage:
1. Right-click index.html
2. "Open with Live Server"
3. Browser opens at http://localhost:5500
4. Edit code → Save → Auto-refresh!

Benefits:
✅ Save time (no manual refresh)
✅ See changes instantly
✅ Better workflow
✅ Multiple devices can connect (test on phone!)
```

---

**2. Prettier - Code Formatter**
```javascript
// Before Prettier (messy):
function calculate(a,b){return a+b;}
const user={name:"Juan",age:25,city:"Manila"}

// After Prettier (clean):
function calculate(a, b) {
  return a + b;
}

const user = {
  name: "Juan",
  age: 25,
  city: "Manila"
};
```

**Setup:**
```
1. Install Prettier extension
2. Settings → Search "Format On Save"
3. Check ✅ "Editor: Format On Save"
4. Now: Every Ctrl+S auto-formats code!
```

**Benefits:**
✅ Consistent code style
✅ No manual formatting
✅ Team uses same style
✅ Looks professional

---

**3. ESLint - JavaScript Linter**
```javascript
// ESLint catches errors BEFORE running code:

// Error 1: Unused variable
const userName = "Juan";  // ⚠️ 'userName' is assigned but never used

// Error 2: Missing semicolon
const age = 25  // ⚠️ Missing semicolon

// Error 3: Undefined variable
console.log(userAge);  // ❌ 'userAge' is not defined

// Error 4: Double declaration
let city = "Manila";
let city = "Quezon";  // ❌ 'city' is already declared
```

**Benefits:**
✅ Catch bugs early
✅ Better code quality
✅ Learn best practices
✅ Red squiggly lines = error

---

**4. Auto Rename Tag**
```html
<!-- Without extension: -->
<div class="container">
  <h1>Hello</h1>
</div>

<!-- Change opening <div> to <section>: -->
<section class="container">
  <h1>Hello</h1>
</div>  <!-- ❌ Still </div> - mismatch! -->


<!-- With extension: -->
<div class="container">
  <h1>Hello</h1>
</div>

<!-- Change opening <div> to <section>: -->
<section class="container">
  <h1>Hello</h1>
</section>  <!-- ✅ Auto-changed to </section>! -->
```

**Benefits:**
✅ Prevents mismatched tags
✅ Saves time typing
✅ Fewer bugs

---

**5. Material Icon Theme**
```
File Explorer (Without icons):
📁 src
  📄 index.html
  📄 style.css
  📄 script.js
  📄 README.md

File Explorer (With Material Icons):
📁 src
  🌐 index.html     (HTML icon)
  🎨 style.css      (CSS icon)
  📜 script.js      (JavaScript icon)
  📋 README.md      (Markdown icon)
  📁 images         (Folder icon)
    🖼️ logo.png     (Image icon)
```

**Benefits:**
✅ Easy to find files by type
✅ Beautiful interface
✅ Better visual organization

---

**Other Recommended Extensions:**

**6. Path Intellisense**
```html
<!-- Auto-completes file paths: -->
<img src="./  <!-- Type "./" and see suggestions:
  📁 images/
  📁 css/
  📄 index.html
  📄 script.js
-->

<!-- Select images/ → see files inside: -->
<img src="./images/  <!-- Suggestions:
  🖼️ logo.png
  🖼️ banner.jpg
  🖼️ avatar.png
-->

<img src="./images/logo.png">  <!-- ✅ No typos! -->
```

---

**7. GitLens - Git Supercharged**
```javascript
// Shows who wrote each line and when:
const userName = "Juan";  // John Doe, 2 days ago
const userAge = 25;       // Maria Santos, 1 week ago

// Hover over line → see full commit info:
// Author: John Doe
// Date: Nov 11, 2024
// Message: "Added user authentication"
```

---

**8. Bracket Pair Colorizer**
```javascript
// Matching brackets get same color:
function calculate() {    // ← Blue
  if (true) {             // ← Green
    for (let i = 0; i < 10; i++) {  // ← Yellow
      console.log(i);
    }                     // ← Yellow
  }                       // ← Green
}                         // ← Blue

// Easy to see matching pairs!
```

---

### Part 3: Essential Keyboard Shortcuts

**File Operations:**
```
Ctrl + N          New file
Ctrl + O          Open file
Ctrl + S          Save file
Ctrl + Shift + S  Save as...
Ctrl + W          Close current tab
Ctrl + Shift + T  Reopen closed tab
```

---

**Editing:**
```
Ctrl + X          Cut line (no selection needed!)
Ctrl + C          Copy line (no selection needed!)
Ctrl + V          Paste
Ctrl + Z          Undo
Ctrl + Y          Redo
Ctrl + /          Toggle line comment
Ctrl + Shift + /  Toggle block comment
Shift + Alt + ↓   Copy line down
Alt + ↓           Move line down
Ctrl + Shift + K  Delete line
```

---

**Selection:**
```
Ctrl + D          Select next occurrence
Ctrl + Shift + L  Select all occurrences
Ctrl + A          Select all
Shift + ←/→       Select characters
Ctrl + Shift + ←/→  Select words
Shift + Alt + →   Expand selection
```

---

**Multi-Cursor (POWERFUL!):**
```javascript
// Example: Add semicolon to multiple lines
const firstName = "Juan"   // ← Click here
const lastName = "Cruz"    // ← Alt+Click here
const age = 25             // ← Alt+Click here

// Now type ; once → appears on all 3 lines!
const firstName = "Juan";
const lastName = "Cruz";
const age = 25;
```

**Shortcuts:**
```
Alt + Click       Add cursor at click position
Ctrl + Alt + ↓    Add cursor below
Ctrl + Alt + ↑    Add cursor above
Ctrl + Shift + L  Add cursor to all selected occurrences
```

---

**Navigation:**
```
Ctrl + P          Quick open (search files)
Ctrl + Shift + P  Command palette
Ctrl + B          Toggle sidebar
Ctrl + `          Toggle terminal
Ctrl + \          Split editor
Ctrl + 1/2/3      Focus editor group
Ctrl + G          Go to line number
F12               Go to definition
Alt + ←/→         Navigate back/forward
```

---

**Search:**
```
Ctrl + F          Find in current file
Ctrl + H          Find and replace
Ctrl + Shift + F  Find in all files
Ctrl + Shift + H  Replace in all files
F3                Find next
Shift + F3        Find previous
```

---

**Formatting:**
```
Shift + Alt + F   Format entire document
Ctrl + K, Ctrl + F  Format selection
Tab               Indent
Shift + Tab       Outdent
```

---

### Part 4: Debugging Workflow with DevTools

**Mark's Bug Investigation:**

**Bug 1: editProfile is not defined**

```javascript
// Console error:
Uncaught ReferenceError: editProfile is not defined
    at HTMLButtonElement.onclick (index.html:12)
```

**Investigation Steps:**

1. **Open DevTools** (F12)
2. **Go to Console Tab** → See error
3. **Click on `index.html:12`** → Opens Sources tab
4. **See the problematic line:**
   ```html
   <button onclick="editProfile()">Edit Profile</button>
   ```
5. **Check script.js** → Function not defined!
6. **Fix:**
   ```javascript
   // script.js
   function editProfile() {
     alert('Edit profile clicked!');
     // TODO: Open edit modal
   }
   ```
7. **Save → Live Server auto-refreshes** ✅

---

**Bug 2: avatar.jpg not found (404)**

```
Network Tab shows:
avatar.jpg    404 Not Found    120ms
```

**Investigation:**

1. **Network Tab** → See 404 error
2. **Check file structure:**
   ```
   project/
   ├─ index.html
   ├─ style.css
   ├─ script.js
   └─ images/
      └─ avatar.jpg  ← File is HERE!
   ```
3. **Problem:** Code says `src="avatar.jpg"` pero file is in `images/` folder
4. **Fix:**
   ```html
   <!-- Before: -->
   <img src="avatar.jpg" alt="Profile Picture">
   
   <!-- After: -->
   <img src="images/avatar.jpg" alt="Profile Picture">
   ```
5. **Save → Browser auto-reloads → Image shows!** ✅

---

### Part 5: Complete Development Workflow

**Mark's Typical Day:**

**Morning Routine:**
```
1. Open VS Code
   - Ctrl + K, Ctrl + O → Open project folder
   
2. Pull latest code from GitHub
   - Ctrl + ` (open terminal)
   - git pull origin main
   
3. Create new feature branch
   - git checkout -b feature/user-profile
   
4. Start Live Server
   - Right-click index.html
   - "Open with Live Server"
```

---

**Coding Phase:**
```
5. Write HTML
   - Type ! + Tab → HTML boilerplate
   - Use Emmet shortcuts:
     div.container>h1+p → expands to:
     <div class="container">
       <h1></h1>
       <p></p>
     </div>
   
6. Style with CSS
   - Ctrl + Space → Auto-complete CSS properties
   - Save (Ctrl + S) → Prettier formats
   
7. Add JavaScript
   - ESLint shows errors in real-time
   - Fix issues before running
   
8. Test in browser
   - Changes appear instantly (Live Server)
   - Use DevTools to debug
```

---

**Testing Phase:**
```
9. Check console for errors
   - F12 → Console Tab
   - Fix any red errors
   
10. Test on mobile size
    - F12 → Toggle device toolbar (Ctrl + Shift + M)
    - Test responsive design
    
11. Check network performance
    - Network Tab → See load times
    - Optimize slow resources
```

---

**Submission Phase:**
```
12. Format code
    - Shift + Alt + F → Format all files
    
13. Commit changes
    - Ctrl + Shift + G (Source Control)
    - Type commit message
    - Click ✓ to commit
    
14. Push to GitHub
    - Terminal: git push origin feature/user-profile
    
15. Create Pull Request
    - Team reviews code
    - Merge to main branch
```

---

### Philippine Developer Context

**Common Setup in PH Companies:**

**Startups (BGC, Makati):**
```
Editor: VS Code (95%)
Terminal: Git Bash / PowerShell
Node Version: Latest LTS
Package Manager: npm / yarn
Browser: Chrome (primary), Firefox (testing)
Deployment: Vercel, Netlify, AWS
```

---

**Corporate (Banks, BPO):**
```
Editor: VS Code or IntelliJ
Version Control: GitLab (internal)
Code Reviews: Mandatory
Testing: Required before merge
Deployment: Manual approval process
```

---

**Freelance Developers:**
```
Tools: VS Code, Figma, Postman
Communication: Slack, Discord
Project Management: Trello, Asana
Payment: PayPal, Wise, PayMaya
Clients: Local and international
```

---

**Typical Filipino Developer Salary (2024):**
```
Junior (0-2 years):    ₱25,000 - ₱40,000/month
Mid-level (3-5 years): ₱50,000 - ₱80,000/month
Senior (5+ years):     ₱80,000 - ₱150,000/month
Lead/Manager:          ₱120,000 - ₱200,000/month

Remote (International):
Junior:                $500 - $1,500/month
Mid:                   $1,500 - $3,500/month
Senior:                $3,000 - $7,000/month
```

---

## Key Takeaways

**Essential Tools:**
1. ✅ **VS Code** - Modern code editor
2. ✅ **Live Server** - Auto-reload browser
3. ✅ **Prettier** - Code formatting
4. ✅ **ESLint** - Error detection
5. ✅ **Chrome DevTools** - Debugging

**Must-Know Shortcuts:**
- `Ctrl + S` - Save
- `Ctrl + /` - Comment
- `Ctrl + Shift + L` - Select all occurrences
- `Ctrl + P` - Quick open file
- `F12` - Open DevTools

**DevTools Tabs:**
- **Console** - Errors and logs
- **Elements** - HTML/CSS inspection
- **Network** - HTTP requests
- **Sources** - Debugging JavaScript

**Pro Tips:**
1. Learn keyboard shortcuts (10x faster!)
2. Use Live Server (never manual refresh)
3. Let Prettier handle formatting
4. Check Console regularly
5. Master multi-cursor editing
6. Practice daily! 🚀
