# Mr.shaw Marzban-scripts Fork 更新记录

本文件记录相对 [Gozargah/Marzban-scripts](https://github.com/Gozargah/Marzban-scripts) 的新增与调整。感谢原作者和贡献者，保留上游 Git 历史与许可证。

## 正式版核心一致性闸门（2026-09-30，未发布）

- `install_latest_xray.sh` 安装前校验下载的 Xray 二进制版本必须与显式请求的版本一致。
- 正式安装和更新继续以 `v26.3.27` 为唯一默认核心，错误版本会中止，不会静默覆盖现有核心。

## 开发中（尚未发布）

- 安装和更新脚本改为从 `kissow/Marzban`、`kissow/Marzban-node` 与 `kissow/Marzban-scripts` 读取文件，并拉取 `ghcr.io/kissow/` 的 Fork 镜像。
- 新增 `marzban adopt` 与 `marzban-node adopt`：已有官方安装可在原目录切换镜像，保留 `.env`、数据库、证书和 Compose 的其他配置。
- `update` 会先备份并验证原数据目录，再拉取自己的镜像；不执行 `down -v`。
- `install` 遇到已有目录会退出，防止覆盖现有配置和用户数据。
- 手动 `backup` 不再清空整个旧备份目录，每次使用独立临时目录。

发布前仍需在隔离 Linux 服务器验证 SQLite/MySQL/MariaDB 的数据保留、Node 证书、镜像拉取和 `marzban update` 的实际行为。
