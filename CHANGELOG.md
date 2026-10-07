# Mr.shaw Marzban-scripts Fork 更新记录

## MR-20261008-NODE-RELAY-SOURCES 配对登记（本地，未发布）

本轮scripts安装/更新代码、命令、镜像地址、固定Xray v26.3.27、证书与目录无变化；仅配对说明，未推送本轮资料。主控增加Node来源API/迁移和独立管理弹窗；Node新增managed-node-relay-v1认证快照/监听进程。两边镜像尚未构建发布，不提供当前生产更新指令作为已发布功能。

发布后已切Fork的服务器先在承担来源的Node执行marzban-node update，核对能力/连接/核心，再在主控执行marzban update；仅作目标的既有配对Node不强制更新。无需重复adopt/install或额外转发软件；在源服务器放行业务入口TCP端口。新服务器继续原一键install，保留旧服务器数据、.env、证书、控制/API端口与卷。正式发布需登记配对SHA、Actions、两镜像架构摘要及服务器验收，当前均待执行。

[主控管理接口与范围](https://github.com/kissow/Marzban/blob/master/docs/NODE_RELAY_SOURCES.md)；[Node线协议](https://github.com/kissow/Marzban-node/blob/master/docs/node-relay.md)。新链接本轮上传后才公开可用。下方旧发布证据不代替本轮。


## MR-20261003-EGRESS-UDP：配对部署文档（2026-10-03）

- scripts 仅更新文档；Bash 运行时、命令、镜像来源、固定核心 v26.3.27、证书、端口和数据路径无变化，不构建新的 scripts 容器。
- 配对主面板 `10f46df8e52ad24c79a1d4a1aafc020a7f7ad335` / Node `ff3ed8affb43a7c0be84b7404b25ba149cd9c805` 新增 `udp_mode` 和 `managed-outbounds-udp-v1`；新模式需要两边更新，先 Node 后主面板。既有 Fork 继续 update，不重复 adopt/reinstall。
- UDP DNS TCP 兼容、供应商限制和待验收项目均在 README 和两边协议文档登记；代码推送、Actions、镜像发布与服务器验收是不同状态，以配对仓库发布证据为准。

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
