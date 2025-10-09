# PowerShell script to add source-type filtering to all retrain MAA buttons
# This adds "Not(GetVariableSystem.HasValue('maa_manager_selected_regiment_type_name', MenAtArmsType.GetNameNoTooltip))" 
# to the visible condition of all buttons

$files = @(
    "mod\gui\retrain\maam_base_regular_buttons.gui",
    "mod\gui\retrain\maam_base_regional_buttons.gui",
    "mod\gui\retrain\maam_cultural_buttons.gui",
    "mod\gui\retrain\maam_dlc_ep3_buttons.gui",
    "mod\gui\retrain\maam_dlc_fp1_buttons.gui",
    "mod\gui\retrain\maam_dlc_fp3_buttons.gui",
    "mod\gui\retrain\maam_dlc_mpo_buttons.gui",
    "mod\gui\retrain\maam_dynasty_legacy_buttons.gui",
    "mod\gui\retrain\maam_accolade_buttons.gui"
)

foreach ($file in $files) {
    $filePath = Join-Path $PSScriptRoot $file
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $file"
        
        $content = Get-Content $filePath -Raw
        
        # Pattern: Find visible lines that have scripted GUI but don't already have the HasValue check
        # Match lines like: visible = "[GetScriptedGui('maa_manager_can_show_XXX').IsShown(GuiScope.SetRoot(GetPlayer.MakeScope).End)]"
        # But NOT lines that already have HasValue
        
        # Replace pattern: wrap the existing visible condition with And() and add the Not(HasValue(...)) check
        $pattern = 'visible = "\[(GetScriptedGui\([^)]+\)\.IsShown\(GuiScope\.SetRoot\(GetPlayer\.MakeScope\)\.End\))\]"'
        
        # Check if file needs update (doesn't already have HasValue)
        if ($content -match $pattern -and $content -notmatch 'HasValue') {
            # Replacement: Add And() wrapper and Not(HasValue...) condition
            $replacement = 'visible = "[And($1, Not(GetVariableSystem.HasValue(''maa_manager_selected_regiment_type_name'', MenAtArmsType.GetNameNoTooltip)))]"'
            
            $newContent = $content -replace $pattern, $replacement
            
            # Count replacements
            $matches = [regex]::Matches($content, $pattern)
            Write-Host "  - Found $($matches.Count) buttons to update"
            
            # Write back to file
            Set-Content -Path $filePath -Value $newContent -NoNewline
            Write-Host "  - Updated successfully`n"
        }
        elseif ($content -match 'HasValue\(''maa_manager_selected_regiment_type_name''') {
            Write-Host "  - Already has filtering applied, skipping`n"
        }
        else {
            Write-Host "  - No matching patterns found`n"
        }
    }
    else {
        Write-Host "File not found: $filePath`n"
    }
}

Write-Host "Done! All files processed."
