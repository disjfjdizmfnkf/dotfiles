# 别名配置 
alias vim = neovide
alias vi = nvim
alias g = git
alias lg = lazygit
alias ff = fastfetch
alias c = clear
alias tig = ^"C:/Program Files/Git/usr/bin/tig.exe"
alias less = ^"C:/Program Files/Git/usr/bin/less.exe"
alias oe = explorer
alias snv = sudo nvim

# 自定义函数: 更新 hosts 文件 (等效于 Git Bash 脚本)
def upHost [] {
    let bash_script = '''
        _hosts=$(mktemp /tmp/hostsXXX);
        hosts="/c/Windows/System32/drivers/etc/hosts";
        remote="https://raw.hellogithub.com/hosts";
        reg="/# GitHub520 Host Start/,/# Github520 Host End/d";
        sed "$reg" $hosts > "$_hosts";
        curl "$remote" >> "$_hosts";
        cat "$_hosts" > "$hosts";
        rm "$_hosts";
    '''
    
    # 调用 Git Bash 执行脚本
    ^"C:/Program Files/Git/git-bash.exe" -c $bash_script
}

# 添加运行 shell 脚本的命令
def run-sh [script_path: path] {
    if ((which bash | length) > 0) {
        ^bash $script_path
    } else if ((which git | length) > 0) {
        # 假设 Git Bash 安装在标准位置
        ^"C:/Program Files/Git/bin/bash.exe" $script_path
    } else if ((which wsl | length) > 0) {
        ^wsl bash $script_path
    } else {
        echo "错误: 未找到可用的 bash 解释器。请安装 Git Bash, WSL 或其他提供 bash 的工具。"
    }
}

# 添加一个用于直接执行 bash 命令的便捷函数
def bash [command: string] {
    # 直接使用提供的 Git Bash 路径
    if (ls "C:/Program Files/Git/git-bash.exe" | length) > 0 {
        ^"C:/Program Files/Git/git-bash.exe" -c $command
    } else if ((which bash | length) > 0) {
        ^bash -c $command
    } else if ((which git | length) > 0) {
        ^"C:/Program Files/Git/bin/bash.exe" -c $command
    } else if ((which wsl | length) > 0) {
        ^wsl bash -c $command
    } else {
        echo "错误: 未找到可用的 bash 解释器。请安装 Git Bash, WSL 或其他提供 bash 的工具。"
    }
}

def nufzf [] {$in | each {|i| $i | to json --raw} | str join "\n" | fzf  | from json}
