ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

for repo in \
  "https://github.com/zsh-users/zsh-history-substring-search" \
  "https://github.com/zsh-users/zsh-autosuggestions" \
  "https://github.com/zsh-users/zsh-syntax-highlighting" \
  "https://github.com/MenkeTechnologies/zsh-expand"; do
  plugin="${ZSH_CUSTOM}/plugins/${${repo:t}%.git}"
  [ -d "$plugin" ] || git clone "$repo" "$plugin"
done

unset repo plugin
