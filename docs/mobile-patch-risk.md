# YehosoftDocs - Mobile Patch Risks

Enabling mobile editing in the Community Edition carries certain technical and UX risks.

## 1. User Experience (UX) Risks
- **Screen Real Estate**: The ONLYOFFICE mobile editor is complex. On smaller phones, the editing toolbars and keyboard may overlap, making editing difficult.
- **Touch Precision**: Some features (like selecting small spreadsheet cells or resizing shapes) may lack the precision found in the Enterprise version, leading to user frustration.
- **UI Responsiveness**: The React-based mobile UI in CE might not have the same level of optimization as the Enterprise/Mobile app versions.

## 2. Technical Risks
- **Performance**: Mobile browsers have limited CPU and RAM. Editing large documents may lead to crashes or severe lag.
- **Concurrency**: Enabling mobile editing increases the likelihood of concurrent editing sessions, which might hit the Community Edition connection limit (20) more quickly.
- **Bug Surface**: YehosoftDocs becomes responsible for supporting mobile-specific UI bugs that were previously "locked away."

## 3. Compliance & Maintenance Risks
- **Upstream Changes**: ONLYOFFICE may change the location or implementation of these flags in future versions (e.g., 8.4+), requiring patch updates.
- **AGPLv3 Compliance**: As a modification to the source code, this patch must be provided to users if the software is distributed.

## 4. Mitigation Strategy
- **Minimalism**: Keep the patch limited strictly to the flags identified.
- **Testing**: Test on a variety of mobile devices (Android/iOS) and browsers (Chrome/Safari).
- **Clear Documentation**: Ensure the patch is clearly documented as an "Experimental Support" feature.

---
*Risk Assessment: Medium. Recommended for experimental integration.*
