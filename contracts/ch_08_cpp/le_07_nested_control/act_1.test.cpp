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
=== MULTIPLICATION TABLE ===
1	2	3	4	5	6	7	8	9	10	
2	4	6	8	10	12	14	16	18	20	
3	6	9	12	15	18	21	24	27	30	
4	8	12	16	20	24	28	32	36	40	
5	10	15	20	25	30	35	40	45	50	
6	12	18	24	30	36	42	48	54	60	
7	14	21	28	35	42	49	56	63	70	
8	16	24	32	40	48	56	64	72	80	
9	18	27	36	45	54	63	72	81	90	
10	20	30	40	50	60	70	80	90	100	
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
