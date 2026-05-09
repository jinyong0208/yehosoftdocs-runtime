# YehosoftDocs - Hot-Swap Deployment Guide (Mobile)

This guide provides the commands to deploy the patched `web-apps` component into a running ONLYOFFICE container for validation.

## 1. Environment Verification
Ensure the build has completed and the `deploy/web-apps` directory exists.

```bash
ls -d /home/jiny/projects/yehosoftdocs-source/sources/web-apps/deploy/web-apps
```

## 2. Deployment Commands

### Step 1: Identify and Backup
```bash
# Get the container name/ID
CONTAINER_NAME=$(docker ps --format '{{.Names}}' --filter ancestor=onlyoffice/documentserver:8.3.3)

# Backup the original web-apps
docker exec -u root $CONTAINER_NAME mv /var/www/onlyoffice/documentserver/web-apps /var/www/onlyoffice/documentserver/web-apps.bak
```

### Step 2: Inject Patched Build
```bash
# Copy the new web-apps directory
docker cp /home/jiny/projects/yehosoftdocs-source/sources/web-apps/deploy/web-apps $CONTAINER_NAME:/var/www/onlyoffice/documentserver/

# Fix permissions
docker exec -u root $CONTAINER_NAME chown -R ds:ds /var/www/onlyoffice/documentserver/web-apps
```

### Step 3: Restart Services
ONLYOFFICE web assets are served by Nginx. No service restart is strictly required, but clearing the backend cache can help.
```bash
docker exec -u root $CONTAINER_NAME supervisorctl restart all
```

## 3. Rollback Strategy
If issues occur, restore the backup:
```bash
docker exec -u root $CONTAINER_NAME rm -rf /var/www/onlyoffice/documentserver/web-apps
docker exec -u root $CONTAINER_NAME mv /var/www/onlyoffice/documentserver/web-apps.bak /var/www/onlyoffice/documentserver/web-apps
docker exec -u root $CONTAINER_NAME supervisorctl restart all
```

---
*Deployment Guide Version: 1.0*
