# YehosoftDocs Runtime Release Notes

## Version: 8.3.3 / 8.3.3-edms3 (Mobile Branding Update)
- **Release Date**: 2026-09-07
- **Base Image**: ONLYOFFICE DocumentServer 8.3.3 (Upstream Build 8.3.3-18)
- **Target Images**:
  - `yehosoft/yehosoftdocs-runtime:8.3.3`
  - `yehosoft/yehosoftdocs-runtime:8.3.3-edms3`
- **Pre-Release Backup Tag (Docker Hub)**:
  - `yehosoft/yehosoftdocs-runtime:8.3.3-backup-pre-mobile-branding`
  - Backup Digest: `sha256:f8e4512b2847efc143cdc5dd37b9ad4fb851f209ed4cdd6ae8cec6fda8f41074`

---

## 1. 变更范围与交付内容 (Scope of Changes)
本次发布严格限定于**移动端品牌视觉一致性补丁**，不包含任何业务代码修改或未经验证的原型：
- **包含内容**：
  1. 移动端 6 个核心 Logo 资产更新（SVG 与无损 PNG）。
  2. 独立品牌补丁：`patches/branding/mobile-branding.patch` (SHA256: `868c37b2261f7b979c8edfbf794bb851af4e5bf9476988aa59d0ef1c88d39e97`)。
  3. 自动化前端构建与移动端资源同步脚本：`scripts/build-web-apps.sh`。
  4. 纯前端层叠镜像 Dockerfile：`docker/Dockerfile.branding-fixed`。
  5. 构建与回滚指引文档：`docs/mobile-branding-build-and-rollback.md`。
- **排除内容**：
  - 不包含 AI 模拟插件原型或任何测试文档。
  - 不修改 `latest` 标签。
  - 不包含任何密钥、凭证或生产环境 `.env` 文件。

---

## 2. 真实验证状态记录 (Verification Status)

> [!NOTE]
> 记录基于真实端到端测试，区分已验收项与尚未验收项：

| 模块 / 平台 | 验证项 | 验证状态 | 说明 |
| :--- | :--- | :--- | :--- |
| **移动端 (Flutter / iOS / Android)** | 文档编辑器顶部导航栏 Logo | **已验收通过** | 显示与 Web 端一致的 YehosoftDocs 品牌标识 |
| **移动端 (Flutter / iOS / Android)** | "关于" (About) 对话框 Logo | **已验收通过** | 浅色模式显示正常，保留 ONLYOFFICE 及 AGPLv3 归属声明 |
| **移动端 (Flutter)** | 表格编辑器 (Spreadsheet) | **待验收** | 顶栏与关于页尚未进行 Flutter 端到端截屏验收 |
| **移动端 (Flutter)** | 演示编辑器 (Presentation) | **待验收** | 顶栏与关于页尚未进行 Flutter 端到端截屏验收 |
| **移动端 (Flutter)** | 移动端深色模式 (Dark Theme) | **待验收** | 深色关于页 Logo (`logo-new-white.svg`) 待真机环境验收 |
| **移动端 (Flutter)** | 移动端编辑保存与回调全链路 | **待验收** | 尚未在移动端进行编辑回写回归测试 |
| **桌面端 (PC Web)** | 品牌与编辑功能回归 | **已验收通过** | 保持原有 YehosoftDoc 品牌与完整编辑功能 |

---

## 3. 架构兼容性说明 (Architecture)
- **镜像架构**：`linux/amd64`
- **说明**：远端原有基础镜像（digest `sha256:f8e4512b2847efc143cdc5dd37b9ad4fb851f209ed4cdd6ae8cec6fda8f41074`）即为纯 `linux/amd64` 单架构镜像，本次发布保持同架构更新，不存在丢失多架构支持的情况。

---

## 4. 联调方容器更新与回滚操作 (Ops Instructions)

### 更新命令
```bash
# 1. 拉取最新发布镜像
docker pull yehosoft/yehosoftdocs-runtime:8.3.3
# 或
docker pull yehosoft/yehosoftdocs-runtime:8.3.3-edms3

# 2. 重新启动服务容器（以实际容器名或 docker-compose 为准）
docker-compose down && docker-compose up -d
```

### 回滚命令
```bash
# 若出现异常，立即回滚至保留的备份镜像：
docker pull yehosoft/yehosoftdocs-runtime:8.3.3-backup-pre-mobile-branding
docker tag yehosoft/yehosoftdocs-runtime:8.3.3-backup-pre-mobile-branding yehosoft/yehosoftdocs-runtime:8.3.3
docker restart <container_name>
```
