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

SET "XML_FILE=ARTVU_Office2024LTSC_Standard_ZhCN_Institutional.xml"
SET "SETUP_EXE=setup.exe"
SET "PARAMETERS=/configure %XML_FILE%"
:: Get the full path to the current batch file (with a backslash \ at the end).
SET "CURRENT_DIR=%~dp0"
SET "FULL_SETUP_PATH=%CURRENT_DIR%%SETUP_EXE%"

ECHO Starting Office ODT with administrator privileges...

:: Use PowerShell's Start-Process to elevate privileges and set the working directory
:: -FilePath: Specifies the program to run (the full path to setup.exe)
:: -ArgumentList: The arguments passed to setup.exe
:: -WorkingDirectory: Explicitly sets the working directory of setup.exe to the current directory
:: -Verb RunAs: Request administrator privileges
powershell.exe -Command "Start-Process -FilePath '%FULL_SETUP_PATH%' -ArgumentList '%PARAMETERS%' -WorkingDirectory '%CURRENT_DIR%' -Verb RunAs"

ECHO The script has finished executing.
PAUSE