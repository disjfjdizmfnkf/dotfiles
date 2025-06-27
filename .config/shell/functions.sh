# .config/shell/functions.sh
# @author nate zhou
# @since 2025
# general functions for bash/zsh

# cd into parent
Cd() {
    cd "$(dirname $1)"
}

gcd() {
    cd $(git rev-parse --show-toplevel)
}
# avoid nested lf
lf() {
    [ -z "$LF_LEVEL" ] && /usr/bin/lf "$@" || exit &>/dev/null
}

lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}

# print the 16 terminal colors
colors() {
    for i in {0..15}; do
        printf "\e[48;5;${i}m  \e[0m"
        [ $((($i + 1) % 8)) -eq 0 ] && printf "\n"
    done
}

# offline dictionary with wordnet
dict() {
    /usr/bin/dict -d wn "$@" | /usr/bin/less -i -F
}

# package management
## list binaries
plb() {
    pacman -Ql "$@" | grep -E '/usr/bin/.+$'
}
## list licenses
pll() {
    pacman -Qi "$@" | grep '^Licenses' | cut -d' ' -f10-
}
## list build date
pld() {
    pacman -Qi "$@" | grep -e '^Build Date' -e '^Version'
}
