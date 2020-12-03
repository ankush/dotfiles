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

# open and disown zathura
function z()
{
    zathura $1 & disown
}

function tbr()
{
    cd ~/Dropbox/UoL/TBR
    ls
}

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


# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ankush/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ankush/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ankush/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ankush/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# define external disk mount point
hdd="/mnt/ankush/DATA/"

# Downloads directory
alias down="cd $hdd/Downloads"

# Texlive
export PATH="$hdd/softwares/texlive/2020/bin/x86_64-linux:$PATH"
export MANPATH="$hdd/softwares/texlive/2020/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$hdd/softwares/texlive/2020/texmf-dist/doc/info:$INFOPATH"

alias :q="exit" # hehe

source $HOME/.aliases

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# tmux aliases
alias t=tmux
alias mux=tmuxinator

# file manager
alias f=vifm
