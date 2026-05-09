# YehosoftDocs - Version Synchronization Analysis (v8.3.3)

The "Editor updated" loop occurs when the frontend application version does not match the server build version.

## 1. Trigger Mechanism
The loop is triggered in the mobile editor's main controller:
- **File**: `sources/web-apps/apps/{editor}/mobile/src/controller/Main.jsx`
- **Function**: `onServerVersion(buildVersion)`
- **Logic**:
  ```javascript
  if (About.appVersion() !== buildVersion && !About.compareVersions()) {
      // Triggers "Editor updated" dialog and reloads page
  }
  ```

## 2. Version Sources
- **Frontend Version**: `About.appVersion()` is derived from `__PRODUCT_VERSION__`, which is injected by Webpack during the `web-apps` build. If not specified, it defaults to a placeholder (e.g., `6.2.0.123d`).
- **Server Version**: `buildVersion` is sent by the DocService (server) to the `sdkjs` engine, which then passes it to the frontend shell.
- **SDKJS Version**: `sdkjs` also has an internal `g_cProductVersion` injected during its build process.

## 3. The Synchronization Gap
When `web-apps` was rebuilt for the mobile patch, the environment variables `PRODUCT_VERSION` and `BUILD_NUMBER` were likely missing. This caused the patched frontend to identify as version `6.2.0`, while the server (and existing `sdkjs`) identified as `8.3.3`.

## 4. Resolution Strategy
To stop the loop, both `sdkjs` and `web-apps` must be rebuilt with environment variables that match the server's version.

### Build Parameters
- `PRODUCT_VERSION=8.3.3`
- `BUILD_NUMBER=1`

---
*Note: This synchronization is critical for any ONLYOFFICE component modification.*
