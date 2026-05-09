# YehosoftDocs - Source Layout

This document describes the recommended workspace structure for YehosoftDocs development.

## Directory Structure

```text
/home/jiny/projects/yehosoftdocs-source/
├── setup-repos.sh          # Orchestration script to clone/update repos
├── sources/                # Clean ONLYOFFICE source repositories
│   ├── build_tools/        # Orchestrator
│   ├── core/               # C++ engine
│   ├── server/             # Node.js backend
│   ├── sdkjs/              # Editor SDK
│   ├── web-apps/           # Frontend UI
│   ├── DocumentServer/     # Integration logic
│   └── dictionaries/       # Spellcheck
├── docs/                   # Workspace-specific documentation
│   ├── repo-map.md
│   ├── source-layout.md
│   ├── patch-strategy.md
│   └── build-strategy.md
└── patches/                # [Future] Directory for .patch files
```

## Workspace Guidelines
- **Immutable Sources**: Treat files in `sources/` as read-only upstream references.
- **Git Branching**: For each repository in `sources/`, create a `yehosoftdocs-v8.3.3` branch when starting the patching phase.
- **Patch Management**: Store all modifications as standard `.patch` files in the `patches/` directory to ensure reproducibility and AGPLv3 compliance visibility.
- **Clean Builds**: Use a separate `out/` directory (created by `build_tools`) for build artifacts to keep the source tree clean.

---
*Note: This layout is optimized for WSL2 performance and Docker-based builds.*
