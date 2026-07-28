# Pin every plugin to a commit hash instead of following its default branch.
# To update: bump the hash after reviewing the diff.
plugin_pins=(
  "https://github.com/zsh-users/zsh-autosuggestions" 85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5
  "https://github.com/zsh-users/zsh-syntax-highlighting" 1d85c692615a25fe2293bdd44b34c217d5d2bf04
  "https://github.com/MenkeTechnologies/zsh-expand" 2375f1d6418c82edeed4b85283ef25af687df6fd
)

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
stamp="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-plugin-pin-check"
netfail="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-plugin-net-fail"

# $recent: upstream was polled within the last 30 days.
# $failed: git failed within the last hour, so leave the network alone.
recent=($stamp(Nmd-30))
failed=($netfail(Nmh-1))

for repo pin in $plugin_pins; do
  (( $#failed )) && break

  plugin="${ZSH_CUSTOM}/plugins/${${repo:t}%.git}"

  if [ ! -r "$plugin/.git/HEAD" ] || [ "$(<$plugin/.git/HEAD)" != "$pin" ]; then
    # Assemble in a temp dir and swap it in, so that a failed fetch cannot leave
    # a half-installed plugin behind.
    tmp="${plugin}.tmp.$$"

    if git init -q "$tmp" &&
      git -C "$tmp" remote add origin "$repo" &&
      git -C "$tmp" fetch -q --depth 1 origin "$pin" &&
      git -C "$tmp" checkout -q --detach "$pin"; then
      rm -rf "$plugin" && mv "$tmp" "$plugin"
    else
      rm -rf "$tmp"
      mkdir -p "${netfail:h}" && : >| "$netfail"
      failed=($netfail)
    fi
  fi

  (( $#recent || $#failed )) || {
    latest="${$(git ls-remote "$repo" HEAD)%%[[:space:]]*}"

    if [ -n "$latest" ]; then
      [ "$latest" != "$pin" ] &&
        print -u2 -r -- "${${repo:t}%.git}: ${repo}/compare/${pin[1,7]}...${latest[1,7]}"
    else
      mkdir -p "${netfail:h}" && : >| "$netfail"
      failed=($netfail)
    fi
  }
done

# Only claim to have polled when every repository answered.
(( $#recent || $#failed )) || { mkdir -p "${stamp:h}" && : >| "$stamp" }

unset repo pin plugin tmp latest stamp netfail recent failed plugin_pins
