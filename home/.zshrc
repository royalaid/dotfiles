# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/Documents/git/go
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/Users/royalaid/Documents/git/flutter/flutter/bin

export EDITOR="nvim"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_12HR=true
SPACESHIP_HOST_SHOW="always"
SPACESHIP_HOST_SHOW_FULL=true
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ftb="nohup java -jar ~/Apps/launcher^FTB_Launcher.jar > /dev/null &"
alias lc='colorls -r'
alias tmux="tmux -2"
alias bbk='rlwrap deps.clj -Scommand "bb -cp {{classpath}} {{main-opts}}"'

#Used at the end when launching GUI programs from the shell (e.g. `gimp image.jpg @`).
#It pipes both stdout and stderr to logger (which ends up in systemd's
#journal) so it doesn't clutter the terminal and disowns the job so it doesn't
#get killed when you exit the shell. It also has the nice property of looking
#symmetric. 
#via https://www.reddit.com/r/programming/comments/6itu98/hints_for_writing_unix_tools/dj9ckoa/
alias -g @='|& logger &|'

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias htop="sudo htop"
  alias eclimd="/Applications/eclipse_mars/Eclipse.app/Contents/Eclipse/eclimd"
  alias eclim="/Applications/eclipse_mars/Eclipse.app/Contents/Eclipse/eclim"
  export PATH="$HOME/Library/Haskell/bin:$PATH" 
fi

if hash ag 2>/dev/null; then
    alias ag='ag --pager="less -XFR"'
fi

alias xa="exa -abghl --git --color=automatic"

#VirtualEnvWrapper
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=100000
HISTFILESIZE=200000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Setup requires running
# ```
# git clone git://github.com/zsh-users/zsh-autosuggestions
# $ZSH_CUSTOM/plugins/zsh-autosuggestions
# ```
# and
# ```
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# ```
plugins=(docker git brew macos fasd zsh-autosuggestions zsh-syntax-highlighting)
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

. ~/.nvm/nvm.sh # This loads nvm.

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # From http://madebynathan.com/2011/10/04/a-nicer-way-to-use-xclip/
  # A shortcut function that simplifies usage of xclip.
  # - Accepts input from either stdin (pipe), or params.
  # ------------------------------------------------
  cb() {
    local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
    # Check that xclip is installed.
    if ! type xclip > /dev/null 2>&1; then
      echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
      # Check user is not root (root doesn't have access to user xorg server)
    elif [[ "$USER" == "root" ]]; then
      echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
    else
      # If no tty, data should be available on stdin
      if ! [[ "$( tty )" == /dev/* ]]; then
        input="$(< /dev/stdin)"
        # Else, fetch input from params
      else
        input="$*"
      fi
      if [ -z "$input" ]; then  # If no input, print usage message.
        echo "Copies a string to the clipboard."
        echo "Usage: cb <string>"
        echo "       echo <string> | cb"
      else
        # Copy input to clipboard
        echo -n "$input" | xclip -selection c
        # Truncate text for status
        if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
        # Print status.
        echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
      fi
    fi
  }
  # Aliases / functions leveraging the cb() function
  # ------------------------------------------------
  # Copy contents of a file
  function cbf() { cat "$1" | cb; }  
  # Copy SSH public key
  alias cbssh="cbf ~/.ssh/id_rsa.pub"  
  # Copy current working directory
  alias cbwd="pwd | cb"  
  # Copy most recent command in bash history
  alias cbhs="cat $HISTFILE | tail -n 1 | cb"  
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
unalias grv

#Fix `homeshick cd` when using homeshick from brew, see https://github.com/andsens/homeshick/issues/177
export HOMESHICK_DIR=/usr/local/opt/homeshick
source "/usr/local/opt/homeshick/homeshick.sh"

#Enable mcfly
eval "$(mcfly init zsh)"

source /Users/royalaid/Library/Preferences/org.dystroy.broot/launcher/bash/br

if [ -f ~/.zsh/archconfig ]; then
    source ~/.zsh/archconfig
fi

