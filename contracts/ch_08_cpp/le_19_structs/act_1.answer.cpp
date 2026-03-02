#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    bool isVaccinated;
};

int main() {
    // Create a Resident variable
    Resident person1;
    
    // Initialize the members
    person1.name = "Juan Dela Cruz";
    person1.age = 35;
    person1.isVaccinated = true;
    
    // Display the resident's information
    cout << "Resident Name: " << person1.name << endl;
    cout << "Age: " << person1.age << endl;
    cout << "Vaccination Status: " << (person1.isVaccinated ? "Yes" : "No") << endl;
    
    return 0;
}

