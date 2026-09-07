# Mobile Branding Build & Rollback Guide

## 1. 验证状态说明 (Verification Status)

> [!IMPORTANT]
> 必须严格区分各模块的实际验证状态，严禁宣称全量通过。

### 已验证通过范围 (Verified & Passed)
- **运行环境**：Flutter 移动端 WebView 原生集成（edms-mobile）。
- **验证页面**：文档编辑器（Document Editor, Word）。
- **验证要素**：
  - 顶部导航栏 Logo（`logo-ios.svg` / `logo-android.svg`）正常显示为 YehosoftDocs 品牌标识。
  - "关于"（About）界面 Logo（`logo-new.svg`）正常显示为 YehosoftDocs 品牌标识。
  - 保留原有开源及版权声明（Based on ONLYOFFICE Docs / Community Edition / AGPLv3）。

### 尚未验证范围 (Pending Verification - Do NOT Claim Passed)
- **表格编辑器 (Spreadsheet / Cell)**：移动端顶栏与关于页渲染尚未进行 Flutter 端到端真机截屏验收。
- **演示编辑器 (Presentation / Slide)**：移动端顶栏与关于页渲染尚未进行 Flutter 端到端真机截屏验收。
- **移动端深色模式 (Dark Theme)**：深色关于页 Logo（`logo-new-white.svg`）在真机深色切换下的对比度与显示效果尚未完成端到端验收。
- **移动端编辑与保存流程**：在移动端进行内容编辑、协同、保存及回调流程尚未进行端到端回归。

---

## 2. 构建流程 (Build Process)

### 前提条件与上游版本
- **上游版本**：ONLYOFFICE DocumentServer 8.3.3 (Build 8.3.3-18)
- **源码仓库上下文**：`yehosoftdocs-source/sources/web-apps`

### 步骤 1：前端编译与资源自动同步
使用自动化脚本完成 Grunt 编译以及跨模块 Logo 自动同步（避免依赖手工复制）：
```bash
bash scripts/build-web-apps.sh [PATH_TO_YEHOSOFTDOCS_SOURCE]
```

### 步骤 2：镜像构建
基于已知稳定的 8.3.3-edms3 镜像作为基础层，仅叠加纯前端编译产物：
```bash
docker build -f docker/Dockerfile.branding-fixed -t yehosoft/yehosoftdocs-runtime:8.3.3 .
```

---

## 3. 回滚方案 (Rollback Procedure)

### 场景 A：Docker Hub 镜像回滚
若线上镜像需要回滚至移动端品牌更新前的版本，拉取或重命名保留的备份标签：
```bash
docker pull yehosoft/yehosoftdocs-runtime:8.3.3-backup-pre-mobile-branding
docker tag yehosoft/yehosoftdocs-runtime:8.3.3-backup-pre-mobile-branding yehosoft/yehosoftdocs-runtime:8.3.3
docker push yehosoft/yehosoftdocs-runtime:8.3.3
```

### 场景 B：应用/容器端更新与回滚
- **更新运行容器（联调方执行）**：
  ```bash
  docker pull yehosoft/yehosoftdocs-runtime:8.3.3
  # 重新创建或重启运行容器
  docker restart <container_name>
  ```
- **回滚运行容器（联调方执行）**：
  ```bash
  docker pull yehosoft/yehosoftdocs-runtime:8.3.3-backup-pre-mobile-branding
  # 将容器镜像切回备份标签
  ```

### 场景 C：源码工作区补丁回滚
若需在源码端撤销移动端品牌修改：
```bash
cd sources/web-apps
git apply --reverse ../../patches/branding/mobile-branding.patch
```
