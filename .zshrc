HISTFILE=~/.zsh_history

HISTSIZE=1000000
SAVEHIST=1000000

export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

autoload -U promptinit; promptinit
# プロンプトを変更
prompt pure

setopt auto_cd

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
# zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-history-substring-search"
# zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "supercrabtree/k"
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "b4b4r07/enhancd", use:init.sh
zplug "paulirish/git-open", as:plugin
zplug "zsh-users/zsh-syntax-highlighting", defer:2
: "cd先のディレクトリのファイル一覧を表示する" && {
  [ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 } # enhancdがない場合
  [ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1" # enhancdがあるときはそのHook機構を使う
}

: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load

if [ -f ~/.zsh_local ]; then
  source ~/.zsh_local
fi

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias deno='docker run --rm -ti -v $(pwd):/workingdir -w /workingdir denoland/deno:1.39.2'
alias sbt='docker run --rm -ti -v ~/.sbt:/root/.sbt -v ~/.cache/coursier:/root/.cache/coursier/v1/https -v $(pwd):/workingdir -w /workingdir sbtscala/scala-sbt:eclipse-temurin-focal-17.0.10_7_1.9.8_2.12.18 sbt'

