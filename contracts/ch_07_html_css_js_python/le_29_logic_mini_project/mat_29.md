# Lesson 29: Logic Mini Project - Barangay Service Portal

---

## Building a Complete System

"Kuya Miguel, we've learned so much! Can we build something real?" Tian asked excitedly.

Rhea Joy added, "Something that uses everything—variables, conditions, loops, functions, arrays, and objects?"

Kuya Miguel smiled. "Absolutely! Let's build a **Barangay Service Portal**—a complete system that manages visitors, calculates fees, tracks services, and generates reports!"

---

## Project Overview

**Barangay Service Portal Features:**
1. Add new visitors with complete information
2. Calculate fees with automatic discounts (senior/PWD)
3. Display all visitors and their status
4. Search for specific visitors
5. Generate daily summary report
6. Track total revenue

**Technologies:**
- Variables and constants
- Conditional statements (if/else)
- Loops (for, for...of)
- Functions for code organization
- Arrays to store visitor list
- Objects to store visitor details

---

## Project Structure

```javascript
// Configuration
const CONFIG = {
    services: {
        clearance: { name: "Barangay Clearance", fee: 50 },
        residency: { name: "Residency Certificate", fee: 30 },
        indigency: { name: "Indigency Certificate", fee: 20 },
        permit: { name: "Business Permit", fee: 100 }
    },
    discounts: {
        senior: 0.20,  // 20%
        pwd: 0.20      // 20%
    },
    officeName: "San Juan Barangay Hall"
};

// Visitor database
let visitors = [];
let nextId = 1;

// Main functions
function addVisitor(name, age, serviceType, isPWD) { /* ... */ }
function calculateFee(visitor) { /* ... */ }
function displayAllVisitors() { /* ... */ }
function searchVisitor(searchTerm) { /* ... */ }
function generateReport() { /* ... */ }
function displayHeader() { /* ... */ }
```

---

## Complete Implementation

```javascript
// ======================================
// BARANGAY SERVICE PORTAL
// A Complete Visitor Management System
// ======================================

// ============ CONFIGURATION ============
const CONFIG = {
    services: {
        clearance: { name: "Barangay Clearance", fee: 50 },
        residency: { name: "Residency Certificate", fee: 30 },
        indigency: { name: "Indigency Certificate", fee: 20 },
        permit: { name: "Business Permit", fee: 100 }
    },
    discounts: {
        senior: 0.20,  // 20% for seniors (60+)
        pwd: 0.20      // 20% for PWD
    },
    officeName: "San Juan Barangay Hall",
    officeHours: "Monday-Friday: 8AM-5PM, Saturday: 8AM-12PM"
};

// ============ DATA STORAGE ============
let visitors = [];  // Array to store all visitors
let nextId = 1;     // Auto-increment ID

// ============ UTILITY FUNCTIONS ============

/**
 * Display portal header
 */
function displayHeader() {
    console.log("\n╔═══════════════════════════════════════╗");
    console.log("║   BARANGAY SERVICE PORTAL v1.0        ║");
    console.log("║   " + CONFIG.officeName + "          ║");
    console.log("╚═══════════════════════════════════════╝");
    console.log("Hours: " + CONFIG.officeHours);
    console.log("─────────────────────────────────────────\n");
}

/**
 * Get current timestamp
 */
function getCurrentTimestamp() {
    const now = new Date();
    return now.toLocaleString('en-PH', { 
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
}

/**
 * Validate service type
 */
function isValidService(serviceType) {
    return CONFIG.services.hasOwnProperty(serviceType);
}

// ============ CORE FUNCTIONS ============

/**
 * Add new visitor to the system
 */
function addVisitor(name, age, serviceType, isPWD) {
    // Validation
    if (!name || name.trim() === "") {
        console.log("❌ Error: Name is required");
        return false;
    }
    
    if (age < 0 || age > 120) {
        console.log("❌ Error: Invalid age");
        return false;
    }
    
    if (!isValidService(serviceType)) {
        console.log("❌ Error: Invalid service type");
        console.log("Available: clearance, residency, indigency, permit");
        return false;
    }
    
    // Create visitor object
    const visitor = {
        id: nextId++,
        name: name,
        age: age,
        serviceType: serviceType,
        isPWD: isPWD || false,
        timestamp: getCurrentTimestamp(),
        status: "pending"
    };
    
    // Add to database
    visitors.push(visitor);
    
    console.log("✅ Visitor added successfully!");
    console.log("   ID: " + visitor.id);
    console.log("   Name: " + visitor.name);
    console.log("   Service: " + CONFIG.services[serviceType].name);
    
    return true;
}

/**
 * Calculate fee with discounts
 */
function calculateFee(visitor) {
    const service = CONFIG.services[visitor.serviceType];
    const baseFee = service.fee;
    let finalFee = baseFee;
    let discount = 0;
    let discountReason = "None";
    
    // Apply discounts
    if (visitor.age >= 60) {
        discount = baseFee * CONFIG.discounts.senior;
        discountReason = "Senior Citizen (20%)";
    } else if (visitor.isPWD) {
        discount = baseFee * CONFIG.discounts.pwd;
        discountReason = "PWD (20%)";
    }
    
    finalFee = baseFee - discount;
    
    return {
        serviceName: service.name,
        baseFee: baseFee,
        discount: discount,
        discountReason: discountReason,
        finalFee: finalFee
    };
}

/**
 * Display detailed visitor information
 */
function displayVisitorDetails(visitor) {
    const feeInfo = calculateFee(visitor);
    
    console.log("\n┌─────────────────────────────────────┐");
    console.log("│ Visitor ID: " + visitor.id);
    console.log("├─────────────────────────────────────┤");
    console.log("│ Name: " + visitor.name);
    console.log("│ Age: " + visitor.age);
    
    if (visitor.age >= 60) {
        console.log("│ Category: Senior Citizen 🎉");
    } else if (visitor.isPWD) {
        console.log("│ Category: PWD 🎉");
    } else {
        console.log("│ Category: Regular");
    }
    
    console.log("│");
    console.log("│ Service: " + feeInfo.serviceName);
    console.log("│ Base Fee: ₱" + feeInfo.baseFee.toFixed(2));
    
    if (feeInfo.discount > 0) {
        console.log("│ Discount: -₱" + feeInfo.discount.toFixed(2));
        console.log("│ Reason: " + feeInfo.discountReason);
    }
    
    console.log("│ FINAL FEE: ₱" + feeInfo.finalFee.toFixed(2));
    console.log("│");
    console.log("│ Timestamp: " + visitor.timestamp);
    console.log("│ Status: " + visitor.status.toUpperCase());
    console.log("└─────────────────────────────────────┘");
}

/**
 * Display all visitors
 */
function displayAllVisitors() {
    if (visitors.length === 0) {
        console.log("\n📭 No visitors in the system");
        return;
    }
    
    console.log("\n╔═══════════════════════════════════════╗");
    console.log("║        ALL VISITORS (" + visitors.length + ")                ║");
    console.log("╚═══════════════════════════════════════╝");
    
    for (let visitor of visitors) {
        displayVisitorDetails(visitor);
    }
}

/**
 * Search for visitor by name or ID
 */
function searchVisitor(searchTerm) {
    const results = [];
    
    // Convert search term to string and lowercase
    const searchString = String(searchTerm).toLowerCase();
    
    for (let visitor of visitors) {
        // Search by ID (exact match)
        if (visitor.id === parseInt(searchTerm)) {
            results.push(visitor);
        }
        // Search by name (partial match)
        else if (visitor.name.toLowerCase().includes(searchString)) {
            results.push(visitor);
        }
    }
    
    if (results.length === 0) {
        console.log("\n❌ No visitors found matching: " + searchTerm);
        return;
    }
    
    console.log("\n🔍 Search Results (" + results.length + " found):");
    
    for (let visitor of results) {
        displayVisitorDetails(visitor);
    }
}

/**
 * Update visitor status
 */
function processVisitor(visitorId) {
    let found = false;
    
    for (let visitor of visitors) {
        if (visitor.id === visitorId) {
            visitor.status = "completed";
            found = true;
            console.log("✅ Visitor #" + visitorId + " marked as completed");
            displayVisitorDetails(visitor);
            break;
        }
    }
    
    if (!found) {
        console.log("❌ Visitor ID " + visitorId + " not found");
    }
}

/**
 * Generate daily summary report
 */
function generateReport() {
    if (visitors.length === 0) {
        console.log("\n📭 No data to generate report");
        return;
    }
    
    console.log("\n╔═══════════════════════════════════════╗");
    console.log("║         DAILY SUMMARY REPORT          ║");
    console.log("╚═══════════════════════════════════════╝");
    
    // Initialize counters
    let totalRevenue = 0;
    let seniorCount = 0;
    let pwdCount = 0;
    let regularCount = 0;
    let completedCount = 0;
    let pendingCount = 0;
    
    // Service type counters
    const serviceCounts = {
        clearance: 0,
        residency: 0,
        indigency: 0,
        permit: 0
    };
    
    // Process each visitor
    for (let visitor of visitors) {
        const feeInfo = calculateFee(visitor);
        totalRevenue += feeInfo.finalFee;
        
        // Count categories
        if (visitor.age >= 60) {
            seniorCount++;
        } else if (visitor.isPWD) {
            pwdCount++;
        } else {
            regularCount++;
        }
        
        // Count status
        if (visitor.status === "completed") {
            completedCount++;
        } else {
            pendingCount++;
        }
        
        // Count services
        serviceCounts[visitor.serviceType]++;
    }
    
    // Display statistics
    console.log("\n📊 VISITOR STATISTICS");
    console.log("─────────────────────────────────────────");
    console.log("Total Visitors: " + visitors.length);
    console.log("  • Senior Citizens: " + seniorCount);
    console.log("  • PWD: " + pwdCount);
    console.log("  • Regular: " + regularCount);
    console.log("");
    console.log("Status Breakdown:");
    console.log("  • Completed: " + completedCount);
    console.log("  • Pending: " + pendingCount);
    
    console.log("\n📋 SERVICE BREAKDOWN");
    console.log("─────────────────────────────────────────");
    for (let serviceType in serviceCounts) {
        if (serviceCounts[serviceType] > 0) {
            const service = CONFIG.services[serviceType];
            console.log("  • " + service.name + ": " + serviceCounts[serviceType]);
        }
    }
    
    console.log("\n💰 FINANCIAL SUMMARY");
    console.log("─────────────────────────────────────────");
    console.log("Total Revenue: ₱" + totalRevenue.toFixed(2));
    console.log("Average Fee: ₱" + (totalRevenue / visitors.length).toFixed(2));
    
    // Calculate potential vs actual revenue (showing discount impact)
    let potentialRevenue = 0;
    for (let visitor of visitors) {
        const service = CONFIG.services[visitor.serviceType];
        potentialRevenue += service.fee;
    }
    
    const totalDiscount = potentialRevenue - totalRevenue;
    console.log("Total Discounts Given: ₱" + totalDiscount.toFixed(2));
    console.log("Discount Rate: " + ((totalDiscount / potentialRevenue) * 100).toFixed(1) + "%");
    
    console.log("\n─────────────────────────────────────────");
    console.log("Report generated: " + getCurrentTimestamp());
    console.log("─────────────────────────────────────────\n");
}

// ============ TESTING THE SYSTEM ============

displayHeader();

console.log("▶️  Adding test visitors...\n");

// Add multiple visitors
addVisitor("Juan Dela Cruz", 25, "clearance", false);
addVisitor("Maria Santos", 65, "residency", false);
addVisitor("Pedro Reyes", 30, "indigency", true);
addVisitor("Rosa Garcia", 70, "clearance", false);
addVisitor("Jose Ramos", 22, "permit", false);
addVisitor("Ana Mendoza", 45, "residency", false);

console.log("\n▶️  Processing visitors...\n");

// Process some visitors
processVisitor(1);
processVisitor(3);
processVisitor(5);

console.log("\n▶️  Searching for visitors...\n");

// Search examples
searchVisitor("Maria");
searchVisitor(2);

console.log("\n▶️  Displaying all visitors...\n");

// Display all
displayAllVisitors();

console.log("\n▶️  Generating report...\n");

// Generate report
generateReport();

console.log("\n✅ Demo completed!");
console.log("\nThank you for using Barangay Service Portal!");
```

---

## How to Use This System

### 1. Add Visitors
```javascript
addVisitor("Name", age, "serviceType", isPWD);

// Examples
addVisitor("Juan Cruz", 25, "clearance", false);
addVisitor("Maria Santos", 65, "residency", false);
addVisitor("Pedro Reyes", 30, "indigency", true);
```

### 2. Process Visitors
```javascript
processVisitor(visitorId);

// Example
processVisitor(1);  // Mark visitor #1 as completed
```

### 3. Search Visitors
```javascript
searchVisitor(searchTerm);

// Examples
searchVisitor("Juan");    // Search by name
searchVisitor(3);         // Search by ID
```

### 4. View All Visitors
```javascript
displayAllVisitors();
```

### 5. Generate Report
```javascript
generateReport();
```

---

## Key Learning Points

### 1. Code Organization
- Constants for configuration
- Separate functions for each feature
- Clear naming conventions

### 2. Data Management
- Array to store multiple visitors
- Objects to represent each visitor
- Structured data with properties

### 3. Input Validation
- Check for empty names
- Validate age range
- Verify service types

### 4. Business Logic
- Automatic discount calculation
- Status tracking
- Revenue calculation

### 5. User Experience
- Clear console output
- Formatted displays
- Error messages

---

## Extension Ideas

Want to make this better? Try adding:

1. **Edit Visitor Information**
   ```javascript
   function updateVisitor(id, newData) { /* ... */ }
   ```

2. **Delete Visitor**
   ```javascript
   function deleteVisitor(id) { /* ... */ }
   ```

3. **Filter by Status**
   ```javascript
   function getVisitorsByStatus(status) { /* ... */ }
   ```

4. **Export to JSON**
   ```javascript
   function exportData() {
       return JSON.stringify(visitors);
   }
   ```

5. **Date Range Reports**
   ```javascript
   function generateReportByDate(startDate, endDate) { /* ... */ }
   ```

---

## Summary

Tian reviewed the project:

**What We Built:**
- Complete visitor management system
- Automatic fee calculation with discounts
- Search and display functionality
- Comprehensive reporting

**Technologies Used:**
- ✅ Variables and constants
- ✅ Objects (visitor data, configuration)
- ✅ Arrays (visitor database)
- ✅ Functions (modular code)
- ✅ Conditionals (discounts, validation)
- ✅ Loops (displaying, searching, reporting)

**Key Skills:**
- Breaking complex problems into functions
- Managing data with arrays and objects
- Input validation and error handling
- Generating formatted output
- Creating reusable, maintainable code

Rhea Joy smiled. "We built a real system! This could actually help a barangay!"

Kuya Miguel nodded. "Exactly! You've mastered the fundamentals of programming logic. Next, we'll learn to make this interactive with HTML, CSS, and the DOM!"

---

## What's Next?

Congratulations on completing **Course 05: JavaScript Logic Fundamentals**!

In **Course 12: Modern JavaScript & DOM**, you'll learn:
- Manipulating web pages with the DOM
- Handling user events (clicks, inputs)
- Creating interactive interfaces
- Working with APIs and data
- Building dynamic web applications

Get ready to bring your JavaScript to life in the browser! 🚀

---

---

## Closing Story

Tian built an interactive barangay calculator: input household income, calculate taxes, display exemptions, show net amount. Variables, conditionals, loops, functions, arrays, objectseverything learned so far, combined.

Kuya Miguel tested it thoroughly. Edge cases. Invalid inputs. Extreme values. It handled everything gracefully.

"You're thinking like a software engineer now," Miguel said proudly. "Not just writing codesolving problems, handling errors, anticipating users."

Tian deployed the calculator to the barangay portal. Residents started using it immediately. Real code. Real users. Real impact.

"JavaScript fundamentals: complete," Kuya Miguel announced. "Ready for modern JavaScript and DOM manipulation?"

Tian nodded eagerly. The logic was mastered. Now it was time to bring it into the browser.

_Next up: Course 12Modern Barangay JS: Interactive Life in Motion!_