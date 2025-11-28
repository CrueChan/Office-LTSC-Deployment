@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Office Activator V2.0 (Safe Mode)
color 0A

:: ==========================================
:: 1. Admin Rights Check (Robust Method)
:: ==========================================
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Requesting Admin privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

:: ==========================================
:: 2. Safe Variable Definitions
:: ==========================================
:: We define these first to avoid parentheses errors in IF blocks later
set "PF86=%ProgramFiles(x86)%"
set "PF64=%ProgramFiles%"
set "TargetDir="

echo.
echo Scanning for Office installation...

:: ==========================================
:: 3. Path Detection Logic
:: ==========================================

:: --- C2R Method (Office 2016/2019/2021/2024) ---
:: Check 32-bit Office on 64-bit Windows (Most Common)
if exist "%PF86%\Microsoft Office\root\Office16\ospp.vbs" set "TargetDir=%PF86%\Microsoft Office\root\Office16"
:: Check 64-bit Office on 64-bit Windows
if exist "%PF64%\Microsoft Office\root\Office16\ospp.vbs" set "TargetDir=%PF64%\Microsoft Office\root\Office16"

:: --- MSI Method (Older/Legacy) ---
if not defined TargetDir (
    if exist "%PF86%\Microsoft Office\Office16\ospp.vbs" set "TargetDir=%PF86%\Microsoft Office\Office16"
    if exist "%PF64%\Microsoft Office\Office16\ospp.vbs" set "TargetDir=%PF64%\Microsoft Office\Office16"
)

:: --- Office 2013/2010 Fallback ---
if not defined TargetDir (
    if exist "%PF86%\Microsoft Office\Office15\ospp.vbs" set "TargetDir=%PF86%\Microsoft Office\Office15"
    if exist "%PF64%\Microsoft Office\Office15\ospp.vbs" set "TargetDir=%PF64%\Microsoft Office\Office15"
    if exist "%PF86%\Microsoft Office\Office14\ospp.vbs" set "TargetDir=%PF86%\Microsoft Office\Office14"
    if exist "%PF64%\Microsoft Office\Office14\ospp.vbs" set "TargetDir=%PF64%\Microsoft Office\Office14"
)

:: --- Error Handler ---
if not defined TargetDir (
    cls
    color 0C
    echo.
    echo [ERROR] ospp.vbs not found!
    echo.
    echo Please make sure Office is installed.
    echo Support: Office 2010, 2013, 2016, 2019, 2021, 2024.
    echo.
    pause
    exit
)

echo Found path: "%TargetDir%"
cd /d "%TargetDir%"

:: ==========================================
:: 4. Activation Execution
:: ==========================================
echo.
echo Setting KMS server...
cscript //nologo ospp.vbs /sethst:kms1.example.com >nul

echo Activating Office...
cscript //nologo ospp.vbs /act

echo.
echo ==========================================
echo        Checking Status
echo ==========================================
cscript //nologo ospp.vbs /dstatus | findstr /i "LICENSE STATUS"
echo.
echo If you see "LICENSED", it worked!
echo.
pause
