#!/bin/bash

### Wiritten by Gemini 3 pro 

# 定义路径
DOT_DIR="$HOME/dotfiles"
README="$DOT_DIR/README.md"

# 1. 自动收集本地配置
echo "--- 正在收集本地配置 ---"
mkdir -p "$DOT_DIR/bin" "$DOT_DIR/nvim/colors" "$DOT_DIR/zsh"

cp ~/.local/bin/trans "$DOT_DIR/bin/" 2>/dev/null || true
cp ~/.config/nvim/init.vim "$DOT_DIR/nvim/" 2>/dev/null || true
cp ~/.config/nvim/colors/vscode_theme.vim "$DOT_DIR/nvim/colors/" 2>/dev/null || true
cp ~/.zshrc "$DOT_DIR/zsh/.zshrc" 2>/dev/null || true

# 2. 生成实时目录树并更新 README
echo "--- 正在更新 README 目录树 ---"
TREE_OUTPUT=$(tree -I '.git|.gitignore|scripts|*.tmp' "$DOT_DIR")

# 使用 Python 进行绝对安全的文本替换
python3 -c '
import sys
readme_path = sys.argv[1]
tree_data = sys.argv[2]

with open(readme_path, "r", encoding="utf-8") as f:
    content = f.read()

start_mark = ""
end_mark = ""

if start_mark in content and end_mark in content:
    pre = content.split(start_mark)[0]
    post = content.split(end_mark)[1]
    new_content = pre + start_mark + "\n```text\n" + tree_data + "\n```\n" + end_mark + post
    with open(readme_path, "w", encoding="utf-8") as f:
        f.write(new_content)
    print("✓ 树状图已成功插入！")
else:
    print("⚠ 警告: 在 README 中找不到 或 标记！")
' "$README" "$TREE_OUTPUT"

# 3. 推送到 GitHub
echo "--- 正在推送到远端 ---"
cd "$DOT_DIR" || exit
git add .
git commit -m "Sync: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✨ 完成！GitHub 主页已更新。"
