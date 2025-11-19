@echo off

REM SPDX-License-Identifier: MIT
REM Copyright (c) Crue Chan
REM
REM Permission is hereby granted, free of charge, to any person obtaining a copy
REM of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights
REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
REM copies of the Software, and to permit persons to whom the Software is
REM furnished to do so, subject to the following conditions listed in the LICENSE file.

REM ============================================
REM BAT Launcher: Invokes PowerShell scripts with administrator privileges
REM ============================================

title Office LTSC 2024 Installation - Launcher

SET "PS_SCRIPT=%~dp0Office_Installer.ps1"

IF NOT EXIST "%PS_SCRIPT%" (
    ECHO [Error] Core script Office_Installer.ps1 not found.
    ECHO Please ensure that this file is in the same directory as this launcher.
    pause
    exit /b 1
)

ECHO Starting the Office installation script with administrator privileges...
ECHO (A User Account Control (UAC) prompt will appear; please select "Yes".)

:: Use PowerShell's Start-Process to call itself and elevate privileges with RunAs
:: The -File parameter ensures that PowerShell scripts execute in a reliable environment
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath 'powershell.exe' -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PS_SCRIPT%""' -Verb RunAs"

ECHO Startup command sent. Please check the installation interface.
pause
exit /b 0