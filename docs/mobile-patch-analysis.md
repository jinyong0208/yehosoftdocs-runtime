# YehosoftDocs - Mobile Patch Analysis (v8.3.3.1)

This document analyzes the logic restricting mobile editing in ONLYOFFICE Docs 8.3.3 Community Edition and proposes a minimal patch.

## 1. Identified Restriction Logic

### A. The "Support" Flag
The primary restriction is a hardcoded boolean in a "patch" file for each editor.
- **Files**:
  - `apps/documenteditor/mobile/src/lib/patch.jsx`
  - `apps/spreadsheeteditor/mobile/src/lib/patch.jsx`
  - `apps/presentationeditor/mobile/src/lib/patch.jsx`
- **Logic**:
  ```javascript
  EditorUIController.isSupportEditFeature = () => {
      return false // <-- Hardcoded to false in CE
  };
  ```

### B. Forced View Mode (Document Editor)
In the Document Editor, even if permissions allow editing, a `forceView` parameter defaults to `true` for mobile.
- **File**: `apps/documenteditor/mobile/src/controller/Main.jsx`
- **Logic**:
  ```javascript
  const isForceView = isMobileForceView ?? customization?.mobile?.forceView ?? true;
  // ...
  if( isForceView ) {
      this.api.asc_addRestriction(Asc.c_oAscRestrictionType.View);
  }
  ```

### C. Open Source Warning
A warning dialog is triggered if a mobile user attempts to edit in the Open Source version.
- **File**: `apps/documenteditor/mobile/src/controller/Main.jsx`
- **Logic**:
  ```javascript
  if (appOptions.config.mode !== 'view' && !EditorUIController.isSupportEditFeature()) {
      // Shows dialog with _t.errorOpensource
  }
  ```

## 2. Minimal Patch Proposal

### Patch 1: Enable Support Flag
Change `return false` to `return true` in all three `patch.jsx` files. This unlocks the editing UI and bypasses the Open Source warning.

### Patch 2: Disable Forced View
Change the default of `isForceView` from `true` to `false` in `documenteditor/mobile/src/controller/Main.jsx`. This prevents the editor from automatically entering View-only mode on mobile devices.

## 3. Scope of Rebuild
- **web-apps**: **Required**. These changes are in the React-based frontend and must be transpiled/bundled.
- **sdkjs**: **Not Required** for this specific patch, as the logic is contained within the application shell (web-apps).
- **core/server**: **Not Required**.

---
*Status: Research Complete. Patch ready for creation.*
