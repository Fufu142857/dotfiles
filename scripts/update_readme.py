### Wiritten by Gemini 3 pro

import sys

readme_path = "README.md"

# 读取临时树状图
try:
    with open("tree.tmp", "r", encoding="utf-8") as f:
        tree_data = f.read().strip()
except FileNotFoundError:
    print("⚠ 错误: 找不到 tree.tmp 文件。")
    sys.exit(1)

with open(readme_path, "r", encoding="utf-8") as f:
    content = f.read()

header = "## 📂 Project Structure\n"
next_header = "\n## "

if header in content:
    # 拆分上半部分（包含该标题）
    parts = content.split(header, 1)
    pre_content = parts[0] + header
    rest_content = parts[1]

    # 寻找下一个标题的位置
    if next_header in rest_content:
        post_parts = rest_content.split(next_header, 1)
        post_content = next_header + post_parts[1]
    else:
        post_content = "\n"

    # 将树状图准确拼接在两个标题之间
    new_content = pre_content + "\n```text\n" + tree_data + "\n```\n" + post_content

    with open(readme_path, "w", encoding="utf-8") as f:
        f.write(new_content)
    print("✓ 完美！树状图已成功读取并插入。")
else:
    print("⚠ 错误: README 中找不到 '## 📂 Project Structure' 这个标题。")
