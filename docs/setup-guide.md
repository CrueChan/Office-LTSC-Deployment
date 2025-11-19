# Setup Instructions

## Option A: Multi-Config Setup (Recommended)

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

## Option B: Single-Config Setup

1. Place these files in the same directory:
   - `Install_Office.bat`
   - `setup.exe` (from ODT extraction)
   - Your XML configuration file (update the filename in the `.bat` script)

2. Double-click `Install_Office.bat`
   - Click "Yes" when UAC prompt appears
   - Installation will proceed automatically