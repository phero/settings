# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

umask 0002

#bindkey -v
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#
#       Completion
#
setopt auto_cd
setopt auto_menu
setopt list_packed
setopt list_types
setopt noautoremoveslash
setopt magic_equal_subst
setopt print_eight_bit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#
#       History
#
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt append_history
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks

setopt auto_pushd
setopt pushd_ignore_dups

#
#       Alias
#
setopt complete_aliases

if [ -x /usr/bin/dircolors ]; then
       alias ols='ls'
       alias ls='ls --color=auto --file-type'
       alias grep='grep --color=auto'
fi

alias l='ls -h'
alias ll='ls -lh'
alias lla='ls -alFh'
alias la='ls -Ah'

alias L='less'
alias crontab='crontab -i'
alias ssh='ssh -A'
alias less='/usr/share/vim/vim74/macros/less.sh'
alias ack='ack-grep --nosql'
alias xi='xsel -i -b'
alias xo='xsel -o -b'

# for Git
alias kc='git diff --cached'
alias kcl='git diff --cached | less'
alias kh='git diff HEAD'
alias khl='git diff HEAD | less'
alias ks='git status'
alias ka='git add'
alias kap='git add -p'
alias kb='git branch'
alias kg='git log --graph --oneline'
export PATH=${PATH}:/usr/share/doc/git/contrib/diff-highlight

# for Docker
alias drm="docker ps -as | sed '1,1 d' | cut -d ' ' -f 1 | xargs docker rm"
alias drmi="docker images | sed '1,1 d' | perl -anle 'print $F[2]' | xargs docker rmi"

# utility
alias utf8='find . -type f | grep -vE "\.pyc$" | xargs nkf --guess | grep -vE "(UTF-8 \(LF\)|BINARY|ASCII \(LF\)|ASCII)"'
export PATH=${PATH}:~/tools/linux-tools/bin/
