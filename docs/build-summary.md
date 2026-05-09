# YehosoftDocs - Experimental Build Summary (Mobile)

This document summarizes the requirements and expectations for the first experimental mobile support build.

## 1. Build Metrics (Estimated)
- **Component**: `web-apps` (v8.3.3.1 patched)
- **Estimated Build Time**: 15 - 25 minutes (WSL2 / 8-core CPU / 16GB RAM)
- **Additional Disk Usage**: 
  - `node_modules`: ~600 MB
  - `deploy/`: ~150 MB
  - `out/` (if using build_tools): ~200 MB
  - **Total**: ~1 GB

## 2. Compliance & Attribution
- **AGPLv3**: This build is a derivative work of ONLYOFFICE Docs Community Edition. The patched source code is maintained in the `yehosoftdocs-mobile-build` branch.
- **Attribution**: 
  - All "Powered by ONLYOFFICE" logos and links remain intact.
  - No ONLYOFFICE copyright headers have been removed from the source files.
  - The `About` dialog will still reflect the original ONLYOFFICE versioning.

## 3. Experimental Status
This build is for **local evaluation only**. It is NOT intended for production use.
- **Goal**: Verify if the UI allows basic editing on mobile browsers.
- **Non-Goal**: Stability, performance optimization, or bypassing server-side connection limits.

---
*Yehosoft Engineering - 2026*
