# Apple Silicon Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export ZPLUG_HOME="/opt/homebrew/opt/zplug"
if [[ -f "$ZPLUG_HOME/init.zsh" ]]; then
  source "$ZPLUG_HOME/init.zsh"
else
  echo "[zshrc] zplug not found: $ZPLUG_HOME"
  return
fi

# plugins
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# Pure needs async (official zplug integration)
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme

# install if needed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  else
    echo
  fi
fi

zplug load

# completion init
autoload -Uz compinit
compinit

[[ -f ~/.zsh_local ]] && source ~/.zsh_local
eval "$(mise activate zsh)"
