@echo off
REM ============================================================
REM Men-At-Arms Manager Mod Deployment Script
REM Deploys the mod to CK3's default mod directory
REM ============================================================

echo Men-At-Arms Manager - Mod Deployment Script
echo ============================================

REM Set variables
set MOD_NAME=MenAtArmsManager
set SOURCE_DIR=%~dp0mod
set DESCRIPTOR_SOURCE=%~dp0descriptor.mod

REM Default CK3 mod directory (Windows)
set CK3_MOD_DIR=%USERPROFILE%\Documents\Paradox Interactive\Crusader Kings III\mod

REM Check if source files exist
if not exist "%SOURCE_DIR%" (
    echo ERROR: Source mod folder not found at: %SOURCE_DIR%
    echo Please run this script from the project root directory.
    pause
    exit /b 1
)

if not exist "%DESCRIPTOR_SOURCE%" (
    echo ERROR: descriptor.mod file not found at: %DESCRIPTOR_SOURCE%
    echo Please run this script from the project root directory.
    pause
    exit /b 1
)

REM Create CK3 mod directory if it doesn't exist
if not exist "%CK3_MOD_DIR%" (
    echo Creating CK3 mod directory: %CK3_MOD_DIR%
    mkdir "%CK3_MOD_DIR%"
)

echo.
echo Source Directory: %SOURCE_DIR%
echo Target Directory: %CK3_MOD_DIR%
echo.

REM Remove existing mod installation (if any)
if exist "%CK3_MOD_DIR%\%MOD_NAME%" (
    echo Removing existing mod installation...
    rmdir /s /q "%CK3_MOD_DIR%\%MOD_NAME%"
)

if exist "%CK3_MOD_DIR%\%MOD_NAME%.mod" (
    echo Removing existing mod descriptor...
    del "%CK3_MOD_DIR%\%MOD_NAME%.mod"
)

REM Copy mod folder
echo Copying mod folder...
xcopy "%SOURCE_DIR%" "%CK3_MOD_DIR%\%MOD_NAME%\" /E /I /H /Y
if errorlevel 1 (
    echo ERROR: Failed to copy mod folder
    pause
    exit /b 1
)

REM Copy and rename descriptor file
echo Copying mod descriptor...
copy "%DESCRIPTOR_SOURCE%" "%CK3_MOD_DIR%\%MOD_NAME%.mod"
if errorlevel 1 (
    echo ERROR: Failed to copy descriptor file
    pause
    exit /b 1
)

REM Update the descriptor file with correct path
echo Updating descriptor file path...
powershell -Command "(Get-Content '%CK3_MOD_DIR%\%MOD_NAME%.mod') -replace 'path=\"mod/MenAtManager\"', 'path=\"mod/%MOD_NAME%\"' | Set-Content '%CK3_MOD_DIR%\%MOD_NAME%.mod'"

echo.
echo ============================================
echo Deployment Complete!
echo ============================================
echo.
echo Mod Location: %CK3_MOD_DIR%\%MOD_NAME%\
echo Descriptor:   %CK3_MOD_DIR%\%MOD_NAME%.mod
echo.
echo Next Steps:
echo 1. Start CK3 Launcher
echo 2. Go to Mods tab
echo 3. Enable "Men-At-Arms Manager"
echo 4. Create or select a playset
echo 5. Start the game to test
echo.
echo For testing: Open console (~) and type:
echo effect maa_manager_open_window
echo.
