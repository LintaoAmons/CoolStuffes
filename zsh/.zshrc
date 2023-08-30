# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################## 🔽 ENV 🔽 ###########################
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk11/Contents/Home"
export M2_HOME="$HOME/.m2/wrapper/dists/apache-maven-3.6.3-bin/1iopthnavndlasol9gbrbg6bf2/apache-maven-3.6.3"
export GOPATH=$HOME/go
export LANG=en_US.UTF-8
export EDITOR="nvim"
export TMUX_TMPDIR=~/.tmux
export GRAVEYARD="~/.local/share/Trash." # for rip command

# History in cache directory:
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
source ~/.secrets
########################## 🔼 ENV 🔼 ##########################

########################## 🔽 PATH 🔽 ###########################
paths=(
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
/Library/Apple/usr/bin
/opt/homebrew/bin
/opt/homebrew/sbin
/opt/local/bin
/opt/local/sbin
${HOME}/.local/bin
${HOME}/.m2/wrapper/dists/apache-maven-3.6.3-bin/1iopthnavndlasol9gbrbg6bf2/apache-maven-3.6.3/bin
${HOME}/go/bin
${HOME}/.cargo/bin
/opt/local/lib/postgresql15/bin
${HOME}/Library/Python/3.9/bin
)
join_by() {
    local separator="$1"
    shift
    printf '%s' "$1" "${@/#/$separator}"
}
path=$(join_by ":" "${paths[@]}")
export PATH="$path"
########################## 🔼 PATH 🔼 ##########################

autoload -U colors && colors

########################## 🔽 AUTO COMP 🔽 ###########################
# Basic auto/tab complete:
autoload bashcompinit && bashcompinit
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# put the custom completions here: /usr/local/share/zsh/site-functions
# Addtional completions can be found in: https://github.com/zsh-users/zsh-completions
_comp_options+=(globdots)		# Include hidden files.
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=$HOME/.oh-my-zsh/custom/zsh-completions

complete -C '/usr/local/bin/aws_completer' aws
source <(kubectl completion zsh)
########################## 🔼 AUTO COMP 🔼 ###########################

# vi mode
bindkey -v
export KEYTIMEOUT=1

########################## 🔽 JUMP 🔽 ###########################
eval "$(jump shell zsh)"

__jump_chpwd() {
  jump chdir
}

jump_completion() {
  reply="'$(jump hint "$@")'"
}

j() {
  local dir="$(jump cd $@)"
  test -d "$dir" && cd "$dir"
}

typeset -gaU chpwd_functions
chpwd_functions+=__jump_chpwd

compctl -U -K jump_completion j
########################## 🔼 JUMP 🔼 ##########################


########################## 🔽 OH MY ZSH 🔽 ###########################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh" 
# source ~/powerlevel10k/powerlevel10k.zsh-theme
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  fzf-tab
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
########################## 🔼 OH MY ZSH 🔼 ##########################

########################## 🔽 LOAD OTHER CONFIGS 🔽 ###########################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # this must put after oh-my-zsh plugins
                                       # to avoid unexpected overwrite
bindkey "ç" fzf-cd-widget                                       
source "/opt/homebrew/Cellar/fzf/0.38.0/shell/key-bindings.zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh 
########################## 🔼 LOAD OTHER CONFIGS 🔼 ##########################


########################## 🔽 NVM 🔽 ###########################
# export NVM_DIR="$HOME/.nvm"
# export PATH=$PATH:"$HOME/.nvm/versions/node/v14.16.0/bin"
# source /opt/local/share/nvm/init-nvm.sh
# nvm() { . "/usr/local/opt/nvm/nvm.sh"; nvm $@; }
########################## 🔼 NVM 🔼 ##########################

########################## 🔽 ALIAS 🔽 ###########################
alias chat="nvim -c 'lua require(\"scratch\").scratchByType(\"gp4.md\")'"
alias vim="nvim"
alias gp!="git push --no-verify"
alias v="lvim +\"Telescope oldfiles\""
alias glog="git log --pretty=format:'%C(auto)%h%C(blue) %<|(19)%as%C(auto)%d %s' --graph"
alias kc="kubectl"
alias python="python3"
alias gitsync="$HOME/Documents/Git-Sync/sync.sh"
alias df='vim +DiffviewOpen'
alias lm="limactl"
alias lt="lsgo | head -n 30"
alias gonew="source go-new"
alias awsprofileswither="source aws-profile-switcher"
alias kl="minikube kubectl --"

########################## 🔼 ALIAS 🔼 ##########################

########################## 🔽 SHORTCUTS 🔽 ###########################
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'

# ctrl-u toggle lazygit
bindkey -s '^u' 'lazygit\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
########################## 🔼 SHORTCUTS 🔼 ##########################

# Load zsh-syntax-highlighting; should be last.
# source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
