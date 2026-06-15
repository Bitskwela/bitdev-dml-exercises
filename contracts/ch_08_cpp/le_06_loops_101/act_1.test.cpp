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
=== GARBAGE COLLECTION REMINDERS ===
Reminder #1: Please segregate your waste properly.
Reminder #2: Please segregate your waste properly.
Reminder #3: Please segregate your waste properly.
Reminder #4: Please segregate your waste properly.
Reminder #5: Please segregate your waste properly.
Reminder #6: Please segregate your waste properly.
Reminder #7: Please segregate your waste properly.
Reminder #8: Please segregate your waste properly.
Reminder #9: Please segregate your waste properly.
Reminder #10: Please segregate your waste properly.
Reminder #11: Please segregate your waste properly.
Reminder #12: Please segregate your waste properly.
Reminder #13: Please segregate your waste properly.
Reminder #14: Please segregate your waste properly.
Reminder #15: Please segregate your waste properly.
Reminder #16: Please segregate your waste properly.
Reminder #17: Please segregate your waste properly.
Reminder #18: Please segregate your waste properly.
Reminder #19: Please segregate your waste properly.
Reminder #20: Please segregate your waste properly.
Reminder #21: Please segregate your waste properly.
Reminder #22: Please segregate your waste properly.
Reminder #23: Please segregate your waste properly.
Reminder #24: Please segregate your waste properly.
Reminder #25: Please segregate your waste properly.
Reminder #26: Please segregate your waste properly.
Reminder #27: Please segregate your waste properly.
Reminder #28: Please segregate your waste properly.
Reminder #29: Please segregate your waste properly.
Reminder #30: Please segregate your waste properly.
Reminder #31: Please segregate your waste properly.
Reminder #32: Please segregate your waste properly.
Reminder #33: Please segregate your waste properly.
Reminder #34: Please segregate your waste properly.
Reminder #35: Please segregate your waste properly.
Reminder #36: Please segregate your waste properly.
Reminder #37: Please segregate your waste properly.
Reminder #38: Please segregate your waste properly.
Reminder #39: Please segregate your waste properly.
Reminder #40: Please segregate your waste properly.
Reminder #41: Please segregate your waste properly.
Reminder #42: Please segregate your waste properly.
Reminder #43: Please segregate your waste properly.
Reminder #44: Please segregate your waste properly.
Reminder #45: Please segregate your waste properly.
Reminder #46: Please segregate your waste properly.
Reminder #47: Please segregate your waste properly.
Reminder #48: Please segregate your waste properly.
Reminder #49: Please segregate your waste properly.
Reminder #50: Please segregate your waste properly.
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
