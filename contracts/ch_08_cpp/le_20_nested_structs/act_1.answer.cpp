#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

struct Date {
    int day;
    int month;
    int year;
};

struct Resident {
    string name;
    Date birthDate;
};

int main() {
    Resident person;
    person.name = "Crisostomo Ibarra";
    
    // Initialize nested member
    person.birthDate.day = 30;
    person.birthDate.month = 12;
    person.birthDate.year = 1861;
    
    // Output formatted information
    cout << "Resident: " << person.name << endl;
    cout << "Birth Date: " 
         << setfill('0') << setw(2) << person.birthDate.day << "/" 
         << setfill('0') << setw(2) << person.birthDate.month << "/" 
         << person.birthDate.year << endl;
    
    return 0;
}

