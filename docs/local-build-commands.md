# YehosoftDocs - Local Build Commands (Mobile Experiment)

This document provides the specific commands to build the patched `web-apps` component.

## 1. Prerequisites
- Node.js v18.x or v20.x
- Python 3
- `npm` (included with Node.js)

## 2. Build Steps

### Step 1: Prepare Translations
The ONLYOFFICE frontend requires merging translation files before the main build.
```bash
cd /home/jiny/projects/yehosoftdocs-source/sources/web-apps/translation
python3 merge_and_check.py
```

### Step 2: Install Dependencies
```bash
cd /home/jiny/projects/yehosoftdocs-source/sources/web-apps/build
npm install
```

### Step 3: Run Grunt Build
This will bundle and minify the Document, Spreadsheet, and Presentation editors.
```bash
npx grunt --force
```

## 3. Expected Output
The build artifacts will be generated in:
`/home/jiny/projects/yehosoftdocs-source/sources/web-apps/deploy/web-apps/`

## 4. Troubleshooting
- **Memory Issues**: If the build fails due to OOM, increase Node.js memory limit:
  `export NODE_OPTIONS="--max-old-space-size=8192"`
- **Missing Files**: Ensure `sdkjs` is present in the `sources/` directory, as some grunt tasks might reference it.

---
*Build Commands Version: 1.0*
