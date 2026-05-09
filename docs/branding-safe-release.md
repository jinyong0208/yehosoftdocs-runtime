# Safe Branding Release Strategy

This document outlines the corrective actions taken to fix the branding release loop and server initialization errors.

## 1. Problem Diagnosis
- **Issue**: Latest image (`8.3.3`) fails with 502 Bad Gateway.
- **Root Cause**: The server binaries (`docservice`, `converter`) were rebuilt using `pkg` but encountered `MODULE_NOT_FOUND` at runtime due to missing dependencies in the bundle.
- **Impact**: Server failed to spawn, while the frontend (`web-apps`) was correctly branded.

## 2. Safe Fix Strategy
Instead of attempting to fix the `pkg` build, we revert to the known-stable server environment and apply branding as a pure frontend layer.

- **Base Image**: `yehosoft/yehosoftdocs-runtime:8.3.3-edms3` (Stable).
- **Injection Layer**: Patched and branded `web-apps`.
- **Exclusion**: Server binaries, `sdkjs`, and core C++ remain untouched from the stable base.

## 3. Build Command
```bash
docker build -t yehosoft/yehosoftdocs-runtime:8.3.3-branding-test -f Dockerfile.branding-fixed .
```

## 4. Test & Verification
1.  **Healthcheck**: Verify if `docservice` is running on port 8000.
2.  **Branding**: Open the editor and verify the "YD" logo and "YehosoftDocs" browser title.
3.  **Stability**: Ensure no 502 errors appear during document loading.

## 5. Rollback Procedure
If the test image fails, immediately revert the runtime tag to the stable base:
```bash
docker tag yehosoft/yehosoftdocs-runtime:8.3.3-edms3 yehosoft/yehosoftdocs-runtime:8.3.3
```

---
*Release Owner: Yehosoft Engineering*
