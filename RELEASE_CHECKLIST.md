# Mr.shaw deployment release checklist

## MR-20261008-NODE-RELAY-SOURCES 配对登记（本地，未发布）

本轮scripts安装/更新代码、命令、镜像地址、固定Xray v26.3.27、证书与目录无变化；仅配对说明，未推送本轮资料。主控增加Node来源API/迁移和独立管理弹窗；Node新增managed-node-relay-v1认证快照/监听进程。两边镜像尚未构建发布，不提供当前生产更新指令作为已发布功能。

发布后已切Fork的服务器先在承担来源的Node执行marzban-node update，核对能力/连接/核心，再在主控执行marzban update；仅作目标的既有配对Node不强制更新。无需重复adopt/install或额外转发软件；在源服务器放行业务入口TCP端口。新服务器继续原一键install，保留旧服务器数据、.env、证书、控制/API端口与卷。正式发布需登记配对SHA、Actions、两镜像架构摘要及服务器验收，当前均待执行。

[主控管理接口与范围](https://github.com/kissow/Marzban/blob/master/docs/NODE_RELAY_SOURCES.md)；[Node线协议](https://github.com/kissow/Marzban-node/blob/master/docs/node-relay.md)。新链接本轮上传后才公开可用。下方旧发布证据不代替本轮。


## MR-20261003-EGRESS-UDP (2026-10-03)

- [x] Paired documentation published at scripts revision `23c6dffe006eea30e117ffc86972f5fc94eab33d`; [syntax and Fork target checks](https://github.com/kissow/Marzban-scripts/actions/runs/37119329541) succeeded.
- [x] Scripts runtime unchanged: install/adopt/update, certificates, ports, data paths and pinned Xray `v26.3.27` retained. No scripts image build is required.
- [x] Panel image source `10f46df8e52ad24c79a1d4a1aafc020a7f7ad335` and Node image source `ff3ed8affb43a7c0be84b7404b25ba149cd9c805` built successfully. Both latest image architectures and OCI revisions verified; see [panel evidence](https://github.com/kissow/Marzban/blob/master/docs/EGRESS_UDP_RELEASE.md) and [Node evidence](https://github.com/kissow/Marzban-node/blob/master/docs/egress-udp-release.md).
- [x] Existing switched Fork servers use `marzban-node update` first, then `marzban update`; no repeated adopt/reinstall or volume deletion. Back up and verify existing data before updating.
- [x] Existing egress API paths/authentication retained; optional `udp_mode` and Node capability `managed-outbounds-udp-v1` documented in paired repositories. Old profiles default to legacy; TCP-only is not arbitrary UDP-to-TCP conversion.
- [ ] Actual server authenticated pairing, provider TCP53, residential exit IP, v2rayNG/Clash Meta behavior and UDP-capable provider regression accepted.
- [ ] Actual original-component desktop/mobile screenshots reviewed.
- [ ] Legacy rollback and non-DNS UDP application behavior accepted on the actual servers.

Images published and server acceptance are separate states. This checklist is not a stable-release claim. Later documentation-only commits use `[skip ci]`; they do not replace image source revisions or prior Actions evidence.
