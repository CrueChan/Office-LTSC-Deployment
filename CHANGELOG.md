# Changelog

All notable changes to the Office LTSC Deployment Toolkit are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Support for Office LTSC 2027 (when released)
- GUI-based configuration editor
- Batch deployment across multiple computers
- PowerShell module wrapper for advanced scripting
- Native language support for additional languages

---

## [1.0.0] - 2025-11-18

### Added
- Initial release of Office LTSC Deployment Toolkit
- `Install_Launcher.bat` - Multi-configuration entry point with UAC elevation
- `Install_Office.bat` - Single-configuration simplified deployment script
- `Office_Installer.ps1` - Interactive PowerShell menu system for configuration selection
- Comprehensive README in English and Simplified Chinese
- XML Configuration Reference Guide
- Contributing Guidelines
- MIT License
- Security Review and Safety Confirmation
- `.gitignore` for safe repository management

### Features
- Automatic administrator privilege elevation via UAC
- Multi-configuration support with file existence validation
- Menu-driven installation interface
- UTF-8 encoding support for multilingual environments
- Clear error handling and user-friendly error messages
- Exit code reporting for troubleshooting
- Support for both Professional Plus and Standard editions
- Support for multiple languages (Chinese, English, Japanese, etc.)
- Configuration templates for common institutional setups

### Documentation
- Detailed setup instructions for both deployment methods
- System requirements and compatibility information
- Configuration file creation guide with examples
- Comprehensive troubleshooting section
- FAQ addressing common questions
- Example scenarios for different use cases

### Security
- No hardcoded credentials or sensitive information
- Safe file path handling for paths with spaces
- Proper permission elevation without privilege escalation exploits
- Security audit confirming safe-to-open-source status

### Testing
- Validated on Windows 10 (versions 1909+)
- Tested on Windows 11 (all current versions)
- Windows Server 2016+ compatibility confirmed
- PowerShell 5.0+ support verified
- Multi-language configuration tested

---

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** version - Incompatible API changes (e.g., script parameter changes)
- **MINOR** version - New functionality in backward-compatible manner
- **PATCH** version - Backward-compatible bug fixes

## Types of Changes

- **Added** - New features
- **Changed** - Changes in existing functionality
- **Deprecated** - Soon-to-be removed features
- **Removed** - Removed features
- **Fixed** - Bug fixes
- **Security** - Security vulnerability fixes

## Release Process

When preparing a release:

1. Update version number in:
   - This file (CHANGELOG.md)
   - Script file headers (comments)
   - Documentation references

2. Update dates and sections:
   - Change `[Unreleased]` section to version number
   - Use [YYYY-MM-DD] date format
   - Include all changes in appropriate categories

3. Create GitHub release:
   - Tag with version number (v1.0.0)
   - Copy relevant changelog section to release notes
   - Attach any relevant files

4. Verify:
   - All scripts are current
   - Documentation is accurate
   - No sensitive information is exposed

## Contributors

### Version 1.0.0 Contributors
- Initial development and release

---

## Future Roadmap

### Version 1.1.0 (Planned)
- [ ] Add logging to file for deployment history
- [ ] Support for Office 2019 LTSC (legacy support)
- [ ] Configuration validation tool
- [ ] Pre-flight system check script

### Version 1.2.0 (Planned)
- [ ] Web-based configuration builder
- [ ] Batch deployment helper script
- [ ] Installation report generation
- [ ] Uninstall script with safe removal

### Version 2.0.0 (Planned - Major Release)
- [ ] PowerShell module architecture
- [ ] Remote deployment support
- [ ] Centralized logging system
- [ ] Advanced error recovery

---

## Known Issues

### Current Version
- None documented at this time

### Previously Resolved
- **Issue**: PowerShell execution policy prevents script execution
  - **Status**: Fixed in v1.0.0
  - **Solution**: Added execution policy bypass in launcher

- **Issue**: File paths with spaces cause installation failure
  - **Status**: Fixed in v1.0.0
  - **Solution**: Proper quoting and path array handling

---

## Deprecation Notices

None at this time. This is the initial release.

---

## Security Notices

### Version 1.0.0
- ✅ No known security vulnerabilities
- ✅ Security audit completed and documented
- ✅ No hardcoded credentials or sensitive data
- ✅ Safe for open-source distribution

---

## Support Timeline

| Version | Release Date | End of Support |
|---------|-------------|-----------------|
| 1.0.x | 2025-11-18 | 2026-11-18 (12 months) |

When new versions are released, older versions will continue to receive critical security updates for 12 months from the new release date.

---

## Compatibility Matrix

| Component | Version 1.0.0 |
|-----------|--------------|
| **Office** | LTSC 2024 |
| **Windows** | 10 (1909+), 11, Server 2016+ |
| **PowerShell** | 5.0+ |
| **.NET** | Not required |
| **Admin Rights** | Required |

---

## Migration Guides

### Upgrading from Earlier Versions

This is the initial release, so no migration is needed.

For future releases, migration guides will be provided here.

---

## Feedback and Suggestions

We value your input! Please:

- [Report bugs](../../issues/new?labels=bug)
- [Request features](../../issues/new?labels=enhancement)
- [Share feedback](../../issues/new?labels=feedback)
- [Ask questions](../../issues/new?labels=question)

---

**Last Updated**: November 18, 2025
**Maintained by**: Office LTSC Deployment Toolkit Contributors
