# YehosoftDocs - Build Strategy

This document outlines the build process for generating YehosoftDocs artifacts from the patched source.

## 1. Runtime Image Strategy
- **Base Image**: Use the official `onlyoffice/documentserver:8.3.3` image as the base for runtime experiments.
- **Layering**: Apply YehosoftDocs customizations (fonts, config) as additional layers or volume mounts.
- **Custom Build**: When source-level changes (like connection limits) are needed, a full custom image will be built.

## 2. Source Build Strategy
- **Orchestrator**: Use `build_tools/make.py` or `automate.py` to drive the build.
- **Execution Directory**: Always run build commands from the `sources/` directory. The `build_tools` scripts expect sibling directories for `core`, `server`, `sdkjs`, and `web-apps`.
- **Environment**: Build within a controlled Docker container to ensure toolchain consistency (Node.js version, C++ compiler, etc.).
- **Incremental Builds**: Focus on building only the modified components (e.g., `server` or `web-apps`) to speed up the development cycle.

## 3. Docker Build Strategy
- **Multi-Stage Builds**:
  - **Stage 1 (Compile)**: Build C++ core and minify JavaScript.
  - **Stage 2 (Package)**: Bundle the compiled artifacts into a clean deb/rpm or raw file structure.
  - **Stage 3 (Runtime)**: Create the final Docker image based on a slim OS (e.g., Ubuntu 22.04) with only necessary runtime dependencies.
- **Optimization**: Utilize Docker build cache for the `core` component, as it changes less frequently and takes the longest to compile.

## 4. WSL2 Performance Tips
- **File System**: Keep all source code on the WSL2 Linux file system (`/home/...`) to avoid the performance penalty of cross-OS file access (`/mnt/c/...`).
- **Memory**: Ensure WSL2 has at least 16GB of RAM allocated in `.wslconfig` for the `core` compilation phase.

---
*Strategy Owner: YehosoftDocs Engineering Team*
