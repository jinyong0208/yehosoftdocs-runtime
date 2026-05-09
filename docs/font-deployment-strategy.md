# YehosoftDocs - Customer Font Deployment Strategy

To support proprietary Chinese fonts (e.g., SimSun, Microsoft YaHei) without bundling them in the public image, follow this mounting strategy.

## 1. Directory Setup
On the host machine, create a `fonts/` directory:
```bash
mkdir -p /home/jiny/projects/YehosoftDocs/fonts
```

## 2. Copy Fonts
Place your `.ttf` or `.ttc` font files into the `fonts/` directory:
- `simsun.ttc` (SimSun & NSimSun)
- `msyh.ttc` (Microsoft YaHei)
- `simhei.ttf` (SimHei)
- `simkai.ttf` (KaiTi)
- `simfang.ttf` (FangSong)

## 3. Docker Compose Configuration
Ensure your `docker-compose.yml` mounts the fonts directory:
```yaml
services:
  onlyoffice:
    image: yehosoft/yehosoftdocs-runtime:8.3.3
    volumes:
      - ./fonts:/usr/share/fonts/truetype/custom
```

## 4. Refresh Font Cache
After adding new fonts, run the following command to regenerate the ONLYOFFICE font list:
```bash
docker exec -it onlyoffice-docs yehosoftdocs-refresh-fonts
```

## 5. Verification
Check if the fonts are recognized by the system:
```bash
docker exec -it onlyoffice-docs fc-list :lang=zh
```

---
*Note: The public image already includes open-source WenQuanYi and Noto CJK fonts.*
