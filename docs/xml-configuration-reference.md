# Office LTSC XML Configuration Reference

Complete reference guide for creating and customizing XML configuration files for the Office Deployment Tool.

## Table of Contents

1. [Basic Structure](#basic-structure)
2. [Common Elements](#common-elements)
3. [Product IDs](#product-ids)
4. [Language Codes](#language-codes)
5. [Properties](#properties)
6. [Examples](#examples)
7. [Validation Tips](#validation-tips)

---

## Basic Structure

Every configuration file must follow this structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
  <Add OfficeClientEdition="64" Channel="PerpetualVL2024">
    <Product ID="ProPlus2024Volume">
      <!-- Configuration options here -->
    </Product>
  </Add>
  
  <!-- Additional settings here -->
</Configuration>
```

### Root Element: `<Configuration>`

| Attribute | Values | Required | Description |
|-----------|--------|----------|-------------|
| `ID` | Any string | Optional | Identifier for your configuration (use in file names) |

### Add Element: `<Add>`

Controls which Office version and channel to install.

| Attribute | Values | Required | Default | Description |
|-----------|--------|----------|---------|-------------|
| `OfficeClientEdition` | `32`, `64` | Yes | - | Bit version: 32-bit or 64-bit |
| `Channel` | `PerpetualVL2024` | Yes | - | Installation channel (LTSC = perpetual) |

**Note**: For Office LTSC 2024, always use:
```xml
<Add OfficeClientEdition="64" Channel="PerpetualVL2024">
```

---

## Common Elements

### Product Element

Specifies which Office product to install.

```xml
<Product ID="ProPlus2024Volume">
  <Language ID="zh-cn" />
  <Language ID="en-us" />
</Product>
```

### Language Element

Defines which languages to include.

```xml
<Product ID="ProPlus2024Volume">
  <Language ID="zh-cn" />      <!-- Simplified Chinese (Primary) -->
  <Language ID="zh-tw" />      <!-- Traditional Chinese -->
  <Language ID="en-us" />      <!-- English (US) -->
  <Language ID="en-gb" />      <!-- English (UK) -->
  <Language ID="ja-jp" />      <!-- Japanese -->
  <Language ID="ko-kr" />      <!-- Korean -->
</Product>
```

**Primary Language**: The first `<Language>` element becomes the primary UI language.

### Remove MSI Element

Removes older Office versions before installing LTSC.

```xml
<RemoveMSI />
```

**When to use**: Include this if you're upgrading from Office 2016, 2019, or earlier versions.

### Updates Element

Controls automatic updates after installation.

```xml
<Updates Enabled="TRUE" />    <!-- Enable automatic updates -->
<Updates Enabled="FALSE" />   <!-- Disable automatic updates -->
```

**Default**: Updates are disabled for LTSC (perpetual licensing).

### Display Element

Controls installation UI appearance.

```xml
<Display Level="Full" AcceptEULA="TRUE" />
```

| Attribute | Values | Description |
|-----------|--------|-------------|
| `Level` | `Full`, `None` | `Full`: Show installer UI; `None`: Silent installation |
| `AcceptEULA` | `TRUE`, `FALSE` | Automatically accept End User License Agreement |

### Property Elements

Configure specific Office behavior.

```xml
<Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
```

**Common Properties**:

| Property | Values | Default | Description |
|----------|--------|---------|-------------|
| `FORCEAPPSHUTDOWN` | `TRUE`, `FALSE` | `TRUE` | Force close Office applications during installation |
| `SharedComputerLicensing` | `0`, `1` | `0` | Multi-user licensing: `1` for shared computers |
| `SCLCacheOverride` | `TRUE`, `FALSE` | `FALSE` | Override shared computer cache settings |
| `AUTOACTIVATE` | `0`, `1` | `1` | Auto-activate using KMS or MAK |

---

## Product IDs

### Office LTSC 2024 Products

| Product ID | Product Name | Edition |
|-----------|-------------|---------|
| `ProPlus2024Volume` | Office Professional Plus 2024 | Full suite |
| `Standard2024Volume` | Office Standard 2024 | Word, Excel, PowerPoint, Outlook, Publisher |
| `ProjectStd2024Volume` | Project Standard 2024 | Project Management |
| `ProjectPro2024Volume` | Project Professional 2024 | Project Management |
| `VisioStd2024Volume` | Visio Standard 2024 | Diagramming |
| `VisioPro2024Volume` | Visio Professional 2024 | Diagramming |

### Individual Applications

For licensing purposes, these are available within products:

- Word (`Word2024Volume`)
- Excel (`Excel2024Volume`)
- PowerPoint (`PowerPoint2024Volume`)
- Outlook (`Outlook2024Volume`)
- Publisher (`Publisher2024Volume`)
- Access (`Access2024Volume`)
- OneNote (`OneNote2024Volume`)

---

## Language Codes

### Commonly Used Languages

| Language Code | Language | Region |
|--------------|----------|--------|
| `zh-cn` | Chinese | Simplified (China) |
| `zh-tw` | Chinese | Traditional (Taiwan) |
| `en-us` | English | United States |
| `en-gb` | English | United Kingdom |
| `ja-jp` | Japanese | Japan |
| `ko-kr` | Korean | Korea |
| `fr-fr` | French | France |
| `es-es` | Spanish | Spain |
| `de-de` | German | Germany |
| `it-it` | Italian | Italy |
| `ru-ru` | Russian | Russia |
| `pt-br` | Portuguese | Brazil |
| `pt-pt` | Portuguese | Portugal |
| `vi-vn` | Vietnamese | Vietnam |
| `th-th` | Thai | Thailand |

**Complete List**: [Microsoft Office Language IDs](https://learn.microsoft.com/en-us/deployoffice/office-deployment-tool-configuration-options#language-element)

---

## Properties

### Security and Licensing

```xml
<!-- Require administrator for installation -->
<Property Name="INSTALLTARGETPATH" Value="C:\Program Files\Microsoft Office\" />

<!-- Use KMS for licensing (requires KMS server) -->
<Property Name="AUTOACTIVATE" Value="1" />

<!-- Multiple Activation Key (MAK) licensing -->
<Property Name="AUTOACTIVATE" Value="1" />
<!-- Then use slmgr.vbs or KMS host for activation -->
```

### User Experience

```xml
<!-- Disable automatic updates (for LTSC) -->
<Updates Enabled="FALSE" />

<!-- Show progress during installation -->
<Display Level="Full" AcceptEULA="TRUE" />

<!-- Silent installation (no UI) -->
<Display Level="None" AcceptEULA="TRUE" />

<!-- Disable Office startup on installation completion -->
<Property Name="SETUP_REBOOT" Value="Never" />
```

### Application Settings

```xml
<AppSettings>
  <!-- Set Excel default file format to Excel 97-2003 -->
  <User Key="software\microsoft\office\16.0\excel\options" 
        Name="defaultformat" 
        Value="51" />
  
  <!-- Disable Office tips on startup -->
  <User Key="software\microsoft\office\16.0\common\general" 
        Name="showcustomuitips" 
        Value="0" />
  
  <!-- Set default theme to use system theme -->
  <User Key="software\microsoft\office\16.0\common\general" 
        Name="theme" 
        Value="0" />
</AppSettings>
```

---

## Examples

### Example 1: Multilingual Institutional Deployment

For institutions serving both Chinese and English-speaking users:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration ID="AEPC_Multilingual">
  <Add OfficeClientEdition="64" Channel="PerpetualVL2024">
    <Product ID="ProPlus2024Volume">
      <Language ID="zh-cn" />    <!-- Primary language -->
      <Language ID="en-us" />    <!-- Secondary language -->
      <Language ID="ja-jp" />    <!-- Additional support -->
    </Product>
  </Add>
  
  <Display Level="Full" AcceptEULA="TRUE" />
  <Updates Enabled="FALSE" />
  <RemoveMSI />
  
  <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
  <Property Name="SharedComputerLicensing" Value="0" />
</Configuration>
```

### Example 2: Silent Installation with Custom Settings

For automated deployment without user interaction:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration ID="ARTVU_Silent">
  <Add OfficeClientEdition="64" Channel="PerpetualVL2024">
    <Product ID="Standard2024Volume">
      <Language ID="zh-cn" />
    </Product>
  </Add>
  
  <Display Level="None" AcceptEULA="TRUE" />
  <Updates Enabled="FALSE" />
  <RemoveMSI />
  
  <Property Name="FORCEAPPSHUTDOWN" Value="TRUE" />
  <Property Name="AUTOACTIVATE" Value="1" />
  
  <AppSettings>
    <User Key="software\microsoft\office\16.0\common\general" 
          Name="showcustomuitips" 
          Value="0" />
  </AppSettings>
</Configuration>
```

### Example 3: Professional Plus with Developer Focus

For technical teams needing full functionality:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration ID="TechLab_ProPlus">
  <Add OfficeClientEdition="64" Channel="PerpetualVL2024">
    <Product ID="ProPlus2024Volume">
      <Language ID="en-us" />
      <Language ID="zh-cn" />
    </Product>
  </Add>
  
  <Display Level="Full" AcceptEULA="TRUE" />
  <Updates Enabled="FALSE" />
  <RemoveMSI />
  
  <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
  <Property Name="SharedComputerLicensing" Value="0" />
  
  <AppSettings>
    <!-- Enable macro security warnings -->
    <User Key="software\microsoft\office\16.0\excel\security" 
          Name="vbawarnings" 
          Value="3" />
    
    <!-- Enable formula auditing tools -->
    <User Key="software\microsoft\office\16.0\excel\options" 
          Name="displayformulabar" 
          Value="1" />
  </AppSettings>
</Configuration>
```

### Example 4: Shared Computer (Lab/Classroom)

For lab or classroom computers with multiple users:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration ID="Lab_SharedComputer">
  <Add OfficeClientEdition="64" Channel="PerpetualVL2024">
    <Product ID="Standard2024Volume">
      <Language ID="zh-cn" />
    </Product>
  </Add>
  
  <Display Level="None" AcceptEULA="TRUE" />
  <Updates Enabled="FALSE" />
  <RemoveMSI />
  
  <Property Name="FORCEAPPSHUTDOWN" Value="TRUE" />
  <Property Name="SharedComputerLicensing" Value="1" />
  <Property Name="SCLCacheOverride" Value="FALSE" />
  <Property Name="AUTOACTIVATE" Value="1" />
</Configuration>
```

---

## Validation Tips

### Check Your XML

1. **Valid XML Syntax**
   - Opening and closing tags must match
   - All attribute values must be quoted
   - Proper nesting required

   ```xml
   <!-- ✅ Correct -->
   <Language ID="zh-cn" />
   
   <!-- ❌ Wrong: Missing closing / -->
   <Language ID="zh-cn">
   
   <!-- ❌ Wrong: Unquoted attribute -->
   <Add OfficeClientEdition=64 />
   ```

2. **Product ID Validation**
   - Must be a valid product from the list above
   - Case-sensitive (`ProPlus2024Volume`, not `propluss2024volume`)

3. **Language Code Validation**
   - Use valid language codes from Microsoft's list
   - Simplified Chinese is `zh-cn` (lowercase, hyphen-separated)

4. **Test Installation**
   ```powershell
   # Validate XML before running actual installation
   & "setup.exe" /download "config.xml" "C:\OfflineCache"
   
   # Then run actual installation
   & "setup.exe" /configure "config.xml"
   ```

### Common Mistakes

| Mistake | Example | Correct |
|---------|---------|---------|
| Unquoted attributes | `Channel=PerpetualVL2024` | `Channel="PerpetualVL2024"` |
| Missing closing slash | `<Language ID="zh-cn">` | `<Language ID="zh-cn" />` |
| Wrong product ID | `Standard` | `Standard2024Volume` |
| Case sensitivity | `zh-CN` | `zh-cn` |
| Improper nesting | Elements out of order | Follow structure strictly |

---

## Microsoft Documentation

For complete reference, see:

- [Office Deployment Tool Configuration Options](https://learn.microsoft.com/en-us/deployoffice/office-deployment-tool-configuration-options)
- [Office Languages and Language Tags](https://learn.microsoft.com/en-us/deployoffice/office-deployment-tool-configuration-options#language-element)
- [Property Element Reference](https://learn.microsoft.com/en-us/deployoffice/office-deployment-tool-configuration-options#property-element)

---

## Tips for Institutional Deployments

1. **Test Before Rolling Out**
   - Always test configuration on a few computers first
   - Verify all languages work correctly
   - Test licensing activation

2. **Documentation**
   - Name your config files clearly: `INSTITUTION_Language_Edition_Date.xml`
   - Include version numbers
   - Document any custom settings in comments

3. **Backup Original Configs**
   - Keep a copy of tested configurations
   - Version control with Git
   - Document changes over time

4. **Licensing**
   - Verify you have appropriate volume licenses
   - Configure KMS host or MAK properly
   - Test activation process

5. **Updates Strategy**
   - Decide on update policy (LTSC receives updates but less frequently than Microsoft 365)
   - Configure centralized update management if needed
   - Document your update schedule

---

Last Updated: November 2025