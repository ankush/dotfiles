zstyle :omz:plugins:ssh-agent agent-forwarding on
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# oh-my-zsh plugins
plugins=(git ubuntu ssh-agent)


source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_IN.UTF-8

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Python HTTP server alias
alias httpserver="xdg-open http://localhost:8000 && python -m http.server"

# dotfiles manager
alias dot="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# enable autocompletion on dotfiles manager
compdef dot='git'
setopt complete_aliases

# the one true text editor
alias v="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

# Common config files
alias vrc="nvim ~/.config/nvim/init.vim"
alias vxm="nvim ~/.xmonad/xmonad.hs"

alias open="xdg-open"

# open and disown zathura
function z()
{
    zathura $1 & disown
}

# quick open a tbr file
alias tbr='z "$(ls -d ~/Dropbox/UoL/TBR/* | fzf)"'

# extract files
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# safe rm and move
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias :q="exit" # hehe


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND='rg --files --follow'

# tmux aliases
alias t=tmux
alias mux=tmuxinator
source $HOME/.aliases

# define external disk mount point
hdd="/mnt/ankush/DATA/"

# Downloads directory
alias down="cd $hdd/Downloads"

# Texlive
export PATH="$hdd/softwares/texlive/2020/bin/x86_64-linux:$PATH"
export MANPATH="$hdd/softwares/texlive/2020/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$hdd/softwares/texlive/2020/texmf-dist/doc/info:$INFOPATH"

# ruby
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# quick file/project launchers
alias p='cd $(ls -d ~/proj/* | fzf) && tmxl'

# add local python scripts to PATH
export PATH="$HOME/.local/bin:$PATH"

# python
export PATH="/home/ankush/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# golang
export PATH="/home/ankush/go/bin:$PATH"

# cool
export PATH="/usr/class/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"

# opam configuration
test -r /home/ankush/.opam/opam-init/init.zsh && . /home/ankush/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
