# PowerShell script to restructure quiz files
# Converts grouped answers at bottom to inline answers after each question

$basePath = "c:\Users\Christian\Desktop\Bitkswela\bitdev-dml-exercises\contracts\ch_09_python"

$lessons = @(
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
    "le_30_capstone_database_driven_app"
)

function Restructure-Quiz {
    param($filepath)
    
    $content = Get-Content -Path $filepath -Raw -Encoding UTF8
    
    # Extract answers section
    if ($content -match '## Answers\s*\n(.*?)\n\s*---\s*\n## Detailed Explanations\s*\n(.*?)\n\s*---') {
        $answersText = $matches[1]
        $explanationsText = $matches[2]
        
        # Parse answers into hashtable
        $answers = @{}
        $answersText -split '\s+' | Where-Object { $_ -match '(\d+):\s*([A-D])' } | ForEach-Object {
            if ($_ -match '(\d+):\s*([A-D])') {
                $answers[$matches[1]] = $matches[2]
            }
        }
        
        # Parse explanations into hashtable
        $explanations = @{}
        $explLines = ($explanationsText -split '\n') | Where-Object { $_.Trim() -ne '' }
        foreach ($line in $explLines) {
            if ($line -match '^\*?\*?Q(\d+)[\*:]?\*?\s*(.+)$') {
                $explanations[$matches[1]] = $matches[2].Trim()
            }
        }
        
        # Remove answers and explanations sections
        $content = $content -replace '(?s)\n---\n## Answers\s*\n.*?\n---\n## Detailed Explanations\s*\n.*?(\n---)', '$1'
        
        # Add inline answers after each question
        for ($i = 10; $i -ge 1; $i--) {
            $answer = $answers["$i"]
            $explanation = $explanations["$i"]
            
            if ($answer -and $explanation) {
                # Find question pattern
                $pattern = "(\*\*Question $i:\*\*.*?D\. [^\n]+)"
                if ($content -match $pattern) {
                    $questionBlock = $matches[1]
                    $answerBlock = "`n`n**Answer:** $answer  `n**Explanation:** $explanation`n`n---"
                    $content = $content -replace [regex]::Escape($questionBlock), "$questionBlock$answerBlock"
                }
            }
        }
        
        # Write back
        Set-Content -Path $filepath -Value $content -Encoding UTF8 -NoNewline
        Write-Host "✓ $([System.IO.Path]::GetFileName([System.IO.Path]::GetDirectoryName($filepath)))" -ForegroundColor Green
    }
    else {
        Write-Host "✗ Could not find answers/explanations in $filepath" -ForegroundColor Red
    }
}

Write-Host "`nRestructuring quizzes..." -ForegroundColor Cyan

foreach ($lesson in $lessons) {
    $quizPath = Join-Path $basePath "$lesson\quiz.md"
    if (Test-Path $quizPath) {
        Restructure-Quiz -filepath $quizPath
    }
    else {
        Write-Host "✗ File not found: $lesson\quiz.md" -ForegroundColor Yellow
    }
}

Write-Host "`nAll done!" -ForegroundColor Green
