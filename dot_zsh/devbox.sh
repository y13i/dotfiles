if command -v devbox &>/dev/null; then eval "$(devbox global shellenv --init-hook)"; fi

[[ -f "${HOME}/.oh-my-zsh/completions/_devbox" ]] || devbox completion zsh > ~/.oh-my-zsh/completions/_devbox

alias db="devbox"
alias dba="devbox add"
alias dbl="devbox list"
