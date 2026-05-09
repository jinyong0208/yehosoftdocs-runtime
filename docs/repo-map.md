# YehosoftDocs - Repository Map

This document describes the role of each ONLYOFFICE repository in the YehosoftDocs workspace (v8.3.3.1).

## Core Repositories

| Repository | Tag | Purpose | Future Patch Target |
| :--- | :--- | :--- | :--- |
| **build_tools** | `v8.3.3.1` | The build orchestrator. Contains Python scripts to automate the build process across all components. | - |
| **core** | `v8.3.3.1` | C++ engine for document conversion (`x2t`) and rendering. | **Yes** (Performance/Compatibility) |
| **server** | `v8.3.3.1` | Node.js backend services. Handles sessions, licensing, and document management. | **Yes** (Connection Limits) |
| **sdkjs** | `v8.3.3.1` | JavaScript Editor SDK. The core logic for the WYSIWYG editor. | **Yes** (Branding/Logic) |
| **web-apps** | `v8.3.3.1` | Frontend UI. Contains HTML/CSS/JS for the editor interface. | **Yes** (Mobile restrictions/Branding) |
| **DocumentServer** | `v8.3.3` | Integration layer. Contains Dockerfiles and higher-level configuration. | **Yes** (Integration/Customization) |
| **dictionaries** | `v8.3.3.1` | Spellchecking dictionaries. | - |

## Detailed Purpose and Patch Targets

### 1. `server` (Backend)
- **Purpose**: Manages document editing sessions, user collaboration, and license verification.
- **Patch Target (Connection Limits)**: The `Common/sources/constants.js` file contains the `LICENSE_CONNECTIONS` limit. YehosoftDocs may need to adjust this for EDMS3 scale.
- **Patch Target (Licensing)**: `Common/sources/license.js` handles the verification of the ONLYOFFICE license.

### 2. `web-apps` (Frontend)
- **Purpose**: The user interface for Document, Spreadsheet, and Presentation editors.
- **Patch Target (Mobile Restrictions)**: ONLYOFFICE Community Edition restricts editing on mobile devices. Patches in `web-apps/apps/*/mobile/app.js` can unlock these capabilities.
- **Patch Target (Branding)**: CSS and asset files in `apps/common/main/resources/` are targets for YehosoftDocs branding.

### 3. `sdkjs` (Editor Logic)
- **Purpose**: Low-level editor logic, including cursor management, selection, and document model manipulation.
- **Patch Target (Plugins)**: YehosoftDocs may inject custom plugins or modify plugin loading behavior here.

### 4. `core` (C++ Engine)
- **Purpose**: Heavy lifting for document conversion.
- **Patch Target**: Primarily for bug fixes or specific conversion improvements required by EDMS3 users.

---
*Note: All modifications must comply with AGPLv3. Attribution to ONLYOFFICE must be maintained.*
