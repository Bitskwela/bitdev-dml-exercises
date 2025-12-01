# PowerShell script to rename remaining mat_N.md files in ch_08_cpp
$basePath = "c:\Users\Christian\Desktop\Bitkswela\bitdev-dml-exercises\contracts\ch_08_cpp"

# Lessons 6-31 already have mat_N.md format based on folder structure
# Just verify they exist

$lessons = @(
    @{num=6; folder="le_06_loops_101"},
    @{num=7; folder="le_07_nested_control"},
    @{num=8; folder="le_08_logical_operators"},
    @{num=9; folder="le_09_mini_project_atm"},
    @{num=10; folder="le_10_functions_defined"},
    @{num=11; folder="le_11_parameters_return_values"},
    @{num=12; folder="le_12_scope_rules"},
    @{num=13; folder="le_13_modular_grade_calculator"},
    @{num=14; folder="le_14_arrays"},
    @{num=15; folder="le_15_strings"},
    @{num=16; folder="le_16_pointers"},
    @{num=17; folder="le_17_pointers_vs_references"},
    @{num=18; folder="le_18_dynamic_memory"},
    @{num=19; folder="le_19_structs"},
    @{num=20; folder="le_20_nested_structs"},
    @{num=21; folder="le_21_enums"},
    @{num=22; folder="le_22_contact_book"},
    @{num=23; folder="le_23_classes"},
    @{num=24; folder="le_24_constructors"},
    @{num=25; folder="le_25_encapsulation"},
    @{num=26; folder="le_26_inheritance"},
    @{num=27; folder="le_27_polymorphism"},
    @{num=28; folder="le_28_templates"},
    @{num=29; folder="le_29_exceptions"},
    @{num=30; folder="le_30_stl"},
    @{num=31; folder="le_31_final_crud"}
)

Write-Host "Checking mat_N.md files..." -ForegroundColor Cyan

foreach ($lesson in $lessons) {
    $expectedFile = Join-Path $basePath "$($lesson.folder)\mat_$($lesson.num).md"
    if (Test-Path $expectedFile) {
        Write-Host "✓ mat_$($lesson.num).md exists" -ForegroundColor Green
    } else {
        Write-Host "✗ mat_$($lesson.num).md NOT FOUND - needs checking" -ForegroundColor Yellow
    }
}

Write-Host "`nDone!" -ForegroundColor Cyan
