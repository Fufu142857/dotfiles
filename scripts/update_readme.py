### Wiritten by Gemini 3 pro

import os
import sys

readme_path = "README.md"

# 读取刚才生成的树状图
with open("tree.tmp", "r", encoding="utf-8") as f:
    tree_data = f.read().strip()

with open(readme_path, "r", encoding="utf-8") as f:
    content = f.read()

start_mark = ""
end_mark = ""

if start_mark in content and end_mark in content:
    pre = content.split(start_mark)[0]
    post = content.split(end_mark)[1]

    # 拼接新的内容
    new_content = (
        pre + start_mark + "\n```text\n" + tree_data + "\n```\n" + end_mark + post
    )

    with open(readme_path, "w", encoding="utf-8") as f:
        f.write(new_content)
    print("✓ 树状图已成功插入 README！")
else:
    print("⚠ 错误: README 中找不到 或 标记。")
