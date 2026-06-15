// LESSON VALIDATOR (auto-generated, real test)
// Validates a student's program OUTPUT against the expected golden output.
//
// Usage in the grading pipeline (e.g. blockskwela-rs):
//   1. compile act_1.answer.cpp (or the student's submission) -> ./prog
//   2. run:  ./prog < act_1.input.txt  > out.txt     (input optional)
//   3. run:  ./validator < out.txt                   (this file, compiled)
//   4. exit code 0 = PASS, 1 = FAIL (a line-by-line diff is printed on failure)
//
// Comparison ignores leading/trailing blank lines and trailing whitespace on
// each line, so cosmetic spacing never causes a false failure.
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

static const string EXPECTED = R"BSKWELA(

1. Add Contact
2. Display All
3. Search
4. Exit
Choice: Enter name: Enter phone: Select category (0:Personal, 1:Work, 2:Emergency): Contact added!

1. Add Contact
2. Display All
3. Search
4. Exit
Choice: Enter name: Enter phone: Select category (0:Personal, 1:Work, 2:Emergency): Contact added!

1. Add Contact
2. Display All
3. Search
4. Exit
Choice: 
--- Contact List ---
Name: Juan Dela Cruz | Phone: 0917-100-2000 | Category: Personal
Name: Maria Santos | Phone: 0918-300-4000 | Category: Emergency

1. Add Contact
2. Display All
3. Search
4. Exit
Choice: Enter name to search: Found: Maria Santos [Emergency] - 0918-300-4000

1. Add Contact
2. Display All
3. Search
4. Exit
Choice: Enter name to search: Contact not found.

1. Add Contact
2. Display All
3. Search
4. Exit
Choice: 
)BSKWELA";

static vector<string> splitLines(const string& s) {{
    vector<string> out; string line; istringstream in(s);
    while (getline(in, line)) {{
        while (!line.empty() && (line.back()==' '||line.back()=='\t'||line.back()=='\r'))
            line.pop_back();
        out.push_back(line);
    }}
    while (!out.empty() && out.back().empty()) out.pop_back();
    while (!out.empty() && out.front().empty()) out.erase(out.begin());
    return out;
}}

int main() {{
    stringstream ss; ss << cin.rdbuf();
    vector<string> exp = splitLines(EXPECTED);
    vector<string> got = splitLines(ss.str());
    bool ok = (exp.size()==got.size());
    if (ok) for (size_t i=0;i<exp.size();++i) if (exp[i]!=got[i]) {{ ok=false; break; }}
    if (ok) {{ cout << "[PASS] output matches expected (" << exp.size() << " lines)\n"; return 0; }}
    cout << "[FAIL] output does not match expected\n";
    size_t n = max(exp.size(), got.size());
    for (size_t i=0;i<n;++i) {{
        string e = i<exp.size()? exp[i] : "<missing>";
        string g = i<got.size()? got[i] : "<missing>";
        if (e!=g) cout << "  line " << (i+1) << ":\n    expected: " << e << "\n    got:      " << g << "\n";
    }}
    return 1;
}}
