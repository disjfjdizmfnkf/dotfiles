
############
# FUNCTION #
############

function tmuxInit() {
  if [[ -z $TMUX ]]; then
    # Get the session IDs
    session_ids="$(tmux list-sessions 2>/dev/null)"

    # Create new session if no sessions exist
    if [[ -z "$session_ids" ]]; then
      tmux new-session
    else
      # Select from existing sessions or create a new one
      create_new_session="Create new session"
      choices="$(echo -e "$session_ids\n${create_new_session}\n")"
      choice="$(echo -e "$choices" | fzf | cut -d: -f1)"

      if [[ $choice =~ ^[0-9]+$ ]]; then
        # Attach existing session
        tmux attach-session -t "$choice"
      elif [[ "$choice" == "$create_new_session" ]]; then
        # Create new session
        tmux new-session
        :
      fi
    fi
  fi
}

function startTmux() {
  # Start the tmux session if not already in a tmux session
  if [[ -z $TMUX ]]; then
    # Get the list of existing sessions
    session_ids="$(tmux list-sessions 2>/dev/null | awk -F: '{print $1}')"

    if [[ -z "$session_ids" ]]; then
      # Create a new session named "1" if no sessions exist
      tmux new-session -s "1"
    else
      # Attach to the latest session
      latest_session=$(echo "$session_ids" | tail -n 1)
      tmux attach-session -t "$latest_session"
    fi
  fi
}

function proxyOn() {
  local port="${1:-10808}";
  local protocol="${2:-socks5}";

  case "$protocol" in
    "http")
      export http_proxy="http://127.0.0.1:$port";
      export https_proxy="http://127.0.0.1:$port";
      ;;  
    "socks5")
      export http_proxy="socks5://127.0.0.1:$port";
      export https_proxy="socks5://127.0.0.1:$port";
      ;;
    *)
      echo "不支持协议: $protocol"
      return 1
      ;;
  esac

  echo "🚀protocol: $protocol, port: $port";
}

# 取消代理
function proxyOff() {
  unset http_proxy;
  unset https_proxy;
  echo "🚫CLI Proxy disabled"
}

# Automatically do an ls after each cd, z, or zoxide
function cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

# Create and go to the directory
function mkdirg() {
  mkdir -p "$1"
  cd "$1"
}

function fzf-file-widget() {
    local files
    files=$(find . -type f | fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --height 65% --tmux bottom,40% --layout reverse --border top )
    if [[ -n "$files" ]]; then
        nvim "$files"  # 或使用任何你想用来打开文件的命令@
    fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# 临时覆盖包搜索函数 (消除执行错误命令时的延迟)
# function command_not_found_handler() {
#     echo "zsh: command not found: $1" >&2
#     return 127
# }

############
#   导出   #
############

# 导出bash环境
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

# rustup
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
# rustup end

# pnpm
export PNPM_HOME="/home/dtc/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# nvm start
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# nvm end

###############
# omz plugins #
###############

plugins=(
    z
    git
    archlinux
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    vi-mode
    copypath
    fzf-tab
)

############
#  启动项  #
############

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo
source <(fzf --zsh) # Set-up FZF key bindings (CTRL R for fuzzy history finder)

startTmux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
# pokemon-colorscripts --no-title -s -r

# fastfetch. Will be disabled if above colorscript was chosen to install
# fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc


############
# 设置别名 #
############

# 目录切换
alias home='cd ~'
alias desk='cd ~/Desktop/'
alias dotfiles='cd ~/dotfiles/'
alias download='cd ~/Downloads/'
alias github='windows-valut'
alias windows-valut='cd /home/dtc/Data/500-dtc/'
alias linux-valut='cd /home/dtc/workspace/'

# 文件夹权限
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# pacman yay
alias pacy='sudo pacman -Syy'
alias pacu='sudo pacman -Syu'
alias pacup='pacu;pacy'
alias yayp='yay -Ps'
alias yayu='yay -Syu'
alias yayy='yay -Syy'
alias yayup='yayu;yayy'
alias refreshMirror='sudo reflector --verbose -c China --latest 12 --sort rate --threads 100 --save /etc/pacman.d/mirrorlist' # 排序并写入pacman 镜像源

# Set-up packages
alias c='clear'
alias ls='eza --icons'
alias lsa='eza -ah --icons'
alias lsh='eza -a --icons -d .*'
alias ll='eza -l --icons'
alias lla='eza -al --icons'
alias llh='eza -al --icons -d .*'
alias lf="ls -l | egrep -v '^d'" # 只显示文件
alias lt='eza -a --tree --level=3 --icons'
alias cls='clear'
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias rmd='/bin/rm  --recursive --force --verbose '
alias ping='ping -c 10'
alias less='less -R'
alias svi='sudo vim'
alias nv='neovim'
alias snv='sudo -e nvim'
alias icat='kitty +kitten icat'
alias pytorch='conda activate pytorch'
alias mkdocs='conda activate mkdocs'
alias base='codna activate base'
#alias g='git'
#alias obsidian='obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime'
#alias qq='linuxqq --ozone-platform-hint=auto --enable-wayland-ime'

# 其他工具
alias volumeList="pactl list shink-inputs"  # show volume input list
# alias stow="stow"  # 将这个写到这里只是为了让我不要忘记还有这样一个好用的工具

function upHost() {
   sudo sh -c 'sed -i "/# GitHub520 Host Start/q" /etc/hosts && curl -s https://raw.hellogithub.com/hosts >> /etc/hosts'
}

# 查ip
alias ipcn="curl myip.ipip.net"
alias ip="curl ip.sb"


# 终端玩具
alias pokemon='pokego --no-title -r 1,3,6'
# alias pokemon='pokemon-colorscripts --no-title -s -r'
alias bat='bat --paging=auto'
alias tclock='tty-clock -c -b -s -C 7'
alias cmatrix='cmatrix -ba -u 2 -C white'
alias ff='fastfetch'
alias pf='pokemon | fastfetch --file-raw -'
alias nf='neofetch --ascii $HOME/.config/neofetch/logo'
alias sl='sl -e'


#################
#  keyBindings  #
#################


# ctrl+F 搜索当前目录下的文件
bindkey '^F' fzf-file-widget  # fzf-file-widget can be find in FUNCTION


###############
#    prxoy    #
###############

# 设置代理端口变量
DEFAULT_PORT=10808

# function proxyOn
# function proxyOff

####################
# Anaconda 环境变量#
####################

# 都写到bash的环境变量中了
# alias conda='~/software/anaconda3/bin/conda'
# export PATH=~/software/anaconda3/bin:$PATH
# # 使用 Anaconda python包
# export PYTHONPATH="/home/dtc/software/anaconda3/lib/python3.12/site-packages:$PYTHONPATH"

#################
#      zsh      #
#################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# zsh外观
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# 使用starship的主题
eval "$(starship init zsh)"


