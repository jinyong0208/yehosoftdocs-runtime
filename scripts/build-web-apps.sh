#!/bin/bash
# ==============================================================================
# YehosoftDocs Runtime - Web-Apps Build & Mobile Branding Sync Script
# Target Repository: yehosoftdocs-runtime
# Upstream Version: ONLYOFFICE DocumentServer 8.3.3 (Build 8.3.3-18)
#
# Context:
#   This script automates the compilation of frontend web-apps from the source repo
#   and ensures all mobile branding assets (SVGs and PNGs) are synchronized to the
#   deploy directory before packaging with Dockerfile.branding-fixed.
#
# Usage:
#   bash scripts/build-web-apps.sh [PATH_TO_YEHOSOFTDOCS_SOURCE]
# ==============================================================================
set -euo pipefail

SOURCE_DIR="${1:-/home/jiny/projects/yehosoftdocs-source}"
WEB_APPS_DIR="${SOURCE_DIR}/sources/web-apps"

export PRODUCT_VERSION="${PRODUCT_VERSION:-8.3.3}"
export BUILD_NUMBER="${BUILD_NUMBER:-1}"

echo "=========================================================="
echo "YehosoftDocs Web-Apps Build"
echo "Upstream Version : ${PRODUCT_VERSION}.${BUILD_NUMBER}"
echo "Source Location  : ${SOURCE_DIR}"
echo "=========================================================="

if [ ! -d "${WEB_APPS_DIR}" ]; then
    echo "ERROR: web-apps directory not found at: ${WEB_APPS_DIR}" >&2
    echo "Please specify the correct path to yehosoftdocs-source." >&2
    exit 1
fi

# Step 1: Translations merge
if [ -f "${WEB_APPS_DIR}/translation/merge_and_check.py" ]; then
    echo "[1/4] Merging translation files..."
    python3 "${WEB_APPS_DIR}/translation/merge_and_check.py"
fi

# Step 2: Grunt build
echo "[2/4] Executing Grunt build..."
cd "${WEB_APPS_DIR}/build"
./node_modules/.bin/grunt --force

# Step 3: Automated Post-Build Branding Sync
# Grunt documenteditor/spreadsheeteditor/presentationeditor tasks copy to their respective
# deploy directories, but build/common.json does not copy to deploy/web-apps/apps/common/mobile.
# This automated step ensures complete coverage across all mobile path variants.
echo "[3/4] Synchronizing mobile branding assets into deploy/web-apps/apps/common/mobile/resources/img..."
mkdir -p "${WEB_APPS_DIR}/deploy/web-apps/apps/common/mobile/resources/img"
cp -r "${WEB_APPS_DIR}/apps/common/mobile/resources/img/"* "${WEB_APPS_DIR}/deploy/web-apps/apps/common/mobile/resources/img/"

# Step 4: Verification of Deploy Artifacts
echo "[4/4] Verifying mobile logo assets in deploy output..."
CHECK_FILES=(
    "about/logo-new.svg"
    "about/logo-new-white.svg"
    "header/logo-ios.svg"
    "header/logo-android.svg"
    "header/header-logo-ios.png"
    "header/header-logo-android.png"
)

for editor in documenteditor spreadsheeteditor presentationeditor common; do
    for f in "${CHECK_FILES[@]}"; do
        target="${WEB_APPS_DIR}/deploy/web-apps/apps/${editor}/mobile/resources/img/${f}"
        if [ ! -f "${target}" ]; then
            echo "ERROR: Missing expected deploy asset: ${target}" >&2
            exit 1
        fi
    done
done

echo "=========================================================="
echo "Web-Apps build and asset synchronization completed successfully!"
echo "Deploy Artifacts: ${WEB_APPS_DIR}/deploy/web-apps"
echo "Build Dockerfile: docker/Dockerfile.branding-fixed"
echo "=========================================================="
