# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/Documents/git/go
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$JAVA_HOME/bin:$PATH

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ftb="nohup java -jar ~/Apps/launcher^FTB_Launcher.jar > /dev/null &"
alias lc='colorls -r'
alias tmux="tmux -2"

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
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home"
  export PATH="$HOME/Library/Haskell/bin:$PATH" 
fi

if hash ag 2>/dev/null; then
    alias ag='ag --pager="less -XFR"'
fi

alias xa="exa -abghl --git --color=automatic"

# === fzf ===

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() {
  ag -g "" "$1"
}

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
plugins=(docker git brew jsontools osx rvm fasd lolcat mvn vagrant mercurial cargo rust zsh-autosuggestions zsh-syntax-highlighting)
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/royalaid/Apps/WebStorm-135.1063"
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


#Grab all repo branches after fresh clone
#from https://coderwall.com/p/0ypmka
function gitall(){
  for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do
    git branch --track ${branch#remotes/origin/} $branch
  done
}

export PATH="$PATH:$HOME/Apps/Nim/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
