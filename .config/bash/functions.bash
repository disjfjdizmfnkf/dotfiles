# bash/functions.sh
# @author nate zhou
# @since 2025
# bash specific functions

osc7_cwd() { # new footclient in current working directory for bash
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd

help() { # read help with a pager
    help_output=$(command help "$@")
    [ "$?" -eq 0 ] && echo "$help_output" | /usr/bin/less -i
}

