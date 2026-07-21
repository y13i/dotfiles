if command -v devbox &>/dev/null; then eval "$(devbox global shellenv)"; fi

[[ -f "${HOME}/.oh-my-zsh/completions/_devbox" ]] || devbox completion zsh > ~/.oh-my-zsh/completions/_devbox
