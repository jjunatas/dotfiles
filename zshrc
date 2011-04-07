# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="gallifrey"
export ZSH_THEME="jreese"


# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

plugins=(cap gem git github osx rails ruby textmate)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/`whoami`/bin:/usr/local:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/usr/local:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH;

# Fix for rvm issues with .zsh
unsetopt auto_name_dirs

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
