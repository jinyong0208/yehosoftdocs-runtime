# YehosoftDocs Runtime

YehosoftDocs Runtime is a production-ready document editing runtime based on ONLYOFFICE Docs Community Edition.

It is optimized for:

- Enterprise document management systems (EDMS)
- Chinese document compatibility
- Mobile editing support
- Flutter/WebView integration
- Docker-based private deployment
- JWT-secured integrations

## Features

- Mobile web editor support
- Chinese font optimization
- Enterprise runtime branding
- Docker-ready runtime
- Community Edition compatible
- Private deployment friendly

````markdown id="jlwm193"
## Quick Start

```yaml
onlyoffice:
  image: yehosoft/yehosoftdocs-runtime:8.3.3
  ports:
    - "18010:80"
```
## Font Mounting

Custom fonts can be mounted using:

​
./fonts:/usr/share/fonts/truetype/custom

Refresh font cache:

​
fc-cache -fv

## Notes

YehosoftDocs Runtime is based on ONLYOFFICE Docs Community Edition and preserves ONLYOFFICE attribution and AGPL licensing requirements.

## License

- ONLYOFFICE Docs Community Edition: AGPLv3
- YehosoftDocs Runtime overlay modifications: AGPL-compatible
