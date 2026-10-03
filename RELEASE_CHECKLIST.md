# Mr.shaw deployment release checklist

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
