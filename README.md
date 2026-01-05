# Bitskwela x Bitdev Developer Micro Learning (DML)

Welcome to Bitskwela's DML Course Repository—an ever-growing curriculum that guides learners from smart contracts through web, data, and systems programming. Every lesson leans on Filipino stories (barangays, palengke wars, jeepney fares, etc.), gradual challenges, and runnable tooling so you learn by writing and verifying real code.

## 📚 Repository Structure

- `contracts/` – Core chapters that teach the following paths:
  - **`ch_01_basic_solidity/`** – Solidity fundamentals (30 lessons) covering syntax, data structures, functions, events, tokens, and security.
  - **`ch_02_solidity_side_quests/`** – Seven focused challenges (reentrancy, approvals, royalties) reinforcing safe token flows.
  - **`ch_03_mini_projects/`** – Five Solidity systems (staking, lending, liquidity) that bundle lessons into product stories.
  - **`ch_04_dapps/`** – DApp lessons that connect Solidity contracts with JavaScript frontends and MetaMask flows.
  - **`ch_05_javascript/`** and **`ch_06_javascript_mini_projects/`** – JavaScript fundamentals and mini-projects for building frontend logic and utilities.
  - **`ch_07_html_css_js_python/`** – Full-stack web development with HTML, CSS, JavaScript, and Python/Flask apps.
  - **`ch_08_cpp/`** – C++ lessons ranging from control flow to OOP and systems-level projects.
  - **`ch_09_python/`** – Python programming with database foundations, NumPy/Pandas analytics, Flask APIs, and a capstone Resident Management System.
  - **`ch_12_move_language/`** – Move language arc covering resources, generics, testing, and security for Sui/Aptos-style chains.
- `exercises/` – Supplementary practice problems and coding drills.
- `artifacts/`, `cache/` – Generated Hardhat compilations and validations.
- `.github/` – Workflows and Copilot instructions, including OpenSpec prompts.

## 🎯 Curriculum Highlights

- **Story + Filipino Context**: Follow Neri and crew through barangay funds, palengke merchants, and jeepney fare puzzles to see abstract programming gain cultural weight.
- **Testing-First Learning**: Every activity includes Hardhat/Chai or Python scripts so you prove solutions rather than guess.
- **Multi-Track Progression**: Begin with Solidity basics, branch into JavaScript/Move/Python/C++ as your interest deepens, and cap off with full-stack or security-focused capstones.

## 🛠️ Technologies in Play

- **Solidity** and **Hardhat** for smart contract development, including OpenZeppelin libraries and testing infrastructure.
- **JavaScript/Node.js** for frontends, tooling, and Hardhat test scripts.
- **Python** (Flask, NumPy, Pandas, Matplotlib) for backends, APIs, and data science labs.
- **C++** (STL, OOP, memory management) for systems programming exercises.
- **Move Language** for resource-oriented programming on Sui/Aptos-style chains.
- **Tools**: MetaMask, VS Code, Git, npm, chai/mocha/ethers, sqlite/MySQL for backend demos.

## 🚀 Recommended Learning Paths

1. **Solidity Developer**
   - Chapters 5 → 1 → 2 → 3 → 4 → 12 (JavaScript foundation first helps handle tests and DApps).
2. **Full-Stack Web Developer**
   - Chapters 7 → 9 → 5 → 6, then circle back to Chapter 4 for DApp polish.
3. **Systems & Data**
   - Chapter 8 → 9 → 7, with optional returns to Solidity for smart contracts.

## 📖 Getting Started

1. Clone the repository: `git clone <repo-url>`
2. Install node dependencies: `npm install`
3. Use Hardhat for Solidity chapters: `npx hardhat test` or `npm test` from the lesson folder.
4. Use Python 3.8+ (with pip) for chapters under `ch_07_html_css_js_python` and `ch_09_python`.
5. Follow the story-driven lesson order or jump to the topic that excites you—the metadata files and index guide the next steps.

**Simulan natin!** (Let’s start!) 🇵🇭✨ #Bitskwela x Bitdev Developer Micro Learning (DML)

Welcome to Bitskwela's DML Course Repository! This comprehensive collection contains structured exercises, lessons, and mini-projects designed to take you from zero to hero across multiple programming disciplines—from smart contract development to full-stack web applications.

## 📚 Repository Structure

- `contracts/`  
  Contains all course materials organized by chapters and topics:

  - **`ch_01_basic_solidity/`** – Basic Solidity concepts and syntax (30 lessons)

    - From variables and functions to advanced topics like inheritance, OpenZeppelin, ERC tokens, and security

  - **`ch_02_solidity_side_quests/`** – Side quests and deeper dives (7 lessons)

    - Token transfers, NFT minting, reentrancy fixes, multi-sig wallets, and more

  - **`ch_03_mini_projects/`** – Solidity mini-projects for hands-on learning (5 projects)

    - Liquidity protocols, staking systems, lending platforms, and tokenized stores

  - **`ch_04_dapps/`** – DApp development exercises (20 lessons)

    - Frontend integration, MetaMask connection, UI components, and full-stack DApp development

  - **`ch_05_javascript/`** – JavaScript fundamentals (20 lessons)

    - Core JavaScript concepts needed for blockchain and web development

  - **`ch_06_javascript_mini_projects/`** – JavaScript mini-projects (5 projects)

    - Practical JavaScript applications with Filipino context

  - **`ch_07_html_css_js_python/`** – Complete Web Development (47 lessons)

    - From internet fundamentals to full-stack Flask applications with HTML, CSS, JavaScript, and Python

  - **`ch_08_cpp/`** – C++ from Zero to Hero (31 lessons)

    - Fundamentals, OOP, memory management, STL, and complete CRUD applications

  - **`ch_09_python/`** – Python Programming (30 lessons)

    - Database fundamentals, data science, Flask web development, and full-stack applications

- `exercises/`  
  Additional exercises and practice problems.

- `artifacts/`, `cache/`  
  Build and compilation outputs (auto-generated by Hardhat).

- `.github/`  
  GitHub workflows and Copilot instructions.

## 🎯 Course Progression

### Course 1: Basic Solidity (30 Lessons)

Start your blockchain journey with fundamental Solidity concepts:

- **Lessons 1-4**: Variables, data types, and basic operations
- **Lessons 5-8**: Control structures, mappings, and structs
- **Lessons 9-12**: Arrays, constructors, and events
- **Lessons 13-18**: Function types, global variables, and memory management
- **Lessons 19-23**: Inheritance, interfaces, and libraries
- **Lessons 24-30**: OpenZeppelin, token standards (ERC20, ERC721, ERC1155), and security

### Course 2: Solidity Side Quests (7 Lessons)

Deepen your understanding with practical blockchain challenges:

- Token transfer mechanisms and approval systems
- NFT minting logic and marketplace features
- Security fixes and multi-signature wallets
- Dynamic pricing and royalty systems

### Course 3: Mini Projects (5 Projects)

Build complete smart contract systems:

- Liquidity lockdown mechanisms
- Staking and reward systems
- Lending protocol implementation
- Security and audit practices
- Tokenized retail systems

### Course 4: DApp Development (20 Lessons)

Learn full-stack blockchain development:

- **Frontend Integration**: MetaMask connection, wallet interactions
- **Smart Contract Communication**: Reading data, triggering functions
- **User Experience**: Event listeners, real-time updates
- **Advanced Features**: Multi-network support, gas optimization
- **Complete DApps**: NFT platforms, DeFi dashboards, DAOs

### Course 5: JavaScript Fundamentals (20 Lessons)

Master JavaScript for web and blockchain development:

- Core programming concepts and syntax
- DOM manipulation and web interactions
- Modern JavaScript features and best practices
- Asynchronous programming and API integration

### Course 6: JavaScript Mini Projects (5 Projects)

Apply JavaScript skills in practical scenarios:

- Administrative and tracking systems
- Calculator and POS applications
- Community service platforms

### Course 7: Complete Web Development (47 Lessons)

Full-stack web development from fundamentals to deployment:

- **Lessons 1-5**: Web fundamentals and how the internet works
- **Lessons 6-11**: HTML foundations and semantic markup
- **Lessons 12-17**: CSS fundamentals and styling
- **Lessons 18-22**: Responsive design with Flexbox and Grid
- **Lessons 23-29**: JavaScript logic and programming fundamentals
- **Lessons 30-36**: Modern JavaScript, DOM, and API integration
- **Lessons 37-42**: Full-stack development with Flask
- **Lessons 43-47**: Authentication, deployment, and production apps

### Course 8: C++ from Zero to Hero (31 Lessons)

Master systems programming with C++:

- **Lessons 1-9**: Foundations and control flow → ATM Simulator project
- **Lessons 10-13**: Functions and modularity → Grade Calculator project
- **Lessons 14-22**: Data structures, pointers, memory → Contact Book project
- **Lessons 23-31**: OOP, templates, STL, exceptions → Barangay CRUD System capstone

### Course 9: Python Programming (30 Lessons)

Data-driven development with Python:

- **Lessons 1-3**: Database foundations (SQL, tables, keys)
- **Lessons 4-12**: Python fundamentals (syntax, data structures, control flow)
- **Lessons 13-18**: Data science with NumPy, Pandas, Matplotlib → Budget Forecaster project
- **Lessons 19-21**: File handling and modules
- **Lessons 22-24**: Web development with Flask and REST APIs
- **Lessons 25-30**: Database design and integration → Resident Management System capstone

## 🚀 Getting Started

1. **Prerequisites**: Basic programming knowledge helpful but not required
2. **Setup**: Clone this repository and install dependencies
   ```bash
   git clone <repository-url>
   cd bitdev-dml-exercises
   npm install
   ```
3. **For Solidity**: Use Hardhat for smart contract development and testing
4. **For Python**: Use Python 3.8+ with pip for package management
5. **For C++**: Use g++, clang++, or Visual C++ compiler
6. **Learning Path**: Follow courses sequentially or jump to your area of interest

## 🛠️ Technology Stack

**Blockchain & Smart Contracts:**

- Solidity, OpenZeppelin
- Hardhat, Ethers.js
- Ethereum and compatible networks

**Web Development:**

- HTML5, CSS3, JavaScript ES6+
- Flask (Python web framework)
- REST API design

**Programming Languages:**

- JavaScript/Node.js
- Python 3.x (NumPy, Pandas, Matplotlib)
- C++ (STL, OOP)

**Databases:**

- SQLite, SQL fundamentals
- Database design and normalization

**Testing & Tools:**

- Chai, Mocha
- VS Code, Browser DevTools
- Git version control

## 📖 Learning Approach

This course uses a **story-driven approach with Filipino context** to make learning engaging and relatable. Each lesson includes:

- Clear learning objectives
- Practical coding exercises
- Real-world barangay-themed applications
- Progressive difficulty levels
- Mini-projects to apply your knowledge

## 🗺️ Recommended Learning Paths

### 🔗 Blockchain Developer Path

1. Course 5: JavaScript Fundamentals
2. Course 1: Basic Solidity
3. Course 2: Solidity Side Quests
4. Course 3: Mini Projects
5. Course 4: DApp Development

### 🌐 Full-Stack Web Developer Path

1. Course 7: Complete Web Development (HTML, CSS, JS, Flask)
2. Course 9: Python Programming (Database & Data Science)
3. Course 6: JavaScript Mini Projects

### 💻 Systems Programming Path

1. Course 8: C++ from Zero to Hero
2. Course 9: Python Programming

### 📊 Data & Backend Path

1. Course 9: Python Programming
2. Course 7: Complete Web Development (Flask sections)

---

Start with the path that matches your goals and work through each lesson systematically. Each course builds upon foundational concepts, ensuring solid understanding before advancing to complex topics.

**Simulan natin!** (Let's start!) 🇵🇭✨
