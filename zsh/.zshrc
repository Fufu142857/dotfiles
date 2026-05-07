# ==============================================================================
# STAGE 0: Instant Prompt 
# ==============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# STAGE 1: 环境变量 & 路径管理 
# ==============================================================================

# # 1. 加载敏感信息 (eg. API Keys)
# if [[ -f ~/.zsh_secrets ]]; then
#     source ~/.zsh_secrets
# fi

# 2. 网络配置
export https_proxy=http://127.0.0.1:7897
export http_proxy=http://127.0.0.1:7897
export all_proxy=socks5://127.0.0.1:7897

# 3. 语言与编辑器设置
export LANG=en_US.UTF-8
export EDITOR='nvim'

# 4. PATH 管理
typeset -U path
# !!!越在前面优先级越高
path=(
    # Homebrew 核心 
    /opt/homebrew/bin
    /opt/homebrew/sbin
    # Python 
    /opt/homebrew/opt/python@3.9/bin
    # 用户个人工具
    $HOME/.local/bin
    # Ruby (原有配置)
    /opt/homebrew/opt/ruby/bin
    # vimgolf
    /opt/homebrew/lib/ruby/gems/3.4.0/bin

    # 系统自带 (作为兜底)
    $path
)

# 5. 开启命令行编辑器支持
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^g' edit-command-line

# ==============================================================================
# STAGE 2: 框架 & 插件配置
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 插件列表
plugins=(
    git
    # 未来会加 z (快速跳转) 或 extract (万能解压)
)

source $ZSH/oh-my-zsh.sh

# 加载外部插件[使用检测逻辑]
# 高亮
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# 自动建议
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 设置 vimgolf defalt = nvim
export GOLFVIM="vimgolf-nvim"

# ==============================================================================
# STAGE 3: 个性化定义[别名 & 脚本]
# ==============================================================================

# See you again!
# 关机
alias seeu='sudo shutdown -h now'

# Python 3.9
alias python='/opt/homebrew/bin/python3.9'
alias python3='/opt/homebrew/bin/python3.9'
alias pip='/opt/homebrew/bin/pip3.9'
alias pip3='/opt/homebrew/bin/pip3.9'
# 检查是哪个python
alias pyver='python --version && which python'

# Loop up oxford dict 
# 显示和mac内置词典相同
alias ox='~/.local/bin/oxford_lookup.py'

# Open Chrome in full-screen
alias chrome='osascript -e "tell application \"Google Chrome\" to activate" -e "delay 0.5" -e "tell application \"System Events\" to keystroke \"f\" using {control down, command down}"'

# Synchronize with my dotfiles
# 利用 Github 同步我的终端配置
alias dotsync="bash ~/dotfiles/scripts/sync.sh"

# gitacp
# Git 自动提交脚本
function gitacp() {
    git add .
    echo -n "💬 请输入 Commit 信息: "
    read msg
    if [ -z "$msg" ]; then
        msg="Update (Auto-committed)"
    fi
    git commit -m "$msg"
    git push
    echo "🚀 Ok Fine Update!!!"
}

# myTodo
# 待办事项插件
if [[ -f ~/.mytodo/core.sh ]]; then
    source ~/.mytodo/core.sh
fi

# Typora
# 建立 markdown 文件并用 Typora 打开
function ty() {
  # 如果没传参数，直接打开 Typora 程序本身
  if [ -z "$1" ]; then
    open -a "Typora"
    return
  fi
  # 处理文件名：去掉可能存在的 .md 后缀再统一补上
  local FILE="${1%.md}.md"
  # 如果文件不存在则创建
  if [ ! -f "$FILE" ]; then
    touch "$FILE"
  fi
  # 使用 Typora 打开
  open -a "Typora" "$FILE"
}

# Fucking World(For fun)
function fuck() {
    echo "What a fucking world!"
    echo ""
    echo "Rest now, ☕️."
}

# md2pdf
# pandoc & typst
function md2pdf() {
    if [ -z "$1" ]; then
        echo "Error: Missing input file."
        echo "Usage: md2pdf <filename.md>"
        return 1
    fi
  
    local FILE="${1%.*}"
    echo "Compiling $1 ..."
  
    pandoc "$1" -o "${FILE}.pdf" --pdf-engine=typst --template="$HOME/.config/pandoc/typst_template.typ"
  
    if [ $? -eq 0 ]; then
        echo "Done: ${FILE}.pdf"
    else
        echo "Error: Compilation failed."
    fi
}

# ==============================================================================
# STAGE 4: 渲染界面
# ==============================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

