@echo off
chcp 65001 >nul
REM ================================================================
REM  党建电视大屏 · 一键全屏启动（Microsoft Edge Kiosk 全屏模式）
REM  固定域名：https://dawndsre.github.io/party-screen/
REM  特点：免安装、无需服务器，双击即可让电视全屏展示大屏页面
REM ================================================================
echo 正在以全屏（Kiosk）模式打开党建电视大屏 ...
echo 地址：https://dawndsre.github.io/party-screen/
start "" msedge --kiosk "https://dawndsre.github.io/party-screen/" --edge-kiosk-type=fullscreen --no-first-run --no-default-browser-check
echo.
echo 提示：页面每 30 秒自动从固定域名拉取最新数据。
echo 退出全屏：按 Alt + F4，或打开任务管理器结束 msedge 进程。
echo 若未打开，请确认本机已安装 Microsoft Edge。
pause
