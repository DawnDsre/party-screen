#!/usr/bin/env bash
# 党建大屏 GitHub Pages 一键部署脚本（macOS / Linux）
# 用法：在解压的 party-github-pages 目录里执行  bash deploy.sh
set -e
echo "============================================================"
echo "  党建大屏 GitHub Pages 一键部署脚本（macOS / Linux）"
echo "============================================================"
if ! command -v git >/dev/null 2>&1; then
  echo "[错误] 未检测到 Git，请先安装（Mac: brew install git；Linux: sudo apt install git）"
  exit 1
fi
echo "Git 已就绪。"
echo
echo "【第 1 步：填写你的 GitHub 仓库地址】"
echo "  例：https://github.com/你的用户名/party-screen.git"
read -rp "粘贴仓库地址后回车： " REPO_URL
if [ -z "$REPO_URL" ]; then echo "[错误] 仓库地址不能为空。"; exit 1; fi
echo
echo "【第 2 步：初始化并上传】"
git init -b main
git add -A
git commit -m "初始化党建大屏（GitHub Pages 部署）"
git remote add origin "$REPO_URL"
git branch -M main
git push -u origin main
echo
echo "【第 3 步：开启 GitHub Pages】"
echo "  请手动在浏览器操作："
echo "  1) 仓库 → Settings → 左侧「代码、规划和自动化」→ Pages"
echo "  2) Build and deployment → Source 选 「GitHub Actions」"
echo "  3) 等 1-2 分钟，Actions 里 Deploy to GitHub Pages 变绿"
echo "  4) Settings → Pages 复制站点网址："
echo "     固定网址 = https://你的用户名.github.io/party-screen/"
echo
echo "部署完成！后台地址（把 .git 换成 /admin.html）："
echo "  $REPO_URL/admin.html"
echo "大屏数据： https://你的用户名.github.io/party-screen/screen-data.json"
