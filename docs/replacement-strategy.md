# YehosoftDocs - Runtime Replacement Strategy

Once the `web-apps` component is built, you can apply it to a running ONLYOFFICE Docs container for immediate validation.

## 1. Hot-Swap Strategy (Fast Validation)
If you already have a Document Server container running:

```bash
# 1. Identify the container ID
CONTAINER_ID=$(docker ps -q --filter ancestor=onlyoffice/documentserver:8.3.3)

# 2. Backup original web-apps (Optional)
docker exec $CONTAINER_ID mv /var/www/onlyoffice/documentserver/web-apps /var/www/onlyoffice/documentserver/web-apps.bak

# 3. Copy new web-apps to the container
docker cp /home/jiny/projects/yehosoftdocs-source/sources/web-apps/deploy/web-apps $CONTAINER_ID:/var/www/onlyoffice/documentserver/

# 4. Refresh browser (Disable Cache)
```

## 2. Experimental Docker Image Strategy
To create a persistent experimental image:

```bash
cd /home/jiny/projects/yehosoftdocs-source/
cat <<EOF > Dockerfile.mobile
FROM onlyoffice/documentserver:8.3.3
LABEL maintainer="Yehosoft Engineering"
LABEL description="Experimental mobile editing build for YehosoftDocs"

# Replace web-apps with patched version
COPY sources/web-apps/deploy/web-apps /var/www/onlyoffice/documentserver/web-apps

# Ensure correct permissions
RUN chown -R ds:ds /var/www/onlyoffice/documentserver/web-apps
EOF

docker build -t yehosoft/yehosoftdocs-mobile-experiment:8.3.3 -f Dockerfile.mobile .
```

## 3. Local Test Strategy
- **Android**: Use Chrome on Android. Enable "Request Desktop Site" to see if it triggers the standard view, then switch back to "Mobile Site" to verify the patch.
- **iPhone/iPad**: Use Safari. Verify that the "Open Source" warning no longer appears when trying to edit.
- **Chrome DevTools**: Use the Device Toolbar (Ctrl+Shift+M) to emulate various mobile devices and verify the UI responsiveness.

---
*Replacement Strategy Version: 1.0*
