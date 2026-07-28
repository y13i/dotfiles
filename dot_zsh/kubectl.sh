if command -v kubectl &>/dev/null; then eval "$(kubectl completion zsh)"; fi

alias kg="kubectl get"
alias kd="kubectl describe"
alias kdf="kubectl diff -f"
alias kk="kubectl kustomize"
alias kak="kubectl apply --kustomize"
alias kdk="kubectl diff --kustomize"
alias krr="kubectl rollout restart"
alias ktn="kubectl top node"
alias ktp="kubectl top pod"
