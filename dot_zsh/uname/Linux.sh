if [[ -d /home/linuxbrew/.linuxbrew && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi

# https://zenn.dev/kaityo256/articles/open_command_on_wsl
function open() {
  # check if it's running on WSL
  [[ ! (( $+commands[explorer.exe] )) ]] && return 1

  if [ $# != 1 ]; then
    explorer.exe .
  else
    if [ -e $1 ]; then
      cmd.exe /c start $(wslpath -w $1) 2> /dev/null
    else
      echo "open: $1 : No such file or directory" 
    fi
  fi
}
