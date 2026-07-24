function zshaddhistory() {
  emulate -L zsh
  setopt local_options extended_glob
  if [[ $1 = *(#i)PASSWORD* || $1 = *"AWS_SECRET_ACCESS_KEY"* ]] ; then
    return 1
  fi
  return 0
}
