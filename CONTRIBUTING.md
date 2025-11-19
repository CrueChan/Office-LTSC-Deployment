# Contributing to Office LTSC Deployment Toolkit

Thank you for considering a contribution to this project! We appreciate all kinds of contributions, from bug reports to feature requests and code improvements.

## Code of Conduct

- Be respectful and constructive in all interactions
- Help others learn and grow
- Report issues professionally
- Assume good intent from contributors

## Types of Contributions

### 🐛 Bug Reports

Found a bug? Please create an issue with:

1. **Clear description** of the problem
2. **Steps to reproduce**
   - What command did you run?
   - What was the expected behavior?
   - What was the actual behavior?
3. **Environment information**
   - Windows version (e.g., Windows 11 21H2)
   - PowerShell version (run: `$PSVersionTable.PSVersion`)
   - Office LTSC 2024 ODT version
   - Any relevant error messages

**Example Issue:**
```
Title: Install_Launcher.bat fails with "Access Denied" error

Description:
When running Install_Launcher.bat on Windows 11 Enterprise, 
the UAC elevation fails.

Steps to Reproduce:
1. Place Install_Launcher.bat and Office_Installer.ps1 in C:\Temp\Office
2. Double-click Install_Launcher.bat
3. Click "Yes" on UAC prompt

Expected: Menu appears with configuration options
Actual: Error dialog: "Access Denied (0x80070005)"

Environment:
- Windows 11 Enterprise 23H2
- PowerShell 5.1.22621.1778
- Office LTSC 2024 ODT v16.0.16934.20000
```

### ✨ Feature Requests

Have an idea for improvement? Share it!

1. **Clear title** describing the feature
2. **Description** of what you want and why
3. **Suggested implementation** (if you have ideas)
4. **Examples** of how it would be used

**Example Feature Request:**
```
Title: Add support for Office licensing key configuration

Description:
Allow users to specify KMS host or MAK (Multiple Activation Key) 
in the XML configuration or as a command-line parameter.

Suggested Implementation:
Add a new configuration variable that gets populated into the XML.
```

### 📖 Documentation Improvements

Documentation updates are valuable!

- Fix typos or grammar errors
- Clarify confusing sections
- Add examples or use cases
- Translate documentation to other languages
- Improve troubleshooting guides

### 💻 Code Contributions

Want to contribute code? Great!

## Development Workflow

### 1. Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/cruechan/Office-LTSC-Deployment.git
cd Office-LTSC-2024-Deployment
```

### 2. Create a Feature Branch

```bash
# Create and checkout a new branch
git checkout -b feature/your-feature-name
# or for bug fixes:
git checkout -b fix/your-bug-name
```

### 3. Make Your Changes

- Keep changes focused and minimal
- One feature or fix per branch
- Maintain existing code style

### 4. Test Thoroughly

Before submitting:

```powershell
# Test on multiple Windows versions if possible
# Test with different Office LTSC 2024 configurations
# Verify UAC elevation works correctly
# Check error handling paths

# Example: Test the PowerShell script
cd C:\test-deployment
copy .\Office_Installer.ps1 .
# Test menu navigation
# Test with and without config files present
# Test error messages
```

### 5. Commit with Clear Messages

```bash
# Good commit message
git commit -m "Add support for custom KMS host configuration"

# Avoid vague messages
git commit -m "Fix stuff"  # ❌ Too vague

# Multi-line commit for detailed changes
git commit -m "Add KMS host support to XML configurator

- Parse KMS_HOST from configuration menu
- Validate KMS host format (hostname or IP)
- Add example XML snippets to documentation"
```

### 6. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:

- **Clear title** describing the change
- **Description** of what and why
- **Related issues** (if any)
- **Testing confirmation**

## Code Style Guidelines

### PowerShell

```powershell
# Use proper naming conventions
$VariableName = "Value"  # PascalCase for variables
$functionName = {        # camelCase for function names (though not used here)

# Use clear comments
# Single-line comments for brief notes
$SetupExe = Join-Path -Path $ScriptDir -ChildPath "setup.exe"

<#
Multi-line comments for complex logic.
Explain the why, not the what (code explains itself).
#>
foreach ($key in $Configs.Keys) {
    # Logic here
}

# Use proper indentation (4 spaces)
if ($Condition) {
    Write-Host "Message"
} else {
    Write-Host "Alternative"
}

# Use appropriate cmdlets (not cmd.exe commands)
Test-Path $FilePath      # ✅ PowerShell way
dir $FilePath            # ❌ cmd.exe way

# Use proper error handling
try {
    & $SetupExe $Arguments
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
```

### Batch Files

```batch
@echo off
REM Use clear variable names
SET "OUTPUT_FILE=result.txt"

REM Use proper comments
REM Single-line explanation of what follows

REM Use indentation for clarity
IF EXIST "%OUTPUT_FILE%" (
    ECHO File exists
    del "%OUTPUT_FILE%"
)

REM Quote file paths with spaces
IF NOT EXIST "%SCRIPT_PATH%\setup.exe" (
    ECHO Error: setup.exe not found
    exit /b 1
)
```

### Comments and Documentation

```powershell
# ✅ Good: Explains purpose and non-obvious logic
# Filter disabled configurations and show them grayed out
if ($SelectedConfig.Disabled) {
    Write-Host "[Error] Configuration file is missing..." -ForegroundColor Red
    continue
}

# ❌ Poor: States the obvious
# Check if the key exists
if ($Configs.ContainsKey($Choice)) {

# ✅ Good: Multi-line for complex operations
<#
Check each configuration file for existence.
Mark as disabled if missing so users know
which files they need to provide.
#>
foreach ($key in $Configs.Keys) {
    $filePath = Join-Path -Path $ScriptDir -ChildPath $Configs[$key].File
    if (-not (Test-Path $filePath)) {
        $Configs[$key].Disabled = $true
    }
}
```

## File Organization

When adding new features:

- **Scripts**: Add to `src/` directory
- **Configurations**: Add to `config/` directory
- **Documentation**: Add to `docs/` directory
- **Examples**: Add to `examples/` directory

## Testing Checklist

Before submitting a pull request, ensure:

- [ ] Code runs without errors
- [ ] All error messages are clear and helpful
- [ ] File path handling works with spaces and special characters
- [ ] UAC elevation works correctly
- [ ] Script behavior is consistent across Windows 10, 11, and Server 2016+
- [ ] PowerShell execution policy requirements are documented
- [ ] No hardcoded paths (use relative paths or environment variables)
- [ ] No sensitive information (passwords, API keys, etc.)
- [ ] Comments are clear and explain the "why"
- [ ] Documentation is updated to reflect changes

## Security Considerations

When contributing:

- **Never commit credentials** (API keys, passwords, certificates)
- **Validate user input** to prevent injection attacks
- **Use quotes** around file paths to handle spaces safely
- **Avoid hardcoded paths** that might not exist on all systems
- **Check for administrative access** before privileged operations
- **Report security issues privately** instead of opening public issues

## Documentation Standards

### README Updates
- Keep language clear and simple
- Use examples for complex concepts
- Link to external references when helpful
- Update version numbers in examples

### Troubleshooting Additions
- Include exact error message/symptoms
- Step-by-step solutions
- Links to related Microsoft documentation
- Environment details (Windows version, PowerShell version)

### XML Configuration Examples
- Include comments explaining each section
- Show multiple examples (simple and complex)
- Link to Microsoft's official documentation
- Highlight any institution-specific customizations

## Review Process

1. **Automated Checks**
   - Code syntax validation
   - File format checks
   - Security scanning (for sensitive data)

2. **Manual Review**
   - Code functionality review
   - Testing verification
   - Documentation quality check
   - Compatibility verification

3. **Discussion**
   - Maintainers may ask for changes
   - Be open to feedback
   - Update your PR based on comments

4. **Merge**
   - Once approved, your changes will be merged
   - You'll be credited in the changelog

## Questions?

- Check [README](README.md)
- Review existing issues and discussions
- Ask in a new issue with the `question` label
- Check [Troubleshooting](README.md#troubleshooting) section

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for making this project better!** 🎉

Your contributions help others in educational institutions deploy Office more efficiently.
