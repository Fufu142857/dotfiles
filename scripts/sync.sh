#!/bin/bash

### Wiritten by Gemini 3 pro 

# 进入 dotfiles 目录工作
cd "$HOME/dotfiles" || exit

echo "--- 正在收集本地配置 ---"
mkdir -p bin nvim/colors zsh

# 复制文件
cp ~/.local/bin/trans bin/ 2>/dev/null || true
cp ~/.config/nvim/init.vim nvim/ 2>/dev/null || true
cp ~/.config/nvim/colors/vscode_theme.vim nvim/colors/ 2>/dev/null || true
cp ~/.zshrc zsh/ 2>/dev/null || true

echo "--- 正在生成目录树 ---"
# 将树状图输出到临时文件
tree -a -I '.git|.gitignore|scripts|README.md|*.tmp' > tree.tmp
# 调用独立的 Python 脚本处理文本
python3 scripts/update_readme.py
# 删除临时文件
rm tree.tmp

echo "--- 正在推送到远端 ---"
git add .
git commit -m "Sync: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✨ GitHub 主页已同步。"
