# YehosoftDocs - Mobile Support Validation Checklists

Use these checklists to verify the success of the mobile support patch.

## 1. Android Chrome Checklist
- [ ] Open a document in the mobile browser.
- [ ] Verify that the "Open Source" warning dialog DOES NOT appear.
- [ ] Verify that the document DOES NOT default to "View-only" mode.
- [ ] Check if the virtual keyboard appears when clicking on a text area.
- [ ] Verify that the formatting toolbar (B/I/U, Font size) is visible and functional.
- [ ] Test spreadsheet cell selection and data entry.
- [ ] Test presentation slide navigation and basic text editing.

## 2. iPhone/iPad Safari Checklist
- [ ] Open a document in Safari.
- [ ] Verify the absence of the restriction warning.
- [ ] Verify that editing tools are available in the UI.
- [ ] Test "Pinch-to-zoom" behavior in the editor.
- [ ] Verify that the UI adapts correctly to portrait and landscape orientations.

## 3. Chrome DevTools (Emulation) Checklist
- [ ] Set device to "iPhone 12 Pro" or "Pixel 7".
- [ ] Verify the `app.js` and CSS bundles loaded are the patched ones (Check file sizes/timestamps).
- [ ] Inspect the DOM for the presence of the toolbar elements.
- [ ] Simulate touch events to verify interactive elements (menus, buttons).

## 4. Common Verification
- [ ] **Attribution**: "Powered by ONLYOFFICE" must be visible in the "About" dialog.
- [ ] **Compliance**: No core ONLYOFFICE backend services were modified.

---
*Validation Checklists Version: 1.0*
