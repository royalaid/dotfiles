alias grep='ggrep'
# === Environment Variables ===
set -gx GOPATH $HOME/Documents/git/go
set -gx RUST_SRC_PATH ~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
set fish_greeting

# Append directories to PATH (fish’s PATH is an array)
#set -gx PATH $PATH $GOPATH/bin
#set -gx PATH $PATH $GOROOT/bin
#set -gx PATH $JAVA_HOME/bin $PATH
#set -gx PATH $PATH /Users/royalaid/Documents/git/flutter/flutter/bin

set -gx EDITOR nvim

# === Darwin‐Specific Settings ===
if test (uname) = Darwin
    alias htop 'sudo htop'
end

# === ag Alias (if command exists) ===
if type -q ag
    alias ag 'ag --pager="less -XFR"'
end

alias xa 'eza -abghl --icons --git --color=automatic'
alias za 'eza -ghl --icons --git'

# === VirtualEnvWrapper ===
#set -gx WORKON_HOME $HOME/.virtualenvs
# In fish, consider using “virtualfish” instead of sourcing virtualenvwrapper.sh

# === History Settings ===
# Fish manages history differently—no need to set HISTSIZE/HISTFILESIZE here.

# === Plugin System ===
# oh‑my‑zsh plugins and fpath adjustments don’t apply.
# Use fisher or similar package managers for fish.

# === System Binaries in PATH ===
# (Uncomment and adjust MANPATH if needed.)

# === nvm / RVM / Cargo ===
# For nvm, use nvm.fish or an alternative fish-friendly tool.
# source ~/.nvm/nvm.fish

set -gx PATH $PATH $HOME/.rvm/bin
set -gx PATH $PATH $HOME/.cargo/bin

# === Linux‐Specific Clipboard Functions ===
if test (uname) = Linux
    function cb
        # NOTE: Handling of color escape codes and stdin may seem unusual.
        set -l _scs_col "\e[0;32m"
        set -l _wrn_col "\e[1;31m"
        set -l _trn_col "\e[0;33m"

        if not type -q xclip
            echo -e "$_wrn_col You must have the 'xclip' program installed.\e[0m"
        else if test $USER = root
            echo -e "$_wrn_col Must be regular user (not root) to copy to clipboard.\e[0m"
        else
            # If no interactive input, grab from stdin; otherwise use arguments.
            if not test -t 0
                set input (cat)
            else
                set input $argv
            end
            if test -z "$input"
                echo "Copies a string to the clipboard."
                echo "Usage: cb <string>"
                echo "       echo <string> | cb"
            else
                echo -n $input | xclip -selection c
                if test (string length -- $input) -gt 80
                    set input (string sub -l 1 -L 80 $input)"$_trn_col... \e[0m"
                end
                echo -e "$_scs_col Copied to clipboard:\e[0m $input"
            end
        end
    end

    function cbf
        cat $argv[1] | cb
    end

    alias cbssh 'cbf ~/.ssh/id_rsa.pub'
    alias cbwd 'pwd | cb'
    # NOTE: Fish history is stored differently; adjust cbhs as needed.
    alias cbhs 'cat ~/.local/share/fish/fish_history | tail -n 1 | cb'
end

# === fzf Setup ===
if test -f $HOME/.fzf.fish
    source $HOME/.fzf.fish
end
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# === Removing a Previous Alias ===
# Fish doesn’t support “unalias” directly.
# To remove a function alias, use: functions -e grv 2>/dev/null

# === Homeshick Settings ===
set -gx HOMESHICK_DIR /usr/local/opt/homeshick
# source /usr/local/opt/homeshick/homeshick.fish  # if a fish version exists

set -gx PATH $PATH /Users/royalaid/.foundry/bin

# === Nargo Settings ===
set -gx NARGO_HOME /Users/royalaid/.nargo
set -gx PATH $PATH $NARGO_HOME/bin

# === LM Studio CLI and Android Settings ===
set -gx PATH /Users/royalaid/.local/bin $PATH
set -gx PATH $PATH /Users/royalaid/.cache/lm-studio/bin
set -gx ANDROID_HOME /Users/$USER/Library/Android/sdk
starship init fish | source
mcfly init fish | source

# opencode
fish_add_path /Users/royalaid/.opencode/bin

# Added by Antigravity
fish_add_path /Users/royalaid/.antigravity/antigravity/bin

# Brew updater
alias brewup 'brew update && brew outdated --greedy && brew upgrade --greedy && brew cleanup'
