function parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
 
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0;0m\]"
 
PS1="$GREEN\W$NO_COLOR$RED\$(parse_git_branch)$GREEN\$$NO_COLOR "
 
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
 
#aliases
 
alias ls='ls -h'
alias ll='ls -lhF'
alias la='ls -lhA'
alias l='ls -CF'

export JAVA_HOME=$(/usr/libexec/java_home)
export MYSQL_HOME=/usr/local/mysql-5.6.14-osx10.7-x86_64

export PATH=$MYSQL_HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

if [ -f ~/dotfiles/git-completion.bash ]; then
	.  ~/dotfiles/git-completion.bash
fi

if [ -f ~/dotfiles/maven-completion.bash ]; then
	. ~/dotfiles/maven-completion.bash
fi

if [ -f ~/dotfiles/npm-completion.bash ]; then
	. ~/dotfiles/npm-completion.bash
fi

function gi() { curl http://www.gitignore.io/api/$@ ;}

export NVM_DIR="/Users/guilherme/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR JENV TO WORK!!!
[[ -s "/Users/guilherme/.jenv/bin/jenv-init.sh" ]] && source "/Users/guilherme/.jenv/bin/jenv-init.sh" && source "/Users/guilherme/.jenv/commands/completion.sh"
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
