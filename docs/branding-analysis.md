# YehosoftDocs - Branding Enhancement Analysis (v8.3.3)

This document outlines the strategy for applying a minimal enterprise branding layer to the YehosoftDocs Runtime while maintaining ONLYOFFICE attribution.

## 1. Visual Identity Direction
- **Primary Color**: `#2a4e7a` (Deep Enterprise Blue)
- **Secondary Color**: `#404040` (Slate Gray)
- **Identity**: "YehosoftDocs Runtime"
- **Footnote**: "Based on ONLYOFFICE Docs"

## 2. Target Asset Locations

### A. Logos (SVG)
The following SVGs will be replaced with the minimal "YD" logo:
- `apps/common/main/resources/img/header/header-logo_s.svg` (Top left logo)
- `apps/common/main/resources/img/header/dark-logo_s.svg` (Dark mode logo)
- `apps/common/main/resources/img/about/logo_s.svg` (About dialog logo)

### B. Favicons (.ico)
A clean "Y" icon will replace the existing favicons:
- `apps/documenteditor/main/resources/img/favicon.ico`
- `apps/spreadsheeteditor/main/resources/img/favicon.ico`
- `apps/presentationeditor/main/resources/img/favicon.ico`

### C. Browser Titles
Modify `<title>` in `index.html` across all editors:
- `apps/documenteditor/main/index.html` -> `YehosoftDocs | Documents`
- `apps/spreadsheeteditor/main/index.html` -> `YehosoftDocs | Spreadsheets`
- `apps/presentationeditor/main/index.html` -> `YehosoftDocs | Presentations`

### D. About Dialog
Modify `apps/common/mobile/lib/view/About.jsx` (and desktop equivalent) to:
- Change "ONLYOFFICE" to "YehosoftDocs Runtime".
- Add a new line: "Based on ONLYOFFICE Docs v8.3.3".
- Retain the original copyright and AGPL link.

## 3. Patch Strategy
- **Surgical Metadata**: Use `APP_TITLE_TEXT="YehosoftDocs"` and `COMPANY_NAME="Yehosoft"` env vars during the `web-apps` build.
- **Asset Injection**: Use `write_file` to overwrite SVG placeholders.
- **Code Patches**: Minimal `replace` calls for JSX and HTML files.

---
*Status: Strategy Ready. Proceeding with asset generation and patching.*
