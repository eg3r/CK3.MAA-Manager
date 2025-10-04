@echo off
echo Men-At-Arms Manager - Mod Removal Script
echo ==========================================
echo.

REM Set the target directory where the mod is installed
set "TARGET_DIR=%USERPROFILE%\Documents\Paradox Interactive\Crusader Kings III\mod"
set "MOD_NAME=MenAtManager"

echo Target Directory: %TARGET_DIR%
echo Mod Name: %MOD_NAME%
echo.

REM Check if target directory exists
if not exist "%TARGET_DIR%" (
    echo ERROR: CK3 mod directory not found at: %TARGET_DIR%
    echo Make sure Crusader Kings III is installed and has been run at least once.
    exit /b 1
)

echo Removing mod installation...
if exist "%TARGET_DIR%\%MOD_NAME%" (
    rmdir /s /q "%TARGET_DIR%\%MOD_NAME%"
    echo - Removed mod folder: %TARGET_DIR%\%MOD_NAME%
) else (
    echo - Mod folder not found (already removed?)
)

echo Removing mod descriptor...
if exist "%TARGET_DIR%\%MOD_NAME%.mod" (
    del /q "%TARGET_DIR%\%MOD_NAME%.mod"
    echo - Removed mod descriptor: %TARGET_DIR%\%MOD_NAME%.mod
) else (
    echo - Mod descriptor not found (already removed?)
)

echo.
echo ==========================================
echo Mod Removal Complete!
echo ==========================================
echo.
echo The Men-At-Arms Manager mod has been removed from:
echo Mod Folder:   %TARGET_DIR%\%MOD_NAME%\
echo Descriptor:   %TARGET_DIR%\%MOD_NAME%.mod
echo.
echo Next Steps:
echo 1. Start CK3 Launcher
echo 2. Go to Mods tab
echo 3. The mod should no longer appear in your mod list
echo 4. Any existing playsets using this mod will show a warning
echo.
echo To reinstall the mod, run deploy_mod.bat
echo.