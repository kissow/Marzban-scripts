# Mr.shaw 部署脚本 Fork

基于 Gozargah/Marzban-scripts 的开源扩展，保留上游历史、作者致谢与许可证。提供 Fork 镜像的一键install、原安装adopt与保留数据update；不使用重装或删卷来更新已有服务器。

## MR-20261008-NODE-RELAY-SOURCES（配对文档，本地未发布）

本轮脚本运行时代码和命令无变化，不构建脚本镜像。配对主控与Node新增来源选择、managed-node-relay-v1、原认证控制快照；发布后先更新承担来源的Node，再更新主控，保留既有证书、控制/API端口、用户数据和固定核心v26.3.27。新业务监听端口在选定来源上放行，不增加监控端口。

详细 [升级范围与控制接口](https://github.com/kissow/Marzban/blob/master/docs/NODE_RELAY_SOURCES.md) 与 [Node协议](https://github.com/kissow/Marzban-node/blob/master/docs/node-relay.md) 本轮上传后公开可用；本轮提交/Actions/镜像/服务器验收均未执行。此前发布记录不能代替当前配对证据。新机使用install，已切Fork使用update，不重复adopt。
