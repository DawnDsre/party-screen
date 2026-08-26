# 党建电视大屏 · GitHub Pages 联网部署指南

> 目标：让电视大屏（Win10/Win7 的 exe）连接到一个**你拥有的固定网址**，你在该网址的**后台登录、上传数据/文件**，电视大屏**每 15–30 秒自动拉取更新**。
> 整套方案**只依赖你的 GitHub 账号**，无需任何服务器、无需付费。

---

## 一、整体原理（先看这 1 分钟）

```
你（浏览器）               GitHub 仓库                电视大屏（exe）
   │                            │                          │
   │  ① 登录后台 admin.html     │                          │
   │     用 GitHub 令牌写数据   │                          │
   │ ───────────────────────►  │  data/party.json         │
   │                           │  screen-data.json ◄──────┤ ② 每 15s 拉取
   │                          【GitHub Pages 固定网址】    │    ./screen-data.json
   │                           │                          │
   │                           └─────────────────────────►│ ③ 自动刷新大屏
```

- **固定网址** = `https://<你的用户名>.github.io/<仓库名>/`（GitHub Pages 免费提供）
- **后台登录** = 打开 `admin.html`，填入你的 GitHub 令牌（PAT），即可编辑/上传
- **电视更新** = 在 exe 的「后台管理 → 远程数据源」里填上面的固定网址，电视自动联网

---

## 二、第 1 步：在 GitHub 创建仓库并上传文件

1. 打开 https://github.com/new
2. 仓库名建议：`party-screen`（这就是固定网址的一部分）
3. 可见性：**Public（公开）** —— 显示数据已脱敏（不含姓名/电话），公开安全；若要完全私有参见第五步
4. 勾选 **Add a README file**
5. 点 **Create repository**

6. 把本目录（`party-github-pages/`）里的文件上传到仓库根目录：
   - `index.html`、`admin.html`、`screen-data.json`
   - `data/party.json`（连同 `data/` 文件夹）
   - `.github/workflows/pages.yml`（连同 `.github/` 文件夹）
   - 方式：在仓库页面点 **Add file → Upload files**，把这几个文件拖进去，写提交说明「初始化党建大屏」后 **Commit changes**

   > 也可以点 **Add file → Create new file** 逐个粘贴，但上传文件夹更省事。

---

## 三、第 2 步：开启 GitHub Pages（得到固定网址）

1. 仓库页 → **Settings → Pages**（左侧栏）
2. **Build and deployment → Source** 选 **GitHub Actions**
3. 等待 1–2 分钟，Actions 自动运行（`pages.yml`）。运行成功后，顶部会出现：
   > Your site is live at https://<用户名>.github.io/party-screen/
4. 这个网址就是**固定网址**：
   - 大屏地址：`https://<用户名>.github.io/party-screen/screen-data.json`
   - 后台地址：`https://<用户名>.github.io/party-screen/admin.html`

   （若想用自己公司域名，把 `CNAME.example` 改名为 `CNAME` 写入域名并做 DNS 解析即可。）

---

## 四、第 3 步：登录后台，上传数据

1. 浏览器打开 `https://<用户名>.github.io/party-screen/admin.html`
2. 填写：
   - **仓库所有者**：你的 GitHub 用户名
   - **仓库名**：`party-screen`
   - **分支**：`main`
   - **GitHub Token（PAT）**：见下
3. 生成 PAT：打开 https://github.com/settings/tokens?type=beta
   - 点 **Generate new token**，勾选 **repo**（读写仓库）权限，过期可选 90 天或 No expiration
   - 复制生成的 `github_pat_xxx...`（只显示一次，保存好）
4. 点 **连接并加载数据**，即可看到支部信息 / 三会一课 / 党员名册（脱敏）/ 文件上传
5. 编辑后点 **保存并发布** → 数据写入仓库 `screen-data.json`，电视大屏 **30 秒内自动更新**

> 文件上传：在「文件上传」区选图片 → 上传到仓库 `uploads/`，会得到可引用网址。

---

## 五、第 4 步：让电视大屏连上固定网址

在电视电脑（Win10 或 Win7）上：

1. 打开 exe，按 `F12` 或点「浏览器打开后台」进入**后台管理**（地址类似 `http://127.0.0.1:8000/admin`）
2. 找到 **「远程数据源」** 输入框
3. 填入：`https://<用户名>.github.io/party-screen/screen-data.json`
4. 保存 → 回到大屏，**每 15 秒自动从固定网址拉取数据**；断网时自动回退本地数据

> 提示：地址填 **.json 文件** 即可直接拉取；若你以后改用带服务器的后端，填后端根地址（如 `https://xxx.onrender.com`）也会自动补 `/api/relay/screen-data`。

---

## 六、隐私与「私有仓库」选项

- 本方案的 `screen-data.json` 是**脱敏展示数据**（统计 + 会议 + 职务层级/部门，**不含姓名与电话**），公开仓库即可放心展示。
- 若你希望连脱敏数据也不公开，可把仓库设为 **Private**：
  - Settings → Change visibility → 设为私有
  - 私有仓库的 GitHub Pages 仅仓库协作者可访问；此时电视端拉取需带令牌，建议在「远程数据源」填 **带令牌的 raw 地址**：
    `https://<令牌>@raw.githubusercontent.com/<用户>/party-screen/main/screen-data.json`
  - 该令牌仅存于电视端浏览器 localStorage，不外泄即可。

---

## 七、常见问题

| 现象 | 原因 / 解决 |
|------|------|
| 后台连不上 | PAT 未勾 `repo` 权限；或仓库名/用户名填错；或令牌过期需重新生成 |
| 电视不更新 | 「远程数据源」地址是否填对（以 `.json` 结尾）；电视是否联网；GitHub Pages 是否部署成功 |
| 发布后大屏没变 | 等 30 秒自动刷新；或手动重启大屏 exe |
| 想改域名 | 用 `CNAME` 文件 + 域名 DNS 解析到 `<用户名>.github.io` |
| 数据想换回本地 | 清空「远程数据源」输入框并保存，大屏回退本地数据 |

---

## 八、文件说明

| 文件 | 作用 |
|------|------|
| `index.html` | 电视大屏页面，每 30 秒拉取 `screen-data.json` |
| `admin.html` | 后台管理，登录后编辑/上传，写入仓库 |
| `screen-data.json` | 电视拉取的脱敏展示数据（发布后生成） |
| `data/party.json` | 后台编辑的完整源数据 |
| `.github/workflows/pages.yml` | GitHub Pages 自动部署（Auto Deploy） |
| `CNAME.example` | 自定义域名模板 |
