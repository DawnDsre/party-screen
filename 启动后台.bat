@echo off
chcp 65001 >nul
REM ================================================================
REM  党建电视大屏 · 后台管理一键启动
REM  固定域名：https://dawndsre.github.io/party-screen/admin.html
REM  说明：打开后台登录页，填入 GitHub 仓库信息与 PAT 后即可编辑发布
REM ================================================================
echo 正在打开党建大屏后台管理 ...
echo 地址：https://dawndsre.github.io/party-screen/admin.html
start "" msedge "https://dawndsre.github.io/party-screen/admin.html"
echo.
echo 提示：后台显示的数据均已脱敏，公开发布不含任何真实姓名 / 手机号 / 身份证 / 邮箱。
echo 若未打开，请确认本机已安装 Microsoft Edge。
pause
