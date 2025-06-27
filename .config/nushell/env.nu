# argc-completions 补全
$env.ARGC_COMPLETIONS_ROOT = 'C:\Users\86181\AppData\Roaming\nushell\argc-completions'
$env.ARGC_COMPLETIONS_PATH = ($env.ARGC_COMPLETIONS_ROOT + '\completions\windows;' + $env.ARGC_COMPLETIONS_ROOT + '\completions')
$env.Path = ($env.Path | prepend ($env.ARGC_COMPLETIONS_ROOT + '\bin'))
argc --argc-completions nushell | save -f 'C:\Users\86181\AppData\Roaming\nushell\argc-completions\tmp\argc-completions.nu'
source 'C:\Users\86181\AppData\Roaming\nushell\argc-completions\tmp\argc-completions.nu'


# zoxide文件跳转
zoxide init --cmd cd nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu


$env.config.buffer_editor = "neovide"
$env.config = {
 keybindings: [
  {
    name: fuzzy_history_fzf
    modifier: control
    keycode: char_r
    mode: [emacs , vi_normal, vi_insert]
    event: {
      send: executehostcommand
      cmd: "commandline edit --replace (
        history
          | where exit_status == 0
          | get command
          | reverse
          | uniq
          | str join (char -i 0)
          | fzf --scheme=history --read0 --tiebreak=chunk --layout=reverse --preview='echo {..}' --preview-window='bottom:3:wrap' --bind alt-up:preview-up,alt-down:preview-down --height=70% -q (commandline) --preview='echo -n {} | nu --stdin -c \'nu-highlight\''
          | decode utf-8
          | str trim
      )"
    }
  }

  {
    name: fuzzy_file_fzf
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: {
        send: executehostcommand
        # cmd: "commandline edit --replace (
        #     ls | get name
        #        | fzf --layout=reverse --preview='bat --style=numbers --color=always --line-range=:500 {}' --preview-window='right:50%:wrap' --height=70%
        #        | decode utf-8
        #        | str trim
        # )"
        cmd: "fzf --layout=reverse --preview='bat --style=numbers --color=always --line-range=:500 {}' --preview-window='right:50%:wrap' --height=70%"
    }
  }
]  
show_banner: false
}
$env.config.highlight_resolved_externals = true
$env.config.color_config = {
    shape_external_resolved: green
    shape_internalcall: green
    shape_external: white
    shape_externalarg: white
    shape_string: white
    shape_directory: purple_underline
    shape_filepath: purple_underline
}
$env.config.history.max_size = 10000
$env.config.history.file_format = "sqlite" # 将历史记录保存到数据库，而不是 txt 文件
$env.config.completions.external.max_results = 20

