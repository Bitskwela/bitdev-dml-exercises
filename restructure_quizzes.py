import re
import os
from pathlib import Path

def restructure_quiz(filepath):
    """Restructure quiz file to have inline answers after each question."""
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract the answers section
    answers_match = re.search(r'## Answers\s*\n(.*?)\n\s*---', content, re.DOTALL)
    if not answers_match:
        print(f"No answers section found in {filepath}")
        return False
    
    answers_text = answers_match.group(1).strip()
    
    # Extract detailed explanations
    explanations_match = re.search(r'## Detailed Explanations\s*\n(.*?)\n\s*---', content, re.DOTALL)
    if not explanations_match:
        print(f"No explanations section found in {filepath}")
        return False
    
    explanations_text = explanations_match.group(1).strip()
    
    # Parse answers: "1: B  2: C  3: A" or "1: B\n2: C\n3: A"
    answers_dict = {}
    for match in re.finditer(r'(\d+):\s*([A-D])', answers_text):
        answers_dict[match.group(1)] = match.group(2)
    
    # Parse explanations: "Q1 explanation. Q2 explanation." or "**Q1:** explanation."
    explanations_dict = {}
    for match in re.finditer(r'\*?\*?Q(\d+)[\*:]?\*?\s*(.*?)(?=\s*\*?\*?Q\d+|\Z)', explanations_text, re.DOTALL):
        q_num = match.group(1)
        explanation = match.group(2).strip()
        explanations_dict[q_num] = explanation
    
    # Remove old answers and explanations sections
    content = re.sub(r'\n---\n## Answers\s*\n.*?\n\s*---\n## Detailed Explanations\s*\n.*?(\n\s*---)', r'\1', content, flags=re.DOTALL)
    
    # Find all questions and add inline answers
    def add_answer_after_question(match):
        question_num = match.group(1)
        full_question = match.group(0)
        
        answer = answers_dict.get(question_num, "?")
        explanation = explanations_dict.get(question_num, "No explanation")
        
        # Add answer and explanation after the question options
        answer_block = f"\n\n**Answer:** {answer}  \n**Explanation:** {explanation}\n\n---"
        
        return full_question + answer_block
    
    # Match questions: **Question N:** ... (options A-D) ... followed by next question or Quiz 2 or ---
    pattern = r'(\*\*Question (\d+):\*\* .*?\nD\. [^\n]+)'
    
    # Process questions before answers section was removed
    content_before_answers = re.sub(r'\n---\n## Answers.*', '', content, flags=re.DOTALL)
    
    # Find all questions
    questions = list(re.finditer(pattern, content_before_answers, re.DOTALL))
    
    # Add answers in reverse order to preserve positions
    for match in reversed(questions):
        question_num = match.group(2)
        start, end = match.span()
        
        answer = answers_dict.get(question_num, "?")
        explanation = explanations_dict.get(question_num, "No explanation")
        
        answer_block = f"\n\n**Answer:** {answer}  \n**Explanation:** {explanation}\n\n---"
        
        # Check if next character is a newline followed by Quiz 2 or another question
        next_pos = end
        if next_pos < len(content) and content[next_pos:next_pos+5] == '\n\n---':
            # Before quiz 2 section, don't add extra ---
            answer_block = f"\n\n**Answer:** {answer}  \n**Explanation:** {explanation}\n"
        
        content = content[:end] + answer_block + content[end:]
    
    # Remove the old Answers and Explanations sections
    content = re.sub(r'\n---\n## Answers\s*\n.*?\n---\n## Detailed Explanations\s*\n.*?(\n---)', r'\1', content, flags=re.DOTALL)
    
    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✓ Restructured {os.path.basename(os.path.dirname(filepath))}")
    return True


# Process lessons 8-30
base_path = Path(r"c:\Users\Christian\Desktop\Bitkswela\bitdev-dml-exercises\contracts\ch_09_python")

lessons_to_process = [
    "le_08_variables_data_types_operators",
    "le_09_input_output_basics",
    "le_10_conditionals_control_flow",
    "le_11_loops_for_while",
    "le_12_string_formatting_manipulation",
    "le_13_intro_quantitative_methods",
    "le_14_numpy_pandas_matplotlib",
    "le_15_descriptive_statistics_probability",
    "le_16_regression_linear_models",
    "le_17_simulation_data_python",
    "le_18_mini_project_model_future",
    "le_19_file_io_python",
    "le_20_csv_json",
    "le_21_python_modules_imports",
    "le_22_web_servers_flask_basics",
    "le_23_templates_forms_post_requests",
    "le_24_rest_apis_101",
    "le_25_data_modeling_er_diagrams",
    "le_26_normalization_1nf_2nf_3nf",
    "le_27_indexing_strategies",
    "le_28_python_database_connection",
    "le_29_executing_queries_from_python",
    "le_30_capstone_database_driven_app",
]

print("Starting quiz restructure...")
for lesson in lessons_to_process:
    quiz_file = base_path / lesson / "quiz.md"
    if quiz_file.exists():
        restructure_quiz(quiz_file)
    else:
        print(f"✗ File not found: {lesson}/quiz.md")

print("\nAll done!")
