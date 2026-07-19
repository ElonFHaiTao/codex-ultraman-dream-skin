# Codex 奥特曼风 · 星穹守望

基于 [Fei-Away/Codex-Dream-Skin](https://github.com/Fei-Away/Codex-Dream-Skin) 的 Windows 定制版。主题使用原创“光之巨人”角色与红银、深空蓝、能量青配色，不包含官方角色图、商标或 UI 截图。

![主题预览](preview.jpg)

## 视觉设计

- 右侧为原创红银光之守护者，左侧保留 Codex 导航与文字安全区。
- 2560 × 1440 连续壁纸，不把侧栏、卡片或输入框画进背景。
- 首页保持宇宙氛围；任务页使用 `ambient` 模式降低背景干扰。
- 深色外观，青色为交互强调色，红色用于点缀。
- 当前 Codex 不提供原生建议卡时，首页会显示非交互的主题标语与在线状态，不伪装原生按钮。
- 输入区域使用纯白文本光标和青色双层聚焦边框，确保深色背景下位置清晰。

## 一键安装与启动（Windows）

1. 从 [Releases](https://github.com/ElonFHaiTao/codex-ultraman-dream-skin/releases/latest) 下载 ZIP 并完整解压。
2. 保存当前工作并退出 Codex。
3. 双击解压目录中的：

```text
launcher\Codex 奥特曼主题.exe
```

启动器不会显示 CMD 黑框，会自动检查环境、安装或切换主题，并在需要时重启 Codex。以后继续使用这个 EXE 或它创建的桌面快捷方式启动即可。

如果 EXE 被安全软件拦截，也可以双击根目录的 `一键启动奥特曼主题.cmd`。失败时会显示原因，并把详细日志写入 `%LOCALAPPDATA%\CodexDreamSkin\one-click.log`。

## 命令行安装（可选）

1. 完全关闭 Codex。
2. 在本目录打开 PowerShell，执行：

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\windows\scripts\install-dream-skin.ps1
   powershell -ExecutionPolicy Bypass -File .\windows\scripts\start-dream-skin.ps1
   ```

以后可使用桌面快捷方式启动，也可以从系统托盘暂停、恢复或切换主题。

## 验证与恢复

验证注入：

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\scripts\verify-dream-skin.ps1
```

恢复 Codex 官方外观：

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\scripts\restore-dream-skin.ps1
```

## 说明

- 不修改 `WindowsApps`、`app.asar`、官方签名、账号或 API 配置。
- 主题通过仅绑定 `127.0.0.1` 的本机 CDP 注入；启用期间只运行可信本机程序。
- 当前 Microsoft Store 版 Codex 会优先使用应用自带的 Node.js；其他安装方式可能需要 Node.js 22 或更高版本。
- 这是非官方同人风格主题，与奥特曼版权方、OpenAI 或 Codex 无关联。
- 引擎代码沿用上游 MIT 许可；新壁纸为本次任务生成的原创素材。
