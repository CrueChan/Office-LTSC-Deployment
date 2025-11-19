# 🔧 Troubleshooting

## Issue: "Office_Installer.ps1 not found"

**Solution**: Ensure both `Install_Launcher.bat` and `Office_Installer.ps1` are in the same directory.

```powershell
# Check file location
Get-ChildItem -Path $PSScriptRoot
```

## Issue: "setup.exe not found"

**Solution**: Download and extract the Office Deployment Tool to the same directory:

1. Download ODT from Microsoft
2. Extract the contents
3. Copy `setup.exe` to your deployment folder
4. Verify with: `Test-Path .\setup.exe`

## Issue: "Configuration file missing"

**Solution**: The .xml file referenced in the script doesn't exist in the script directory.

**Check**:
```powershell
Test-Path ".\AEPC_Office2024_MultilangEn_Personal.xml"
```

**Fix**: Either place the correct XML file or update the configuration reference in `Office_Installer.ps1`.

## Issue: UAC Prompt Not Appearing or Installation Fails

**Solution**: Check PowerShell execution policy:

```powershell
# Run as Administrator, then:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Issue: "ODT startup failed or returned a non-zero"

The exit code will be displayed. Common codes:

| Exit Code | Meaning |
|-----------|---------|
| 0 | Success |
| 1 | Invalid configuration file |
| 2 | setup.exe not found |
| 3 | Product ID not recognized |
| 17025 | Another Office installation in progress |

**Solution**: Review the XML configuration or check if another installation is running.

## Issue: Installation Hangs or Takes Unusually Long

**Possible causes**:
- Network connectivity issues (if downloading components)
- Antivirus software interference
- Insufficient disk space
- Another Office installation process running

**Solution**:
```powershell
# Check for other Office installations
Get-Process | findstr -i "setup"

# Review installation logs
Get-Content "$env:APPDATA\Microsoft\Office\[version]\logging\*"
```