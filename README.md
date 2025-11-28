# Office LTSC Quick Deployment Toolkit

A lightweight, user-friendly PowerShell and Batch script toolkit for automating Microsoft Office LTSC deployments across multiple institutions. Streamline your institutional software deployments with minimal configuration.

## 🎯 Features

- **One-click deployment**: Execute a single batch file to launch Office installation
- **Multi-configuration support**: Choose from multiple pre-configured XML profiles during installation
- **Administrator privilege handling**: Automatic UAC prompt management
- **Robust error handling**: File existence checks, exit code validation, and graceful error messaging
- **UTF-8 multilingual support**: Full support for Chinese, English, and other languages
- **No external dependencies**: Works with Windows native tools and Office Deployment Tool

## 📋 What's Included

- `Install_Launcher.bat` - Entry point that elevates to administrator and launches the PowerShell installer
- `Install_Office.bat` - Simplified single-config alternative for fixed deployments
- `Office_Installer.ps1` - Multi-config selector with menu-driven installation UI
- Configuration templates for various institution setups

## 🚀 Quick Start (5 minutes)

### Prerequisites

1. **Windows 10/11 or Windows Server 2016+**
2. **PowerShell 5.0 or later** (built-in on Windows 10+)
3. **Office LTSC ODT** (Office Deployment Tool)
   - Download from: [Microsoft Office Deployment Tool](https://www.microsoft.com/en-us/download/details.aspx?id=49117)
   - Extract `setup.exe` into the same directory as these scripts

4. **Configuration XML file(s)**
   - Use the provided templates or create your own
   - Place in the same directory as the scripts

### Setup Instructions

#### Option A: Multi-Config Setup (Recommended)

1. Create a folder for your deployment:
   ```
   mkdir Office-Deployment
   cd Office-Deployment
   ```

2. Place these files in the folder:
   - `Install_Launcher.bat`
   - `Office_Installer.ps1`
   - `setup.exe` (from ODT extraction)
   - Your `*.xml` configuration files

3. Double-click `Install_Launcher.bat`
   - Click "Yes" when UAC prompt appears
   - Select your configuration from the menu
   - Wait for installation to complete

#### Option B: Single-Config Setup

1. Place these files in the same directory:
   - `Install_Office.bat`
   - `setup.exe` (from ODT extraction)
   - Your XML configuration file (update the filename in the `.bat` script)

2. Double-click `Install_Office.bat`
   - Click "Yes" when UAC prompt appears
   - Installation will proceed automatically

## 📖 File Reference

### Install_Launcher.bat
**Purpose**: Entry point for multi-configuration deployments
**Usage**: `Install_Launcher.bat`
**Features**:
- Elevates to administrator privileges via PowerShell
- Launches the interactive menu system
- Validates script file existence before proceeding

### Install_Office.bat
**Purpose**: Simplified single-configuration deployment
**Usage**: `Install_Office.bat`
**Features**:
- Direct setup.exe execution with `/configure` parameter
- Minimal configuration (edit `XML_FILE` variable before use)
- Best for standardized institutional deployments

**Note**: Modify line 2 with your actual XML filename:
```batch
SET "XML_FILE=YourConfigFile.xml"
```

### Office_Installer.ps1
**Purpose**: Interactive configuration selector with menu UI
**Usage**: Automatically launched by `Install_Launcher.bat`
**Features**:
- Display available configurations with file existence validation
- Menu-driven selection (0-2 options)
- Real-time configuration file validation
- Clear error messages for missing files
- Automatic exit code reporting

**Configuration definition** (lines 11-20):
```powershell
$Configs = @{
    "1" = @{
        Name = "Your Config Name"
        File = "your-config-file.xml"
    }
    "2" = @{
        Name = "Another Config"
        File = "another-config.xml"
    }
}
```

## 🔑 KMS Configuration Script

This repository now includes a universal batch script (`AutoActivate.bat`) designed to automate the KMS client configuration for Office LTSC.

### Features
* **Smart Path Detection**: Automatically scans all common installation paths (C2R & MSI) to locate `ospp.vbs`.
* **Auto-Elevation**: Automatically requests Administrator privileges if run as a standard user.
* **Universal Support**: Compatible with Office 2016, 2019, 2021, and 2024 LTSC.

### Usage
1.  Complete the Office installation.
2.  Run `AutoActivate.bat`.
3.  The script will detect your Office version, set the KMS host, and apply the activation command automatically.

## ⚙️ System Requirements

| Component | Requirement |
|-----------|-------------|
| OS | Windows 10 (1909+) or Windows Server 2016+ |
| PowerShell | 5.0 or later |
| Administrator Access | Required (automatic UAC elevation) |
| Disk Space | ~3 GB for Office LTSC 2024 |
| Internet Connection | Not required (local installation) |

## 📝 Configuration Guide

### Creating Custom XML Configuration Files

The Office Deployment Tool uses XML configuration files to control installation options. Key parameters:

```xml
<Configuration ID="INSTITUTION_NAME">
  <!-- Language and product selection -->
  <Add OfficeClientEdition="64" Channel="PerpetualVL2024">
    <Product ID="ProPlus2024Volume">
      <Language ID="zh-cn" /> <!-- Simplified Chinese -->
      <Language ID="en-us" /> <!-- English -->
    </Product>
  </Add>

  <!-- Installation settings -->
  <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
  <Property Name="SharedComputerLicensing" Value="0" />

  <!-- Customization options -->
  <Updates Enabled="TRUE" />
  <RemoveMSI />
  <AppSettings>
    <User Key="software\microsoft\office\16.0\excel\options" Name="defaultformat" Value="51" />
  </AppSettings>
</Configuration>
```

For detailed XML reference, see: [Microsoft Office Deployment Tool Configuration Reference](https://learn.microsoft.com/en-us/deployoffice/office-deployment-tool-configuration-options)

### Multi-Language Example

```xml
<Product ID="ProPlus2024Volume">
  <Language ID="zh-cn" />    <!-- Simplified Chinese -->
  <Language ID="zh-tw" />    <!-- Traditional Chinese -->
  <Language ID="en-us" />    <!-- English (US) -->
  <Language ID="ja-jp" />    <!-- Japanese -->
</Product>
```

## 🔧 Troubleshooting

### Issue: "Office_Installer.ps1 not found"

**Solution**: Ensure both `Install_Launcher.bat` and `Office_Installer.ps1` are in the same directory.

```powershell
# Check file location
Get-ChildItem -Path $PSScriptRoot
```

### Issue: "setup.exe not found"

**Solution**: Download and extract the Office Deployment Tool to the same directory:

1. Download ODT from Microsoft
2. Extract the contents
3. Copy `setup.exe` to your deployment folder
4. Verify with: `Test-Path .\setup.exe`

### Issue: "Configuration file missing"

**Solution**: The .xml file referenced in the script doesn't exist in the script directory.

**Check**:
```powershell
Test-Path ".\AEPC_Office2024_MultilangEn_Personal.xml"
```

**Fix**: Either place the correct XML file or update the configuration reference in `Office_Installer.ps1`.

### Issue: UAC Prompt Not Appearing or Installation Fails

**Solution**: Check PowerShell execution policy:

```powershell
# Run as Administrator, then:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue: "ODT startup failed or returned a non-zero"

The exit code will be displayed. Common codes:

| Exit Code | Meaning |
|-----------|---------|
| 0 | Success |
| 1 | Invalid configuration file |
| 2 | setup.exe not found |
| 3 | Product ID not recognized |
| 17025 | Another Office installation in progress |

**Solution**: Review the XML configuration or check if another installation is running.

### Issue: Installation Hangs or Takes Unusually Long

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

## 📋 Typical Deployment Scenarios

### Scenario 1: Multi-Institution Deployment
Use `Install_Launcher.bat` with multiple XML configurations:
- Configuration 1: AEPC (Multilingual + Professional Plus)
- Configuration 2: ARTVU (Simplified Chinese + Standard)
- Configuration 3: Research Lab (English Only + Developer Tools)

### Scenario 2: Standardized Institutional Deployment
Use `Install_Office.bat` with a single configuration for consistency across all workstations.

### Scenario 3: Automated/Scripted Deployment
Extend the PowerShell script for batch deployment across multiple machines:
```powershell
$Computers = @("PC001", "PC002", "PC003")
foreach ($Computer in $Computers) {
    Invoke-Command -ComputerName $Computer -ScriptBlock {
        & "\\SharedPath\Office_Installer.ps1"
    }
}
```

## 🤝 Contributing

Contributions are welcome! If you'd like to contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Make your changes and test thoroughly
4. Commit with clear messages
5. Push to the branch and open a Pull Request

Please ensure your contributions:
- Follow the existing code style
- Include comments for complex logic
- Test with multiple Office versions and configurations
- Update documentation accordingly

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Microsoft Office Deployment Tool documentation
- Windows PowerShell community best practices
- Feedback from institutional IT teams

## ❓ FAQ

**Q: Can I use this with Office 365 (Microsoft 365)?**
A: Yes, this toolkit is not only specifically designed for Office LTSC (volume licensing perpetual version), but also Microsoft 365 can use it as a kind of deployment method.

**Q: Does this work with Office 2019 or earlier versions?**
A: Yes, these scripts are optimized for Office LTSC. Earlier versions may have different XML schemas, you can generate your XML with [Office Customization Tool](https://config.office.com/deploymentsettings).

**Q: Can I schedule installations for off-hours?**
A: Yes, you can create a scheduled task that runs `Install_Office.bat` or the PowerShell script at a specific time using Windows Task Scheduler.

**Q: Is network connectivity required?**
A: Not if all Office components are pre-downloaded. However, initial setup and language pack downloads may require internet access.

**Q: How do I uninstall Office?**
A: Use the standard Windows Control Panel → Programs and Features → Uninstall. This toolkit only handles installation.

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check the [Troubleshooting](#troubleshooting) section above
- Review Microsoft's Office Deployment Tool documentation

---

**Last Updated**: November 2025
**Version**: 1.0
**Author**: Office Deployment Toolkit Contributors
