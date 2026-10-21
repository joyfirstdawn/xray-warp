# Render 部署 v2: Xray 前门 + 服务端 WARP 出口 (usque MASQUE)
结构: 你的 Clash -> 本服务 (VLESS+WS, Render 域名) -> usque MASQUE 隧道 -> Cloudflare WARP 出口 (warp=on)
- WARP 在服务器端连接, 不受用户本地 UDP 被拦影响; 客户端只走普通 WS/TCP
- UUID / WS 路径同部署包: /ray-d2aa2008
- usque 设备在容器首次启动时自动注册 (免费 WARP), 重启/重部署会重新注册, 属正常
- 若部署日志里 MASQUE (HTTP/3) 连不上, 在 Render 环境变量加 USQUE_HTTP2=1 改走 HTTP/2 再重新部署
- Free 实例 15 分钟无流量休眠, 唤醒约 1 分钟; 出站额度有限, 验证/轻量使用
部署步骤同 v1: New -> Web Service -> Docker -> Free
