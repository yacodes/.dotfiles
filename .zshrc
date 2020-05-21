export TERM=screen-256color
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export EDITOR='vi'

# Set PATH for rust lang
export PATH=$HOME/bin:/usr/local/bin:/.cargo/bin:$PATH

# Set up the prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '*'
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{yellow}∮ %F{cyan}[%b%c] '

autoload -Uz promptinit
autoload -U colors && colors
promptinit
PROMPT='%F{yellow}λ %m%f%b %F{green}[%c]%f%b %F{yellow}%f%b'\$vcs_info_msg_0_'%f%b'

export LC_ALL=en_US.UTF-8

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e


# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Aliases
alias ll="ls -la"
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias v="vi"
alias g="git"
alias weather="curl wttr.in/Moscow"
alias tidal="ghci -ghci-script"

# Use modern completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
