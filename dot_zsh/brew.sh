if ! command -v brew &>/dev/null; then
  print -u2 -r -- 'brew not found. Install it: https://brew.sh/'
  return
fi

brewfile="${HOMEBREW_BUNDLE_FILE_GLOBAL:-$HOME/.Brewfile}"
stamp="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-brew-bundle-check"

# $recent: the Brewfile was checked within the last 7 days. Editing the Brewfile
# invalidates that, so a fresh entry is reported on the next shell instead of
# waiting out the interval.
recent=($stamp(Nmd-7))
[ -r "$brewfile" ] && [ "$brewfile" -nt "$stamp" ] && recent=()

if [ -r "$brewfile" ] && (( ! $#recent )); then
  # Stamp first: a drifted Brewfile should nag once per interval, not on every
  # single shell startup.
  mkdir -p "${stamp:h}" && : >| "$stamp"

  missing="$(brew bundle check --global --verbose 2>&1)" ||
    print -u2 -r -- "$missing"
fi

unset brewfile stamp recent missing
