#!/bin/bash

### Wiritten by Gemini 3 pro 

# Define Path
DOT_DIR="$HOME/dotfiles"
README="$DOT_DIR/README.md"

# 1. 自动收集系统中的最新配置
echo "--- 正在收集本地配置 ---"
mkdir -p "$DOT_DIR/bin" "$DOT_DIR/nvim/colors" "$DOT_DIR/zsh"

cp ~/.local/bin/trans "$DOT_DIR/bin/"
cp ~/.config/nvim/init.vim "$DOT_DIR/nvim/"
cp ~/.config/nvim/colors/vscode_theme.vim "$DOT_DIR/nvim/colors/"
cp ~/.zshrc "$DOT_DIR/zsh/.zshrc"

# 2. 生成实时目录树并更新 README
# 使用 tree 命令
echo "--- 正在更新 README 目录树 ---"
TREE_OUTPUT=$(tree -I '.git|.gitignore|scripts' "$DOT_DIR")

sed -i '' "//a\\
\`\`\`text\\
$TREE_OUTPUT\\
\`\`\`" "$README"

# 3. 推送到 GitHub
echo "--- 正在推送到远端 ---"
cd "$DOT_DIR" || exit
git add .
git commit -m "Sync: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✨ 完成！GitHub 主页已更新。"
