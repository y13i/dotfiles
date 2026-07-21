function zshaddhistory() {
  emulate -L zsh
  if [[ $1 = *"AWS_SECRET_ACCESS_KEY"* ]] ; then
    return 1
  fi
  return 0
}
