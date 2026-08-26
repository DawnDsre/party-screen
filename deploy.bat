@echo off
chcp 65001 >nul
echo ============================================================
echo   党建大屏 GitHub Pages 一键部署脚本（Windows）
echo   请在「已解压的 party-github-pages 目录」里双击本文件运行
echo ============================================================
echo.
echo 【前置检查】
where git >nul 2>nul
if errorlevel 1 (
  echo [错误] 未检测到 Git。请先安装：https://git-scm.com/download/win
  echo          安装时一路 Next，勾选 "Add Git to PATH"。装完重开此窗口。
  pause
  exit /b 1
)
echo Git 已就绪。
echo.
echo 【第 1 步：填写你的 GitHub 仓库地址】
echo   例：https://github.com/你的用户名/party-screen.git
echo   （仓库请先在 github.com 上新建，名字任意，可见性选 Public）
echo.
set /p REPO_URL="粘贴仓库地址后回车： "
if "%REO_URL%"=="" set "REO_URL=%REPO_URL%"
if "%REPO_URL%"=="" (
  echo [错误] 仓库地址不能为空。
  pause
  exit /b 1
)
echo.
echo 【第 2 步：初始化并上传】
git init -b main
git add -A
git commit -m "初始化党建大屏（GitHub Pages 部署）"
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main
if errorlevel 1 (
  echo.
  echo [提示] push 失败，常见原因：
  echo   1) 仓库地址填错 / 仓库不存在
  echo   2) 未登录 GitHub —— 请先运行一次： git config --global credential.helper manager
  echo      然后重新双击本脚本，push 时会弹出 GitHub 登录框
  echo   3) 仓库非空（已有文件）——可改执行： git pull origin main --rebase 后再 push
  pause
  exit /b 1
)
echo.
echo 【第 3 步：开启 GitHub Pages】
echo   请手动在浏览器操作（脚本无法代你点网页）：
echo   1) 打开仓库 → Settings → 左侧「代码、规划和自动化」→ Pages
echo   2) Build and deployment → Source 选 「GitHub Actions」
echo   3) 等 1-2 分钟，Actions 标签里 Deploy to GitHub Pages 变绿
echo   4) 回到 Settings → Pages，复制站点网址：
echo       固定网址 = https://你的用户名.github.io/party-screen/
echo.
echo 部署完成！固定网址：
echo   admin 后台： %REPO_URL%/admin.html   （把 .git 换成 /admin.html）
echo   大屏数据：   https://你的用户名.github.io/party-screen/screen-data.json
echo.
pause
