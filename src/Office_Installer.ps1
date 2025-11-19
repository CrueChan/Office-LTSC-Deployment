# SPDX-License-Identifier: MIT
# Copyright (c) Crue Chan
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions listed in the LICENSE file.

#Requires -RunAsAdministrator

# Setting up the encoding environment
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Get the current script directory (PowerShell environment, path is reliable)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SetupExe = Join-Path -Path $ScriptDir -ChildPath "setup.exe"

# --- Configuration file definition ---
$Configs = @{
    "1" = @{
        Name = "AEPC Multilingual (Professional Plus)"
        File = "AEPC_Office2024_MultilangEn_Personal.xml"
    }
    "2" = @{
        Name = "ARTVU Simplified Chinese (Standard)"
        File = "ARTVU_Office2024LTSC_SimplifiedChinese_Institutional.xml"
    }
}

# --- Check the file ---
foreach ($key in $Configs.Keys) {
    $filePath = Join-Path -Path $ScriptDir -ChildPath $Configs[$key].File
    if (-not (Test-Path $filePath)) {
        $Configs[$key].Disabled = $true
        $Configs[$key].Name += " (Disabled: Missing files)"
    }
}

# --- Main menu loop ---
while ($true) {
    Clear-Host
    Write-Host "============================================"
    Write-Host "Office LTSC 2024 Installation and Configuration Selector"
    Write-Host "============================================"
    Write-Host ""
    Write-Host "Please select your installation configuration:"
    Write-Host ""
    
    foreach ($key in $Configs.Keys | Sort-Object) {
        Write-Host "[$key] $($Configs[$key].Name)"
    }
    
    Write-Host ""
    Write-Host "[0] quit"
    Write-Host "============================================"
    Write-Host ""
    
    $Choice = Read-Host "Enter your selection (0-2)"

    if ($Choice -eq "0") {
        exit
    } elseif ($Configs.ContainsKey($Choice)) {
        $SelectedConfig = $Configs[$Choice]
        
        if ($SelectedConfig.Disabled) {
            Write-Host "[Error] Configuration file is missing, please select again." -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }
        
        # --- Start installation ---
        Clear-Host
        Write-Host "============================================"
        Write-Host "Start the installation process"
        Write-Host "============================================"
        Write-Host "Configuration file: $($SelectedConfig.File)"
        Write-Host "Starting ODT... Please observe the Office installation interface."
        Write-Host ""
        
        # **Core fix: Directly invoking Start-Process in the PowerShell environment**
        # The program is now running with administrator privileges, and the working directory is the script directory.
        
        $XmlPath = Join-Path -Path $ScriptDir -ChildPath $SelectedConfig.File

		# **Key fix: Use the parameter array @() to ensure that /configure and the XML path are correctly separated and passed.**
        $ArgumentsArray = @(
            "/configure"
            "`"$XmlPath`""  # Use double quotes to enclose the path to prevent it from containing spaces.
        )
        
        # Use the invocation operator (&) and parameter arrays
        & $SetupExe $ArgumentsArray
        
        # Check the ODT exit code
        $ExitCode = $LASTEXITCODE

        if ($ExitCode -eq 0) {
            Write-Host "The ODT installation process has started. Please wait for the installation to complete." -ForegroundColor Green
        } else {
             Write-Host "ODT startup failed or returned a non-zero ($ExitCode). Please check the logs." -ForegroundColor Red
        }

        Write-Host ""
        Read-Host "Press any key to return to the main menu..." | Out-Null
    } else {
        Write-Host "[Error] Invalid selection, please try again." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

exit