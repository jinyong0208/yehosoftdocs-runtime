# YehosoftDocs - Mobile Build Plan

This document describes how to build the patched mobile editor for YehosoftDocs.

## 1. Build Environment
- **Platform**: WSL2 (Ubuntu 22.04 recommended).
- **Tools**: Node.js (v18+), Python 3.
- **Base**: Clean `web-apps` source at `v8.3.3.1`.

## 2. Rebuild Requirements
To apply the mobile patch, ONLY the `web-apps` component needs to be rebuilt.
- **Component**: `web-apps`
- **Impact**: Generates new `app.js` and CSS bundles for the mobile editors.

## 3. Build Commands

### Step 1: Navigate to Build Tools
```bash
cd /home/jiny/projects/yehosoftdocs-source/sources/build_tools
```

### Step 2: Execute Build for Web-Apps
```bash
python3 make.py --module web-apps --branch v8.3.3.1 --update true
```
*Note: Using `--update true` ensures that the build tool recognizes the modified local files.*

## 4. Estimated Build Time
- **System**: 8-core CPU, 16GB RAM.
- **Time**: ~15 - 25 minutes.
- **Factors**: Minification and bundling of three editor applications (Document, Spreadsheet, Presentation).

## 5. Rollback Strategy
1.  **Git**: Switch back to the `main` or `v8.3.3.1` clean branch in `web-apps`.
2.  **Clean**: Delete the `out/` directory to ensure no stale artifacts remain.
3.  **Rebuild**: Run the build command again to restore the original Community Edition behavior.

---
*Build Plan Version: 1.0*
