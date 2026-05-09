# YehosoftDocs - Patch Strategy

YehosoftDocs maintains a minimal-impact patching strategy to ensure long-term maintainability and AGPLv3 compliance.

## 1. Upstream Sync Strategy
- **Baseline**: The current baseline is ONLYOFFICE Docs `v8.3.3.1`.
- **Monitoring**: Regularly check the ONLYOFFICE `8.3` branch for security hotfixes.
- **Merge Process**:
  1. Fetch upstream changes.
  2. Rebase `yehosoftdocs-v8.3.3` branch onto the new upstream tag.
  3. Resolve conflicts, prioritizing ONLYOFFICE core logic unless it conflicts with EDMS3 requirements.
  4. Regenerate patch files.

## 2. Minimal Patch Strategy
- **Targeted Edits**: Only modify files essential for YehosoftDocs goals (connection limits, mobile restrictions, branding).
- **Separation of Concerns**: Avoid mixing branding changes with logic changes.
- **Documentation**: Every patch must be documented with its purpose and the specific ONLYOFFICE version it targets.
- **Non-Invasive Branding**: Prefer CSS overrides and asset replacement over structural HTML changes.

## 3. Merge Conflict Strategy
- **Conflict Priority**: In case of a conflict between an upstream fix and a YehosoftDocs patch:
  - If the fix is a security patch, adapt the YehosoftDocs patch to the new logic.
  - If the fix is a UI change, evaluate if the branding patch is still necessary.
- **Traceability**: Maintain a log of why certain conflict resolutions were chosen in `patches/README.md`.

## 4. AGPLv3 Compliance
- **Transparency**: All patches must be clearly visible and separable from the original source.
- **Distribution**: If YehosoftDocs is distributed, the patched source code must be made available in accordance with AGPLv3.
- **Attribution**: NEVER remove "Powered by ONLYOFFICE" or other attribution marks unless it's a specific branding requirement that still allows for "Based on ONLYOFFICE" notice.

---
*Strategy Owner: YehosoftDocs Engineering Team*
