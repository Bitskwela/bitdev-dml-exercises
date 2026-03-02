#include <iostream>
using namespace std;

/**
 * LESSON 06: LOOPS
 * Task: Barangay Reminder Notices
 */

int main() {
    cout << "=== GARBAGE COLLECTION REMINDERS ===" << endl;
    
    for (int i = 1; i <= 50; i++) {
        cout << "Reminder #" << i << ": Please segregate your waste properly." << endl;
    }
    
    return 0;
}
