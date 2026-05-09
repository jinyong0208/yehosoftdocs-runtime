# YehosoftDocs - SDKJS Rebuild & Sync Commands

Follow these steps to synchronize `sdkjs` and `web-apps` to resolve the "Editor updated" loop.

## 1. Minimal Rebuild for SDKJS

### Step 1: Install Dependencies
```bash
cd /home/jiny/projects/yehosoftdocs-source/sources/sdkjs/build
npm install --silent
```

### Step 2: Build with Version Sync
```bash
export PRODUCT_VERSION=8.3.3
export BUILD_NUMBER=1
npx grunt --force
```

## 2. Minimal Rebuild for Web-Apps (Patched)

### Step 1: Prepare Translations
```bash
cd /home/jiny/projects/yehosoftdocs-source/sources/web-apps/translation
python3 merge_and_check.py
```

### Step 2: Build with Version Sync
```bash
cd /home/jiny/projects/yehosoftdocs-source/sources/web-apps/build
export PRODUCT_VERSION=8.3.3
export BUILD_NUMBER=1
npx grunt --force
```

## 3. Hot-Swap Sync Deployment

### Step 1: Backup and Clear
```bash
CONTAINER_NAME=$(docker ps --format '{{.Names}}' --filter ancestor=onlyoffice/documentserver:8.3.3)

# Clear existing folders (assuming backups were already made)
docker exec -u root $CONTAINER_NAME rm -rf /var/www/onlyoffice/documentserver/sdkjs
docker exec -u root $CONTAINER_NAME rm -rf /var/www/onlyoffice/documentserver/web-apps
```

### Step 2: Inject Synchronized Bundles
```bash
# Inject SDKJS
docker cp /home/jiny/projects/yehosoftdocs-source/sources/sdkjs/deploy/sdkjs $CONTAINER_NAME:/var/www/onlyoffice/documentserver/

# Inject Web-Apps (Patched)
docker cp /home/jiny/projects/yehosoftdocs-source/sources/web-apps/deploy/web-apps $CONTAINER_NAME:/var/www/onlyoffice/documentserver/

# Fix Permissions
docker exec -u root $CONTAINER_NAME chown -R ds:ds /var/www/onlyoffice/documentserver/sdkjs
docker exec -u root $CONTAINER_NAME chown -R ds:ds /var/www/onlyoffice/documentserver/web-apps
```

### Step 3: Refresh
```bash
docker exec -u root $CONTAINER_NAME supervisorctl restart all
```

---
*Status: Ready for execution.*
